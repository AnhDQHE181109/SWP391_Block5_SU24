package Controller;
import model.DAOStock;
import model.DAOStockImportDetail;
import model.DAOProductStockImport;// Add this import
import entity.Stock;
import entity.StockImportDetail;
import entity.ProductStockImport;
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
            AccountDAO daoAccount = new AccountDAO(); // Add this line

            List<StockImportDetail> stockImportDetails = daoStockImportDetail.getByImportID(importId);
            ProductStockImport productStockImport = daoProductStockImport.getProductStockImportById(importId);

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

            // Get username from accountID
            String username = null;
            if (productStockImport != null) {
                int accountID = productStockImport.getAccountID();
                username = daoAccount.getUsernameByAccountID(accountID);
            }

            request.setAttribute("stockImportDetails", stockImportDetails);
            request.setAttribute("stockDetailsMap", stockDetailsMap);
            request.setAttribute("productStockImport", productStockImport);
            request.setAttribute("username", username); // Add this line

            System.out.println("stockDetailsMap" + stockDetailsMap);
            System.out.println("stockImportDetails" + stockImportDetails);
            System.out.println("productStockImport" + productStockImport);
            System.out.println("username" + username); // Add this line

            request.getRequestDispatcher("staff/stockUpdateDetails.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        }
    }
}