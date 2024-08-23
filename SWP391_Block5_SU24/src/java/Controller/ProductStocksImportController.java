/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.ProductStockImport;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ProductStocksImportController extends HttpServlet {

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
            out.println("<title>Servlet ProductVariantsImportController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductVariantsImportController at " + request.getContextPath() + "</h1>");
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
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You must be logged in to do that!')");
            out.println("location.href=\"login.jsp\"");
            out.println("</script>");
            return;
        }
        int accountID = account.getAccountID();
        
        List<ProductStockImport> productsList = (List<ProductStockImport>) session.getAttribute("productsList");
        
        String removeProductIn = request.getParameter("removeProduct");
        if (removeProductIn != null) {
            int removeProduct = 0;
            
            try {
                removeProduct = Integer.parseInt(removeProductIn);
            } catch (NumberFormatException e) {
                System.out.println("removeProduct: " + e);
                request.setAttribute("productsList", productsList);
                request.setAttribute("errorMessage", "Invalid request parameter!");
                request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
                return;
            }
            
            productsList.remove(removeProduct - 1);
        }
        
        request.setAttribute("productsList", productsList);
        request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
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
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You must be logged in to do that!')");
            out.println("location.href=\"login.jsp\"");
            out.println("</script>");
            return;
        }
        int accountID = account.getAccountID();
        
        String productName = request.getParameter("productName");
        String productColor = request.getParameter("productColor");
        String productSizeIn = request.getParameter("productSize");
        String supplierName = request.getParameter("supplierName");
        String productQuantityIn = request.getParameter("productQuantity");

//        out.println("POSTED");

        List<ProductStockImport> productsList = (List<ProductStockImport>) session.getAttribute("productsList");

        if (productsList == null) {
            productsList = new ArrayList<>();
            session.setAttribute("productsList", productsList);
        }
        
        int productSize = 0;
        int productQuantity = 0;
        try {
            productSize = Integer.parseInt(productSizeIn);
            productQuantity = Integer.parseInt(productQuantityIn);
        } catch (NumberFormatException e) {
            System.out.println("productSize / productQuantity: " + e);
            request.setAttribute("errorMessage", "Product size or quantity is invalid!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }
        
        ProductStockImport productStock = new 
        ProductStockImport("", supplierName, productName, productColor, productSize, productQuantity);
        
        productsList.add(productStock);
        
        request.setAttribute("productsList", productsList);
        request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
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
