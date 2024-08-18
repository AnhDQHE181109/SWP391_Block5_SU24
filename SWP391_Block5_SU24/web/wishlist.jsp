<%-- 
    Document   : wishlist
    Created on : Aug 17, 2024, 6:38:33 PM
    Author     : nobbe
--%>

<%@ page import="java.util.List" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
    <title>Wishlist - Footwear</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">
    
    <!-- Include your existing CSS files -->
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/ionicons.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/flexslider.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
    
<div class="colorlib-loader"></div>

<div id="page">
    <nav class="colorlib-nav" role="navigation">
        <div class="top-menu">
            <div class="container">
                <div class="row">
                    <div class="col-sm-7 col-md-9">
                        <div id="colorlib-logo"><a href="index.jsp">Footwear</a></div>
                    </div>
                    <div class="col-sm-5 col-md-3">
                        <form action="#" class="search-wrap">
                            <div class="form-group d-flex">
                                <input type="search" class="form-control search" placeholder="Search">
                                <button class="btn btn-primary submit-search" type="submit" style="margin-left: 5px;">
                                    <i class="icon-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 text-left menu-1">
                        <ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li class="has-dropdown">
                                <a href="men.html">Men</a>
                                <ul class="dropdown">
                                    <li><a href="product-detail.html">Product Detail</a></li>
                                    <li><a href="cart.html">Shopping Cart</a></li>
                                    <li><a href="checkout.html">Checkout</a></li>
                                    <li><a href="order-complete.html">Order Complete</a></li>
                                    <li><a href="wishlist.jsp">Wishlist</a></li>
                                </ul>
                            </li>
                            <li><a href="women.html">Women</a></li>
                            <li><a href="about.html">About</a></li>
                            <li><a href="contact.html">Contact</a></li>
                            <li class="cart"><a href="cart.html"><i class="icon-shopping-cart"></i> Cart [0]</a></li>
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
                    <p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Wishlist</span></p>
                </div>
            </div>
        </div>
    </div>

    <div class="colorlib-product">
        <div class="container">
            <% 
                Account account = (Account) session.getAttribute("account");
                if (account == null) {
                    response.sendRedirect("login.jsp");
                }
            %>

            <!-- Flex container for search and sort options -->
            <div class="row mb-4">
                <div class="col-md-12 d-flex justify-content-between">
                    <!-- Search bar -->
                    <form action="#" class="search-wrap d-flex">
                        <div class="form-group d-flex">
                            <input type="search" class="form-control search" placeholder="Search">
                            <button class="btn btn-primary submit-search" type="submit" style="margin-left: 5px;">
                                <i class="icon-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Sorting options -->
                    <form method="get" action="WishlistController" class="d-flex align-items-center">
                        <label for="sort" class="mr-2">Sort By:</label>
                        <select name="sort" id="sort" class="form-control" onchange="this.form.submit()">
                            <option value="name">Name</option>
                            <option value="price">Price</option>
                        </select>
                    </form>
                </div>
            </div>

            <div class="row row-pb-lg">
                <div class="col-md-12">
                    <div class="product-name d-flex">
                        <div class="one-forth text-left px-4">
                            <span>Product Details</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Price</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Size</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Color</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Add to Cart</span>
                        </div>
                        <div class="one-eight text-center px-4">
                            <span>Remove</span>
                        </div>
                    </div>

                    <!-- Display wishlist items dynamically -->
                    <c:if test="${wishlistItems != null && !wishlistItems.isEmpty()}">
                        <c:forEach var="item" items="${wishlistItems}">
                            <div class="product-cart d-flex">
                                <div class="one-forth">
                                    <div class="product-img" style="background-image: url(${item.imageURL});"></div>
                                    <div class="display-tc">
                                        <h3>${item.productName}</h3>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">${item.price}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>${item.size}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>${item.color}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <a href="CartController?action=add&stockId=${item.stockID}" class="btn btn-primary">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <a href="WishlistController?action=remove&wishlistId=${item.wishlistID}" class="closed"></a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!-- If the wishlist is empty -->
                    <c:if test="${wishlistItems == null || wishlistItems.isEmpty()}">
                        <p>Your wishlist is empty.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <footer id="colorlib-footer" role="contentinfo">
        <!-- Footer content -->
    </footer>
</div>

<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
</div>
<!-- Include your existing JS files -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/magnific-popup-options.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/jquery.stellar.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>


