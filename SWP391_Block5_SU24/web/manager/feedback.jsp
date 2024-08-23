<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.DAOBrand" %>
<%@page import="entity.Brand" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Discount Management - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet">
    
    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet -->
    <link href="css/manager.css" rel="stylesheet">
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function editBrand(brandId, brandName) {
            document.querySelector('#editForm [name="brandId"]').value = brandId;
            document.querySelector('#editForm #brandName').value = brandName;
            $('#editModal').modal('show');
        }
        
        function updateBrand(event) {
            event.preventDefault(); // Prevent form submission
            
            const formData = new FormData(event.target);
            const brandId = formData.get('brandId');
            const brandName = formData.get('brandName');
            
            fetch('BrandController', {
                method: 'POST',
                body: new URLSearchParams({
                    id: brandId,
                    name: brandName
                })
            })
            .then(response => {
                if (response.ok) {
                    alert('Brand updated successfully!');
                    location.reload(); // Reload to see the changes
                } else {
                    return response.text().then(text => {
                        alert(text);
                    });
                }
            })
            .catch(error => {
                console.error('Error updating brand:', error);
                alert('An error occurred while updating the brand. Please try again later.');
            });
        }
    </script>
</head>

<body>
    <div class="container-fluid position-relative bg-light" style="padding-left: 250px;">
        <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="manager_home.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"></i>Manager Site</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="${pageContext.request.contextPath}/images/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Jhon Doe</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="manager/manager_home.jsp" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>

                                <a href="${pageContext.request.contextPath}/BrandController?action=list" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Brand </a>
                        <a href="${pageContext.request.contextPath}/CategoryController" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Category</a>
                        <a href="${pageContext.request.contextPath}/DiscountServlet?action=list" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Discount</a>
                        <a href="${pageContext.request.contextPath}/FeedbackController?username=&productName=&sortBy=rating" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Feedback</a>

                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Manage Requests</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="manage_request.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>View Requests</a>
                                <a href="history_requests.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Request History</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

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

 
    </div>
</body>


</html>
