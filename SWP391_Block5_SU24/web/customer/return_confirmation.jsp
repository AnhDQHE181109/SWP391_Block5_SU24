<%-- 
    Document   : return_confirmation
    Created on : Aug 23, 2024, 10:26:21 PM
    Author     : nobbe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Return Request Submitted</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Your return request has been submitted successfully!</h2>
        <p>We will review your request and notify you of the decision shortly.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Return to Home</a>
    </div>
</body>
</html>

