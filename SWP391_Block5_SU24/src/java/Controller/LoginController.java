/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AccountDAO;

/**
 *
 * @author Long
 */
public class LoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        if(request.getAttribute("auth_error")!=null){
        response.sendRedirect("login.jsp");
        return;
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        int role = Integer.parseInt(request.getParameter("role"));
        AccountDAO adao = new AccountDAO();
        if (adao.validateAccount(username, password) == 1) { //return 1 login successful
            if (!adao.getAccount(username).isStatus()) {
                request.setAttribute("error_active", "true");
                request.setAttribute("username", username);
                response.sendRedirect("login.jsp?error=Account is unavailable");
                return;
            }
            Cookie loginCookie = new Cookie("user", username);
            loginCookie.setMaxAge(30 * 60);
            response.addCookie(loginCookie);
            HttpSession session = request.getSession();
            session.setAttribute("account", adao.getAccount(username));
            switch (adao.getAccount(username).getRole()) {
                case 1: {
                    response.sendRedirect("index.jsp");
                    break;
                }
                case 2: {
                    response.sendRedirect("stocksManager");
                    break;
                }
                case 3: {
                    response.sendRedirect("manager/manager_home.jsp");
                    break;
                }
                case 4: {
                    response.sendRedirect("");
                    break;
                }
                default: {
                    response.sendRedirect("login.jsp");
                    break;
                }
            }
        } else if (adao.validateAccount(username, password) == 2) { //return 2 login failed
            request.setAttribute("username", username);
            response.sendRedirect("login.jsp?error=Wrong username or password.");
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
