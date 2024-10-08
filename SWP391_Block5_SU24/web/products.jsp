<!DOCTYPE HTML>
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
<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Brand> brandList = pDAO.getAllBrands();
    List<Category> categoryList = pDAO.getAllCategories();
    List<String> colorList = pDAO.getAllColors();
    List<Integer> sizeList = pDAO.getAllSizes();
    List<String> materialList = pDAO.getAllMaterials();

    String[] selectedBrands = request.getParameterValues("brand");
    String[] selectedCategories = request.getParameterValues("category");
    String[] selectedColors = request.getParameterValues("color");
    String[] selectedSizes = request.getParameterValues("size");
    String[] selectedMaterials = request.getParameterValues("material");

    List<Integer> brandIds = (selectedBrands != null) ? Arrays.stream(selectedBrands).map(Integer::parseInt).collect(Collectors.toList()) : new ArrayList<>();
    List<Integer> categoryIds = (selectedCategories != null) ? Arrays.stream(selectedCategories).map(Integer::parseInt).collect(Collectors.toList()) : new ArrayList<>();
    List<String> colors = (selectedColors != null) ? Arrays.asList(selectedColors) : new ArrayList<>();
    List<Integer> sizes = (selectedSizes != null) ? Arrays.stream(selectedSizes).map(Integer::parseInt).collect(Collectors.toList()) : new ArrayList<>();
    List<String> materials = (selectedMaterials != null) ? Arrays.asList(selectedMaterials) : new ArrayList<>();
    String query = request.getParameter("query");
    List<Product> products = pDAO.getFilteredProducts(brandIds, categoryIds, colors, sizes, materials, query);
%>
<html>
    <head>
        <title>Products</title>
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

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Products</span></p>
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

            <div class="colorlib-featured">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 text-center">
                            <div class="featured">
                                <div class="featured-img featured-img-2" style="background-image: url(images/img_bg_2.jpg);">
                                    <h2>Nike</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 text-center">
                            <div class="featured">
                                <div class="featured-img featured-img-2" style="background-image: url(images/women.jpg);">
                                    <h2>Puma</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 text-center">
                            <div class="featured">
                                <div class="featured-img featured-img-2" style="background-image: url(images/item-11.jpg);">
                                    <h2>Air forces</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="colorlib-product">
                <div class="container">
                    <div class="row">

                        <div class="col-lg-3 col-xl-3">
                            <form method="get" action="products.jsp">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="side border mb-1">
                                            <h3>Brand</h3>
                                            <ul>
                                                <% for(Brand brand : brandList) { %>
                                                <li>
                                                    <input type="checkbox" name="brand" value="<%= brand.getBrandId() %>" <%= (request.getParameterValues("brand") != null && Arrays.asList(request.getParameterValues("brand")).contains(String.valueOf(brand.getBrandId()))) ? "checked" : "" %> />
                                                    <%= brand.getBrandName() %>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="side border mb-1">
                                            <h3>Size</h3>
                                            <ul>
                                                <% for(Integer size : sizeList) { %>
                                                <li>
                                                    <input type="checkbox" name="size" value="<%= size %>" <%= (request.getParameterValues("size") != null && Arrays.asList(request.getParameterValues("size")).contains(String.valueOf(size))) ? "checked" : "" %> />
                                                    <%= size %>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="side border mb-1">
                                            <h3>Category</h3>
                                            <ul>
                                                <% for(Category category : categoryList) { %>
                                                <li>
                                                    <input type="checkbox" name="category" value="<%= category.getCategoryId() %>" <%= (request.getParameterValues("category") != null && Arrays.asList(request.getParameterValues("category")).contains(String.valueOf(category.getCategoryId()))) ? "checked" : "" %> />
                                                    <%= category.getCategoryName() %>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="side border mb-1">
                                            <h3>Colors</h3>
                                            <ul>
                                                <% for(String color : colorList) { %>
                                                <li>
                                                    <input type="checkbox" name="color" value="<%= color %>" <%= (request.getParameterValues("color") != null && Arrays.asList(request.getParameterValues("color")).contains(color)) ? "checked" : "" %> />
                                                    <%= color %>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <button type="submit" class="btn btn-primary">Apply Filters</button>
                                    </div>
                            </form>       
                        </div>
                    </div>

                    <div class="col-lg-9 col-xl-9">
                        <div class="row row-pb-md">
                            <% for (Product product : products) { %>
                            <div class="col-lg-4 mb-4 text-center">
                                <div class="product-entry border">
                                    <a href="ProductDetailsController?productID=<%=product.getProductId() %>" class="prod-img">
                                        <img src="<%= product.getImageURL() %>" class="img-fluid" alt="Product Image">
                                    </a>
                                    <div class="desc">
                                        <h2><a href="ProductDetailsController?productID=<%=product.getProductId() %>"><%= product.getProductName() %></a></h2>
                                        <span class="price">$<%= product.getPrice() %></span>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <div class="w-100"></div>

                        <div class="row">
                            <div class="col-md-12 text-center">
                                <div class="block-27">
                                    <ul>
                                        <li><a href="#"><i class="ion-ios-arrow-back"></i></a></li>
                                        <li class="active"><span>1</span></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#">5</a></li>
                                        <li><a href="#"><i class="ion-ios-arrow-forward"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
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
                            <span><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></span> 
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

