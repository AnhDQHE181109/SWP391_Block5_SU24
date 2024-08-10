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

    List<Product> outOfStocksList = new ArrayList<>();

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
        
        String newVariantProductID = request.getParameter("newVariantProductID");
        if (newVariantProductID != null) {
            int size = Integer.parseInt(request.getParameter("newVariantSize"));
            String color = request.getParameter("newVariantColor");
            int quantity = Integer.parseInt(request.getParameter("newVariantQuantity"));
            int productID = Integer.parseInt(request.getParameter("newVariantProductID"));
            
            smDAO.addNewProductVariant(productID, size, color, quantity, 1);
            request.setAttribute("openPopup", "popup_" + productID);
        }

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();
        
        //Debugging
//        request.setAttribute("openPopup", "popup_" + 1);

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

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();

        request.setAttribute("productsList", productsList);
        request.setAttribute("productsStocksList", productsStocksList);

        String confirmYes = request.getParameter("confirmYes");
        String confirmNo = request.getParameter("confirmNo");
        if (confirmYes != null) {
            for (Product product : outOfStocksList) {
                smDAO.setProductStock(product.getStockID(), 0);
            }
            outOfStocksList.clear();

            productsStocksList = smDAO.getProductsStocks();
            request.setAttribute("productsStocksList", productsStocksList);
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        } else if (confirmNo != null) {
            outOfStocksList.clear();
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        }

        String outOfStocksProductName = null;
        Map stocksData = request.getParameterMap();
        for (Object key : stocksData.keySet()) {
            String keyString = (String) key;
            String[] value = (String[]) stocksData.get(keyString);
            keyString = keyString.replaceAll("[^\\d]", "");
            System.out.println("Key " + keyString + "   :   " + value[0]);

            if (value[0].trim().equalsIgnoreCase("")) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('One or more quantities is empty!');");
                out.println("</script>");
                return;
            }

            int stockID = Integer.parseInt(keyString);
            int quantity = Integer.parseInt(value[0]);

            if (quantity == 0) {
                Product outOfStockProduct = smDAO.getProductStockByStockID(stockID);
                if (smDAO.getProductStockQuantityByID(stockID) != 0) {
                    outOfStocksList.add(outOfStockProduct);
                    outOfStocksProductName = smDAO.getProductNameByID(outOfStockProduct.getProductId());
                    System.out.println(outOfStocksProductName);
                }
                continue;
            }

            smDAO.setProductStock(stockID, quantity);
        }

        if (outOfStocksList.size() != 0) {
            request.setAttribute("outOfStocksList", outOfStocksList);
            request.setAttribute("outOfStocksProductName", outOfStocksProductName);
            request.setAttribute("popupDisplay", "display: block;");
            //Debugging
            System.out.println("Products variants out of stock:");
            for (Product product : outOfStocksList) {
                System.out.println(smDAO.getProductNameByID(product.getProductId())
                        + " : " + product.getSize() + " : " + product.getColor());
            }
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        }

        productsStocksList = smDAO.getProductsStocks();
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
