/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

import model.WishlistDAO;  // Adjust the package name based on your project structure
import entity.Account;      // Adjust the package name based on your project structure
import entity.Product;      // Adjust the package name based on your project structure
import java.io.PrintWriter;
import model.ShoppingCartDAO;

/**
 *
 * @author nobbe
 */
@WebServlet(name = "WishlistController", urlPatterns = {"/WishlistController"})
public class WishlistController extends HttpServlet {

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
            out.println("<title>Servlet WishlistController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WishlistController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            WishlistDAO wishlistDAO = new WishlistDAO();
            String search = request.getParameter("search");
            String sort = request.getParameter("sort"); // Get the sort parameter
            List<Product> wishlistItems;
            
            ShoppingCartDAO scDAO = new ShoppingCartDAO();
            int cartItemsCount = scDAO.getCartItemsByAccountID(account.getAccountID()).size();

            if (search != null && !search.trim().isEmpty()) {
                wishlistItems = wishlistDAO.searchWishlistItemsByName(account.getAccountID(), search);
            } else {
                wishlistItems = wishlistDAO.getWishlistItems(account.getAccountID(), sort); // Pass the sort parameter
            }

            request.setAttribute("wishlistItems", wishlistItems);
            request.setAttribute("cartItemsCount", cartItemsCount);
            RequestDispatcher dispatcher = request.getRequestDispatcher("customer/wishlist.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("../login.jsp");
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
        processRequest(request, response);
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
