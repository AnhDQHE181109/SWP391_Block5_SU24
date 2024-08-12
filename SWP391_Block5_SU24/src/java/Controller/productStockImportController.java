/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.ProductStockImport;
import model.DAOProductStockImport;
import model.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AccountDAO;
import java.sql.Date;

public class productStockImportController extends HttpServlet {
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
        if (account == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        if (account.getRole() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        
        String searchUsername = request.getParameter("searchUsername");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        List<ProductStockImport> stockImports;
        Map<Integer, String> accountUsernameMap = new HashMap<>();
        
        try {
            if ((searchUsername != null && !searchUsername.isEmpty()) || 
                (startDateStr != null && !startDateStr.isEmpty()) || 
                (endDateStr != null && !endDateStr.isEmpty())) {
                
                // Search by username
                if (searchUsername != null && !searchUsername.isEmpty()) {
                    List<Integer> accountIDs = daoAccount.findAccountIDsByUsername(searchUsername);
                    stockImports = daoProductStockImport.getProductStockImportsByAccountIDs(accountIDs);
                    System.out.println("Searched username: " + searchUsername);
                    System.out.println("Found accountIDs: " + accountIDs);
                } 
                // Search by date range
                else if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);
                    stockImports = daoProductStockImport.getProductStockImportsByDateRange(startDate, endDate);
                    System.out.println("Searched date range: " + startDateStr + " to " + endDateStr);
                }
                // Search by single date
                else if (startDateStr != null && !startDateStr.isEmpty()) {
                    Date date = Date.valueOf(startDateStr);
                    stockImports = daoProductStockImport.getProductStockImportsByDate(date);
                    System.out.println("Searched date: " + startDateStr);
                }
                else {
                    stockImports = daoProductStockImport.getAllProductStockImports();
                }
            } else {
                // No search parameters, fetch all
                stockImports = daoProductStockImport.getAllProductStockImports();
            }
            
            // Populate the map with accountID and username
            for (ProductStockImport stockImport : stockImports) {
                int accountID = stockImport.getAccountID();
                if (!accountUsernameMap.containsKey(accountID)) {
                    String username = daoAccount.getUsernameByAccountID(accountID);
                    accountUsernameMap.put(accountID, username);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error during search operation", e);
        }
        
        // Add stockImports and accountUsernameMap to the request attributes
        request.setAttribute("stockImports", stockImports);
        request.setAttribute("accountUsernameMap", accountUsernameMap);
        System.out.println("accountUsernameMap: " + accountUsernameMap);
        
        // Forward to the JSP page
        request.getRequestDispatcher("staff/stockhistory.jsp").forward(request, response);
    }
}