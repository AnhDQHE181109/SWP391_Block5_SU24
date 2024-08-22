/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOOrder;
import model.DAOProductStockImport;
import entity.ProductStockImport;
import entity.Account;
import entity.StockImportDetail;
import java.util.List;
import model.DAOStock;
import model.DAOStockImportDetail;

/**
 *
 * @author asus
 */
public class ConfirmOrderController extends HttpServlet {

      private static final long serialVersionUID = 1L;

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Get AccountID and Actorname from HttpSession
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

    int accountID = account.getAccountID();
    String actorName = account.getUsername(); // Assuming username is used as actorName
    
    int orderID = Integer.parseInt(request.getParameter("orderID"));
    int stockID = Integer.parseInt(request.getParameter("stockID"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    DAOOrder daoOrder = new DAOOrder();
    DAOStock daoStock = new DAOStock();
    DAOProductStockImport daoProductStockImport = new DAOProductStockImport();
    DAOStockImportDetail daoStockImportDetail = new DAOStockImportDetail();

    // Update stock and order
    boolean stockUpdated = daoStock.reduceStockQuantity(stockID, quantity);
    boolean orderUpdated = (daoOrder.updateOrderStatus(orderID, "2") > 0);

    if (stockUpdated && orderUpdated) {
        // Create ProductStockImport object
        ProductStockImport stockImport = new ProductStockImport();
        stockImport.setAccountID(accountID);
        stockImport.setImportAction(1); // Assuming 1 means successful import
        stockImport.setSupplierName(actorName);

        // Add ProductStockImport
        boolean stockImportAdded = daoProductStockImport.addProductStockImport(stockImport);

        if (stockImportAdded) {
            // Retrieve the latest ProductStockImport to get the ImportID
            List<ProductStockImport> latestImports = daoProductStockImport.getAllProductStockImportsTOP1();
            if (latestImports.isEmpty()) {
                response.getWriter().println("Error retrieving the latest stock import record.");
                return;
            }

            int importID = latestImports.get(0).getImportID();

            // Create StockImportDetail object
            StockImportDetail stockImportDetail = new StockImportDetail();
            stockImportDetail.setStockID(stockID);
            stockImportDetail.setImportID(importID); // Use the retrieved ImportID
            stockImportDetail.setStockQuantity(quantity); // Quantity of the product in the order

            // Add StockImportDetail
            boolean stockImportDetailAdded = daoStockImportDetail.createnew(stockImportDetail);

            if (stockImportDetailAdded) {
                response.sendRedirect("OrderConfirmationPage"); // Redirect to confirmation page
            } else {
                response.getWriter().println("Error adding stock import detail.");
            }
        } else {
            response.getWriter().println("Error adding product stock import.");
        }
    } else {
        response.getWriter().println("Error processing the order.");
    }
}

}
