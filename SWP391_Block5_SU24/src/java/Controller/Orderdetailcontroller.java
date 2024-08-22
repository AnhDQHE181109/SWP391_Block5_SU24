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
       

            
            System.out.println("stockMap" + stockMap);
            System.out.println("productNameMap" + productNameMap);
            System.out.println("status"+status);
            System.out.println("adress"+adress);
            
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
        
        // Create an instance of DAOOrderDetail to call updateOrderStatus
        DAOOrder daoOrder = new DAOOrder();
        
        int updateResult = daoOrder.updateOrderStatus(orderId, newStatus); // Call the instance method
        
        if (updateResult > 0) {
            // Successfully updated the order status, redirect or forward to a confirmation page or reload
            response.sendRedirect("Ordercontroller"); // Redirect to order list after confirming
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
