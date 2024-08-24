package Controller;

import entity.ProductImage;
import entity.Stock;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOProduct;
import model.DAOProductImages;
import model.DAOStock;

/**
 *
 * @author asus
 */
public class AddVariantController extends HttpServlet {

  
 
    private DAOStock daoStock;
    private DAOProductImages daoProductImages;
    private DAOProduct daoProduct; // Add DAOProduct instance

    public void init() {
        daoStock = new DAOStock();
        daoProductImages = new DAOProductImages();
        daoProduct = new DAOProduct(); // Initialize DAOProduct
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int productID = Integer.parseInt(request.getParameter("productID"));
        String[] colors = request.getParameterValues("colors[]");
        String[] imageURLs = request.getParameterValues("imageURLs[]");

        if (colors == null || imageURLs == null || colors.length != 5 || imageURLs.length != 5) {
            throw new IllegalArgumentException("You must provide exactly 5 colors and 5 image URLs.");
        }

        for (int i = 0; i < colors.length; i++) {
            String color = colors[i];
            String imageURL = imageURLs[i];

            // Create a stock object for each color
            Stock stock = new Stock();
            stock.setProductID(productID);
            stock.setColor(color);
            stock.setStockQuantity(0); // Default stock quantity

            List<Integer> generatedStockIDs = daoStock.addStock(stock);

            if (!generatedStockIDs.isEmpty()) {
                int stockID = generatedStockIDs.get(0);

                // Add product image
                ProductImage productImage = new ProductImage();
                productImage.setStockID(stockID);
                productImage.setImageURL(imageURL);

                int imageId = daoProductImages.addProductImage(productImage);

                if (imageId != -1) {
                    // Update the Products table with the new ImageID
                    daoProduct.updateProductImage(productID, imageId);

                    // Automatically add sizes from 35 to 42 for each color
                    for (int size = 35; size <= 42; size++) {
                        Stock sizeStock = new Stock();
                        sizeStock.setProductID(productID);
                        sizeStock.setColor(color);
                        sizeStock.setSize(size);
                        sizeStock.setStockQuantity(0); // Default stock quantity
                        daoStock.addStock(sizeStock);
                    }
                } else {
                    throw new Exception("Failed to add the product image.");
                }
            } else {
                throw new Exception("Failed to add the stock.");
            }
        }
        response.sendRedirect("variantSuccess.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "An error occurred while processing your request.");
        request.getRequestDispatcher("addvariant.jsp").forward(request, response);
    }
}

    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Get productID from request
        String productIDStr = request.getParameter("productID");
        if (productIDStr == null || productIDStr.isEmpty()) {
            throw new IllegalArgumentException("Product ID is missing");
        }

        int productID = Integer.parseInt(productIDStr);

        // Set productID as a request attribute and forward to addvariant.jsp
        request.setAttribute("productID", productID);
        request.getRequestDispatcher("staff/addvariant.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
    } catch (IllegalArgumentException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
    }
}


    @Override
    public String getServletInfo() {
        return "AddVariantController handles the addition of product variants and their images.";
    }
}