<%-- 
    Document   : TestOrderList
    Created on : Aug 22, 2024, 11:39:21 PM
    Author     : nobbe
--%>

<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Order List - Return Request</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Test Order List</h1>
        <%
            // Testing with OrderID 1 specifically
            int orderId = 1;
            DBConnect dbConnect = new DBConnect();
            Connection conn = dbConnect.conn;

            String sql = "SELECT OrderID, OrderDate, Status " +
                         "FROM Orders " +
                         "WHERE OrderID = ? " +
                         "AND Status = 3 " +
                         "AND DATEDIFF(DAY, OrderDate, GETDATE()) <= 15";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                java.sql.Date orderDate = rs.getDate("OrderDate");  // Specify java.sql.Date here
                int status = rs.getInt("Status");

                // Display order details
                out.println("<div class='order-box'>");
                out.println("<p><strong>Order ID:</strong> " + orderId + "</p>");
                out.println("<p><strong>Order Date:</strong> " + orderDate + "</p>");
                out.println("<p><strong>Status:</strong> " + (status == 3 ? "Completed" : "Other Status") + "</p>");

                // Show "Request Return" button if the order is eligible
                if (status == 3) {
                    out.println("<form method='get' action='return_product.jsp'>");
                    out.println("<input type='hidden' name='orderId' value='" + orderId + "'>");
                    out.println("<button type='submit' class='btn btn-primary'>Request Return</button>");
                    out.println("</form>");
                }
                out.println("</div>");
                out.println("<hr>");
            } else {
                out.println("<p>Order ID " + orderId + " is not eligible for return or does not exist.</p>");
            }

            rs.close();
            ps.close();
        %>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

