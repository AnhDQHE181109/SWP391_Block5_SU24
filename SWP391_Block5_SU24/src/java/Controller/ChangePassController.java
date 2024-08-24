/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Util.EncryptionHelper;
import Util.Validator;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AccountDAO;

/**
 *
 * @author Long
 */
public class ChangePassController extends HttpServlet {

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
            out.println("<title>Servlet ChangePassController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassController at " + request.getContextPath() + "</h1>");
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
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String email = request.getParameter("email");
        boolean hasErrors = false;

        if (!repassword.equals(password)) {
            hasErrors = true;
            request.setAttribute("error_password_dupe", "true");
        } else if (Validator.validatePassword(password) == 1) {
            hasErrors = true;
            request.setAttribute("error_password_invalid", "true");
        } else if (Validator.validatePassword(password) == 2) {
            hasErrors = true;
            request.setAttribute("error_password_short", "true");
        } else if (Validator.validatePassword(password) == 3) {
            hasErrors = true;
            request.setAttribute("error_password", "true");
        }
        if (hasErrors) {
            request.setAttribute("autho", "true");
            request.getRequestDispatcher("customer/auth_change_pass.jsp").forward(request, response);
        } else {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = "";
            try {
                hashedPassword = EncryptionHelper.hashPassword(password, salt);
            } catch (Exception e) {
            }
            HttpSession session = request.getSession();
            AccountDAO adao = new AccountDAO();
            Account temp = adao.getAccountbyEmail(email);
            try {
                String t = EncryptionHelper.hashPassword(password, temp.getSalt());
                System.out.println(t);
                System.out.println(temp.getSalt());
                if (t.equals(temp.getHash())) {
                    request.setAttribute("autho", "true");
                    request.setAttribute("error_password_match", "true");
                    request.getRequestDispatcher("customer/auth_change_pass.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
            }
            adao.changePassword(email, hashedPassword, salt);
            request.setAttribute("suchange", "true");
            session.setAttribute("account", adao.getAccountbyEmail(email));
            request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
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
        String pass = request.getParameter("password");
        String username = request.getParameter("curuname");

        AccountDAO adao = new AccountDAO();
        if (adao.validateAccount(username, pass) != 1) {
            request.setAttribute("error_auth_pass", "true");
            request.getRequestDispatcher("customer/customer_profile.jsp?error_auth_pass=true").forward(request, response);
        } else {
            request.setAttribute("autho", "true");
            request.getRequestDispatcher("customer/auth_change_pass.jsp").forward(request, response);
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
