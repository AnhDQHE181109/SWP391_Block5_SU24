<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Order" %>
<%@ page import="entity.Account" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%
    // Retrieve the sorting parameter from the request
    String sort = request.getParameter("sort");

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
        orderItems = orderDAO.getAllOrdersByCustomerId(accountId); // Pass the sort parameter
    }
%>

<html>
    <head>
        <title>Footwear - Order List</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Include existing CSS files -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icomoon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flexslider.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/flaticon/font/flaticon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <div class="colorlib-loader"></div>

        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <div class="top-menu">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-7 col-md-9">
                                <div id="colorlib-logo"><a href="${pageContext.request.contextPath}/index.jsp">Footwear</a></div>
                            </div>
                            <div class="col-sm-5 col-md-3">
                                <form action="${pageContext.request.contextPath}/products.jsp" class="search-wrap" method="get">
                                    <div class="form-group">
                                        <input type="text" id="search-bar" name="query" class="form-control" placeholder="Search for more products..." onkeyup="searchProducts()">
                                        <div id="suggestions" class="list-group"></div>
                                        <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
                                    <li><a href="${pageContext.request.contextPath}/about.html">About</a></li>
                                    <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                    <li class="cart"><a href="${pageContext.request.contextPath}/shoppingCart"><i class="icon-shopping-cart"></i> Cart [0]</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span><a href="${pageContext.request.contextPath}/index.jsp">Home</a></span> / <span>Order List</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="colorlib-product">
                <div class="container">
                    <div class="row">
                        <div class="col-md-20 text-center">
                            <form method="get" action="orderlist.jsp">
                                <label for="sort">Sort by:</label>
                                <select name="sort" id="sort" onchange="this.form.submit()">
                                    <option value="date_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_desc") ? "selected" : "" %>>Date: Latest</option>
                                    <option value="date_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_asc") ? "selected" : "" %>>Date: Earliest</option>
                                    <option value="price_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("price_desc") ? "selected" : "" %>>Price: High to Low</option>
                                    <option value="price_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("price_asc") ? "selected" : "" %>>Price: Low to High</option>
                                </select>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="row row-pb-lg wishlist-table">
                    <div class="col-md-12">
                        <div class="product-name d-flex wishlist-table">
                            <div class="one-forth text-left px-4 wishlist-table">
                                <span>Order Details</span>
                            </div>
                            <div class="one-eight text-center wishlist-table">
                                <span>Date</span>
                            </div>
                            <div class="one-eight text-center wishlist-table">
                                <span>Product</span>
                            </div>
                            <div class="one-eight text-center wishlist-table">
                                <span>Price</span>
                            </div>
                            <div class="one-eight text-center wishlist-table">
                                <span>Total</span>
                            </div>
                        </div>

                        <%
                        int currentOrderId = -1;
                        double totalOrderAmount = 0;

                        for (Order order : orderItems) {
                            if (order.getOrderID() != currentOrderId) {
                                if (currentOrderId != -1) {
                                    // Print total for the previous order
                                    out.println("<div><strong>Total Order Amount: $" + totalOrderAmount + "</strong></div>");
                                    out.println("</div>");
                                }
                                currentOrderId = order.getOrderID();
                                totalOrderAmount = 0;
                                out.println("<div class='order'>");
                                out.println("<h2>Order #" + currentOrderId + "</h2>");
                                out.println("<div class='order-products'>");
                            }

                            totalOrderAmount += order.getProducttotal();
                            %>
                            <div class="product-cart d-flex">
                                <div class="one-forth">
                                    <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/<%= order.getImageUrl() %>);"></div>
                                    <div class="display-tc">
                                        <h3><%= order.getProductName() %></h3>
                                    </div>
                                </div>

                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="date"><%= order.getOrderDate() %></span>
                                    </div>
                                </div>

                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="product-name"><%= order.getProductName() %></span>
                                    </div>
                                </div>

                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">$<%= order.getSalePrice() %></span>
                                    </div>
                                </div>

                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="total">$<%= order.getProducttotal() %></span>
                                    </div>
                                </div>
                            </div>
                        <%
                        }
                        if (currentOrderId != -1) {
                            // Print total for the last order
                            out.println("<div><strong>Total Order Amount: $" + totalOrderAmount + "</strong></div>");
                            out.println("</div>");
                        }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <footer id="colorlib-footer" role="contentinfo">
            <div class="container">
                <div class="row row-pb-md">
                    <!-- Footer content -->
                </div>
            </div>
        </footer>
    </div>

    <div class="gototop js-top">
        <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
    </div>

    <!-- Include existing JS files -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.flexslider-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/magnific-popup-options.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
