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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet EditProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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

        // Create a Product object and set its properties
        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setOrigin(origin);
        product.setMaterial(material);
        product.setPrice(price);
        product.setBrandId(brandId);
        product.setCategoryId(categoryId);

        // Use the DAO to update the product
        ProductDetailsDAO pDAO = new ProductDetailsDAO();
        boolean isUpdated = pDAO.updateProduct(product);

        // Redirect back to the product list page with a success message
        if (isUpdated) {
            response.sendRedirect("productList.jsp?message=Product updated successfully");
        } else {
            response.sendRedirect("productList.jsp?error=Failed to update product");
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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

            // Tạo đối tượng Product với thông tin mới
            // một là sửa lại contructor hai là phải thêm hai hàm khác để tim brand id với category name
            Product updatedProduct = new Product(productId, productName, origin, material, price, brandId, categoryId);

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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
