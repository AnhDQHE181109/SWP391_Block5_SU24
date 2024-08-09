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
                width:80%
            }
            .idiv{
                animation-name: slide-right;
                animation-duration: 1s;
            }
            @keyframes slide-right {
                from {
                    margin-left: -50px;
                }
                to {
                    margin-left: 0px;
                }
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
        </style>
    </head>
    <body>
        <div style="height: 670px; width: 100%;">
            <div class="colorlib-nav" style="padding:50px;padding-left:200px; background-color:white; width:100%; height:12%; font-size:30px; align-items:center;box-shadow:#0000000f 0px 6px 6px 0px;color:#000c;display:flex;">
                <div class="ldiv" style="padding-right:7px" id="colorlib-logo"><a href="index.html">Footwear</a></div> Recover
            </div>
            <div style="background-color:#88c8bc; width:100%;height:85%;align-items: center;justify-content: center;display:flex">
                <div class ="idiv">
                    <div style="background-color:#fff;border-radius:4px;font-size:14px;min-width: 30%;margin-right:50px">
                        <div style="align-items: center; padding: 22px 30px 5px;;font-size:20px; color:black; display:flex">
                            <p style='padding-left:7.5%'>Recover<p>
                        </div>

                        <div style="padding: 0px 30px 30px">
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
                            <form action="AuthRecoverController" method="post" style='display: flex; flex-direction: column; align-items: center;'>                           
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="type" name="npass" placeholder='New password'><br>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="type" name="rnpass" placeholder='Repeat new password'><br>
                                <button style='border:0px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">CHANGE PASSWORD</button>
                            </form>
                            <div style="justify-content: space-between;display:flex; width:100%;align-items: center">
                            </div>
                            <div style="justify-content:center; text-align: center; display:flex; padding: 22px 30px;">
                                New to Footwear? &nbsp;<a href='signup.jsp'>Sign Up</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>