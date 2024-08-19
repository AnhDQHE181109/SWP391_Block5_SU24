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

    String orderIdParam = request.getParameter("orderid");
    List<Order> orderList = new ArrayList<>();

    if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
        int orderId = Integer.parseInt(orderIdParam);
        Order order = daoOrder.getOrderById(orderId, null);
        if (order != null) {
            orderList.add(order);
        }
    } else {
        String usernameSearch = request.getParameter("username");
        String orderDateSearch = request.getParameter("orderDate");
        String statusSearch = request.getParameter("status");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        List<Order> orderList = null;

        if (usernameSearch != null && !usernameSearch.trim().isEmpty()) {
            orderList = daoOrder.getOrdersByUsername(usernameSearch);

    // Forward request and response to the JSP page
    request.getRequestDispatcher("staff/order_manage.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}