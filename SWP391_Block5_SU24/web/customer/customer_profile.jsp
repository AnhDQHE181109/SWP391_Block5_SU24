<%-- 
    Document   : customer_profile
    Created on : Aug 15, 2024, 9:40:10 AM
    Author     : Long
--%>
<%@ page import="java.util.*" %>
<%@ page import="entity.*" %>
<%@ page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> bestSellers = pDAO.getBestSellers();
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
        .profile_container{
            display:flex;
            justify-content: center;
            background-color: #f5f5f5;
        }
        .side-bar{
            display:flex;
            flex-direction: column;
            align-content: center;
            margin:20px;
            margin-top:40px;
        }
        .main-bar{
            margin:20px;
            margin-top:40px;
            background-color:white;
            box-shadow: 20px 16px #88c8bc;
            width:993px;
            height:546px;
        }
        .side-bar-user{
            margin:10px;
            width:90%;
            display:flex;
            flex-direction: row;
            align-content: center;
            padding-bottom: 3px;
            border-bottom: 3px solid #efefef;
        }
        .side-bar-nav{
            margin:10px;
            width:90%;
            margin-left:15px;
            display:flex;
            flex-direction: row;
            align-content: center;
            padding-bottom: 3px;
        }
        .top-main-bar{
            width:90%;
            margin-left:5%;
            align-content: center;
            padding-top:10px;
            border-bottom: 3px solid #efefef;
            padding-bottom:15px;
        }
        .body-main-bar{
            width:90%;
            margin-left: 5%;
            height:80%;
            margin-top:10px;
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
                    <div class="top-main-bar"><span style="font-size:18px;font-weight: 500">My Profile</span><br>Manage and protect your account</div>
                    <div class="body-main-bar">hello</div>
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
