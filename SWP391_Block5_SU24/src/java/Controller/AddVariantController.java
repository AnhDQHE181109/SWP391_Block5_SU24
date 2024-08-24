package Controller;

import entity.ProductImage;
import entity.Stock;
import entity.Discount; // Ensure this class exists
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOProduct;
import model.DAOProductImages;
import model.DAOStock;
import model.DAODiscount; // Import DAODiscount

public class AddVariantController extends HttpServlet {

    private DAOStock daoStock;
    private DAOProductImages daoProductImages;
    private DAOProduct daoProduct;
    private DAODiscount daoDiscount; // Add DAODiscount instance

    @Override
    public void init() {
        daoStock = new DAOStock();
        daoProductImages = new DAOProductImages();
        daoProduct = new DAOProduct();
        daoDiscount = new DAODiscount(); // Initialize DAODiscount
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String[] colors = request.getParameterValues("colors[]");
            String[] imageURLs = request.getParameterValues("imageURLs[]");

            // Kiểm tra sự tồn tại của ProductID trong bảng Products
            if (daoProduct.getProductById(productID) == null) {
                throw new IllegalArgumentException("Product ID does not exist.");
            }

            // Kiểm tra nếu số lượng màu và URL ảnh hợp lệ
            if (colors == null || imageURLs == null || colors.length != 5 || imageURLs.length != 5) {
                throw new IllegalArgumentException("You must provide exactly 5 colors and 5 image URLs.");
            }

            // Xử lý từng màu và URL ảnh
            for (int i = 0; i < colors.length; i++) {
                String color = colors[i];
                String imageURL = imageURLs[i];

                // Thêm tất cả các size (từ 35 đến 42) cho mỗi màu vào bảng Stock
                for (int size = 38; size <= 42; size++) {
                    Stock stock = new Stock();
                    stock.setProductID(productID);
                    stock.setColor(color);
                    stock.setSize(size);
                    stock.setStockQuantity(0); // Đặt số lượng stock mặc định là 0

                    // Thêm bản ghi vào bảng Stock
                    List<Integer> generatedStockIDs = daoStock.addStock(stock);

                    if (!generatedStockIDs.isEmpty()) {
                        int stockID = generatedStockIDs.get(0);

                        // Thêm URL hình ảnh vào bảng ProductImages cho mỗi StockID
                        ProductImage productImage = new ProductImage();
                        productImage.setStockID(stockID);
                        productImage.setImageURL(imageURL);

                        int imageId = daoProductImages.addProductImage(productImage);

                        if (imageId != -1) {
                            // Cập nhật bảng Products với ImageID mới nếu cần
                            daoProduct.updateProductImage(productID, imageId);
                        } else {
                            throw new Exception("Failed to add the product image.");
                        }
                    } else {
                        throw new Exception("Failed to add the stock.");
                    }
                }
            }

            // Chỉ thêm bản ghi giảm giá nếu nút "Create Add Variant" được nhấn
            String action = request.getParameter("action");
            if ("create".equals(action)) {
                Discount discount = new Discount();
                discount.setProductID(productID);
                discount.setDiscountAmount(0.0); // Đặt discountAmount = 0
                boolean discountAdded = daoDiscount.addDiscount(discount);
                
                System.out.println("productID :" +productID);

                if (!discountAdded) {
                    throw new Exception("Failed to add the discount.");
                }
            }
            
            

            response.sendRedirect("stocksManager");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("addvariant.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");

        if (service != null && service.equals("delete")) {
            // Handle delete product request
            try {
                int productID = Integer.parseInt(request.getParameter("productID"));
                daoProduct.deleteProduct(productID);
                response.sendRedirect("stocksManager"); // Redirect to product list or a suitable page
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete the product.");
            }
        } else {
            // Default GET request handling
            try {
                String productIDStr = request.getParameter("productID");
                if (productIDStr == null || productIDStr.isEmpty()) {
                    throw new IllegalArgumentException("Product ID is missing");
                }

                int productID = Integer.parseInt(productIDStr);
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
    }

    @Override
    public String getServletInfo() {
        return "AddVariantController handles the addition of product variants and their images.";
    }
}
