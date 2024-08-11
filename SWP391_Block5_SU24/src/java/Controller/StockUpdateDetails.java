package Controller;

import model.DAOStock;
import model.DAOStockImportDetail;
import entity.Stock;
import entity.StockImportDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/stockupdateDetails")
public class StockUpdateDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get importId from request parameter
        String importIdParam = request.getParameter("importID");
        if (importIdParam == null || importIdParam.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page if importId is missing
            return;
        }

        try {
            int importId = Integer.parseInt(importIdParam);

            // Create DAO objects
            DAOStockImportDetail daoStockImportDetail = new DAOStockImportDetail();
            DAOStock daoStock = new DAOStock();

            // Get stock import details by importId
            List<StockImportDetail> stockImportDetails = daoStockImportDetail.getByImportID(importId);

            // Create a map to hold stock details by stockID
            Map<Integer, Stock> stockDetailsMap = new HashMap<>();

            // Fetch stock details for each stockID
            for (StockImportDetail detail : stockImportDetails) {
                int stockID = detail.getStockID();
                if (!stockDetailsMap.containsKey(stockID)) {
                    Stock stock = daoStock.getStockById(stockID);
                    if (stock != null) {
                        stockDetailsMap.put(stockID, stock);
                    }
                }
            }

            // Set the details and stock details as request attributes
            request.setAttribute("stockImportDetails", stockImportDetails);
            request.setAttribute("stockDetailsMap", stockDetailsMap);
            System.out.println("stockDetailsMap" + stockDetailsMap);
                        System.out.println("stockImportDetails" + stockImportDetails);


            // Forward request to JSP page for display
            request.getRequestDispatcher("staff/stockUpdateDetails.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp"); // Redirect to an error page if importId is invalid
        }
    }
}
