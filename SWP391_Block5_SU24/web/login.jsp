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
        <style>
            .idiv{
                align-items: center;
                display:flex;
                justify-content: flex-end;
                background-image: url(${pageContext.request.contextPath}/images/Banner.png);
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
        <%
        String errorRecover = request.getParameter("error_recover");
        boolean showErrorModal = "true".equals(errorRecover);
        long remainingTime = 100*6*60*1000;
        try{
        long endTime = (long) session.getAttribute("endTime");
        long currentTime = System.currentTimeMillis();
        remainingTime = endTime - currentTime;

        if (remainingTime <= 0) {
        // Time's up, redirect back to the servlet
        response.sendRedirect("login.jsp");
        }
            }catch(Exception e){}
        %>
        <div id="popup-box" class="<%= showErrorModal ? "modal_error" : "modal" %>">
            <div class="content">
                <h1 style="color: black">
                    Recover password
                </h1>
                <% if ("true".equals(request.getAttribute("error_recover"))) { %>
                <p style="color:red" class="error">No account with this email found!</p>
                <% } %>
                <% if ("true".equals(request.getAttribute("error_recover_role"))) { %>
                <p style="color:red" class="error">You do not have permission to use this function!</p>
                <% } %>
                <form action="RecoverController" method="post" style='display: flex; flex-direction: column; align-items: center;'>                           
                    <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="recover-email" placeholder='Recover Email'><br>
                    <button name="role" value="1" style='border:0px;margin-bottom:20px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">Next</button>
                </form>
                <a href="login.jsp?error_recover=false" style="
                   position: absolute;
                   top: 10px;
                   right: 10px;
                   color: #fe0606;
                   font-size: 30px;
                   text-decoration: none;
                   ">&times;</a>
            </div>
        </div>

        <% if (request.getAttribute("recode")!=null){%>
        <div class="modal_error">
            <div class="content">
                <h1 style="color: black">
                    Enter security code
                </h1>
                <% if ("true".equals(request.getAttribute("error_recover_code"))) { %>
                <p style="color:red" class="error">Incorrect recovery code!</p>
                <% } %>
                <form action="RecoverController" method="get" id="rform" class="rform" style="font-size:30px; justify-content: center; text-align: center">
                    <div class="digits">
                        <input type="text" maxlength="1" name="i1" style="width:44px; height:48px; margin:12px">
                        <input type="text" maxlength="1" name="i2" style="width:44px; height:48px; margin:12px">
                        <input type="text" maxlength="1" name="i3" style="width:44px; height:48px; margin:12px">
                        <input type="text" maxlength="1" name="i4" style="width:44px; height:48px; margin:12px 12px 30px 12px">                     
                    </div>
                    <input type="hidden" id="extraData" name="extraData">
                </form>
                <p id="timer"></p>
                <a href="login.jsp" style="
                   position: absolute;
                   top: 10px;
                   right: 10px;
                   color: #fe0606;
                   font-size: 30px;
                   text-decoration: none;
                   ">&times;</a>
            </div>
        </div>
        <%}%>
        <div style="height: 670px; width: 100%;">
            <div class="colorlib-nav" style="padding:50px;padding-left:200px; background-color:white; width:100%; height:12%; font-size:30px; align-items:center;box-shadow:#0000000f 0px 6px 6px 0px;color:#000c;display:flex;">
                <div class="ldiv" style="padding-right:7px" id="colorlib-logo"><a href="index.jsp">Footwear</a></div> Log In
            </div>
            <div style="background-color:#88c8bc; width:100%;height:85%;align-items: center;justify-content: center;display:flex">
                <div class ="idiv">
                    <div style="background-color:#fff;border-radius:4px;font-size:14px;min-width: 30%;margin-right:50px">
                        <div style="align-items: center; padding: 22px 30px 5px;;font-size:20px; color:black; display:flex">
                            <p style='padding-left:7.5%'>Log In<p>
                        </div>

                        <div style="padding: 0px 30px 30px">
                            <% if ("true".equals(request.getAttribute("signup_success"))) { %>
                            <p style="color:#4ac421; padding-left:7.5%" class="error">Sign up successful!</p>
                            <% } %>
                            <%
                            String error = request.getParameter("error");
                            if(!(error==null)){%>
                            <div style="align-items: center;color:red; display:flex">
                                <p style='padding-left:7.5%'><%= error%><p>
                            </div>
                            <%}%>
                            <form action="LoginController" method="post" style='display: flex; flex-direction: column; align-items: center;'>                           
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="text" name="username" placeholder='Username' value="${username != null ? username : ''}"><br>
                                <input style='margin:0px 12px 0px 12px; height: 40px; width:85%;' type="password" name="password" placeholder='Password'><br>
                                <button name="role" value="1" style='border:0px; text-align:center; background-color: #88c8bc;border-radius: 2px;display:flex;color:white;justify-content:center; width: 85%;' type="submit">LOG IN</button>
                            </form>
                            <div style="justify-content: space-between;display:flex; width:100%;align-items: center">
                                <a href="#popup-box" style='padding-left:7.5%'>Forget password</a>
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
        const inputs = document.querySelectorAll('.digits input');

        inputs.forEach((input, index) => {
            input.dataset.index = index;
            input.addEventListener("paste", handleOtpPaste);
            input.addEventListener("keyup", handleOtp);
        });

        function handleOtpPaste(e) {
            const data = e.clipboardData.getData("text");
            const value = data.split("");
            if (value.length === inputs.length) {
                inputs.forEach((input, index) => (input.value = value[index]));
                submit();
            }
        }

        function handleOtp(e) {
            const input = e.target;
            let value = input.value;
            input.value = ""; // Clear the input first
            input.value = value ? value[0] : ""; // Set the first character only
            let fieldIndex = input.dataset.index;

            if (value.length > 0 && fieldIndex < inputs.length - 1) {
                input.nextElementSibling.focus();
            }

            if (e.key === "Backspace" && fieldIndex > 0) {
                input.previousElementSibling.focus();
            }

            if (Array.from(inputs).every(input => input.value.length === 1)) {
                submit();
            }
        }

        function submit() {
            let otp = "";
            inputs.forEach(input => {
                otp += input.value;
            });
            document.getElementById('extraData').value = otp;
            document.getElementById('rform').submit();
        }

        let remainingTime = <%= remainingTime %>;

        function startTimer() {
            let timer = setInterval(function () {
                if (remainingTime <= 0) {
                    clearInterval(timer);
                    document.getElementById("timer").innerHTML = "Code expired, please try again. ";
                    const inputtemp = document.querySelectorAll('.digits input[type="text"]');

                    inputtemp.forEach(input => {
                        input.readOnly = true;
                        input.style.backgroundColor = "#ededed";
                        input.style.color = "white";
                        input.style.borderColor = "darkgray";
                    });
                } else {
                    remainingTime -= 1000;
                    let minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
                    let seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
                    document.getElementById("timer").innerHTML = "Code is available for: " + minutes + "m " + seconds + "s ";
                }
            }, 1000);
        }

        window.onload = startTimer;
    </script>
</html>