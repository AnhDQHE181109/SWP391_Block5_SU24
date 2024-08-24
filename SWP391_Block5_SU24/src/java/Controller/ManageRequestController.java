/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.PrintWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DBConnect;

/**
 *
 * @author nobbe
 */
public class ManageRequestController extends HttpServlet {

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
            out.println("<title>Servlet ManageRequestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageRequestController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.isEmpty()) {
            // Handle the case where orderId is not provided
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter");
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.conn;

        try {
            if ("approve".equals(action)) {
                // Update the return request status to 'Approved'
                String updateReturnRequestSQL = "UPDATE ReturnRequests SET Status = 'Approved' WHERE OrderID = ?";
                PreparedStatement ps1 = conn.prepareStatement(updateReturnRequestSQL);
                ps1.setInt(1, orderId);
                ps1.executeUpdate();
                ps1.close();

                // Update the order status to 'Returned' (5)
                String updateOrderStatusSQL = "UPDATE Orders SET Status = 5 WHERE OrderID = ?";
                PreparedStatement ps2 = conn.prepareStatement(updateOrderStatusSQL);
                ps2.setInt(1, orderId);
                ps2.executeUpdate();
                ps2.close();
            } else if ("reject".equals(action)) {
                // Update the return request status to 'Rejected'
                String updateReturnRequestSQL = "UPDATE ReturnRequests SET Status = 'Rejected' WHERE OrderID = ?";
                PreparedStatement ps = conn.prepareStatement(updateReturnRequestSQL);
                ps.setInt(1, orderId);
                ps.executeUpdate();
                ps.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the manage_request.jsp page
        response.sendRedirect("manager/manage_request.jsp");
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
