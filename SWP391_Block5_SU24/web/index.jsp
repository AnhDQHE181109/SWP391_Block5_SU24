<%-- 
    Document   : index.jsp
    Created on : Aug 11, 2024, 7:23:09 PM
    Author     : Long
--%>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> bestSellers = pDAO.getBestSellers();
    List<Product> discountedProducts = pDAO.getDiscountedProducts();
%>
<html>
    <head>
        <title>Home Screen</title>
        <script src="https://kit.fontawesome.com/c630e9f862.js" crossorigin="anonymous"></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">

        <!-- Animate.css -->
        <link rel="stylesheet" href="css/animate.css">
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="css/icomoon.css">
        <!-- Ion Icon Fonts-->
        <link rel="stylesheet" href="css/ionicons.min.css">
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <!-- Magnific Popup -->
        <link rel="stylesheet" href="css/magnific-popup.css">

        <!-- Flexslider  -->
        <link rel="stylesheet" href="css/flexslider.css">

        <!-- Owl Carousel -->
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">

        <!-- Date Picker -->
        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <!-- Flaticons  -->
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

        <!-- Theme style  -->
        <link rel="stylesheet" href="css/style.css">

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
        .cart.dropdown .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            display: none;
            z-index: 1000;
            min-width: 160px;
            padding: 5px 0;
            margin: 0;
            font-size: 14px;
            color: #333;
            text-align: left;
            background-color: #fff;
            border: 1px solid rgba(0, 0, 0, 0.15);
            border-radius: 4px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
        }

        .cart.dropdown:hover .dropdown-menu {
            display: block;
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
                                    <li class="active"><a href="index.jsp">Home</a></li>
                                    <li><a class="active" href="products.jsp">Products</a></li>
                                    
                                        <% if (session.getAttribute("account") != null) { %>
                                        <%
                                        int accountID = 0;
                                        Account account = (Account)session.getAttribute("account");
                                        if (account != null) {
                                            accountID = account.getAccountID();
                                        }
                                        int cartItemsCount = pDAO.getCartItemsCount(accountID);
                                        %>
                                    <li class="cart dropdown">
                                        <a href="#" class="dropdown-toggle" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fa-regular fa-user"></i> <%= ((Account) session.getAttribute("account")).getUsername() %>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                            <a class="dropdown-item" href="customer/customer_profile.jsp">Profile</a>
                                            <a class="dropdown-item" href="LogoutController">Logout</a>
                                        </div>
                                    </li>
                                    <li class="cart"><a href="customer/wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>

                                    <li class="cart"><a href="shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
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
            <aside id="colorlib-hero">
                <div class="flexslider">
                    <ul class="slides">
                        <li style="background-image: url(images/img_bg_1.jpg);">
                            <div class="overlay"></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                        <div class="slider-text-inner">
                                            <div class="desc">
                                                <h1 class="head-1">Men's</h1>
                                                <h2 class="head-2">Shoes</h2>
                                                <h2 class="head-3">Collection</h2>
                                                <p class="category"><span>New trending shoes</span></p>
                                                <p><a href="products.jsp" class="btn btn-primary">Shop Collection</a></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li style="background-image: url(images/slider-images.jpg);">
                            <div class="overlay"></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                        <div class="slider-text-inner">
                                            <div class="desc">
                                                <h1 class="head-1">Huge</h1>
                                                <h2 class="head-2">Sale</h2>
                                                <h2 class="head-3"><strong class="font-weight-bold">50%</strong> Off</h2>
                                                <p class="category"><span>Big sale sandals</span></p>
                                                <p><a href="products.jsp" class="btn btn-primary">Shop Collection</a></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li style="background-image: url(images/img_bg_3.jpg);">
                            <div class="overlay"></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                        <div class="slider-text-inner">
                                            <div class="desc">
                                                <h1 class="head-1">New</h1>
                                                <h2 class="head-2">Arrival</h2>
                                                <h2 class="head-3">up to <strong class="font-weight-bold">30%</strong> off</h2>
                                                <p class="category"><span>New stylish shoes for men</span></p>
                                                <p><a href="#" class="btn btn-primary">Shop Collection</a></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </aside>
            <div class="colorlib-intro">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <h2 class="intro">It started with a simple idea: Create quality, well-designed products that I wanted myself.</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="colorlib-product">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-6 text-center">
                            <div class="featured">
                                <a href="#" class="featured-img" style="background-image: url(images/men.jpg);"></a>
                                <div class="desc">
                                    <h2><a href="#">Shop Nike's Collection</a></h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 text-center">
                            <div class="featured">
                                <a href="#" class="featured-img" style="background-image: url(images/women.jpg);"></a>
                                <div class="desc">
                                    <h2><a href="#">Shop Puma's Collection</a></h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="colorlib-product">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 offset-sm-2 text-center colorlib-heading">
                            <h2>Best Sellers</h2>
                        </div>
                    </div>
                    <div class="row row-pb-md">
                        <% for (Product product : bestSellers) { %>
                        <div class="col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="ProductDetailsController?productID=<%=product.getProductId() %>" class="prod-img">
                                    <img src="<%= product.getImageURL() %>" class="img-fluid" alt="Product Image">
                                </a>
                                <div class="desc">
                                    <h2><a href="ProductDetailsController?productID=<%=product.getProductId() %>"><%= product.getProductName() %></a></h2>
                                    <span class="price"><%= product.getPrice() %></span>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="row">
                        <div class="col-sm-8 offset-sm-2 text-center colorlib-heading">
                            <h2>On Sale</h2>
                        </div>
                    </div>
                    <div class="row row-pb-md">
                        <% for (Product product : discountedProducts) { %>
                        <div class="col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="ProductDetailsController?productID=<%=product.getProductId() %>" class="prod-img">
                                    <img src="<%= product.getImageURL() %>" class="img-fluid" alt="Product Image">
                                </a>
                                <div class="desc">
                                    <h2><a href="ProductDetailsController?productID=<%=product.getProductId() %>"><%= product.getProductName() %></a></h2>
                                    <span class="price"><%= product.getPrice() %></span>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="colorlib-partner">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 offset-sm-2 text-center colorlib-heading colorlib-heading-sm">
                            <h2>Trusted Partners</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col partner-col text-center">
                            <img src="images/brand-1.jpg" class="img-fluid" alt="Free html4 bootstrap 4 template">
                        </div>
                        <div class="col partner-col text-center">
                            <img src="images/brand-2.jpg" class="img-fluid" alt="Free html4 bootstrap 4 template">
                        </div>
                        <div class="col partner-col text-center">
                            <img src="images/brand-3.jpg" class="img-fluid" alt="Free html4 bootstrap 4 template">
                        </div>
                        <div class="col partner-col text-center">
                            <img src="images/brand-4.jpg" class="img-fluid" alt="Free html4 bootstrap 4 template">
                        </div>
                        <div class="col partner-col text-center">
                            <img src="images/brand-5.jpg" class="img-fluid" alt="Free html4 bootstrap 4 template">
                        </div>
                    </div>
                </div>
            </div>

            <footer id="colorlib-footer" role="contentinfo">
                <div class="container">
                    <div class="row row-pb-md">
                        <div class="col footer-col colorlib-widget">
                            <h4>About Footwear</h4>
                            <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life</p>
                            <p>
                            <ul class="colorlib-social-icons">
                                <li><a href="#"><i class="icon-twitter"></i></a></li>
                                <li><a href="#"><i class="icon-facebook"></i></a></li>
                                <li><a href="#"><i class="icon-linkedin"></i></a></li>
                                <li><a href="#"><i class="icon-dribbble"></i></a></li>
                            </ul>
                            </p>
                        </div>
                        <div class="col footer-col colorlib-widget">
                            <h4>Customer Care</h4>
                            <p>
                            <ul class="colorlib-footer-links">
                                <li><a href="#">Contact</a></li>
                                <li><a href="#">Returns/Exchange</a></li>
                                <li><a href="#">Gift Voucher</a></li>
                                <li><a href="#">Wishlist</a></li>
                                <li><a href="#">Special</a></li>
                                <li><a href="#">Customer Services</a></li>
                                <li><a href="#">Site maps</a></li>
                            </ul>
                            </p>
                        </div>
                        <div class="col footer-col colorlib-widget">
                            <h4>Information</h4>
                            <p>
                            <ul class="colorlib-footer-links">
                                <li><a href="#">About us</a></li>
                                <li><a href="#">Delivery Information</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Support</a></li>
                                <li><a href="#">Order Tracking</a></li>
                            </ul>
                            </p>
                        </div>

                        <div class="col footer-col">
                            <h4>News</h4>
                            <ul class="colorlib-footer-links">
                                <li><a href="blog.html">Blog</a></li>
                                <li><a href="#">Press</a></li>
                                <li><a href="#">Exhibitions</a></li>
                            </ul>
                        </div>

                        <div class="col footer-col">
                            <h4>Contact Information</h4>
                            <ul class="colorlib-footer-links">
                                <li>291 South 21th Street, <br> Suite 721 New York NY 10016</li>
                                <li><a href="tel://1234567920">+ 1235 2355 98</a></li>
                                <li><a href="mailto:info@yoursite.com">info@yoursite.com</a></li>
                                <li><a href="#">yoursite.com</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="copy">
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <p>
                                <span>
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                </span> 
                                <span class="block">Demo Images: <a href="http://unsplash.co/" target="_blank">Unsplash</a> , <a href="http://pexels.com/" target="_blank">Pexels.com</a></span>
                            </p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

        <div class="gototop js-top">
            <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
        </div>

        <!-- jQuery -->
        <script src="js/jquery.min.js"></script>
        <!-- popper -->
        <script src="js/popper.min.js"></script>
        <!-- bootstrap 4.1 -->
        <script src="js/bootstrap.min.js"></script>
        <!-- jQuery easing -->
        <script src="js/jquery.easing.1.3.js"></script>
        <!-- Waypoints -->
        <script src="js/jquery.waypoints.min.js"></script>
        <!-- Flexslider -->
        <script src="js/jquery.flexslider-min.js"></script>
        <!-- Owl carousel -->
        <script src="js/owl.carousel.min.js"></script>
        <!-- Magnific Popup -->
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/magnific-popup-options.js"></script>
        <!-- Date Picker -->
        <script src="js/bootstrap-datepicker.js"></script>
        <!-- Stellar Parallax -->
        <script src="js/jquery.stellar.min.js"></script>
        <!-- Main -->
        <script src="js/main.js"></script>
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

                                        function fetchSuggestions(query) {
                                            fetch('SearchSuggestionsServlet?query=' + encodeURIComponent(query))
                                                    .then(response => response.text())
                                                    .then(data => {
                                                        let suggestionsBox = document.getElementById('suggestions');
                                                        suggestionsBox.innerHTML = data;
                                                        if (data.trim().length > 0) {
                                                            suggestionsBox.style.display = 'block';
                                                            // Add click event to each suggestion
                                                            suggestionsBox.querySelectorAll('.dropdown-item').forEach(item => {
                                                                item.addEventListener('click', function () {
                                                                    document.getElementById('search-bar').value = this.innerText.trim();
                                                                    suggestionsBox.style.display = 'none';
                                                                });
                                                            });
                                                        } else {
                                                            suggestionsBox.style.display = 'none';
                                                        }
                                                    })
                                                    .catch(error => {
                                                        console.error('Error fetching suggestions:', error);
                                                    });
                                        }
        </script>
        <script>
            document.addEventListener('click', function (event) {
                var isClickInside = document.getElementById('userDropdown').contains(event.target);

                if (!isClickInside) {
                    // Close the dropdown
                    document.querySelector('.cart.dropdown .dropdown-menu').style.display = 'none';
                }
            });
        </script>
    </body>
</html>
