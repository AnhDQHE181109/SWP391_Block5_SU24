package Controller;

import entity.Feedback;
import entity.Stock;
import entity.Product; // Giả sử bạn có lớp Product tương ứng
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOFeedback daoFeedback = new DAOFeedback();
        AccountDAO accountDAO = new AccountDAO();
        DAOStock daoStock = new DAOStock(); // Khởi tạo DAOStock
        DAOProduct daoProduct = new DAOProduct(); // Khởi tạo DAOProduct

        try {
            // Lấy danh sách feedbacks
            List<Feedback> feedbackList = daoFeedback.getAllFeedbacks();

            // Tạo Map để lưu trữ accountID và username
            Map<Integer, String> accountUsernameMap = new HashMap<>();
            // Tạo Map để lưu trữ stockID và Stock
            Map<Integer, Stock> stockMap = new HashMap<>();
            // Tạo Map để lưu trữ productID và Product
            Map<Integer, Product> productMap = new HashMap<>();

            // Duyệt qua từng feedback và lấy username, Stock và Product tương ứng
            for (Feedback feedback : feedbackList) {
                int accountID = feedback.getAccountID();
                String username = accountDAO.getUsernameByAccountID(accountID);
                accountUsernameMap.put(accountID, username);

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

            // Truyền feedbackList, accountUsernameMap, stockMap, và productMap đến JSP
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("accountUsernameMap", accountUsernameMap);
            request.setAttribute("stockMap", stockMap);
            request.setAttribute("productMap", productMap);
            request.getRequestDispatcher("manager/feedback.jsp").forward(request, response);
            
            System.out.println("feedbackList: " + feedbackList);
            System.out.println("accountUsernameMap: " + accountUsernameMap);
            System.out.println("stockMap: " + stockMap);
            System.out.println("productMap: " + productMap);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            daoFeedback.finalize(); // Đảm bảo DAO được đóng đúng cách
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống như GET
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
