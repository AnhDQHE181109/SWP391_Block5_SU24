/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AccountDAO;
import Util.EncryptionHelper;
import Util.Validator;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

/**
 *
 * @author nobbe
 */
@WebServlet(name = "CreateStaffController", urlPatterns = {"/CreateStaffController"})
public class CreateStaffController extends HttpServlet {
    private static final long serialVersionUID = 1L;
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
            out.println("<title>Servlet CreateStaffController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateStaffController at " + request.getContextPath() + "</h1>");
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
    // Collect input parameters
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        int role = 2; // Assuming role '2' is for staff

        Validator validator = new Validator();
        AccountDAO accountDAO = new AccountDAO();

        // Server-side validation
        if (!validator.isValidUsername(username)) {
            request.setAttribute("message", "Invalid username.");
            request.getRequestDispatcher("admin/addStaffAccount.jsp").forward(request, response);
            return;
        }

        if (!validator.isValidPassword(password)) {
            request.setAttribute("message", "Invalid password.");
            request.getRequestDispatcher("admin/addStaffAccount.jsp").forward(request, response);
            return;
        }

        if (!validator.isValidEmail(email) || accountDAO.isEmailTaken(email)) {
            request.setAttribute("message", "Invalid or duplicate email.");
            request.getRequestDispatcher("admin/addStaffAccount.jsp").forward(request, response);
            return;
        }

        if (!validator.isValidPhoneNumber(phoneNumber) || accountDAO.isPhoneNumberTaken(phoneNumber)) {
            request.setAttribute("message", "Invalid or duplicate phone number.");
            request.getRequestDispatcher("admin/addStaffAccount.jsp").forward(request, response);
            return;
        }

        try {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = EncryptionHelper.hashPassword(password, salt);

            // Add the account using the AccountDAO method provided
            boolean accountCreated = accountDAO.addAccount(username, hashedPassword, phoneNumber, email, address, role, salt, fullname);

            if (accountCreated) {
                // Redirect to manage_acc.jsp after successful creation
                response.sendRedirect("admin/manage_acc.jsp");
                return; // Important to return after redirect to avoid further processing
            } else {
                request.setAttribute("message", "Failed to create account. Please try again.");
            }
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred during account creation.");
        }

        // If account creation failed, forward back to the form
        request.getRequestDispatcher("admin/addStaffAccount.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    
    
    

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
