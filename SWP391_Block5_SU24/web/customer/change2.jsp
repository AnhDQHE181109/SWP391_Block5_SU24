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
    if(!"true".equals(request.getAttribute("autho"))){
     response.sendRedirect(request.getContextPath() + "/customer/customer_profile.jsp?auth_error=true");
        return;
    }
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
        #pmessage{
            display:none;
            background: #f1f1f1;
            color: #000;
            position: relative;
            padding: 0px 10px 10px 10px;
            margin-bottom: 5px;
        }
        #pmessage p {
            padding: 0px 35px;
            font-size: 14px;
        }
        .pvalid {
            color: green;
        }

        .pvalid:before {
            position: relative;
            left: -35px;
            content: "✔";
        }
        .pinvalid {
            color: red;
        }

        .pinvalid:before {
            position: relative;
            left: -35px;
            content: "✖";
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

                                    <% if (session.getAttribute("account") != null) { %>
                                    <li class="cart dropdown">
                                        <a href="#" class="dropdown-toggle" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fa-regular fa-user"></i> <%= ((Account) session.getAttribute("account")).getUsername() %>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                            <a class="dropdown-item" href="customer/customer_profile.jsp">Profile</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutController">Logout</a>
                                        </div>
                                    </li><li class="cart"><a href="customer/wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>
                                        <%
                                        int accountID = 0;
                                        
                                        if (account != null) {
                                            accountID = account.getAccountID();
                                        }
                                        int cartItemsCount = pDAO.getCartItemsCount(accountID);
                                        %>
                                    <li class="cart"><a href="${pageContext.request.contextPath}/shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
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
                            <tr><td></td><td style="padding-left:7px; padding-top:6px;color:red;"><a style="color:red" href="${pageContext.request.contextPath}/customer/customer_profile.jsp">Profile</a></td></tr>
                            <tr><td></td><td style="padding-left:7px; padding-top:3px;padding-bottom:10px"><a href='#auth_pass'>Change Password</a></td></tr>
                            <tr style="color:black"><td><i style="padding-right:2px" class="fa-regular fa-bell"></i></td><td><a href='${pageContext.request.contextPath}/LoadNotificationController'>Notification</a></td></tr>
                            <tr style="color:black">
                                <td><i style="padding-right:2px" class="fa-regular fa-list-alt"></i></td>
                                <td><a href="customer/order_list.jsp" style="text-decoration: none; color: black;">My Orders</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="main-bar">
                    <div class="top-main-bar"><span style="font-size:18px;font-weight: 500">My Profile</span><br>Manage and protect your account</div>
                    <div class="body-main-bar">
                        <div style="width:80%;height:80%; margin-left:50px;margin-top:30px;">
                            <form action='ChangePhoneNumberController' action='post'>
                                <input type='hidden' name='curid' value='<%= account.getAccountID()%>'>
                                <table>
                                    <tr><th></th><th></th><th></th></tr>
                                    <tr><td></td><td>
                                            <% if ("true".equals(request.getAttribute("error_phone_number"))) { %>
                                            <p style="color:red" class="error">Phone number is required and must contain only digits!</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_phone_number_dupe"))) { %>
                                            <p style="color:red" class="error">Phone number already registered to another account</p>
                                            <% } %>
                                            <% if ("true".equals(request.getAttribute("error_phone_number_length"))) { %>
                                            <p style="color:red" class="error">Invalid phone number!</p>
                                            <% } %>
                                        </td></tr>
                                    <tr><td style="width:150px; text-align: right;padding-top: 25px; padding-right: 3%;">New Phone Number</td><td style='padding-top: 25px'><input required class="protbox" id="pnum" type="text" name='pnum' value="${pn != null ? pn : ''}"></td></tr>
                                    <tr><td></td><td>
                                            <div id="pmessage">          
                                                <b>Phone number must contain: </b>
                                                <p id="pletter" class="pinvalid">Only <b>digits</b></p>
                                                <p id="plength" class="pinvalid">Between <b>9 characters</b> and <b> 11 characters</b></p>
                                                <p id="pnumber" class="pinvalid">A prefix that match <b>'03', '05', '07', '08', or '09'</b></p>
                                            </div> 
                                        </td>
                                    </tr>
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
        var pInput = document.getElementById("pnum");
        var pletter = document.getElementById("pletter");
        var plength = document.getElementById("plength");
        var pnumber = document.getElementById("pnumber");
        pInput.onfocus = function () {
            document.getElementById("pmessage").style.display = "block";
        };
        pInput.onblur = function () {
            document.getElementById("pmessage").style.display = "none";
        };
        const Validpnum = /[^0-9]/;
        pInput.onkeyup = function () {
            if (!Validpnum.test(pInput.value)) {
                pletter.classList.remove("pinvalid");
                pletter.classList.add("pvalid");
            } else {
                pletter.classList.remove("pvalid");
                pletter.classList.add("pinvalid");
            }

            if (!(pInput.value.length < 9 || pInput.value.length > 11)) {
                plength.classList.remove("pinvalid");
                plength.classList.add("pvalid");
            } else {
                plength.classList.remove("pvalid");
                plength.classList.add("pinvalid");
            }
            const phonePattern = /^(03|05|07|08|09)/;
            if (phonePattern.test(pInput.value)) {
                pnumber.classList.remove("pinvalid");
                pnumber.classList.add("pvalid");
            } else {
                pnumber.classList.remove("pvalid");
                pnumber.classList.add("pinvalid");
            }
            if (pInput.value === "") {
                pletter.classList.remove("pvalid");
                pletter.classList.add("pinvalid");
                plength.classList.remove("pvalid");
                plength.classList.add("pinvalid");
                pnumber.classList.remove("pvalid");
                pnumber.classList.add("pinvalid");
            }
        };
        document.addEventListener('click', function (event) {
            var isClickInside = document.getElementById('userDropdown').contains(event.target);

            if (!isClickInside) {
                // Close the dropdown
                document.querySelector('.cart.dropdown .dropdown-menu').style.display = 'none';
            }
        });
    </script>
</html>
