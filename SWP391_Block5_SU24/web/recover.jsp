<%-- 
    Document   : login
    Created on : Aug 5, 2024, 11:28:46 AM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%if(session.getAttribute("auth")==null||!session.getAttribute("auth").equals("true")){response.sendRedirect("login.jsp?error=You do not have permission to access the page!");}%>
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
            #message2 {
                display:none;
                background: #f1f1f1;
                color: #000;
                position: relative;
                padding: 0px 10px 10px 10px;
                margin-bottom: 5px;
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
            #message2 p {
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
        </style>
    </head>
    <body>
        <div style="height: 670px; width: 100%;">
            <div class="colorlib-nav" style="padding:50px;padding-left:200px; background-color:white; width:100%; height:12%; font-size:30px; align-items:center;box-shadow:#0000000f 0px 6px 6px 0px;color:#000c;display:flex;">
                <div class="ldiv" style="padding-right:7px" id="colorlib-logo"><a href="index.jsp">Footwear</a></div> Recover
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
                            <% if ("true".equals(request.getAttribute("error_password_match"))) { %>
                            <p style="color:red" class="error">Password doesn't match!</p>
                            <% } %>
                            <% if ("true".equals(request.getAttribute("error_password_dupe"))) { %>
                            <p style="color:red" class="error">New password can't be the same as old password!</p>
                            <% } %>
                            <form action="AuthRecoverController" method="post" style='display: flex; flex-direction: column; align-items: center;'>                           
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' id="psw" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="npass" placeholder='New password'><br>
                                <div id="message">          
                                    <b>Password must contain: </b>
                                    <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                                    <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                                    <p id="number" class="invalid">A <b>number</b></p>
                                    <p id="length" class="invalid">Minimum <b>8 characters</b></p>
                                </div>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' id="psw2" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="rnpass" placeholder='Repeat new password'><br>
                                <div id="message2">          
                                    <b>Password must contain: </b>
                                    <p id="letter2" class="invalid2">A <b>lowercase</b> letter</p>
                                    <p id="capital2" class="invalid2">A <b>capital (uppercase)</b> letter</p>
                                    <p id="number2" class="invalid2">A <b>number</b></p>
                                    <p id="length2" class="invalid2">Minimum <b>8 characters</b></p>
                                </div>
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
        }

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
        };

        var myInput2 = document.getElementById("psw2");
        var letter2 = document.getElementById("letter2");
        var capital2 = document.getElementById("capital2");
        var number2 = document.getElementById("number2");
        var length2 = document.getElementById("length2");

// When the user clicks on the password field, show the message box
        myInput2.onfocus = function () {
            document.getElementById("message2").style.display = "block";
        }

// When the user clicks outside of the password field, hide the message box
        myInput2.onblur = function () {
            document.getElementById("message2").style.display = "none";
        }

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
        };
    </script>
</html>