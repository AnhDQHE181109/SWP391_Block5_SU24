/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Feedback;
import entity.Stock;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AccountDAO;
import model.DAOFeedback;
import model.DAOStock;

/**
 *
 * @author asus
 */
public class FeedbackDetailController extends HttpServlet {

       private DAOFeedback daoFeedback = new DAOFeedback();
    private AccountDAO accountDAO = new AccountDAO();
    private DAOStock daoStock = new DAOStock();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the feedbackId from the request parameter
        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));

        // Retrieve feedback list by feedbackId
        List<Feedback> feedbackList = daoFeedback.getallfbyFeedbackID(feedbackId);

        // Map to hold account details by accountID
        Map<Integer, Account> accountMap = new HashMap<>();

        // Map to hold Stock details by stockID
        Map<Integer, Stock> stockMap = new HashMap<>();

        // Populate the maps
        for (Feedback feedback : feedbackList) {
            int accountId = feedback.getAccountID();
            int stockId = feedback.getStockID();

            // Retrieve and store account details by account ID if not already retrieved
            if (!accountMap.containsKey(accountId)) {
                List<Account> accounts = accountDAO.getAccountsByAccountID(accountId);
                if (!accounts.isEmpty()) {
                    accountMap.put(accountId, accounts.get(0)); // Assuming single account per ID
                }
            }

            // Retrieve and store stock details by stock ID if not already retrieved
            if (!stockMap.containsKey(stockId)) {
                Stock stock = daoStock.getStockById(stockId);
                stockMap.put(stockId, stock);
            }
        }

        // Set the data in the request scope to pass to JSP
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("accountMap", accountMap);
        request.setAttribute("stockMap", stockMap);
        
        System.out.println("feedbackList: "+feedbackList);
        System.out.println("accountMap :" +accountMap);
        System.out.println("stockMap :" + stockMap);

        // Forward to JSP
        request.getRequestDispatcher("manager/feedbackDetail.jsp").forward(request, response);
    }
}