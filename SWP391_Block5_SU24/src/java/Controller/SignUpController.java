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
import java.util.regex.Pattern;
import java.util.regex.Matcher;
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
    private static final String EMAIL_REGEX = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        Matcher matcher = EMAIL_PATTERN.matcher(email);
        return matcher.matches();
    }

    public static boolean dotcount(String in) {
        int count = 0;
        for (int i = 0; i < in.length(); i++) {
            if (in.charAt(i) == '.') {
                count++;
            }
            if (count >= 1) {
                System.out.println("oh no");
                return false;
            }
        }
        return true;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String pnum = request.getParameter("pnum");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String repassword = request.getParameter("repassword");
        String name = request.getParameter("name");
        boolean hasErrors = false;
        AccountDAO adao = new AccountDAO();

        if (username == null || username.isEmpty()) {
            hasErrors = true;
            request.setAttribute("error_username", "true");
        }
        if (adao.isUsernameTaken(username)) {
            hasErrors = true;
            request.setAttribute("error_usernametaken", "true");
        } else if (username.length() > 20) {
            hasErrors = true;
            request.setAttribute("error_username_length", "true");
        } else if (!isValidUName(username)) {
            hasErrors = true;
            request.setAttribute("error_username_invalid", "true");
        } else {
            for (char c : username.toCharArray()) {
                if (Character.isWhitespace(c)) {
                    hasErrors = true;
                    request.setAttribute("error_username_invalid", "true");
                    break;
                }
            }
        }
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
        String regexPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
                + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
        if (!isValidEmail(email) || (Character.isDigit(email.charAt(0))) || dotcount(email)) {
            hasErrors = true;
            request.setAttribute("error_email", "true");
        }
        if (adao.isEmailTaken(email)) {
            hasErrors = true;
            request.setAttribute("error_emailtaken", "true");
        }
        if (!isValidName(name)) {
            hasErrors = true;
            request.setAttribute("error_name_invalid", "true");
        }
        if (!pnum.matches("[0-9]+")) {
            hasErrors = true;
            request.setAttribute("error_phone_number", "true");
        } else if (adao.isPhoneNumberTaken(pnum)) {
            hasErrors = true;
            request.setAttribute("error_phone_number_dupe", "true");
        } else if (pnum.length() < 9 || pnum.length() > 11 || !pnum.matches("^(03|05|07|08|09).*")) {
            hasErrors = true;
            request.setAttribute("error_phone_number", "true");
        }
        if (hasErrors) {
            request.setAttribute("username", username);
            request.setAttribute("name", name);
            request.setAttribute("pnum", pnum);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = "";
            try {
                hashedPassword = EncryptionHelper.hashPassword(password, salt);
            } catch (Exception e) {
            }
            adao.addAccount(username, hashedPassword, pnum, email, address, 1, salt, name);
            request.setAttribute("signup_success", "true");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    public static boolean isValidName(String name) {
        String regex = "^[a-zA-Z\\s]+$";
        return name.matches(regex);
    }

    public static boolean isValidUName(String input) {
        String regex = "^[^/\\\\<>&$#%\"()!?\'|]+$";

        return input.matches(regex);
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
