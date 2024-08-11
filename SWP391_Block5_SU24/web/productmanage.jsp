<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Brand" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>

<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> products = pDAO.getAllProducts();
    List<Brand> brandList = pDAO.getAllBrands();
    List<Category> categoryList = pDAO.getAllCategories();
%>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>DASHMIN - Bootstrap Admin Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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
        <link href="css/style.css" rel="stylesheet">

        <!-- Add custom styles -->
        <style>
            .action-icons {
                display: flex;
                justify-content: space-around;
            }

            .action-icons i {
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="index.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>DASHMIN</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Jhon Doe</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="index.jsp" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Elements</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="button.html" class="dropdown-item">Buttons</a>
                                <a href="typography.html" class="dropdown-item">Typography</a>
                                <a href="element.html" class="dropdown-item">Other Elements</a>
                            </div>
                        </div>
                        <a href="widget.html" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Widgets</a>
                        <a href="form.html" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>Forms</a>
                        <a href="table.html" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Tables</a>
                        <a href="chart.html" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Charts</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="signin.html" class="dropdown-item">Sign In</a>
                                <a href="signup.html" class="dropdown-item">Sign Up</a>
                                <a href="404.html" class="dropdown-item">404 Error</a>
                                <a href="blank.html" class="dropdown-item active">Blank Page</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.jsp" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control border-0" type="search" placeholder="Search">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-envelope me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Message</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item text-center">See all message</a>
                            </div>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-bell me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">Notificatin</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">
                                <h6 class="fw-normal mb-0">Profile updated</h6>
                                <small>15 minutes ago</small>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item">
                                <h6 class="fw-normal mb-0">New user added</h6>
                                <small>15 minutes ago</small>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item">
                                <h6 class="fw-normal mb-0">Password changed</h6>
                                <small>15 minutes ago</small>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">See all notifications</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex">John Doe</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">My Profile</a>
                            <a href="#" class="dropdown-item">Settings</a>
                            <a href="#" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
            </div>
        </nav>
        <!-- Navbar End -->

        
        <!-- Blank Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="row vh-100 bg-light rounded align-items-center justify-content-center mx-0">
                <div class="col-md-10">
                    <h3>Product List</h3>
                    <table id="productTable" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Origin</th>
                                <th>Material</th>
                                <th>Price</th>
                                <th>Brand</th>
                                <th>Category</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product product : products) { %>    
                            <tr>
                                <td><%= product.getProductName() %></td>
                                <td><%= product.getOrigin() %></td>
                                <td><%= product.getMaterial() %></td>
                                <td><%= product.getPrice() %></td>
                                <td><%= product.getBrandName() %></td>
                                <td><%= product.getCategoryName() %></td>
                                <td>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProductModal"
                                            data-id="<%= product.getProductId() %>" data-name="<%= product.getProductName() %>"
                                            data-origin="<%= product.getOrigin() %>" data-material="<%= product.getMaterial() %>"
                                            data-price="<%= product.getPrice() %>" data-brand="<%= product.getBrandName() %>"
                                            data-category="<%= product.getCategoryName() %>">
                                        Edit
                                    </button>

                                    <!-- Delete Button -->
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteProductModal"
                                            data-id="<%= product.getProductId() %>">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="editProductForm" action="EditProductController" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <div></div>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="productId" id="editProductId">

                            <!-- Product Name -->
                            <div class="mb-3">
                                <label for="editProductName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="editProductName" name="productName" required>
                                <div class="invalid-feedback">
                                    <%
                                        String mess = (String) request.getAttribute("mess");
                                        if (mess != null) {
                                            out.print("<span style='color:red;'>" + mess + "</span>");
                                        }
                                    %>
                                </div>
                            </div>

                            <!-- Origin -->
                            <div class="mb-3">
                                <label for="editOrigin" class="form-label">Origin</label>
                                <input type="text" class="form-control" id="editOrigin" name="origin" required>
                                <div class="invalid-feedback">
                                    <%
                                        if (mess != null) {
                                            out.print("<span style='color:red;'>" + mess + "</span>");
                                        }
                                    %>
                                </div>
                            </div>

                            <!-- Material -->
                            <div class="mb-3">
                                <label for="editMaterial" class="form-label">Material</label>
                                <input type="text" class="form-control" id="editMaterial" name="material" required>
                                <div class="invalid-feedback">
                                    <%
                                        if (mess != null) {
                                            out.print("<span style='color:red;'>" + mess + "</span>");
                                        }
                                    %>
                                </div>
                            </div>

                            <!-- Price -->
                            <div class="mb-3">
                                <label for="editPrice" class="form-label">Price</label>
                                <input type="number" class="form-control" id="editPrice" name="price" step="0.01" required>
                                <div class="invalid-feedback">
                                    <%
                                        if (mess != null) {
                                            out.print("<span style='color:red;'>" + mess + "</span>");
                                        }
                                    %>
                                </div>
                            </div>

                            <!-- Brand Select Dropdown -->
                            <div class="mb-3">
                                <label for="editBrand" class="form-label">Brand</label>
                                <select name="brandId" id="editBrand" class="form-control">
                                    <% for(Brand brand : brandList) { %>
                                    <option value="<%= brand.getBrandId() %>">
                                        <%= brand.getBrandName() %>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <!-- Category Select Dropdown -->
                            <div class="mb-3">
                                <label for="editCategory" class="form-label">Category</label>
                                <select name="categoryId" id="editCategory" class="form-control">
                                    <% for(Category category : categoryList) { %>
                                    <option value="<%= category.getCategoryId() %>">
                                        <%= category.getCategoryName() %>
                                    </option>
                                    <% } %>
                                </select>
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
        `````
        <!-- Delete Product Modal -->
        <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="DeleteProductController" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteProductModalLabel">Confirm Delete</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this product?</p>
                            <input type="hidden" name="productId" id="deleteProductId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Yes, Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Blank End -->


        <!-- Footer Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded-top p-4">
                <div class="row">
                    <div class="col-12 col-sm-6 text-center text-sm-start">
                        &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                    </div>
                    <div class="col-12 col-sm-6 text-center text-sm-end">
                        Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
    </div>
    <!-- Content End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/chart/chart.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/tempusdominus/js/moment.min.js"></script>
<script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
<script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>


<script>
    var editProductModal = document.getElementById('editProductModal');
    editProductModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;

        // Retrieve data attributes from the button
        var productId = button.getAttribute('data-id');
        var productName = button.getAttribute('data-name');
        var origin = button.getAttribute('data-origin');
        var material = button.getAttribute('data-material');
        var price = button.getAttribute('data-price');
        var brand = button.getAttribute('data-brand');
        var category = button.getAttribute('data-category');

        // Populate the modal fields with the retrieved data
        var modal = this;
        modal.querySelector('#editProductId').value = productId;
        modal.querySelector('#editProductName').value = productName;
        modal.querySelector('#editOrigin').value = origin;
        modal.querySelector('#editMaterial').value = material;
        modal.querySelector('#editPrice').value = price;

        // Set the selected brand in the dropdown
        var brandSelect = modal.querySelector('#editBrand');
        for (var i = 0; i < brandSelect.options.length; i++) {
            if (brandSelect.options[i].text === brand) {
                brandSelect.options[i].selected = true;
                break;
            }
        }

        // Set the selected category in the dropdown
        var categorySelect = modal.querySelector('#editCategory');
        for (var i = 0; i < categorySelect.options.length; i++) {
            if (categorySelect.options[i].text === category) {
                categorySelect.options[i].selected = true;
                break;
            }
        }

    });
    var deleteProductModal = document.getElementById('deleteProductModal');
    deleteProductModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var productId = button.getAttribute('data-id');
        var modal = this;
        modal.querySelector('#deleteProductId').value = productId;
    });
    document.getElementById('editProductForm').addEventListener('submit', function (event) {
        let isValid = true;

        // Clear previous error messages
        document.getElementById('productNameError').innerText = '';
        document.getElementById('originError').innerText = '';
        document.getElementById('materialError').innerText = '';
        document.getElementById('priceError').innerText = '';

        // Regex patterns
        const textPattern = /^[A-Z][a-zA-Z\s'-\[\]]*$/;
        const pricePattern = /^\d+(\.\d{1,2})?$/;

        // Validate Product Name
        const productName = document.getElementById('editProductName').value.trim();
        if (!productName.match(textPattern)) {
            document.getElementById('productNameError').innerText = 'Product name must start with an uppercase letter and contain only valid characters.';
            isValid = false;
        }

        // Validate Origin
        const origin = document.getElementById('editOrigin').value.trim();
        if (!origin.match(textPattern)) {
            document.getElementById('originError').innerText = 'Origin must start with an uppercase letter and contain only valid characters.';
            isValid = false;
        }

        // Validate Material
        const material = document.getElementById('editMaterial').value.trim();
        if (!material.match(textPattern)) {
            document.getElementById('materialError').innerText = 'Material must start with an uppercase letter and contain only valid characters.';
            isValid = false;
        }

        // Validate Price
        const price = document.getElementById('editPrice').value.trim();
        if (!price.match(pricePattern)) {
            document.getElementById('priceError').innerText = 'Price must be a valid decimal number (up to 2 decimal places).';
            isValid = false;
        }

        // Prevent form submission if validation fails
        if (!isValid) {
            event.preventDefault();
        }
    });
</script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<!-- Custom Javascript -->
</body>

</html>
