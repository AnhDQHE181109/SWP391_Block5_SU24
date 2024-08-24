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
    <!-- Include necessary CSS and JS files -->
</head>
<body>
    <div class="main-bar">
        <div class="body-main-bar">
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
        </div>
    </div>
</body>
</html>


