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

    try {
        // Fetch sorted stock imports based on user input
        List<ProductStockImport> stockImports = fetchStockImports(request);
        Map<Integer, String> accountUsernameMap = buildAccountUsernameMap(stockImports);

        // Perform pagination
        paginateAndForward(request, response, stockImports, accountUsernameMap);
    } catch (Exception e) {
        throw new ServletException("Error during search or pagination operation", e);
    }
}

private List<ProductStockImport> fetchStockImports(HttpServletRequest request) throws Exception {
    String searchUsername = request.getParameter("searchUsername");
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");
    String sortOrder = request.getParameter("sortOrder"); // New parameter for sorting

    if (searchUsername != null && !searchUsername.isEmpty()) {
        List<Integer> accountIDs = daoAccount.findAccountIDsByUsername(searchUsername);
        return daoProductStockImport.getProductStockImportsByAccountIDs(accountIDs);
    } else if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
        Date startDate = Date.valueOf(startDateStr);
        Date endDate = Date.valueOf(endDateStr);
        return daoProductStockImport.getProductStockImportsByDateRange(startDate, endDate);
    } else if (startDateStr != null && !startDateStr.isEmpty()) {
        Date date = Date.valueOf(startDateStr);
        return daoProductStockImport.getProductStockImportsByDate(date);
    } else {
        // If sortOrder is provided, use it to fetch sorted data
        if (sortOrder != null && (sortOrder.equalsIgnoreCase("ASC") || sortOrder.equalsIgnoreCase("DESC"))) {
            return daoProductStockImport.getAllProductStockImportssort(sortOrder);
        } else {
            return daoProductStockImport.getAllProductStockImports();
        }
    }
}

private Map<Integer, String> buildAccountUsernameMap(List<ProductStockImport> stockImports) throws Exception {
    Map<Integer, String> accountUsernameMap = new HashMap<>();
    for (ProductStockImport stockImport : stockImports) {
        int accountID = stockImport.getAccountID();
        if (!accountUsernameMap.containsKey(accountID)) {
            String username = daoAccount.getUsernameByAccountID(accountID);
            accountUsernameMap.put(accountID, username);
        }
    }
    return accountUsernameMap;
}

private void paginateAndForward(HttpServletRequest request, HttpServletResponse response, List<ProductStockImport> stockImports, Map<Integer, String> accountUsernameMap) throws ServletException, IOException {
    int page = 1;
    int recordsPerPage = 10; // Number of records per page
    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }
    
    int totalRecords = stockImports.size();
    int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

    // Calculate start and end index for the current page
    int start = (page - 1) * recordsPerPage;
    int end = Math.min(start + recordsPerPage, totalRecords);

    // Get the sublist for the current page
    List<ProductStockImport> paginatedOrderList = stockImports.subList(start, end);

    // Set attributes for JSP
    request.setAttribute("stockImports", paginatedOrderList);
    request.setAttribute("accountUsernameMap", accountUsernameMap);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);

    // Forward to the JSP page
    request.getRequestDispatcher("staff/stockhistory.jsp").forward(request, response);
}
}
