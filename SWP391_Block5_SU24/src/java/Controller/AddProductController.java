package Controller;

import entity.Account;
import entity.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOProduct;

public class AddProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Your existing processRequest code, if needed
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Retrieve form parameters
        String productName = request.getParameter("productName");
        String origin = request.getParameter("origin");
        String material = request.getParameter("material");
        String priceStr = request.getParameter("price");
        String categoryIdStr = request.getParameter("categoryId");
        String brandIdStr = request.getParameter("brandId");
        String productStatusStr = request.getParameter("productStatus");

        // Convert form parameters to appropriate data types
        double price = Double.parseDouble(priceStr);
        int categoryId = Integer.parseInt(categoryIdStr);
        int brandId = Integer.parseInt(brandIdStr);
        int productStatus = Integer.parseInt(productStatusStr);

        // Create Product object
        Product product = new Product();
        product.setProductName(productName);
        product.setOrigin(origin);
        product.setMaterial(material);
        product.setPrice(price);
        product.setCategoryId(categoryId);
        product.setBrandId(brandId);
        product.setProductStatus(productStatus);

        // Use DAO to add product to the database
        DAOProduct daoProduct = new DAOProduct();
        daoProduct.addProduct(product);

        // Retrieve the latest product ID
        int latestProductId = daoProduct.getLatestProductId();

        // Get the accountID from the session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account != null) {
            int accountId = account.getAccountID();
            // Store accountID and latestProductId in the session
            session.setAttribute("accountID", accountId);
            session.setAttribute("latestProductId", latestProductId);
            System.out.println("accountId :" +accountId);
            System.out.println("latestProductId : "+latestProductId);
        }

        request.setAttribute("productID", latestProductId);

        // Use sendRedirect to navigate to AddVariantController
        response.sendRedirect("AddVariantController?productID=" + latestProductId);
      
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        if (account.getRole() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding a new product.";
    }
}
