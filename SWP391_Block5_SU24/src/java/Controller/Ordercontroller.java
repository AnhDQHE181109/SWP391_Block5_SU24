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

        // Phân trang
        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int totalRecords = orderList.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        // Tính toán chỉ mục bắt đầu và kết thúc cho trang hiện tại
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);

        // Lấy danh sách đơn hàng cho trang hiện tại
        List<Order> paginatedOrderList = orderList.subList(start, end);

        // Populate username and address map for display
        Map<Integer, String> usernameMap = new HashMap<>();
        Map<Integer, String> addressMap = new HashMap<>();
        Map<Integer, String> phoneMap = new HashMap<>();
        for (Order order : paginatedOrderList) {
            int accountID = order.getAccountID();
            String username = accountDAO.getUsernameByAccountID(accountID);
            String address = accountDAO.getAdressByAccountID(accountID);
            String phone = accountDAO.getPhoneByAccountID(accountID);
            usernameMap.put(accountID, username);
            addressMap.put(accountID, address);
            phoneMap.put(accountID, phone);
        }

        // Set attributes for the JSP
        request.setAttribute("orderList", paginatedOrderList);
        request.setAttribute("usernameMap", usernameMap);
        request.setAttribute("addressMap", addressMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("phoneMap", phoneMap);
        HttpSession session = request.getSession();
        System.out.println("phoneMap" + phoneMap);
        if("true".equals(session.getAttribute("auth_error"))){
        request.setAttribute("auth_error", "true");
        session.setAttribute("auth_error", "false");
        }
        // Forward request and response to the JSP page
        request.getRequestDispatcher("staff/order_manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
