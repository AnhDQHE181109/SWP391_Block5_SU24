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

        <!-- Search Form -->
        <form action="FeedbackController" method="get" class="mb-4">
            <div class="form-row align-items-center">
                <div class="col-auto">
                    <input type="text" class="form-control mb-2" id="username" name="username" placeholder="Enter username" value="${param.username}">
                </div>
                <div class="col-auto">
                    <input type="text" class="form-control mb-2" id="productName" name="productName" placeholder="Enter product name" value="${param.productName}">
                </div>
                <div class="col-auto">
                    <select class="form-control mb-2" id="sortBy" name="sortBy">
                        <option value="">Sort By</option>
                        <option value="rating_asc" ${param.sortBy == 'rating_asc' ? 'selected' : ''}>Rating Ascending</option>
                        <option value="rating_desc" ${param.sortBy == 'rating_desc' ? 'selected' : ''}>Rating Descending</option>
                        <option value="created_at_asc" ${param.sortBy == 'created_at_asc' ? 'selected' : ''}>Created At Ascending</option>
                        <option value="created_at_desc" ${param.sortBy == 'created_at_desc' ? 'selected' : ''}>Created At Descending</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mb-2">Search</button>
                </div>
            </div>
        </form>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Created At</th>
                    <th>Product Name</th>
                    <th>Action</th> <!-- Cột Action -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="feedback" items="${paginatedFeedbackList}">
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
                        <td>
                            <a href="FeedbackDetailController?feedbackId=${feedback.feedbackId}" class="btn btn-info btn-sm">Detail</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}" tabindex="-1">Previous</a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</body>
</html>
