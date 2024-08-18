<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Discount List</title>
    <style>
        .pagination {
            display: inline-block;
        }
        .pagination a {
            color: #007bff;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <h1>Discount List</h1>

    <!-- Form to Search Discounts -->
    <form action="DiscountServlet" method="get">
        <input type="hidden" name="action" value="search">
        <label for="product_name">Search by Product Name:</label>
        <input type="text" id="product_name" name="product_name" placeholder="Enter product name" />
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- Button to Add New Discount -->
    <a href="DiscountServlet?action=showadform" class="btn btn-primary">Add New Discount</a>

    <c:if test="${not empty discountList}">
        <table border="1">
            <thead>
                <tr>
                    <th>Discount ID</th>
                    <th>Product ID</th>
                    <th>Discount Amount</th>
                    <th>Product Name</th>
                    <th>Actions</th> <!-- Column for Edit Button -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="discount" items="${discountList}">
                    <c:set var="product" value="${productMap[discount.productID]}" />
                    <tr>
                        <td>${discount.discountID}</td>
                        <td>${discount.productID}</td>
                        <td>${discount.discountAmount}</td>
                        <td>${product.productName}</td>
                        <td>
                            <!-- Edit Button -->
                            <a href="DiscountServlet?action=showeditform&discountID=${discount.discountID}&productname=${product.productName}" class="btn btn-warning">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination Controls -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="DiscountServlet?action=list&page=${currentPage - 1}">&laquo; Previous</a>
            </c:if>

            <c:forEach var="pageNum" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${pageNum == currentPage}">
                        <a href="#" class="active">${pageNum}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="DiscountServlet?action=list&page=${pageNum}">${pageNum}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="DiscountServlet?action=list&page=${currentPage + 1}">Next &raquo;</a>
            </c:if>
        </div>
    </c:if>

    <c:if test="${empty discountList}">
        <p>No discounts available.</p>
    </c:if>
</body>
</html>
