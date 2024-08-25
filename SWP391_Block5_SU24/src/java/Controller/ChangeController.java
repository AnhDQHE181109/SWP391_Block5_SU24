/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import model.AccountDAO;

/**
 *
 * @author Long
 */
public class ChangeController extends HttpServlet {

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
            out.println("<title>Servlet ChangeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeController at " + request.getContextPath() + "</h1>");
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
        String email = (String) session.getAttribute("email");
        String recode = (String) session.getAttribute("recode");
        String cinput = request.getParameter("extraData");
        String type = (String) session.getAttribute("type");
        int recodei = 0;
        int cinputi = 1;
        try {
            recodei = Integer.parseInt(recode);
            cinputi = Integer.parseInt(cinput);
        } catch (Exception e) {
            request.setAttribute("recode", "true");
            request.setAttribute("error_recover_code", "true");
            request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
            return;
        }
        if (cinputi != recodei) {
            request.setAttribute("recode", "true");
            request.setAttribute("error_recover_code", "true");
            request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
            return;
        } else {
            if (type.equals("email")) {
                request.setAttribute("autho", "true");
                request.getRequestDispatcher("customer/change1.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("autho", "true");
                request.getRequestDispatcher("customer/change2.jsp").forward(request, response);
                return;
            }
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
        String re = request.getParameter("recover-email");
        String type = request.getParameter("type");
        Random rand = new Random();
        int recode = rand.nextInt(9999 - 1000 + 1) + 1000;
        AccountDAO adao = new AccountDAO();
        RecoverController.SendMail.Send("smtp.gmail.com", "swp391a@gmail.com", re,
                "Security code for Footwear", "		\n"
                + "Dear Custumer,\n"
                + "\n"
                + "We received a request to change your " + type + " of your Footwear Account " + re + " through your email address. Your verification code is:\n"
                + "\n"
                + +recode + "\n"
                + "\n"
                + "If you did not request this code, it is possible that someone else is trying to access your account. Do not forward or give this code to anyone.\n"
                + "\n"
                + "Sincerely yours,\n"
                + "\n"
                + "The Footwear Accounts team", "", null);
        HttpSession session = request.getSession();
        session.setAttribute("recode", "" + recode);
        session.setAttribute("email", re);
        request.setAttribute("recode", "true");
        long endTime = System.currentTimeMillis() + (5 * 60 * 1000);
        request.getSession().setAttribute("endTime", endTime);
        session.setAttribute("account", adao.getAccountbyEmail(re));
        session.setAttribute("type", type);
        request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
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
