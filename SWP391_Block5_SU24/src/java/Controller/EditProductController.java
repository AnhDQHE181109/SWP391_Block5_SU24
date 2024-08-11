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
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String origin = request.getParameter("origin");
        String material = request.getParameter("material");
        double price = Double.parseDouble(request.getParameter("price"));
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Product product = new Product(productId, productName, origin, material, price, categoryId, brandId);

        ProductDetailsDAO pDAO = new ProductDetailsDAO();
        try {
            pDAO.updateProduct(product);
            response.sendRedirect("productmanage.jsp"); // Redirect to the product list on success
        } catch (RuntimeException e) {
            request.setAttribute("error", "Failed to update product: " + e.getMessage());
            request.getRequestDispatcher("productmanage.jsp").forward(request, response); // Forward to the same page with an error message
        }
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
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            String origin = request.getParameter("origin");
            String material = request.getParameter("material");
            double price = Double.parseDouble(request.getParameter("price"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            if (productName.isBlank() || origin.isBlank() || material.isBlank()) {
                request.setAttribute("mess", "Input must not be blank");
                request.getRequestDispatcher("productmanage.jsp").forward(request, response);
                return;
            }
            // Tạo đối tượng Product với thông tin mới
            // một là sửa lại contructor hai là phải thêm hai hàm khác để tim brand id với category name
            Product updatedProduct = new Product(productId, productName.trim(), origin.trim(), material.trim(), price, categoryId, brandId);

            // Cập nhật thông tin sản phẩm
            boolean updateSuccess = pDAO.updateProduct(updatedProduct);

            if (updateSuccess) {
                response.sendRedirect("productmanage.jsp?status=updated");
            } else {
                response.sendRedirect("productmanage.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productmanage.jsp?status=error");
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
