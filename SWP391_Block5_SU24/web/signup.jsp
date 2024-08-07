<%-- 
    Document   : login
    Created on : Aug 5, 2024, 11:28:46 AM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Footwear - Free Bootstrap 4 Template by Colorlib</title>
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
        <style>
            .idiv{
                align-items: center;
                display:flex;
                justify-content: flex-end;
                background-image: url(images/Banner.png);
                background-position: 50% 50%;
                background-size: contain;
                background-repeat: no-repeat;
                background-color:#88c8bc;
                height:80%;
                width:80%;
                background-size: 70%;
            }
            .idiv{
                animation-name: slide-up;
                animation-duration: 1s;
            }
            @keyframes slide-up {
                from {
                    margin-bottom: -50px;
                }
                to {
                    margin-bottom: 0px;
                }
            }
        </style>
    </head>
    <body>
        <div style="height: 1000px; width: 100%;">
            <div class="colorlib-nav" style="padding:50px;padding-left:200px; background-color:white; width:100%; height:12%; font-size:30px; align-items:center;box-shadow:#0000000f 0px 6px 6px 0px;color:#000c;display:flex;">
                <div class="ldiv" style="padding-right:7px" id="colorlib-logo"><a href="index.html">Footwear</a></div> Sign Up
            </div>
            <div style="background-color:#88c8bc; width:100%;height:85%;align-items: center;justify-content: center;display:flex">
                <div class ="idiv">
                    <div style="background-color:#fff;border-radius:4px;font-size:14px;min-width: 30%;margin-right:50px">
                        <div style="align-items: center; padding: 22px 30px 5px;;font-size:20px; color:black; display:flex">
                            <p style='padding-left:7.5%'>Sign Up<p>
                        </div>

                        <div style="padding: 0px 30px 30px">
                            <%
                            String error = request.getParameter("error");
                            if(!(error==null)){%>
                            <div style="align-items: center;color:red; display:flex">
                                <p style='padding-left:7.5%'><%= error%><p>
                            </div>
                            <%}%>
                            <form action="SignUpController" method="post" style='display: flex; flex-direction: column; align-items: center;'>
                                <% if ("true".equals(request.getAttribute("error_usernametaken"))) { %>
                                <p class="error">Username has already been taken!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_username"))) { %>
                                <p class="error">Username is required!</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="username" placeholder='Username' required value="${username != null ? username : ''}"><br>
                                <% if ("true".equals(request.getAttribute("error_password"))) { %>
                                <p class="error">Password must contain at least 1 digit, 1 uppercase character!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_password_short"))) { %>
                                <p class="error">Password must be at least 8 characters long!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_password_invalid"))) { %>
                                <p class="error">Invalid password!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_password_dupe"))) { %>
                                <p class="error">Password doesn't match</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="password" name="password" required placeholder='Password'><br>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="password" name="repassword" required placeholder='Repeat Password'><br>
                                <% if ("true".equals(request.getAttribute("error_phone_number"))) { %>
                                <p class="error">Phone number is required and must contain only digits!</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="pnum" required placeholder='Phone Number' value="${pnum != null ? pnum : ''}"><br>
                                <% if ("true".equals(request.getAttribute("error_email"))) { %>
                                <p class="error">Please enter a valid email address!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_emailtaken"))) { %>
                                <p class="error">Email already registered to another account!</p>
                                <% } %>
                              
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="email" required placeholder='Email' value="${email != null ? email : ''}"><br>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="address" required placeholder='Address' value="${address != null ? address : ''}"><br>
                                <button name="role" value="1" style='border:0px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">SIGN UP</button>
                            </form>
                            <div style="justify-content: space-between;display:flex; width:100%;align-items: center">
                                <a style='padding-left:7.5%'>Forget password</a> <a href="login-staff.jsp" style='padding-right:7.5%'>Employee Login</a></div>
                        </div>
                        <div style="justify-content:center; text-align: center; display:flex; padding: 22px 30px;">
                            Already have an account? &nbsp;<a href='login.jsp'>Log In</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>