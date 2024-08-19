<%@ page import="java.util.List" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Brand" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Color" %>
<%@ page import="entity.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.stream.Collectors" %>
<style>
    #suggestions {
        border: 1px solid #ddd;
        max-height: 300px;
        overflow-y: auto;
        z-index: 1000;
        background-color: white;
    }

    #suggestions .dropdown-item {
        cursor: pointer;
        padding: 8px;
        display: flex;
        align-items: center;
    }

    #suggestions .dropdown-item img {
        width: 50px;
        height: 50px;
        margin-right: 10px;
        border-radius: 5px;
    }

    #suggestions .dropdown-item span {
        flex-grow: 1;
    }

</style>
<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> newArrivals = pDAO.getNewArrivals();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>New Arrivals - Footwear</title>
        <script src="https://kit.fontawesome.com/c630e9f862.js" crossorigin="anonymous"></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Include your CSS files here -->
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
                                <form action="products.jsp" method="get" class="search-wrap">
                                    <div class="form-group position-relative">
                                        <input type="search" name="query" id="search-bar" class="form-control search" placeholder="Search for products...">
                                        <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
                                        <div id="suggestions" class="dropdown-menu" style="display: none; position: absolute; width: 100%;"></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li><a href="index.jsp">Home</a></li>
                                    <li class="has-dropdown">
                                        <ul class="dropdown">
                                            <li><a href="product-detail.html">Product Detail</a></li>
                                            <li><a href="cart.html">Shopping Cart</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="order-complete.html">Order Complete</a></li>
                                            <li><a href="add-to-wishlist.html">Wishlist</a></li>
                                        </ul>
                                    </li>
                                    <li class="active"><a href="products.jsp">Products</a></li>
                                    <li><a href="about.html">About</a></li>
                                    <li><a href="contact.html">Contact</a></li>
                                        <%if(session.getAttribute("account")!=null){
                                        Account account = (Account) session.getAttribute("account");
                                        %>
                                    <li class = "cart" id="lsbtn"><a href="LogoutController">Logout</a></li>
                                    <li class = "cart"><i class="fa-regular fa-user"> </i> <%= account.getUsername()%></li>
                                        <%}else{%>
                                    <li class = "cart" id="lsbtn"><a href="signup.jsp">Sign Up</a></li>
                                    <li class = "cart" id="lsbtn"><a href="login.jsp">Login</a></li><%}%>
                                        <%
                                            Account account = (Account) session.getAttribute("account");
                                            int accountID = 0;
                                            if (account != null) {
                                                accountID = account.getAccountID();
                                            }
                                            int cartItemsCount = pDAO.getCartItemsCount(accountID);
                                        %>
                                    <li class="cart"><a href="shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
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

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span><a href="index.jsp">Home</a></span> / <span>New arrivals</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="breadcrumbs-two">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="breadcrumbs-img" style="background-image: url(images/cover-img-1.jpg);">
                            </div>
                            <div class="menu text-center">
                                <a href="newarrival.jsp" class="btn btn-primary btn-lg">New Arrivals</a>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- New Arrival Products Section -->
            <div class="colorlib-product">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 offset-sm-2 text-center colorlib-heading">
                            <h2>New Arrivals</h2>
                        </div>
                    </div>
                    <div class="row row-pb-md">
                        <% for (Product product : newArrivals) { %>
                        <div class="col-lg-4 mb-4 text-center">
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

            <!-- Include footer here if necessary -->

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
            document.getElementById('search-bar').addEventListener('input', function () {
                let query = this.value;
                if (query.length > 0) {
                    fetchSuggestions(query);
                } else {
                    document.getElementById('suggestions').style.display = 'none';
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
    </body>
</html>
