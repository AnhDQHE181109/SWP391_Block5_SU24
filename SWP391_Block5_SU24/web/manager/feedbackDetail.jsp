<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Details</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .container {
            text-align: center;
            margin: 20px;
        }

        .message {
            color: red;
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Feedback Details</h1>

    <c:if test="${not empty feedbackList}">
        <table>
            <thead>
                <tr>
<!--                     Hidden Columns 
                    <th>Feedback ID</th>
                    <th>Account ID</th>
                    <th>Product ID</th>
                    <th>Stock ID</th>-->
                    
                    <!-- Display Columns -->
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Size</th>
                    <th>Color</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="feedback" items="${feedbackList}">
                    <tr>
                        <!-- Hidden Columns -->
                        <td hidden >${feedback.feedbackId}</td>
                        <td  hidden >${feedback.accountID}</td>
                        <td  hidden >${feedback.productID}</td>
                        <td  hidden  >${feedback.stockID}</td>
                        
                        <!-- Display Columns -->
                        <td>${accountMap[feedback.accountID].username}</td>
                        <td>${accountMap[feedback.accountID].fullname}</td>
                        <td>${accountMap[feedback.accountID].phoneNumber}</td>
                        <td>${accountMap[feedback.accountID].email}</td>
                        <td>${accountMap[feedback.accountID].address}</td>
                        <td>${stockMap[feedback.stockID].size}</td>
                        <td>${stockMap[feedback.stockID].color}</td>
                        <td>${feedback.rating}</td>
                        <td>${feedback.comment}</td>
                        <td>${feedback.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty feedbackList}">
        <p class="message">No feedback found for the provided ID.</p>
    </c:if>
</div>

</body>
</html>
