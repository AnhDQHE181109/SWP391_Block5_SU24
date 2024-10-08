/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.OrderDetail;
import entity.Stock;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOOrder;
import model.DAOOrderDetail;
import model.DAOStock;
import model.DAOProduct;
import model.NotificationAlertDAO;

public class Orderdetailcontroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
        
        
        String orderIdParam = request.getParameter("id");
        String status  = request.getParameter("status");
        String adress  = request.getParameter("adress");
        String phone  = request.getParameter("phone");
         String user  = request.getParameter("user");

        

        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            int orderId = Integer.parseInt(orderIdParam);
            
            DAOOrderDetail daoOrder = new DAOOrderDetail();
            List<OrderDetail> orderDetailList = daoOrder.getOrderDetailsByOrderId(orderId);
            
            Map<Integer, Stock> stockMap = new HashMap<>();
            Map<Integer, String> productNameMap = new HashMap<>();  // Map to hold productID and productName
            
            DAOStock daoStock = new DAOStock();
            DAOProduct daoProduct = new DAOProduct();  // Assuming this exists to fetch product names
            
            for (OrderDetail orderDetail : orderDetailList) {
                int stockId = orderDetail.getStockID();
                Stock stock = daoStock.getStockById(stockId);
                stockMap.put(stockId, stock);
                
                // Get productID from stock and retrieve productName
                int productId = stock.getProductID();
                String productName = daoProduct.getProductNameById(productId);
                productNameMap.put(productId, productName);
            }
            
            // Push data into request scope
            request.setAttribute("orderDetailList", orderDetailList);
            request.setAttribute("stockMap", stockMap);
            request.setAttribute("productNameMap", productNameMap);  // Pass product names to JSP
            request.setAttribute("status", status);
            request.setAttribute("adress", adress);
            request.setAttribute("phone", phone);
             request.setAttribute("user", user);

            
       

            
            System.out.println("stockMap" + stockMap);
            System.out.println("productNameMap" + productNameMap);
            System.out.println("status"+status);
            System.out.println("adress"+adress);
            System.out.println("user :" +user);
            
            // Forward request and response to JSP page
            request.getRequestDispatcher("staff/orderdetail.jsp").forward(request, response);
 
        } else {
            response.sendRedirect("staff/erro.jsp");
        }
    }
    
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String orderIdParam = request.getParameter("orderId");
    String newStatus = request.getParameter("newStatus");

    if (orderIdParam != null && !orderIdParam.isEmpty() && newStatus != null && !newStatus.isEmpty()) {
        int orderId = Integer.parseInt(orderIdParam);
        
        // Create an instance of DAOOrder to call getAccountIDByOrderID
        DAOOrder daoOrder = new DAOOrder();
        int accountId = daoOrder.getAccountIDByOrderID(orderId);
        
        if (accountId == -1) {
            request.setAttribute("errorMessage", "Order ID not found.");
            doGet(request, response); // Reuse doGet to show the page again
            return;
        }

        String notiMessage = "";
        String notiPath = "customer/order_list?status=" + newStatus;  // Set the default notification path

        // Determine the notification message based on newStatus
        switch (newStatus) {
            case "1":
                notiMessage = "Order " + orderId + " status has changed from pending to processing.";
                break;
            case "2":
                notiMessage = "Order " + orderId + " status has changed from processing to shipping.";
                break;
            case "4":
                notiMessage = "Order " + orderId + " status has changed to a caceled ."; // Add appropriate message
                break;
            default:
                // Handle invalid status
                request.setAttribute("errorMessage", "Invalid order status.");
                doGet(request, response); // Reuse doGet to show the page again
                return;
        }
        
        System.out.println("newStatus : " + newStatus);
        
        // Update the order status
        int updateResult = daoOrder.updateOrderStatus(orderId, newStatus); // Call the instance method
        
        if (updateResult > 0) {
            // Successfully updated the order status
            // Send a notification
            NotificationAlertDAO notidao = new NotificationAlertDAO();
            notidao.send(accountId, notiMessage, notiPath);
            
            // Redirect to order list after confirming
            response.sendRedirect("Ordercontroller");
        } else {
            // Handle the error, e.g., show an error message on the same page
            request.setAttribute("errorMessage", "Unable to update order status. Please try again.");
            doGet(request, response); // Reuse doGet to show the page again
        }
    } else {
        // Handle the missing orderId or newStatus
        request.setAttribute("errorMessage", "Invalid order ID or status.");
        doGet(request, response); // Reuse doGet to show the page again
    }
}


}



