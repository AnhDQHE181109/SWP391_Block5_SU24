package Controller;

import entity.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductDetailsDAO;

public class EditProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDetailsDAO dao = new ProductDetailsDAO();
            Product product = dao.getProductById(productId);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("brands", dao.getAllBrands());
                request.setAttribute("categories", dao.getAllCategories());
                request.getRequestDispatcher("/staff/editproduct.jsp").forward(request, response);
            } else {
                response.sendRedirect("productlist.jsp?error=Product not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("productlist.jsp?error=Invalid product ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productlist.jsp?error=An unexpected error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName").trim();
            String origin = request.getParameter("origin").trim();
            String material = request.getParameter("material").trim();
            double price = Double.parseDouble(request.getParameter("price").trim());
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int productStatus = Integer.parseInt(request.getParameter("productStatus"));

            if (productName.isEmpty() || origin.isEmpty() || material.isEmpty()) {
                response.sendRedirect("EditProductController?productId=" + productId + "&error=All fields are required.");
                return;
            }

            if (price <= 0 || price > 100000000) {
                response.sendRedirect("EditProductController?productId=" + productId + "&error=Price must be between 0 and 100,000,000 VND.");
                return;
            }

            ProductDetailsDAO pDAO = new ProductDetailsDAO();

            if (pDAO.isProductNameExists(productName, productId)) {
                response.sendRedirect("EditProductController?productId=" + productId + "&error=Product name already exists.");
                return;
            }

            Product product = new Product(productId, productName, origin, material, price, categoryId, brandId);
            product.setProductStatus(productStatus);

            boolean updateSuccess = pDAO.updateProduct(product);

            if (updateSuccess) {
                response.sendRedirect("stocksManager?success=Product updated successfully");
            } else {
                response.sendRedirect("EditProductController?productId=" + productId + "&error=Failed to update product.");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("productlist.jsp?error=Invalid input format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productlist.jsp?error=An unexpected error occurred");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}