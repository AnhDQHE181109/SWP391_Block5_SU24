<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback List</title>
    <!-- Include Bootstrap CSS for styling -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Feedback List</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Created At</th>
                    <th>Product Name</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="feedback" items="${feedbackList}">
                    <tr>
                        <td><c:out value="${accountUsernameMap[feedback.accountID]}"/></td>
                        <td><c:out value="${feedback.rating}"/></td>
                        <td><c:out value="${feedback.comment}"/></td>
                        <td><c:out value="${feedback.createdAt}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty stockMap[feedback.stockID]}">
                                    <c:out value="${productMap[stockMap[feedback.stockID].productID].productName}"/>
                                </c:when>
                                <c:otherwise>
                                    N/A
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
