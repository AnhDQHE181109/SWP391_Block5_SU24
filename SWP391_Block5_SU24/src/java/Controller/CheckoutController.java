/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.CheckoutItem;
import entity.ShoppingCartItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.CheckoutDAO;
import model.ProductDetailsDAO;
import model.ShoppingCartDAO;

/**
 *
 * @author ASUS
 */
public class CheckoutController extends HttpServlet {

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
            out.println("<title>Servlet CheckoutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutController at " + request.getContextPath() + "</h1>");
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
        
//        String shippingFeeIn = request.getParameter("shippingFee");
//        if (shippingFeeIn == null) {
//            out.println("<script type=\"text/javascript\">");
//            out.println("window.history.go(-1);");
//            out.println("</script>");
//            return;
//        } else {
//            double shippingFee = Double.parseDouble(shippingFeeIn);
//            
//            request.setAttribute("shippingFee", shippingFee);
//        }
        
        ShoppingCartDAO scDAO = new ShoppingCartDAO();
        ProductDetailsDAO pdDAO = new ProductDetailsDAO();
        CheckoutDAO coDAO = new CheckoutDAO();
        
        int cartItemsCount = pdDAO.getCartItemsCount(accountID);
        if (cartItemsCount == 0 || !request.getHeader("referer").contains("shoppingCart")) {
            //Debugging
            System.out.println("Checkout GET referer: " + request.getHeader("referer"));
            
            out.println("<script type=\"text/javascript\">");
            out.println("window.history.go(-1);");
            out.println("</script>");
            return;
        }
        CheckoutItem billingDetails = coDAO.getBillingDetails(accountID);
        
        List<ShoppingCartItem> cartItems = scDAO.getCartItemsByAccountID(accountID);
        
        //Debugging
//        System.out.println("Referer: " + request.getHeader("referer"));

        request.setAttribute("cartItemsCount", cartItemsCount);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("billingDetails", billingDetails);
        
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
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
        
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        
//        if (fullname == null || address == null || email == null || phoneNumber == null) {
//            out.println("<script type=\"text/javascript\">");
//            out.println("window.history.go(-1);");
//            out.println("</script>");
//            return;
//        }

        ProductDetailsDAO pdDAO = new ProductDetailsDAO();
        int cartItemsCount = pdDAO.getCartItemsCount(accountID);

        if (!request.getHeader("referer").contains("CheckoutController") || cartItemsCount == 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("location.href=\"home.jsp\"");
            out.println("</script>");
            return;
        }
        
        CheckoutDAO coDAO = new CheckoutDAO();
        
        String userFullname = coDAO.getNameByAccountID(accountID);
        coDAO.addCartToOrder(accountID);
        
        request.setAttribute("userFullname", userFullname);
        request.getRequestDispatcher("customer/order-complete.jsp").forward(request, response);
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
