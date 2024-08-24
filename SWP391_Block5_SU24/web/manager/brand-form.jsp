<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.DAOBrand" %>
<%@page import="entity.Brand" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Brand Management</title>
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
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    
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
            
            fetch('BrandController?action=update', {
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
        
        function validateInput() {
            const inputField = document.getElementById('brandName').value.trim();
            const errorMessage = document.getElementById('error-message');
            const specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/;
            const numberPattern = /\d/;

            if (inputField === '') {
                errorMessage.textContent = 'This field cannot be empty.';
                return false;
            }

            if (numberPattern.test(inputField)) {
                errorMessage.textContent = 'Numbers are not allowed.';
                return false;
            }

            if (specialCharPattern.test(inputField)) {
                errorMessage.textContent = 'Special characters are not allowed.';
                return false;
            }

            errorMessage.textContent = '';  // Clear error message if no errors
            return true;
        }

         
    </script>


</head>

<body>
    <div class="container-fluid position-relative bg-light">
        <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="manager/manager_home.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"></i>Manager Site</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="ms-3">
                            <h5 class="mb-0">Welcome Manager</h5>
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
                                <a href="manager/manage_request.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>View Requests</a>
                                <a href="manager/history_requests.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Request History</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content p-4">
            
    <h1>${brand != null ? "Edit Brand" : "Add New Brand"}</h1>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
<form action="BrandController" method="post" onsubmit="return validateInput()">
    <input type="hidden" name="brandId" value="${brand != null ? brand.brandId : ''}"/>
    <label for="brandName">Brand Name:</label>
    <input type="text" id="brandName" name="brandName" value="${brand != null ? brand.brandName : ''}" required/>
    <div id="error-message" style="color: red;"></div>
    <input type="hidden" name="action" value="${brand != null ? 'update' : 'insert'}"/>
    <button type="submit">${brand != null ? "Update Brand" : "Add Brand"}</button>
</form>
    <a href="BrandController?action=list">Back to Brand List</a>
    
        </div>
        <!-- Content End -->

        <!-- Modal for Editing Brand -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Edit Brand</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editForm" onsubmit="updateBrand(event)">
                        <div class="modal-body">
                            <input type="hidden" name="brandId"/>
                            <div class="mb-3">
                                <label for="brandName" class="form-label">Brand Name</label>
                                <input type="text" class="form-control" id="brandName" name="brandName" required/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
