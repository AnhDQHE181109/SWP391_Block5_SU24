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

            #umessage{
                display:none;
                background: #f1f1f1;
                color: #000;
                position: relative;
                padding: 0px 10px 10px 10px;
                margin-bottom: 5px;
            }
            #umessage p {
                padding: 0px 35px;
                font-size: 14px;
            }
            .uvalid {
                color: green;
            }

            .uvalid:before {
                position: relative;
                left: -35px;
                content: "✔";
            }
            .uinvalid {
                color: red;
            }

            .uinvalid:before {
                position: relative;
                left: -35px;
                content: "✖";
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
            
            
            #Nmessage{
                display:none;
                background: #f1f1f1;
                color: #000;
                position: relative;
                padding: 0px 10px 10px 10px;
                margin-bottom: 5px;
            }
            #Nmessage p {
                padding: 0px 35px;
                font-size: 14px;
            }
            .Nvalid {
                color: green;
            }

            .Nvalid:before {
                position: relative;
                left: -35px;
                content: "✔";
            }
            .Ninvalid {
                color: red;
            }

            .Ninvalid:before {
                position: relative;
                left: -35px;
                content: "✖";
            }
        </style>
    </head>
    <body>
        <div style="height: 1050px; width: 100%;">
            <div class="colorlib-nav" style="padding:50px;padding-left:200px; background-color:white; width:100%; height:12%; font-size:30px; align-items:center;box-shadow:#0000000f 0px 6px 6px 0px;color:#000c;display:flex;">
                <div class="ldiv" style="padding-right:7px" id="colorlib-logo"><a href="index.jsp">Footwear</a></div> Sign Up
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
                                <% if ("true".equals(request.getAttribute("error_name_invalid"))) { %>
                                <p style="color:red" class="error">Invalid Name!</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" id="Nname" name="name" placeholder='Name' required value="${name != null ? name : ''}"><br>    
                                <div id="Nmessage">          
                                    <b>Name must not: </b>
                                    <p id="Nletter" class="Ninvalid">Not contain any <b>special characters</b> or <b>numbers</b></p> 
                                </div>
                                <% if ("true".equals(request.getAttribute("error_username_invalid"))) { %>
                                <p style="color:red" class="error">Invalid username!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_usernametaken"))) { %>
                                <p style="color:red" class="error">Username has already been taken!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_username"))) { %>
                                <p style="color:red" class="error">Username is required!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_username_length"))) { %>
                                <p style="color:red" class="error">Username must contain a maximum of 20 characters!</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" id="usname" name="username" placeholder='Username' required value="${username != null ? username : ''}"><br>
                                <div id="umessage">          
                                    <b>Username must not: </b>
                                    <p id="uletter" class="uinvalid">Not contain any of the following special characters: <br><b>/, \, <, >, &, $, #, %, ", (, ), !, ?, ', |</b>as well as <b></b> whitespace <br> characters</p> 
                                    <p id="ulength" class="uinvalid">Contain <b>maximum 20 characters</b></p>
                                </div>
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
                                
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' id="psw" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="password" required placeholder='Password'><br>
                                <div id="message">          
                                    <b>Password must contain: </b>
                                    <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                                    <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                                    <p id="number" class="invalid">A <b>number</b></p>
                                    <p id="length" class="invalid">Minimum <b>8 characters</b></p>
                                </div>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' id="psw2" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="repassword" required placeholder='Repeat Password'><br>
                                <div id="message2">          
                                    <b>Password must contain: </b>
                                    <p id="letter2" class="invalid2">A <b>lowercase</b> letter</p>
                                    <p id="capital2" class="invalid2">A <b>capital (uppercase)</b> letter</p>
                                    <p id="number2" class="invalid2">A <b>number</b></p>
                                    <p id="length2" class="invalid2">Minimum <b>8 characters</b></p>
                                </div>
                                <% if ("true".equals(request.getAttribute("error_phone_number"))) { %>
                                <p style="color:red" class="error">Phone number is required and must contain only digits!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_phone_number_dupe"))) { %>
                                <p style="color:red" class="error">Phone number already registered to another account</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_phone_number_length"))) { %>
                                <p style="color:red" class="error">Invalid phone number!</p>
                                <% } %>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="number" id="pnum" name="pnum" required placeholder='Phone Number' value="${pnum != null ? pnum : ''}"><br>
                                <div id="pmessage">          
                                    <b>Phone number must contain: </b>
                                    <p id="pletter" class="pinvalid">Only <b>digits</b></p>
                                    <p id="plength" class="pinvalid">Between <b>9 characters</b> and <b> 11 characters</b></p>
                                    <p id="pnumber" class="pinvalid">A prefix that match <b>'03', '05', '07', '08', or '09'</b></p>
                                </div>
                                <% if ("true".equals(request.getAttribute("error_email"))) { %>
                                <p style="color:red" class="error">Please enter a valid email address!</p>
                                <% } %>
                                <% if ("true".equals(request.getAttribute("error_emailtaken"))) { %>
                                <p style="color:red" class="error">Email already registered to another account!</p>
                                <% } %>

                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="email" id='em' required placeholder='Email' value="${email != null ? email : ''}"><br>
                                <div id="emessage">          
                                    <b>Email must:</b>
                                    <p id="estructure" class="einvalid">Follow the email structure: <ul><li>local@domainname.topleveldomain</li><li>domainname part of email must contain at least 2 characters</li><li>topleveldomain part of email must contain at least 2 characters</li></ul></p>
                                    <p id="enumber" class="einvalid">Not <b>start with a digit</b></p>

                                </div>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="address" required placeholder='Address' value="${address != null ? address : ''}"><br>
                                <button name="role" value="1" style='border:0px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">SIGN UP</button>
                            </form>
                            <div style="justify-content: space-between;display:flex; width:100%;align-items: center">
                                <a style='padding-left:7.5%'></a>
                        </div>
                        <div style="justify-content:center; text-align: center; display:flex; padding: 22px 30px;">
                            Already have an account? &nbsp;<a href='login.jsp'>Log In</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
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

        var unameInput = document.getElementById("usname");
        var uletter = document.getElementById("uletter");
        var ulength = document.getElementById("ulength");
        unameInput.onfocus = function () {
            document.getElementById("umessage").style.display = "block";
        };
        unameInput.onblur = function () {
            document.getElementById("umessage").style.display = "none";
        };
        const invalidChars = /[\/\\<>&$#%"()!?'| \t\n\r]/;
        unameInput.onkeyup = function () {
            if (!invalidChars.test(unameInput.value)) {
                uletter.classList.remove("uinvalid");
                uletter.classList.add("uvalid");
            } else {
                uletter.classList.remove("uvalid");
                uletter.classList.add("uinvalid");
            }

            if (unameInput.value.length <= 20) {
                ulength.classList.remove("uinvalid");
                ulength.classList.add("uvalid");
            } else {
                ulength.classList.remove("uvalid");
                ulength.classList.add("uinvalid");
            }
            if (unameInput.value === "") {
                uletter.classList.remove("uvalid");
                uletter.classList.add("uinvalid");
                ulength.classList.remove("uvalid");
                ulength.classList.add("uinvalid");
            }
        };

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
        
        var NInput = document.getElementById("Nname");
        var Nletter = document.getElementById("Nletter");

        NInput.onfocus = function () {
            document.getElementById("Nmessage").style.display = "block";
        };
        NInput.onblur = function () {
            document.getElementById("Nmessage").style.display = "none";
        };
        const NameInvalid =  /^[a-zA-Z\s]+$/;
        NInput.onkeyup = function () {
            if (NameInvalid.test(NInput.value)) {
                Nletter.classList.remove("Ninvalid");
                Nletter.classList.add("Nvalid");
            } else {
                Nletter.classList.remove("Nvalid");
                Nletter.classList.add("Ninvalid");
            }  
            if (NInput.value === "") {
                Nletter.classList.remove("Nvalid");
                Nletter.classList.add("Ninvalid");
            }
        };
    </script>
</html>