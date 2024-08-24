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
        .noti{
            min-height: 50px;
            border-radius: 2px;
            border: 2px solid gray;
        }
        .notir{
            min-height: 50px;
            background-color:gray;
            border-radius: 2px;
            border: 2px solid gray;
        }
        #emessage{
            display:none;
            background: #f1f1f1;
            color: #000;
            position: relative;
            padding: 0px 10px 10px 10px;
            margin-bottom: 5px;
        }
        #emessage p {
            padding: 0px 35px;
            font-size: 14px;
        }
        .evalid {
            color: green;
        }

        .evalid:before {
            position: relative;
            left: -35px;
            content: "✔";
        }
        .einvalid {
            color: red;
        }

        .einvalid:before {
            position: relative;
            left: -35px;
            content: "✖";
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
    </style>
    <body>
        <%        
        boolean showErrorPass = "true".equals(request.getParameter("error_auth_pass"));     
        %>
        <div id="auth_pass" class="<%= showErrorPass ? "modal_error" : "modal" %>">
            <div class="content">                    
                <h3 style="color: black; text-align: center">
                    To protect your account security, please verify your <br>identity by entering your password.
                </h3>
                <% if ("true".equals(request.getAttribute("error_auth_pass"))) { %>
                <p style="color:red;margin-left:7%;" class="error">Incorrect password!</p>
                <% } %>
                <form action="${pageContext.request.contextPath}/ChangePassController" method="post" style='display: flex; flex-direction: column; align-items: center;'>                         
                    <input type="hidden" name="curuname" value="<%= account.getUsername()%>">
                    <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="password" name="password" placeholder='Password'><br>                   
                    <button style='border:0px;margin-bottom:20px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">Proceed</button>
                </form>
                <a href="${pageContext.request.contextPath}/customer/customer_profile.jsp" style="
                   position: absolute;
                   top: 10px;
                   right: 10px;
                   color: #fe0606;
                   font-size: 30px;
                   text-decoration: none;
                   ">&times;</a>
            </div>
        </div>
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
                            <tr><td></td><td style="padding-left:7px; padding-top:3px;padding-bottom:10px"><a href='#auth_pass'>Change Password</a></td></tr>
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
                            <form action='ChangeEmailController' action='post'>
                                <input type='hidden' name='curid' value='<%= account.getAccountID()%>'>
                                <table>
                                    <tr><th></th><th></th><th></th></tr>
                                    <tr><td></td><td>
                                            <% if ("true".equals(request.getAttribute("error_email"))) { %>
                                            <p style="color:red" class="error">Please enter a valid email address!</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_emailtaken"))) { %>
                                            <p style="color:red" class="error">Email already registered to another account!</p>
                                            <% } %>
                                        </td></tr>
                                    <tr><td style="width:150px; text-align: right;padding-top: 25px; padding-right: 3%;">New Email</td><td style='padding-top: 25px'><input required class="protbox" id="em" type="text" name='email'></td></tr>
                                    <tr><td></td><td><div id="emessage">          
                                                <b>Email must:</b>
                                                <p id="estructure" class="einvalid">Follow the email structure: <ul><li>local@domainname.topleveldomain</li><li>domainname part of email must contain at least 2 characters</li><li>topleveldomain part of email must contain at least 2 characters</li></ul></p>
                                                <p id="enumber" class="einvalid">Not <b>start with a digit</b></p>
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
        function openSbox(t) {
            document.getElementById("ts").value = t;
            window.location = "#popup-box";
        }
        var eInput = document.getElementById("em");
        var estructure = document.getElementById("estructure");
        var enumber = document.getElementById("enumber");
        eInput.onfocus = function () {
            document.getElementById("emessage").style.display = "block";
        }
        eInput.onblur = function () {
            document.getElementById("emessage").style.display = "none";
        };
        const InvalidEstart = /^\d/;
        const EMAIL_REGEX = /^(?=.{1,64}@)[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$/;
        eInput.onkeyup = function () {
            if (!InvalidEstart.test(eInput.value)) {
                enumber.classList.remove("einvalid");
                enumber.classList.add("evalid");
            } else {
                enumber.classList.remove("evalid");
                enumber.classList.add("einvalid");
            }
            if (EMAIL_REGEX.test(eInput.value)) {
                estructure.classList.remove("einvalid");
                estructure.classList.add("evalid");
            } else {
                estructure.classList.remove("evalid");
                estructure.classList.add("einvalid");
            }
            if (eInput.value === "") {
                enumber.classList.remove("evalid");
                enumber.classList.add("einvalid");
                estructure.classList.remove("evalid");
                estructure.classList.add("einvalid");
            }
        };
    </script>
</html>
