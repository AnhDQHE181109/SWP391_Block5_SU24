<%-- 
    Document   : feedback
    Created on : Aug 24, 2024, 7:04:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.Order" %>
<%@ page import="entity.Account" %>
<%@ page import="model.ProductDetailsDAO" %>
<%
    // Retrieve necessary data
    Account loggedInUser = (Account) session.getAttribute("account");
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    ProductDetailsDAO orderDAO = new ProductDetailsDAO();
    Order order = orderDAO.getOrderById(orderId);

    if (loggedInUser == null || order == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<% 
    boolean error = "true".equals(request.getParameter("error"));
    boolean feedbackSuccess = "true".equals(request.getParameter("feedbackSuccess"));
%>

<% if (feedbackSuccess) { %>
<div class="alert alert-success">Thank you for your feedback!</div>
<% } else if (error) { %>
<div class="alert alert-danger">There was an error submitting your feedback. Please try again.</div>
<% } %>
<!DOCTYPE html>
<html>
    <head>
        <title>Feedback</title>
        <style>
            /* Main container styling */
            .main-bar {
                margin: 20px;
                padding: 20px;
                background-color: white;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                width: 80%;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }

            /* Feedback form container */
            .feedback-form {
                width: 100%;
                padding: 20px;
                background-color: #f5f5f5;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Feedback form title */
            .feedback-form h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
                font-weight: 600;
            }

            /* Form group styling */
            .feedback-form .form-group {
                margin-bottom: 20px;
            }

            /* Form label styling */
            .feedback-form label {
                font-weight: 600;
                color: #555;
                display: block;
                margin-bottom: 8px;
            }

            /* Input, select, and textarea styling */
            .feedback-form input[type="text"],
            .feedback-form input[type="number"],
            .feedback-form select,
            .feedback-form textarea {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: inset 0px 1px 3px rgba(0, 0, 0, 0.1);
            }

            /* Button styling */
            .feedback-form button {
                background-color: #e63946;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
                width: 100%;
                text-align: center;
            }

            /* Button hover effect */
            .feedback-form button:hover {
                background-color: #c72535;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .main-bar {
                    width: 95%;
                }

                .feedback-form {
                    padding: 15px;
                }
            }

        </style>
    </head>
    <body>
        <div class="main-bar">
            <div class="feedback-form">
                <h2>Leave Your Feedback</h2>
                <form action="${pageContext.request.contextPath}/SubmitFeedbackController" method="post">
                    <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                    <input type="hidden" name="accountId" value="<%= loggedInUser.getAccountID() %>">

                    <div class="form-group">
                        <label for="rating">Rating:</label>
                        <select id="rating" name="rating">
                            <option value="1">1 - Poor</option>
                            <option value="2">2 - Fair</option>
                            <option value="3">3 - Good</option>
                            <option value="4">4 - Very Good</option>
                            <option value="5">5 - Excellent</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="comment">Comment:</label>
                        <textarea id="comment" name="comment" rows="4" cols="50"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Submit Feedback</button>
                </form>

                <!-- Back Button -->

            </div>
            <button class="btn btn-secondary" onclick="goBack()">Back</button>
        </div>

        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </body>
</html>


