/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AccountDAO;
import model.DAOOrder;

/**
 *
 * @author asus
 */
public class Ordercontroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOOrder daoOrder = new DAOOrder();
        AccountDAO accountDAO = new AccountDAO();

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

        String usernameSearch = request.getParameter("username");
        String orderDateSearch = request.getParameter("orderDate");
        String statusSearch = request.getParameter("status");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        List<Order> orderList = null;

        if (usernameSearch != null && !usernameSearch.trim().isEmpty()) {
            orderList = daoOrder.getOrdersByUsername(usernameSearch);

        } else if (orderDateSearch != null && !orderDateSearch.trim().isEmpty()) {
            orderList = daoOrder.getOrdersByDate(orderDateSearch);

        } else if (statusSearch != null && !statusSearch.trim().isEmpty()) {
            orderList = daoOrder.getOrdersByStatus(statusSearch);

        } else if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
            orderList = daoOrder.getOrdersByDateRange(startDate, endDate);

        } else {
            orderList = daoOrder.getAllOrders();
        }

        // Populate username map for display
        Map<Integer, String> usernameMap = new HashMap<>();
        for (Order order : orderList) {
            int accountID = order.getAccountID();
            String username = accountDAO.getUsernameByAccountID(accountID);
            usernameMap.put(accountID, username);
        }

        // Set attributes for the JSP
        request.setAttribute("orderList", orderList);
        request.setAttribute("usernameMap", usernameMap);

        System.out.println("orderList:" + orderList);

        // Forward request and response to the JSP page
        request.getRequestDispatcher("staff/order_manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
