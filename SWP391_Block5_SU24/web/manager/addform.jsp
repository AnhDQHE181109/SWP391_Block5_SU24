<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.DAOBrand" %>
<%@page import="entity.Brand" %>
<%@page import="java.util.List" %>
<%@ page import="entity.Category" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Brand Management - Bootstrap Admin Template</title>
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
    

</head>

<body>
    <div class="container-fluid position-relative bg-light">
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

        <!-- Main Content Start -->
        <div class="content">
            <h2 class="mb-4">Update Discount</h2>
            <form action="DiscountServlet" method="get" onsubmit="return validateForm();">
                <input type="hidden" name="action" value="updateby">
                
                <div class="form-group">
                    <label for="discount_amount">New Discount Amount:</label>
                    <input type="number" name="discount_amount" id="discount_amount" step="0.01" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="brand">Brand:</label>
                    <select name="brand_id" id="brand" class="form-control" >
                        <option value="">None</option>
                        <% for (Brand brand : (List<Brand>) request.getAttribute("brands")) { %>
                            <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="category">Category:</label>
                    <select name="category_id" id="category" class="form-control" >
                        <option value="">None</option>
                        <% for (Category category : (List<Category>) request.getAttribute("categories")) { %>
                            <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Discount</button>
                                    <a href="DiscountServlet?action=list" class="btn btn-secondary">Cancel</a>

            </form>
        </div>
        <!-- Main Content End -->
    </div>
                    
                     <script>
function validateForm() {
    const discountAmount = document.getElementById('discount_amount').value.trim();
    const brand = document.getElementById('brand').value.trim();
    const category = document.getElementById('category').value.trim();

    // Kiểm tra nếu trường discountAmount bị để trống, không phải số, hoặc nhỏ hơn 0 hoặc lớn hơn 100
    if (discountAmount === "" || isNaN(discountAmount) || Number(discountAmount) < 0 || Number(discountAmount) > 100) {
        alert("Please enter a valid discount amount between 0 and 100.");
        return false;
    }

    // Kiểm tra nếu có ký tự đặc biệt trong discountAmount
    const specialChars = /[!@#$%^&*(),.?":{}|<>]/g;
    if (specialChars.test(discountAmount)) {
        alert("Please avoid special characters.");
        return false;
    }

    // Kiểm tra nếu có dấu cách liên tục trong discountAmount
    if (/\s\s+/.test(discountAmount)) {
        alert("Please avoid multiple spaces.");
        return false;
    }

    // Kiểm tra xem ít nhất một trong hai trường brand hoặc category đã được chọn
    if (brand === "" && category === "") {
        alert("Please select at least one of Brand or Category.");
        return false;
    }

    return true;
}


    </script>
</body>

</html>
