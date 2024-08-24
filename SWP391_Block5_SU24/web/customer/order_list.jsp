<%-- 
    Document   : customer_profile
    Created on : Aug 15, 2024, 9:40:10 AM
    Author     : Long
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Order" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String status = request.getParameter("status");
    if (status == null) {
        status = "all"; // Default to "all" if no status is selected
    }
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> bestSellers = pDAO.getBestSellers();

    // Initialize the orderItems variable
    List<Order> orderItems = new ArrayList<>();

    // Retrieve the account ID from the session using the correct attribute name
    Account loggedInUser = (Account) session.getAttribute("account");
    if (loggedInUser == null) {
        out.println("No user logged in, redirecting to login page...");
        response.sendRedirect("login.jsp");
        return; // Stop further execution of JSP
    } else {
        int accountId = loggedInUser.getAccountID();
        ProductDetailsDAO orderDAO = new ProductDetailsDAO();
        orderItems = orderDAO.getAllOrdersByCustomerId(accountId, status); // Pass the sort parameter
    }
    boolean showErrorPass = "true".equals(request.getParameter("error_auth_pass"));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/c630e9f862.js" crossorigin="anonymous"></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">

        <!-- Animate.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icomoon.css">
        <!-- Ion Icon Fonts-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

        <!-- Magnific Popup -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">

        <!-- Flexslider  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flexslider.css">

        <!-- Owl Carousel -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css">

        <!-- Date Picker -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css">
        <!-- Flaticons  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/flaticon/font/flaticon.css">

        <!-- Theme style  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <style>
        .profile_container {
            display: flex;
            justify-content: center;
            background-color: #f5f5f5;
        }
        .side-bar {
            display: flex;
            flex-direction: column;
            align-content: center;
            margin: 20px;
            margin-top: 40px;
        }
        .main-bar {
            margin: 20px;
            margin-top: 40px;
            background-color: white;
            box-shadow: 20px 16px #88c8bc;
            width: 993px;
            max-height: auto; /* Removes fixed height */
            overflow: hidden; /* Ensures no scroll bars appear */
        }

        .side-bar-user {
            margin: 10px;
            width: 90%;
            display: flex;
            flex-direction: row;
            align-content: center;
            padding-bottom: 3px;
            border-bottom: 3px solid #efefef;
        }
        .side-bar-nav {
            margin: 10px;
            width: 90%;
            margin-left: 15px;
            display: flex;
            flex-direction: row;
            align-content: center;
            padding-bottom: 3px;
        }
        .top-main-bar {
            width: 90%;
            margin-left: 5%;
            align-content: center;
            padding-top: 10px;
            border-bottom: 3px solid #efefef;
            padding-bottom: 15px;
        }
        .body-main-bar {
            width: 90%;
            margin-left: 5%;
            height: auto;
            margin-top: 10px;
        }
        .order-list {
            max-height: auto; /* Removes max height */
            overflow: hidden; /* Ensures no scroll bars appear */
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #ddd;
            background-color: #fff;
            margin-bottom: 15px;
        }
        .product-cart {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
        .order-item img {
            width: 100px;
            height: auto;
            border: 1px solid #ddd;
            padding: 5px;
        }
        .order-details {
            flex-grow: 1;
            margin-left: 20px;
        }
        .order-details h3 {
            margin: 0;
            font-size: 18px;
        }
        .order-details .variant {
            color: #888;
            margin: 5px 0;
        }
        .order-details .price {
            font-size: 20px;
            font-weight: bold;
            color: #e63946;
        }
        .order-summary {
            text-align: right;
        }
        .order-summary .total-price {
            font-size: 24px;
            font-weight: bold;
            color: #e63946;
        }
        .order-summary .actions {
            margin-top: 10px;
        }
        .order-summary .actions button {
            margin-right: 10px;
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            cursor: pointer;
        }
        .order-summary .actions .btn-primary {
            background-color: #e63946;
            color: white;
        }
        .order-summary .actions .btn-secondary {
            background-color: #ddd;
            color: black;
        }
        .order-filter-bar {
            display: flex;
            justify-content: space-around;
            background-color: #fff;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .filter-options {
            list-style: none;
            display: flex;
            padding: 0;
            margin: 0;
            justify-content: space-around;
            width: 100%;
        }

        .filter-options li {
            margin: 0 15px;
        }

        .filter-options a {
            text-decoration: none;
            color: #000;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            font-size: 14px;
        }

        .filter-options a:hover,
        .filter-options a.active {
            background-color: #90ccbc;
            color: #fff;
        }
    </style>
    <body>
        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <div class="top-menu">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-7 col-md-9">
                                <div id="colorlib-logo"><a href="${pageContext.request.contextPath}/index.jsp">Footwear</a></div>
                            </div>
                            <div class="col-sm-5 col-md-3">
                                <form action="products.jsp" method="get" class="search-wrap">
                                    <div class="form-group position-relative">
                                        <input type="search" name="query" id="search-bar" class="form-control search" placeholder="Search for products...">
                                        <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
                                        <div id="suggestions" class="dropdown-menu" style="display: none;
                                             position: absolute;
                                             width: 100%;"></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li class="active"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                    <li><a class="active" href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
                                    <li><a href="${pageContext.request.contextPath}/about.html">About</a></li>
                                    <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                        <% if (session.getAttribute("account") != null) { %>
                                    <li class="cart"><a href="wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>
                                        <%
                                        int accountID = 0;
                                        Account account = (Account)session.getAttribute("account");
                                        if (account != null) {
                                            accountID = account.getAccountID();
                                        }
                                        int cartItemsCount = pDAO.getCartItemsCount(accountID);
                                        %>
                                    <li class="cart"><a href="shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
                                    <li class="cart"><a href="LogoutController">Logout</a></li>
                                    <li class="cart"><i class="fa-regular fa-user"></i> <a href="customer_profile.jsp"><%= ((Account) session.getAttribute("account")).getUsername() %></a></li>
                                        <% } else { %>
                                    <li class="cart"><a href="signup.jsp">Sign Up</a></li>
                                    <li class="cart"><a href="login.jsp">Login</a></li>
                                    <li class="cart"><a href="shoppingCart"><i class="icon-shopping-cart"></i> Cart [0]</a></li>
                                        <% } %>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sale">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-8 offset-sm-2 text-center">
                                <div class="row">
                                    <div class="owl-carousel2">
                                        <div class="item">
                                            <div class="col">
                                                <h3><a href="#">25% off (Almost) Everything! Use Code: Summer Sale</a></h3>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <div class="col">
                                                <h3><a href="#">Our biggest sale yet 50% off all summer shoes</a></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
            <div class="profile_container">
                <div class="side-bar" style="width:180px; height:546px;">
                    <div class="side-bar-user"><div style="display:inline-block"><i style="font-size:48px;" class="fa-solid fa-user"></i></div><div style="display:inline-block; padding-left: 10px;"><span style="font-weight: 600">User</span><br><i style="margin-right:3px" class="fa-solid fa-pen"></i>Edit Profile</div></div>
                    <div class="side-bar-nav">
                        <table>
                            <tr><th></th><th></th></tr>
                            <tr style="color:black"><td><i style="padding-right:2px" class="fa-regular fa-user"></i></td><td>My Account</td></tr>
                            <tr><td></td><td style="padding-left:7px; padding-top:6px;color:red;">Profile</td></tr>
                            <tr><td></td><td style="padding-left:7px; padding-top:3px;padding-bottom:10px">Change Password</td></tr>
                            <tr style="color:black"><td><i style="padding-right:2px" class="fa-regular fa-bell"></i></td><td>Notification</td></tr>
                            <tr style="color:black">
                                <td><i style="padding-right:2px" class="fa-regular fa-list-alt"></i></td>
                                <td><a href="order_list.jsp" style="text-decoration: none; color: black;">My Orders</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="main-bar">
                    <div class="body-main-bar">
                        <div class="order-filter-bar">
                            <ul class="filter-options">
                                <a href="?status=all">All</a>
                                <a href="?status=0">Pending</a>
                                <a href="?status=1">Process</a>
                                <a href="?status=2">Delivering</a>
                                <a href="?status=3">Done</a>
                                <a href="?status=4">Canceled</a>
                                <a href="?status=5">Returned</a>
                            </ul>
                        </div>

                        <div class="order-list">
                            <% if (orderItems != null && !orderItems.isEmpty()) { 
                                int currentOrderId = -1;
                                double totalOrderAmount = 0;
                                Date currentDate = new Date();
        
                                for (Order order : orderItems) {
                                    if (order.getOrderID() != currentOrderId) {
                                        if (currentOrderId != -1) {
                                            out.println("<div><strong>Total Order Amount: $" + totalOrderAmount + "</strong></div>");
                                            out.println("</div>");
                                        }
                                        currentOrderId = order.getOrderID();
                                        totalOrderAmount = 0;
                                        out.println("<div class='order'>");
                                        out.println("<div class='order-products'>");
                                    }
                                    totalOrderAmount += order.getProducttotal();

                                    Date orderCompletionDate = order.getOrderDate(); // Assuming getOrderDate() returns the completion date
                                    long diffInMillies = Math.abs(currentDate.getTime() - orderCompletionDate.getTime());
                                    long diffDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
                            %>
                            <div class="product-cart d-flex">
                                <div class="one-eight text-center">
                                    <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/<%= order.getImageUrl() %>);"></div>
                                    <div class="display-tc">
                                        <h3><%= order.getProductName() %></h3>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">x<%= order.getQuantity() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">Price: $<%= order.getSalePrice() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="total">Total: $<%= order.getProducttotal() %></span>
                                    </div>
                                </div>

                                <!-- Show order status when "All" is selected -->
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>Status: 
                                            <%
                                                String statusLabel = "";
                                                switch (order.getStatus()) {
                                                    case "0": statusLabel = "Pending"; break;
                                                    case "1": statusLabel = "Process"; break;
                                                    case "2": statusLabel = "Delivering"; break;
                                                    case "3": statusLabel = "Done"; break;
                                                    case "4": statusLabel = "Canceled"; break;
                                                    case "5": statusLabel = "Returned"; break;
                                                    default: statusLabel = "Unknown"; break;
                                                }
                                                out.print(statusLabel);
                                            %>
                                        </span>
                                    </div>
                                </div>

                                <% if (order.getStatus().equals("0")) { %>
                                <!-- Cancel Order Button for Pending Orders -->
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <form action="${pageContext.request.contextPath}/CancelOrderController" method="post">
                                            <input type="hidden" name="orderId" value="<%= order.getOrderID() %>" />
                                            <button type="submit" class="btn btn-danger">Cancel Order</button>
                                        </form>
                                    </div>
                                </div>
                                <% } else if (order.getStatus().equals("4")) { %>
                                <!-- Buy Again Button for Canceled Orders -->
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <form action="${pageContext.request.contextPath}/BuyAgainController" method="post">
                                            <input type="hidden" name="orderId" value="<%= order.getOrderID() %>" />
                                            <button type="submit" class="btn btn-success">Buy Again</button>
                                        </form>
                                    </div>
                                </div>
                                <% } else if (order.getStatus().equals("3") && diffDays <= 15) { %>
                                <!-- Request Return Button for Orders Done within 15 days -->
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <form method="get" action="return_product.jsp">
                                            <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                            <input type="hidden" name="quantity" value="<%= order.getQuantity() %>">
                                            <input type="hidden" name="price" value="<%= order.getSalePrice() %>">
                                            <button type="submit" class="btn btn-warning">Request Return</button>
                                        </form>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            <% 
                                } // End of the orderItems loop

                                // After the loop ends, output the total for the last order
                                if (currentOrderId != -1) {
                                    out.println("<div><strong>Total Order Amount: $" + totalOrderAmount + "</strong></div>");
                                    out.println("</div>");
                                }
                            %>
                            <% } else { %>
                            <div>No orders found.</div>
                            <% } %>
                        </div>

                    </div>
                </div>
            </div>
    </body>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <!-- popper -->
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <!-- bootstrap 4.1 -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <!-- jQuery easing -->
    <script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
    <!-- Waypoints -->
    <script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
    <!-- Flexslider -->
    <script src="${pageContext.request.contextPath}/js/jquery.flexslider-min.js"></script>
    <!-- Owl carousel -->
    <script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
    <!-- Magnific Popup -->
    <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/magnific-popup-options.js"></script>
    <!-- Date Picker -->
    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
    <!-- Stellar Parallax -->
    <script src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
    <!-- Main -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</html>
