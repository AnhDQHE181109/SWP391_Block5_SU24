package Controller;

import entity.Account;
import entity.Order;
import entity.ProductStockImport;
import model.DAOProductStockImport;
import model.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AccountDAO;

public class productStockImportController extends HttpServlet {
    private static final int PAGE_SIZE = 10; // Số lượng item mỗi trang
    private DAOProductStockImport daoProductStockImport;
    private AccountDAO daoAccount;

    @Override
    public void init() throws ServletException {
        DBConnect dbConnect = new DBConnect();
        daoProductStockImport = new DAOProductStockImport();
        daoAccount = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null || account.getRole() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }

        // Lấy thông tin tìm kiếm từ request
        String searchUsername = request.getParameter("searchUsername");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String sortOrder = request.getParameter("sortOrder");
        String pageStr = request.getParameter("page");
        
       

        List<ProductStockImport> stockImports;
        Map<Integer, String> accountUsernameMap = new HashMap<>();

        try {
            if ((searchUsername != null && !searchUsername.isEmpty()) || 
                (startDateStr != null && !startDateStr.isEmpty()) || 
                (endDateStr != null && !endDateStr.isEmpty())) {
                
                if (searchUsername != null && !searchUsername.isEmpty()) {
                    List<Integer> accountIDs = daoAccount.findAccountIDsByUsername(searchUsername);
                    stockImports = daoProductStockImport.getProductStockImportsByAccountIDs(accountIDs);
                } else if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);
                    stockImports = daoProductStockImport.getProductStockImportsByDateRange(startDate, endDate);
                } else if (startDateStr != null && !startDateStr.isEmpty()) {
                    Date date = Date.valueOf(startDateStr);
                    stockImports = daoProductStockImport.getProductStockImportsByDate(date);
                } else {
                    stockImports = daoProductStockImport.getAllProductStockImports();
                }
            } else {
                stockImports = daoProductStockImport.getAllProductStockImports();
            }



            // Tạo map username
            for (ProductStockImport stockImport : stockImports) {
                int accountID = stockImport.getAccountID();
                if (!accountUsernameMap.containsKey(accountID)) {
                    String username = daoAccount.getUsernameByAccountID(accountID);
                    accountUsernameMap.put(accountID, username);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error during search or pagination operation", e);
        }

        // Mặc định là giảm dần nếu không có giá trị nào
        if (sortOrder == null || (!sortOrder.equals("asc") && !sortOrder.equals("desc"))) {
            sortOrder = "desc";
        }


   // Phân trang
    int page = 1;
    int recordsPerPage = 10;
    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }
    int totalRecords = stockImports.size();
    int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

    // Tính toán chỉ mục bắt đầu và kết thúc cho trang hiện tại
    int start = (page - 1) * recordsPerPage;
    int end = Math.min(start + recordsPerPage, totalRecords);

    // Lấy danh sách đơn hàng cho trang hiện tại
    List<ProductStockImport> paginatedOrderList = stockImports.subList(start, end);
        
        
        // Add stockImports, accountUsernameMap và thông tin phân trang vào request attributes
        request.setAttribute("stockImports", paginatedOrderList);
        request.setAttribute("accountUsernameMap", accountUsernameMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
        System.out.println("paginatedOrderList" + paginatedOrderList);

        // Forward to the JSP page
        request.getRequestDispatcher("staff/stockhistory.jsp").forward(request, response);
    }
}
