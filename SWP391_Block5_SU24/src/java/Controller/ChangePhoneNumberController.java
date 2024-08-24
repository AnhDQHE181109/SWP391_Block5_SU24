/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import static Controller.SignUpController.isValidEmail;
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
public class ChangePhoneNumberController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ChangePhoneNumberController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePhoneNumberController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        boolean hasErrors = false;
        AccountDAO adao = new AccountDAO();
        int curid = Integer.parseInt(request.getParameter("curid"));
        String pnum = request.getParameter("pnum");
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
            request.setAttribute("pn", pnum);
            request.setAttribute("autho", "true");
            request.getRequestDispatcher("customer/change2.jsp").forward(request, response);
        } else {
            
            adao.changePhone(pnum, curid);
            session.setAttribute("account", adao.getAccountById(curid));
            request.setAttribute("suchange", "true");
            request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
