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
import model.ProductDetailsDAO;

/**
 *
 * @author Admin
 */
public class AddProductController extends HttpServlet {

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
            out.println("<title>Servlet AddProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        try {
        ProductDetailsDAO pDAO = new ProductDetailsDAO();

        String productName = request.getParameter("productName").trim();
        String origin = request.getParameter("origin").trim();
        String material = request.getParameter("material").trim();
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int brandId = Integer.parseInt(request.getParameter("brandId"));

        boolean hasErrors = false;

        // Validate inputs
        if (productName.isEmpty() || origin.isEmpty() || material.isEmpty()) {
            request.setAttribute("validationError", "Product name, origin, and material cannot be empty.");
            hasErrors = true;
        }

        if (price < 0 || price > 100000000) {
            request.setAttribute("priceError", "Price must be between 0 and 100,000,000.");
            hasErrors = true;
        }

        // Check if the product name already exists
        boolean isProductExists = pDAO.isProductNameExists(productName);
        if (isProductExists) {
            request.setAttribute("productNameError", "Product name already exists.");
            hasErrors = true;
        }

        if (hasErrors) {
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
            return;
        }

        Product product = new Product(productName, origin, material, price, categoryId, brandId);
        pDAO.addProduct(product);

        response.sendRedirect("productmanage.jsp?status=success");
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("validationError", "An error occurred while adding the product.");
        request.getRequestDispatcher("addproduct.jsp").forward(request, response);
    }
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
