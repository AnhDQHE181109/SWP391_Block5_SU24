package Controller;

import model.DAOStock;
import model.DAOStockImportDetail;
import model.DAOProductStockImport;
import entity.Stock;
import entity.StockImportDetail;
import entity.ProductStockImport;
import entity.StockImportSummary; // Thêm import cho StockImportSummary
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AccountDAO;

@WebServlet("/stockupdateDetails")
public class StockUpdateDetails extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String importIdParam = request.getParameter("importID");
        if (importIdParam == null || importIdParam.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }
        try {
            int importId = Integer.parseInt(importIdParam);
            DAOStockImportDetail daoStockImportDetail = new DAOStockImportDetail();
            DAOStock daoStock = new DAOStock();
            DAOProductStockImport daoProductStockImport = new DAOProductStockImport();
            AccountDAO daoAccount = new AccountDAO(); 

            // Get stock import details and product stock import
            List<StockImportDetail> stockImportDetails = daoStockImportDetail.getByImportID(importId);
            ProductStockImport productStockImport = daoProductStockImport.getProductStockImportById(importId);

            // Get stock details
            Map<Integer, Stock> stockDetailsMap = new HashMap<>();
            for (StockImportDetail detail : stockImportDetails) {
                int stockID = detail.getStockID();
                if (!stockDetailsMap.containsKey(stockID)) {
                    Stock stock = daoStock.getStockById(stockID);
                    if (stock != null) {
                        stockDetailsMap.put(stockID, stock);
                    }
                }
            }

            // Get stock import summary
            List<StockImportSummary> stockImportSummaries = daoStockImportDetail.getStockImportSummary(importId);

            // Get username from accountID
            String username = null;
            if (productStockImport != null) {
                int accountID = productStockImport.getAccountID();
                username = daoAccount.getUsernameByAccountID(accountID);
            }

            // Set attributes for JSP
            request.setAttribute("stockImportDetails", stockImportDetails);
            request.setAttribute("stockDetailsMap", stockDetailsMap);
            request.setAttribute("productStockImport", productStockImport);
            request.setAttribute("username", username);
            request.setAttribute("stockImportSummaries", stockImportSummaries); // Thêm dữ liệu summary

            // Log for debugging
            System.out.println("stockDetailsMap: " + stockDetailsMap);
            System.out.println("stockImportDetails: " + stockImportDetails);
            System.out.println("productStockImport: " + productStockImport);
            System.out.println("username: " + username);
            System.out.println("stockImportSummaries: " + stockImportSummaries); // Thêm log cho summary

            // Forward to JSP
            request.getRequestDispatcher("staff/stockUpdateDetails.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
