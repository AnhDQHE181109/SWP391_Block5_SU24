/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Util.EncryptionHelper;
import Util.Validator;
import java.io.PrintWriter;
import model.AccountDAO;
import entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;

/**
 *
 * @author nobbe
 */
public class UpdateAccountController extends HttpServlet {

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
            out.println("<title>Servlet UpdateAccountController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccountController at " + request.getContextPath() + "</h1>");
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
        // Get parameters from the form
        String accountId = request.getParameter("accountId");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        AccountDAO accountDAO = new AccountDAO();
        Validator validator = new Validator();
        Account account = accountDAO.getAccountById(Integer.parseInt(accountId));
        
        // Validate input
        if (name == null || name.isEmpty()) {
            request.setAttribute("error", "Name cannot be empty.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
            return;
        }

        if (email == null || !validator.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
            return;
        }

        if (!email.equals(account.getEmail()) && !validator.isEmailUnique(email)) {
            request.setAttribute("error", "Email is already taken.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
            return;
        }

        if (phoneNumber == null || !validator.isValidPhoneNumber(phoneNumber)) {
            request.setAttribute("error", "Invalid phone number.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.equals(account.getPhoneNumber()) && !validator.isPhoneNumberUnique(phoneNumber)) {
            request.setAttribute("error", "Phone number is already taken.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
            return;
        }

        // If the password field is not empty, update the password
        if (password != null && !password.isEmpty()) {
            int passwordValidationResult = Validator.validatePassword(password);
            if (passwordValidationResult != 0) {
                String passwordErrorMessage;
                switch (passwordValidationResult) {
                    case 1:
                        passwordErrorMessage = "Password cannot contain spaces.";
                        break;
                    case 2:
                        passwordErrorMessage = "Password must be more than 8 characters.";
                        break;
                    case 3:
                        passwordErrorMessage = "Password must contain at least one digit and one uppercase letter.";
                        break;
                    default:
                        passwordErrorMessage = "Invalid password.";
                        break;
                }
                request.setAttribute("error", passwordErrorMessage);
                request.setAttribute("account", account);
                request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
                return;
            }

            try {
                String salt = account.getSalt();
                String hashedPassword = EncryptionHelper.hashPassword(password, salt);
                account.setHash(hashedPassword);
            } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
                e.printStackTrace();
                request.setAttribute("error", "An error occurred while processing the password. Please try again.");
                request.setAttribute("account", account);
                request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
                return;
            }
        }

        // Set the rest of the account details
        account.setName(name);
        account.setEmail(email);
        account.setPhoneNumber(phoneNumber);
        account.setAddress(address);
        account.setRole(Integer.parseInt(role));

        // Update the account in the database
        System.out.println(account.getName());
        boolean updateSuccess = accountDAO.updateAccount(account);
        if (updateSuccess) {
            response.sendRedirect(request.getContextPath() + "/admin/manage_acc.jsp?success=Account updated successfully");
        } else {
            request.setAttribute("error", "Failed to update account.");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/manage_acc.jsp").forward(request, response);
        }
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */

    @Override
    public String getServletInfo() {
        return "UpdateAccountController handles updating account details";
}




}
