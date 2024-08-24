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
<%Account account = (Account)session.getAttribute("account");%> 
<%
if(!"true".equals(request.getAttribute("autho"))){
    request.getRequestDispatcher("customer/customer_profile.jsp").forward(request, response);
    }
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
            min-height:546px;
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
        .protbox{
            width:370px;
        }
        .sbtn{
            align-items:center;
            border-radius:2px;
            padding:0px 20px;
            height:40px;
            border:none;
            box-shadow:#00000017 0px 1px 1px 0px;
            background-color:#88c8bc;
            color:white;
        }
        .modal {
            position: fixed;
            inset: 0;
            background: rgba(235,
                235,
                235,
                0.7);
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal_error {
            position: fixed;
            inset: 0;
            background: rgba(235,
                235,
                235,
                0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
        }

        .content {
            position: relative;
            background: white;
            padding: 1em 2em;
            border-radius: 4px;
        }

        .modal:target {
            display: flex;
        }
        .digits input {
            font-size: 2rem;
            width: 1.5rem;
            text-align: center;
        }
        .digits input:focus {
            border: 2px solid yellowgreen;
            outline: none;
        }
        #message {
            display:none;
            background: #f1f1f1;
            color: #000;
            position: relative;
            padding: 0px 10px 10px 10px;
            margin-bottom: 5px;
        }
        #message p {
            padding: 0px 35px;
            font-size: 14px;
        }
        .valid {
            color: green;
        }

        .valid:before {
            position: relative;
            left: -35px;
            content: "✔";
        }
        .invalid {
            color: red;
        }

        .invalid:before {
            position: relative;
            left: -35px;
            content: "✖";
        }
        .valid2 {
            color: green;
        }

        .valid2:before {
            position: relative;
            left: -35px;
            content: "✔";
        }
        .invalid2 {
            color: red;
        }

        .invalid2:before {
            position: relative;
            left: -35px;
            content: "✖";
        }
        #message2 p {
            padding: 0px 35px;
            font-size: 14px;
        }
        #message2 {
            display:none;
            background: #f1f1f1;
            color: #000;
            position: relative;
            padding: 0px 10px 10px 10px;
            margin-bottom: 5px;
        }
    </style>
    <body>
        <%
        String errorRecover = request.getParameter("error_recover");
        boolean showErrorModal = "true".equals(errorRecover);
        boolean showErrorPass = "true".equals(request.getParameter("error_auth_pass"));
        long remainingTime = 100*6*60*1000;
        try{
        long endTime = (long) session.getAttribute("endTime");
        long currentTime = System.currentTimeMillis();
        remainingTime = endTime - currentTime;
     
        if (remainingTime <= 0) {
        // Time's up, redirect back to the servlet
        response.sendRedirect("customer_profile.jsp");
        }
            }catch(Exception e){}
        %>

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
                                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                    <li><a class="active" href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
                                    <li><a href="${pageContext.request.contextPath}/about.html">About</a></li>
                                    <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                        <% if (session.getAttribute("account") != null) { %>
                                    <li class="cart active"><i style='color:#9bcbbc' class="fa-regular fa-user"></i> <a href="${pageContext.request.contextPath}/customer/customer_profile.jsp"><%= ((Account) session.getAttribute("account")).getUsername() %></a></li>
                                    <li class="cart"><a href="wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>
                                        <%
                                        int accountID = 0;
                                        
                                        if (account != null) {
                                            accountID = account.getAccountID();
                                        }
                                        int cartItemsCount = pDAO.getCartItemsCount(accountID);
                                        %>
                                    <li class="cart"><a href="${pageContext.request.contextPath}/shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
                                    <li class="cart"><a href="${pageContext.request.contextPath}/LogoutController">Logout</a></li>
                                        <% } else { %>
                                    <li class="cart"><a href="signup.jsp">Sign Up</a></li>
                                    <li class="cart"><a href="login.jsp">Login</a></li>
                                    <li class="cart"><a href="${pageContext.request.contextPath}/shoppingCart"><i class="icon-shopping-cart"></i> Cart [0]</a></li>
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
                    <div class="side-bar-user"><div style="display:inline-block"><i style="font-size:48px;" class="fa-solid fa-user"></i></div><div style="display:inline-block; padding-left: 10px;"><span style="font-weight: 600"><%= account.getUsername()%></span><br><a href="${pageContext.request.contextPath}/customer/customer_profile.jsp"><i style="margin-right:3px" class="fa-solid fa-pen"></i>Edit Profile</a></div></div>
                    <div class="side-bar-nav">
                        <table>
                            <tr><th></th><th></th></tr>
                            <tr style="color:black"><td><i style="padding-right:2px" class="fa-regular fa-user"></i></td><td>My Account</td></tr>
                            <tr><td></td><td style="padding-left:7px; padding-top:6px;color:red;"><a href="${pageContext.request.contextPath}/customer/customer_profile.jsp">Profile</a></td></tr>
                            <tr><td></td><td style="padding-left:7px; padding-top:3px;padding-bottom:10px"><a style='color:red;'>Change Password</a></td></tr>
                            <tr style="color:black"><td><i style="padding-right:2px" class="fa-regular fa-bell"></i></td><td><a href='${pageContext.request.contextPath}/LoadNotificationController'>Notification</a></td></tr>
                            <tr style="color:black">
                                <td><i style="padding-right:2px" class="fa-regular fa-list-alt"></i></td>
                                <td><a href="order_list.jsp" style="text-decoration: none; color: black;">My Orders</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="main-bar">
                    <div class="top-main-bar"><span style="font-size:18px;font-weight: 500">My Profile</span><br>Manage and protect your account</div>
                    <div class="body-main-bar">
                        <div style="width:80%;height:80%; margin-left:50px;margin-top:30px;">
                            <form class="pform" action="ChangePassController" method="get">
                                <input type="hidden" name="email" value="<%= account.getEmail()%>">
                                <table>
                                    <tr><th></th><th></th><th></th></tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <% if ("true".equals(request.getAttribute("error_password"))) { %>
                                            <p style="color:red" class="error">Password must contain at least 1 digit, 1 uppercase character!</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_password_short"))) { %>
                                            <p style="color:red" class="error">Password must be at least 8 characters long!</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_password_invalid"))) { %>
                                            <p style="color:red" class="error">Invalid password!</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_password_dupe"))) { %>
                                            <p style="color:red" class="error">Password doesn't match</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_password_match"))) { %>
                                            <p style="color:red" class="error">New password can't be the same as old password</p>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <tr><td style="width:150px; text-align: right;padding-top: 25px; padding-right: 3%;">New Password</td><td style='padding-top: 25px'><input required class="protbox" id="psw" type="password" name='password' pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"></td></tr>
                                    <tr><td></td><td><div id="message">          
                                                <b>Password must contain: </b>
                                                <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                                                <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                                                <p id="number" class="invalid">A <b>number</b></p>
                                                <p id="length" class="invalid">Minimum <b>8 characters</b></p>
                                            </div></td></tr>
                                    <tr><td style="width:150px; text-align: right;padding-top: 25px; padding-right: 3%;">Repeat Password</td><td style='padding-top: 25px'><input required class="protbox" id="psw2" type="password" name='repassword' pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"></td></tr>
                                    <tr><td></td><td><div id="message2">          
                                                <b>Password must contain: </b>
                                                <p id="letter2" class="invalid2">A <b>lowercase</b> letter</p>
                                                <p id="capital2" class="invalid2">A <b>capital (uppercase)</b> letter</p>
                                                <p id="number2" class="invalid2">A <b>number</b></p>
                                                <p id="length2" class="invalid2">Minimum <b>8 characters</b></p>
                                            </div></td></tr>
                                    <tr><td></td><td style='padding-top:20px;padding-bottom:10px;'><button type="submit" class='sbtn'>SAVE</button></td></tr>                              
                                </table>
                            </form>
                        </div>
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
    <script>
        var myInput = document.getElementById("psw");
        var letter = document.getElementById("letter");
        var capital = document.getElementById("capital");
        var number = document.getElementById("number");
        var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
        myInput.onfocus = function () {
            document.getElementById("message").style.display = "block";
        };

// When the user clicks outside of the password field, hide the message box
        myInput.onblur = function () {
            document.getElementById("message").style.display = "none";
        };

// When the user starts to type something inside the password field
        myInput.onkeyup = function () {
            // Validate lowercase letters
            var lowerCaseLetters = /[a-z]/g;
            if (myInput.value.match(lowerCaseLetters)) {
                letter.classList.remove("invalid");
                letter.classList.add("valid");
            } else {
                letter.classList.remove("valid");
                letter.classList.add("invalid");
            }

            // Validate capital letters
            var upperCaseLetters = /[A-Z]/g;
            if (myInput.value.match(upperCaseLetters)) {
                capital.classList.remove("invalid");
                capital.classList.add("valid");
            } else {
                capital.classList.remove("valid");
                capital.classList.add("invalid");
            }

            // Validate numbers
            var numbers = /[0-9]/g;
            if (myInput.value.match(numbers)) {
                number.classList.remove("invalid");
                number.classList.add("valid");
            } else {
                number.classList.remove("valid");
                number.classList.add("invalid");
            }

            // Validate length
            if (myInput.value.length >= 8) {
                length.classList.remove("invalid");
                length.classList.add("valid");
            } else {
                length.classList.remove("valid");
                length.classList.add("invalid");
            }
            if (myInput.value === "") {
                letter.classList.remove("valid");
                letter.classList.add("invalid");
                capital.classList.remove("valid");
                capital.classList.add("invalid");
                number.classList.remove("valid");
                number.classList.add("invalid");
                length.classList.remove("valid");
                length.classList.add("invalid");
            }
        };
        var myInput2 = document.getElementById("psw2");
        var letter2 = document.getElementById("letter2");
        var capital2 = document.getElementById("capital2");
        var number2 = document.getElementById("number2");
        var length2 = document.getElementById("length2");

// When the user clicks on the password field, show the message box
        myInput2.onfocus = function () {
            document.getElementById("message2").style.display = "block";
        };

// When the user clicks outside of the password field, hide the message box
        myInput2.onblur = function () {
            document.getElementById("message2").style.display = "none";
        };

// When the user starts to type something inside the password field
        myInput2.onkeyup = function () {
            // Validate lowercase letters
            var lowerCaseLetters = /[a-z]/g;
            if (myInput2.value.match(lowerCaseLetters)) {
                letter2.classList.remove("invalid2");
                letter2.classList.add("valid2");
            } else {
                letter2.classList.remove("valid2");
                letter2.classList.add("invalid2");
            }

            // Validate capital letters
            var upperCaseLetters = /[A-Z]/g;
            if (myInput2.value.match(upperCaseLetters)) {
                capital2.classList.remove("invalid2");
                capital2.classList.add("valid2");
            } else {
                capital2.classList.remove("valid2");
                capital2.classList.add("invalid2");
            }

            // Validate numbers
            var numbers = /[0-9]/g;
            if (myInput2.value.match(numbers)) {
                number2.classList.remove("invalid2");
                number2.classList.add("valid2");
            } else {
                number2.classList.remove("valid2");
                number2.classList.add("invalid2");
            }

            // Validate length
            if (myInput2.value.length >= 8) {
                length2.classList.remove("invalid2");
                length2.classList.add("valid2");
            } else {
                length2.classList.remove("valid2");
                length2.classList.add("invalid2");
            }
            if (myInput2.value === "") {
                letter2.classList.remove("valid");
                letter2.classList.add("invalid");
                capital2.classList.remove("valid");
                capital2.classList.add("invalid");
                number2.classList.remove("valid");
                number2.classList.add("invalid");
                length2.classList.remove("valid");
                length2.classList.add("invalid");
            }
        };
    </script>
</html>
