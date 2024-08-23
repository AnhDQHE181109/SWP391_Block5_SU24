package Controller;

import entity.Feedback;
import entity.Stock;
import entity.Product;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AccountDAO;
import model.DAOFeedback;
import model.DAOStock;
import model.DAOProduct;

public class FeedbackController extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOFeedback daoFeedback = new DAOFeedback();
        DAOStock daoStock = new DAOStock(); 
        DAOProduct daoProduct = new DAOProduct(); 
         AccountDAO accountDAO = new AccountDAO();

        try {
            // Lấy tham số tìm kiếm và sắp xếp từ request
            String username = request.getParameter("username");
            String productName = request.getParameter("productName");
            String sortBy = request.getParameter("sortBy");
            String pageStr = request.getParameter("page");

            // Xử lý phân trang
            int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
            int start = (currentPage - 1) * RECORDS_PER_PAGE;
            int end = start + RECORDS_PER_PAGE;

            List<Feedback> feedbackList;

            // Xử lý tìm kiếm và sắp xếp
            if (username != null && !username.trim().isEmpty()) {
                feedbackList = daoFeedback.getFeedbackByUsername(username);
            } else if (productName != null && !productName.trim().isEmpty()) {
                feedbackList = daoFeedback.getFeedbackByProductName(productName);
            } else {
                feedbackList = daoFeedback.getFeedbacksSorted(sortBy); // Phương thức này sắp xếp theo Rating hoặc Created At
            }

            // Xử lý phân trang trong mã
            int totalRecords = feedbackList.size();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
            List<Feedback> paginatedFeedbackList = feedbackList.subList(
                    Math.min(start, totalRecords), 
                    Math.min(end, totalRecords)
            );

            // Tạo Map để lưu trữ accountID và username
            Map<Integer, String> accountUsernameMap = new HashMap<>();
            // Tạo Map để lưu trữ stockID và Stock
            Map<Integer, Stock> stockMap = new HashMap<>();
            // Tạo Map để lưu trữ productID và Product
            Map<Integer, Product> productMap = new HashMap<>();

            // Duyệt qua từng feedback và lấy username, Stock và Product tương ứng
            for (Feedback feedback : paginatedFeedbackList) {
                int accountID = feedback.getAccountID();
                String user = accountDAO.getUsernameByAccountID(accountID);
                accountUsernameMap.put(accountID, user);

                // Lấy Stock thông tin
                int stockID = feedback.getStockID();
                Stock stock = daoStock.getStockById(stockID);
                stockMap.put(stockID, stock);

                // Lấy Product thông tin từ Stock
                int productID = stock.getProductID();
                if (!productMap.containsKey(productID)) {
                    Product product = daoProduct.getProductById(productID);
                    productMap.put(productID, product);
                }
            }

            // Truyền dữ liệu đến JSP
            request.setAttribute("paginatedFeedbackList", paginatedFeedbackList);
            request.setAttribute("accountUsernameMap", accountUsernameMap);
            request.setAttribute("stockMap", stockMap);
            request.setAttribute("productMap", productMap);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.getRequestDispatcher("manager/feedback.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            daoFeedback.finalize(); // Đảm bảo DAO được đóng đúng cách
        }
    }
}
