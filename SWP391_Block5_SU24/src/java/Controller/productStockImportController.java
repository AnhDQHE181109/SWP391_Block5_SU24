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
import java.util.Collections;
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

        // Sắp xếp stockImports
        if (sortOrder != null && sortOrder.equalsIgnoreCase("desc")) {
            Collections.sort(stockImports, (a, b) -> b.getImportDate().compareTo(a.getImportDate()));
        } else {
            Collections.sort(stockImports, (a, b) -> a.getImportDate().compareTo(b.getImportDate()));
        }

        // Tạo map username
        for (ProductStockImport stockImport : stockImports) {
            int accountID = stockImport.getAccountID();
            if (!accountUsernameMap.containsKey(accountID)) {
                String username = daoAccount.getUsernameByAccountID(accountID);
                accountUsernameMap.put(accountID, username);
            }
        }

        // Phân trang
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }
        int totalItems = stockImports.size();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
        int startIndex = (page - 1) * PAGE_SIZE;
        int endIndex = Math.min(startIndex + PAGE_SIZE, totalItems);

        List<ProductStockImport> paginatedStockImports = stockImports.subList(startIndex, endIndex);

        request.setAttribute("stockImports", paginatedStockImports);
        request.setAttribute("accountUsernameMap", accountUsernameMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortOrder", sortOrder);

    } catch (Exception e) {
        throw new ServletException("Error during search or pagination operation", e);
    }

    // Forward to the JSP page
    request.getRequestDispatcher("staff/stockhistory.jsp").forward(request, response);
}
}