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
public class EditProductController extends HttpServlet {

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
            out.println("<title>Servlet EditProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProduct at " + request.getContextPath() + "</h1>");
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
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName").trim();
            String origin = request.getParameter("origin").trim();
            String material = request.getParameter("material").trim();
            String priceStr = request.getParameter("price").trim();

            double price = 0;

            if (productName.isEmpty() || origin.isEmpty() || material.isEmpty() || priceStr.isEmpty()) {
                response.sendRedirect("staff/editproduct.jsp?error=All fields are required.");
                return;
            }

            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0 || price > 100000000) {
                    response.sendRedirect("staff/editproduct.jsp?error=Price must be between 0 and 100,000,000 VND.");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("staff/editproduct.jsp?error=Invalid price format.");
                return;
            }

            ProductDetailsDAO pDAO = new ProductDetailsDAO();

            if (pDAO.isProductNameExists(productName, productId)) {
                response.sendRedirect("staff/editproduct.jsp?error=Product name already exists.");
                return;
            }

            Product product = new Product(productId, productName, origin, material, price, Integer.parseInt(request.getParameter("categoryId")), Integer.parseInt(request.getParameter("brandId")));

            boolean updateSuccess = pDAO.updateProduct(product);

            if (updateSuccess) {
                response.sendRedirect("stocksManager");
            } else {
                response.sendRedirect("staff/editproduct.jsp?error=Failed to update product.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staff/editproduct.jsp?error=An unexpected error occurred.");
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
