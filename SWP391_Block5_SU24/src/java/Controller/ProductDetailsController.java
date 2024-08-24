/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductDetailsDAO;
import entity.ProductDetails;
import entity.ProductStockDetails;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ProductDetailsController extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailsController at " + request.getContextPath() + "</h1>");
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
        int accountID = 0;
        if (account != null) {
            accountID = account.getAccountID();
        }

        ProductDetailsDAO pdDAO = new ProductDetailsDAO();

        String selectedColor = request.getParameter("selectedColor");
        String selectedSize = request.getParameter("selectedSize");
        String productIDin = request.getParameter("productID");
        if (productIDin != null) {
            int productID = 0;

            try {
                productID = Integer.parseInt(productIDin);
            } catch (NumberFormatException e) {
                System.out.println(e);
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error, invalid product ID!');");
                out.println("</script>");
                return;
            }

            ProductDetails productDetails = pdDAO.getProductDetails(productID);
            List<ProductStockDetails> productColors = pdDAO.getProductColors(productID);
            List<Feedback> feedbacksList = pdDAO.getFeedbacksForProductID(productID);
            
            int cartItemsCount = pdDAO.getCartItemsCount(accountID);

            //The index of the image to be displayed in the owl carousel image slider
            int displayedImage = 0;

            if (selectedColor == null) {
                selectedColor = productColors.get(0).getColor();
            }
            for (ProductStockDetails productColor : productColors) {
                if (selectedColor.equalsIgnoreCase(productColor.getColor())) {
                    displayedImage = productColors.indexOf(productColor);
                    break;
                }
            }
            List<ProductStockDetails> productSizes = pdDAO.getSizesByColorAndProductID(productID, selectedColor);
            
            int count = 0;
            for (ProductStockDetails productSize : productSizes) {
                if (productSize.getStockQuantity() == 0) {
                    productSizes.remove(count);
                }
                count++;
            }

            
            if (selectedSize == null) {
                selectedSize = productSizes.get(0).getSize() + "";
            }

            request.setAttribute("productDetails", productDetails);
            request.setAttribute("feedbacksList", feedbacksList);
            request.setAttribute("productColors", productColors);
            request.setAttribute("productSizes", productSizes);
            request.setAttribute("cartItemsCount", cartItemsCount);
            request.setAttribute("selectedColor", selectedColor);
            request.setAttribute("selectedSize", selectedSize);
            request.setAttribute("selectedColorButton", selectedColor + "_" + productIDin);
            request.setAttribute("selectedSizeButton", "Size_" + selectedSize);
            request.setAttribute("displayedImage", displayedImage + "");
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);
        } else if (request.getParameter("addToWishlistProduct") != null) {
            if (accountID == 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You must be logged in to do that!')");
                out.println("location.href=\"login.jsp\"");
                out.println("</script>");
                return;
            }

            String addToWishlistProductIn = request.getParameter("addToWishlistProduct");
            String addToWishlistColor = request.getParameter("addToWishlistColor");
            String addToWishlistSizeIn = request.getParameter("addToWishlistSize");

            int addToWishlistProduct = Integer.parseInt(addToWishlistProductIn);
            int addToWishlistSize = Integer.parseInt(addToWishlistSizeIn);

            int stockID = pdDAO.getStockIDbyColorAndSizeAndProductID(addToWishlistColor, addToWishlistSize, addToWishlistProduct);

            if (pdDAO.getWishlistItemExists(accountID, stockID)) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You already added such product variant into your wishlist!')");
                out.println("window.history.go(-1);");
                out.println("</script>");
                return;
            }
            
            pdDAO.addProductToWishlist(accountID, stockID);
            
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You have added the selected variant to your wishlist!')");
            out.println("window.history.go(-1);");
            out.println("</script>");

        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("window.history.go(-1);");
            out.println("</script>");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
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
