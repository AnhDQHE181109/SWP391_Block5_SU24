/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Util.EncryptionHelper;
import Util.Validator;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AccountDAO;

/**
 *
 * @author Long
 */
public class SignUpController extends HttpServlet {

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
            out.println("<title>Servlet SignUpController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpController at " + request.getContextPath() + "</h1>");
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String pnum = request.getParameter("pnum");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String repassword = request.getParameter("repassword");
        boolean hasErrors = false;
        AccountDAO adao = new AccountDAO();

        if (username == null || username.isEmpty()) {
            hasErrors = true;
            request.setAttribute("error_username", "true");
        }
        if (adao.isUsernameTaken(username)) {
            hasErrors = true;
            request.setAttribute("error_usernametaken", "true");
        }
        if (!repassword.equals(password)) {
            hasErrors = true;
            request.setAttribute("error_password_dupe", "true");
        }
        if (!Validator.validatePassword(password)) {
            hasErrors = true;
            request.setAttribute("error_password", "true");
        }

        if (adao.isEmailTaken(email)) {
            hasErrors = true;
            request.setAttribute("error_emailtaken", "true");
        }
        if (hasErrors) {
            request.setAttribute("username", username);
            request.setAttribute("pnum", pnum);
            request.setAttribute("email", email);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = "";
            try {
                hashedPassword = EncryptionHelper.hashPassword(password, salt);
            } catch (Exception e) {
            }
            
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
