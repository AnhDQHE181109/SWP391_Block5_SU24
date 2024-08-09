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
import model.AccountDAO;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

/**
 *
 * @author Long
 */
public class RecoverController extends HttpServlet {

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
            out.println("<title>Servlet RecoverController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RecoverController at " + request.getContextPath() + "</h1>");
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
        int recodei =  0;
        int cinputi = 1;
        try {
            recodei = Integer.parseInt(recode);
            cinputi = Integer.parseInt(cinput);
        } catch (Exception e) {
            request.setAttribute("recode", "true");
            request.setAttribute("error_recover_code", "true");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        if (cinputi != recodei) {
            request.setAttribute("recode", "true");
            request.setAttribute("error_recover_code", "true");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("recover.jsp").forward(request, response);
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
        AccountDAO adao = new AccountDAO();
        int role = Integer.parseInt(request.getParameter("role"));
        if (!adao.isEmailTaken(re)) {
            request.setAttribute("error_recover", "true");
            request.getRequestDispatcher("login.jsp?error_recover=true").forward(request, response);
        }
        Random rand = new Random();
        int recode = rand.nextInt(9999 - 1000 + 1) + 1000;
        SendMail.Send("smtp.gmail.com", "swp391a@gmail.com", re,
                "Recover code for Footwear", "		\n"
                + "Dear Custumer,\n"
                + "\n"
                + "We received a request to access your Footwear Account " + re + " through your email address. Your verification code is:\n"
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
        request.getRequestDispatcher("login.jsp").forward(request, response);
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

    public class SendMail {

        public static int Send(String SMTPServer,
                String Sender,
                String Recipient,
                String Subject,
                String Body,
                String ErrorMessage,
                String Attachments) {
            // Error status;
            int ErrorStatus = 0;

            // Create some properties and get the default Session;
            final String username = Sender;
            final String password = "sxcr zvko glyc acwu";

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            try {
                // Create a message.
                MimeMessage msg = new MimeMessage(session);

                // extracts the senders and adds them to the message.
                // Sender is a comma-separated list of e-mail addresses as per RFC822.
                {
                    InternetAddress[] TheAddresses = InternetAddress.parse(Sender);
                    msg.addFrom(TheAddresses);
                }

                // Extract the recipients and assign them to the message.
                // Recipient is a comma-separated list of e-mail addresses as per RFC822.
                {
                    InternetAddress[] TheAddresses = InternetAddress.parse(Recipient);
                    msg.addRecipients(Message.RecipientType.TO, TheAddresses);
                }

                // Subject field
                msg.setSubject(Subject);

                // Create the Multipart to be added the parts to
                Multipart mp = new MimeMultipart();

                // Create and fill the first message part
                {
                    MimeBodyPart mbp = new MimeBodyPart();
                    mbp.setText(Body);

                    // Attach the part to the multipart;
                    mp.addBodyPart(mbp);
                }

                // Attach the files to the message
                if (null != Attachments) {
                    int StartIndex = 0, PosIndex = 0;
                    while (-1 != (PosIndex = Attachments.indexOf("///", StartIndex))) {
                        // Create and fill other message parts;
                        MimeBodyPart mbp = new MimeBodyPart();
                        FileDataSource fds
                                = new FileDataSource(Attachments.substring(StartIndex, PosIndex));
                        mbp.setDataHandler(new DataHandler(fds));
                        mbp.setFileName(fds.getName());
                        mp.addBodyPart(mbp);
                        PosIndex += 3;
                        StartIndex = PosIndex;
                    }
                    // Last, or only, attachment file;
                    if (StartIndex < Attachments.length()) {
                        MimeBodyPart mbp = new MimeBodyPart();
                        FileDataSource fds = new FileDataSource(Attachments.substring(StartIndex));
                        mbp.setDataHandler(new DataHandler(fds));
                        mbp.setFileName(fds.getName());
                        mp.addBodyPart(mbp);
                    }
                }

                // Add the Multipart to the message
                msg.setContent(mp);

                // Set the Date: header
                msg.setSentDate(new Date());

                // Send the message;
                Transport.send(msg);
            } catch (MessagingException MsgException) {
                System.out.println("blows here");
                ErrorMessage = MsgException.toString();
                Exception TheException = null;
                if ((TheException = MsgException.getNextException()) != null) {
                    ErrorMessage += "\n" + TheException.toString();
                }
                ErrorStatus = 1;
            }
            System.out.println(ErrorMessage);
            return ErrorStatus;
        }
    }
}
