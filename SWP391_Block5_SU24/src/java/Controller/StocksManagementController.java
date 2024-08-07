/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import model.StocksManagementDAO;

/**
 *
 * @author ASUS
 */
public class StocksManagementController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StocksManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StocksManagementController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        StocksManagementDAO smDAO = new StocksManagementDAO();

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();

        request.setAttribute("productsList", productsList);
        request.setAttribute("productsStocksList", productsStocksList);
        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        StocksManagementDAO smDAO = new StocksManagementDAO();

        String confirmYes = request.getParameter("confirmYes");
        String confirmNo = request.getParameter("confirmNo");
        if (confirmYes != null) {
            
        }

        List<Product> outOfStocksList = new ArrayList<>();
        String outOfStocksProduct = null;
        Map stocksData = request.getParameterMap();
        for (Object key : stocksData.keySet()) {
            String keyString = (String) key;
            String[] value = (String[]) stocksData.get(keyString);
            keyString = keyString.replaceAll("[^\\d]", "");
            System.out.println("Key " + keyString + "   :   " + value[0]);

            int productID = Integer.parseInt(keyString);
            int quantity = Integer.parseInt(value[0]);

            if (quantity == 0) {
                Product outOfStockProduct = smDAO.getProductStockByID(productID);
                outOfStocksList.add(outOfStockProduct);
                outOfStocksProduct = smDAO.getProductStockByID(productID).getProductName();
                continue;
            }

            smDAO.setProductStock(productID, quantity);
        }

        if (outOfStocksList.size() != 0) {
            request.setAttribute("outOfStocksList", outOfStocksList);
            request.setAttribute("outOfStocksProduct", outOfStocksProduct);
            request.setAttribute("popupDisplay", "display: block;");
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        }

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();

        request.setAttribute("productsList", productsList);
        request.setAttribute("productsStocksList", productsStocksList);
        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
