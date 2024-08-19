/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Util.Validator;
import java.io.IOException;
import java.io.PrintWriter;
import model.AccountDAO;
import entity.Account;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author nobbe
 */
@WebServlet(name = "AccountManagementController", urlPatterns = {"/AccountManagementController"})
public class AccountManagementController extends HttpServlet {

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
         AccountDAO accountDAO = new AccountDAO();
        HttpSession session = request.getSession();
        // Get staff accounts (assuming role 2 is for staff)
        List<Account> staffAccounts = accountDAO.getAccountsByRole(2);
        request.setAttribute("staffAccounts", staffAccounts);
        
        // Get user accounts (assuming role 1 is for users)
        List<Account> userAccounts = accountDAO.getAccountsByRole(1);
        request.setAttribute("userAccounts", userAccounts);
        if("true".equals(session.getAttribute("auth_error"))){
        request.setAttribute("auth_error", "true");
        session.setAttribute("auth_error", "false");
        }
        // Forward to the JSP page
        request.getRequestDispatcher("admin/manage_acc.jsp").forward(request, response);
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
        processRequest(request, response);
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
        int accountId = Integer.parseInt(request.getParameter("id"));
        String newEmail = request.getParameter("email");
        String newPhoneNumber = request.getParameter("phoneNumber");
        String newAddress = request.getParameter("address");

        Validator validator = new Validator();
        AccountDAO accountDAO = new AccountDAO();

        if (!validator.isValidEmail(newEmail)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid email format.");
            return;
        }

        if (!validator.isEmailUnique(newEmail)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Email is already taken.");
            return;
        }

        if (!validator.isValidPhoneNumber(newPhoneNumber)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid phone number format.");
            return;
        }

        if (!validator.isPhoneNumberUnique(newPhoneNumber)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Phone number is already taken.");
            return;
        }

        try {
            boolean updated = accountDAO.updateAccount(accountId, newEmail, newPhoneNumber, newAddress);
            if (updated) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Success");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error updating the account.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating the account: " + e.getMessage());
            e.printStackTrace();
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
