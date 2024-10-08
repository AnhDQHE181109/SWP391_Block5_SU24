<%-- 
    Document   : manager_home
    Created on : Aug 8, 2024, 10:25:11 AM
    Author     : nobbe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Product" %>
<%@ page import="model.WishlistDAO" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="model.RevenueDAO" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <title>Manager Home</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="${pageContext.request.contextPath}/images/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/manager.css" rel="stylesheet">
    </head>
    <style>
        .alert {
            padding: 20px;
            background-color: #f44336;
            color: white;
            margin-bottom: 15px;
            position: fixed;
            width:100%;
            z-index: 9999;
        }

        .closebtn {
            margin-left: 15px;
            color: white;
            font-weight: bold;
            float: right;
            font-size: 22px;
            line-height: 20px;
            cursor: pointer;
            transition: 0.3s;
        }

        .closebtn:hover {
            color: black;
        }
        .alert-timer {
            height: 5px;
            background-color: #f1f1f1;
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        .alert-timer-fill {
            height: 100%;
            background-color: orange; /* Green */
            width: 100%;
            transition: width 5s linear;
        }
    </style>
    <body>
        <%if("true".equals(request.getParameter("auth_error"))){%>
        <div class="alert" id="alertDiv">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
            You do not have permission to access this pages.
            <div class="alert-timer">
                <div class="alert-timer-fill" id="timerFill"></div>
            </div>
        </div>
        <%}%>
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
                    <a href="manager_home.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"></i>Manager Site</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="ms-3">
                            <h5 class="mb-0">Welcome Manager</h5>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="manager_home.jsp" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>

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


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="images/user.jpg" alt="" style="width: 40px; height: 40px;">

                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="images/user.jpg" alt="" style="width: 40px; height: 40px;">

                                    </div>
                                </a>

                            </div>

                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                    <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/images/user.jpg" alt="" style="width: 40px; height: 40px;">
                                    <span class="d-none d-lg-inline-flex">Admin</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                    <a href="${pageContext.request.contextPath}/LogoutController" class="dropdown-item">Log Out</a>
                                </div>
                            </div>
                        </div>
                </nav>
                <!-- Navbar End -->


                <%
    RevenueDAO revenueDAO = new RevenueDAO();
    double totalRevenue = revenueDAO.getTotalRevenue();
    double revenueLast4Months = revenueDAO.getRevenueForLastMonths(4);
    double revenueLast8Months = revenueDAO.getRevenueForLastMonths(8);
    double revenueLast12Months = revenueDAO.getRevenueForLastMonths(12);
                %>

                <!-- Sale & Revenue Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">

                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-pie fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Total Revenue</p>
                                    <h6 class="mb-0">$<%= String.format("%.2f", totalRevenue) %></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-bar fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Last 4 months revenue</p>
                                    <h6 class="mb-0">$<%= String.format("%.2f", revenueLast4Months) %></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-bar fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Last 8 months revenue</p>
                                    <h6 class="mb-0">$<%= String.format("%.2f", revenueLast8Months) %></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-bar fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Last 12 months revenue</p>
                                    <h6 class="mb-0">$<%= String.format("%.2f", revenueLast12Months) %></h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Sale & Revenue End -->


                <%
            // Retrieve best-sellers list
            ProductDetailsDAO productDAO = new ProductDetailsDAO();
            List<Product> bestSellers = productDAO.getBestSeller(); 
                %>

                <!-- Best Seller Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Top 5 Best Sellers</h6>
                            <a href="">Show All</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start align-middle table-bordered table-hover mb-0">
                                <thead>
                                    <tr class="text-dark">
                                        <th scope="col">Product Details</th>
                                        <th scope="col">Size</th>
                                        <th scope="col">Color</th>
                                        <th scope="col">Sold</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        int count = 0;
                                        for (Product product : bestSellers) { 
                                            if (count == 5) break; // Limit to top 5
                                            count++;
                                    %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/<%= product.getImageURL() %>" alt="<%= product.getProductName() %>" style="width: 50px; height: 50px;" class="rounded-circle">
                                                <div class="ms-3">
                                                    <h6 class="mb-0"><%= product.getProductName() %></h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td><%= product.getSize() %></td>
                                        <td><%= product.getColor() %></td>
                                        <td><%= product.getTotalQuantity() %> sold</td>
                                    </tr>
                                    <% 
                                        } 
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Best Seller End -->


                <!-- Most Wishlisted Product Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Preferred Products</h6>
                            <a href="">Show All</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start align-middle table-bordered table-hover mb-0">
                                <thead>
                                    <tr class="text-dark">
                                        <th scope="col">Product Details</th>
                                        <th scope="col">Color</th>
                                        <th scope="col">Size</th>
                                        <th scope="col">Wishlisted</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        WishlistDAO wishlistDAO = new WishlistDAO();
                                        List<Product> preferredProducts = wishlistDAO.getTopWishlistedProducts();
                                        for (Product product : preferredProducts) {
                                    %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/<%= product.getImageURL() %>" alt="<%= product.getProductName() %>" style="width: 50px; height: 50px;" class="rounded-circle">
                                                <div class="ms-3">
                                                    <h6 class="mb-0"><%= product.getProductName() %></h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td><%= product.getColor() %></td>
                                        <td><%= product.getSize() %></td>
                                        <td><%= product.getWishlistedCount() %> people</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Most Wishlisted Product End -->


                <!-- Widgets Start -->
                
                <!-- Widgets End -->


                <!-- Footer Start -->

                <!-- Footer End -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script>
                function startAlertTimer() {
                    const timerFill = document.getElementById('timerFill');
                    const alertBox = document.getElementById('alertDiv');

                    // Start the timer
                    setTimeout(function () {
                        alertBox.style.display = 'none'; // Hide the alert
                    }, 5000);

                    // Start the progress bar animation
                    timerFill.style.width = '0%';
                }
                // Start the timer when the page loads
                window.onload = startAlertTimer;
                document.getElementById('search-bar').addEventListener('input', function () {
                    let query = this.value;
                    if (query.length > 0) {
                        fetchSuggestions(query);
                    } else {
                        document.getElementById('alertDiv').style.display = 'none';
                    }
                });
        </script>
    </body>




</html>
