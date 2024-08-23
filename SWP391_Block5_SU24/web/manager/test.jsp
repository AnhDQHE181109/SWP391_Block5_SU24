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

 
    </div>
</body>


</html>
