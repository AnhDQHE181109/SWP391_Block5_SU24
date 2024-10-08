/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.ShoppingCartItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ProductDetailsDAO;
import model.ShoppingCartDAO;

/**
 *
 * @author ASUS
 */
public class ShoppingCartController extends HttpServlet {

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
            out.println("<title>Servlet ShoppingCartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShoppingCartController at " + request.getContextPath() + "</h1>");
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

        ShoppingCartDAO scDAO = new ShoppingCartDAO();
        ProductDetailsDAO pdDAO = new ProductDetailsDAO();

        String removalConfirmation = null;
        String quantityUpdateFor = request.getParameter("quantityUpdateFor");
        String quantityAmountIn = request.getParameter("quantityAmount");
        if (quantityUpdateFor != null) {
            quantityUpdateFor = quantityUpdateFor.replaceAll("[^-?0-9]+", "");

            int updatedStockID = Integer.parseInt(quantityUpdateFor);
            int quantityAmount = Integer.parseInt(quantityAmountIn);

            int quantityInDB = scDAO.getStockQuantityOfStockID(updatedStockID);

            if (quantityAmount == 0) {
                removalConfirmation = "confirmRemoval_" + updatedStockID;
            } else {
                if (quantityAmount > quantityInDB) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert(\"You've achieved the maximum amount for ordering such variant!\")");
                    out.println("location.href='shoppingCart';");
                    out.println("</script>");
                    return;
                }
                scDAO.setCartQuantity(quantityAmount, accountID, updatedStockID);
            }

        }

        String removedProduct = request.getParameter("removedProduct");
        if (removedProduct != null) {
            int removedProductStockID = Integer.parseInt(removedProduct);

            scDAO.removeProductFromCart(accountID, removedProductStockID);
        }

        int cartItemsCount = pdDAO.getCartItemsCount(accountID);

//        String shippingType = request.getParameter("shippingType");
//        double shippingFee = 0;
//        if (shippingType != null) {
//            if (shippingType.equalsIgnoreCase("ecoRadioBox")) {
//                shippingFee = 0.0;
//            } else {
//                shippingFee = 15.0;
//            }
//        } else {
//            shippingType = "ecoRadioBox";
//        }
        List<ShoppingCartItem> cartItems = scDAO.getCartItemsByAccountID(accountID);

        request.setAttribute("cartItemsCount", cartItemsCount);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("removalConfirmation", removalConfirmation);
//        request.setAttribute("shippingFee", shippingFee);
//        request.setAttribute("shippingType", shippingType);
        request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
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

        ShoppingCartDAO scDAO = new ShoppingCartDAO();
        ProductDetailsDAO pdDAO = new ProductDetailsDAO();

        String selectedColor = request.getParameter("selectedColor");
        String selectedSizeIn = request.getParameter("selectedSize");
        String quantityIn = request.getParameter("quantity");
        String productIDin = request.getParameter("selectedProductID");

        int selectedSize = Integer.parseInt(selectedSizeIn);
        int quantity = Integer.parseInt(quantityIn);
        int productID = Integer.parseInt(productIDin);

        int stockID = pdDAO.getStockIDbyColorAndSizeAndProductID(selectedColor, selectedSize, productID);

        if (quantity > scDAO.getStockQuantityOfStockID(stockID)) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert(\"You've achieved the maximum amount for ordering such variant!\")");
            out.println("window.history.go(-1);");
            out.println("</script>");
            return;
        }

        int quantityInCart = scDAO.getCartQuantityOfStockID(accountID, stockID);

        int quantityInDB = scDAO.getStockQuantityOfStockID(stockID);

        //Debugging
        System.out.println("quantityInCart: " + quantityInCart);

        if (quantityInCart < 1) {
            scDAO.addProductToCart(accountID, stockID, quantity, productID);
        } else {
            if ((quantityInCart + quantity) > quantityInDB) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert(\"You've achieved the maximum amount for ordering such variant!\")");
                out.println("window.history.go(-1);");
                out.println("</script>");
                return;
            }

            scDAO.setCartQuantity(quantityInCart + quantity, accountID, stockID);
        }

//        if (quantityInCart < 1) {
//            scDAO.addProductToCart(accountID, stockID, quantity, productID);
//        } else if (quantityInCart >= 1 && quantityInCart < 10) {
//            if ((quantityInCart + quantity) > 10) {
//                out.println("<script type=\"text/javascript\">");
//                out.println("alert(\"You've achieved the maximum amount for ordering such variant, please contact us if you want to order more than 10!\")");
//                out.println("window.history.go(-1);");
//                out.println("</script>");
//                return;
//            }
//            scDAO.setCartQuantity(quantityInCart + quantity, accountID, stockID);
//        } else if (quantityInCart >= 10) {
//            out.println("<script type=\"text/javascript\">");
//            out.println("alert(\"You've achieved the maximum amount for ordering such variant, please contact us if you want to order more than 10!\")");
//            out.println("window.history.go(-1);");
//            out.println("</script>");
//            return;
//        }
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Added to your cart!')");
        out.println("location.href=\"shoppingCart\"");
        out.println("</script>");
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
