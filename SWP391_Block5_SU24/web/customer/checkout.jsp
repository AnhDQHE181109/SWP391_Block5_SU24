<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import = "entity.*" %>
<%@page import = "java.util.*" %>

<!DOCTYPE HTML>
<html>
    <head>
        <title>Cart checkout</title>
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
    </head>
    <body>

        <% if (request.getHeader("referer") == null) { %>
        <script type="text/javascript">
            window.history.go(-1);
        </script>
        <%    return;
        } %>

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
                                    <li><a href="about.html">About</a></li>
                                    <li><a href="contact.html">Contact</a></li>
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
                            <p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Checkout</span></p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="colorlib-product">
                <div class="container">
                    <div class="row row-pb-lg">
                        <div class="col-sm-10 offset-md-1">
                            <div class="process-wrap">
                                <div class="process text-center active">
                                    <p><span>01</span></p>
                                    <h3>Shopping Cart</h3>
                                </div>
                                <div class="process text-center active">
                                    <p><span>02</span></p>
                                    <h3>Checkout</h3>
                                </div>
                                <div class="process text-center">
                                    <p><span>03</span></p>
                                    <h3>Order Complete</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-7">
                            <form action="CheckoutController" id="billingDetailsForm" method="post" class="colorlib-form">
                                <h2>Billing Details</h2>

                                <% CheckoutItem billingDetails = (CheckoutItem) request.getAttribute("billingDetails");
						   Double shippingFee = (Double) request.getAttribute("shippingFee"); %>
                                <div class="row">
                                    <!-- <div class="col-md-12">
                                       <div class="form-group">
                                             <label for="country">Select Country</label>
                                         <div class="form-field">
                                             <i class="icon icon-arrow-down3"></i>
                                             <select name="people" id="people" class="form-control">
                                                     <option value="#">Select country</option>
                                                     <option value="#">Alaska</option>
                                                     <option value="#">China</option>
                                                     <option value="#">Japan</option>
                                                     <option value="#">Korea</option>
                                                     <option value="#">Philippines</option>
                                             </select>
                                          </div>
                                       </div>
                                    </div> -->

                                    <!-- <div class="col-md-6">
                                            <div class="form-group">
                                                    <label for="fname">First Name</label>
                                                    <input type="text" id="fname" class="form-control" placeholder="Your firstname">
                                            </div>
                                    </div>
                                    <div class="col-md-6">
                                            <div class="form-group">
                                                    <label for="lname">Last Name</label>
                                                    <input type="text" id="lname" class="form-control" placeholder="Your lastname">
                                            </div>
                                    </div> -->

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="name">Name</label>
                                            <input type="text" name="name" id="name" class="form-control" placeholder="Name"
                                                   value="<%=billingDetails.getName() %>" style="color:black; font-weight: bold;" readonly>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="fname">Address</label>
                                            <input type="text" id="address" class="form-control" placeholder="Enter Your Address"
                                                   value="<%=billingDetails.getAddress() %>" style="color:black; font-weight: bold;" readonly>
                                        </div>
                                        <!-- <div class="form-group">
                                              <input type="text" id="address2" class="form-control" placeholder="Second Address">
                                        </div> -->
                                    </div>

                                    <!-- <div class="col-md-12">
                                                                     <div class="form-group">
                                                                             <label for="companyname">Town/City</label>
                                             <input type="text" id="towncity" class="form-control" placeholder="Town or City">
                                       </div>
                                    </div>
                                 
                                                             <div class="col-md-6">
                                                                     <div class="form-group">
                                                                             <label for="stateprovince">State/Province</label>
                                                                             <input type="text" id="fname" class="form-control" placeholder="State Province">
                                                                     </div>
                                                             </div>
                                                             <div class="col-md-6">
                                                                     <div class="form-group">
                                                                             <label for="lname">Zip/Postal Code</label>
                                                                             <input type="text" id="zippostalcode" class="form-control" placeholder="Zip / Postal">
                                                                     </div>
                                                             </div> -->

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email">E-mail Address</label>
                                            <input type="text" name="email" id="email" class="form-control" placeholder="E-mail address"
                                                   value="<%=billingDetails.getEmail() %>" style="color:black; font-weight: bold;" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="Phone">Phone Number</label>
                                            <input type="number" name="phoneNumber" id="phoneNumber" class="form-control" placeholder="Phone number"
                                                   value="<%=billingDetails.getPhoneNumber() %>" style="color:black; font-weight: bold;" readonly>
                                        </div>
                                    </div>

                                    <!-- <div class="col-md-12">
                                            <div class="form-group">
                                                    <div class="radio">
                                                      <label><input type="radio" name="optradio"> Create an Account? </label>
                                                      <label><input type="radio" name="optradio"> Ship to different address</label>
                                                    </div>
                                            </div>
                                    </div> -->

                                </div>

                            </form>

                            <div class="row">
                                <div class="col-md-4">
                                    <!-- <% //if (shippingFee == 15.0) { %>
                                            <p class="text-end"><a href="shoppingCart?shippingType=fastRadioBox" class="btn btn-primary">Return to cart</a></p>
                                    <% //} else if (shippingFee == 0.0) { %>
                                            <p class="text-end"><a href="shoppingCart?shippingType=ecoRadioBox" class="btn btn-primary">Return to cart</a></p>
                                    <% //} %> -->

                                    <p class="text-end"><a href="shoppingCart" class="btn btn-primary">Return to cart</a></p>

                                </div>

                                <div class="col-md-4">

                                </div>

                                <div class="col-md-4">
                                    <!-- <p class="text-end"><a href="#" class="btn btn-primary">Place an order</a></p> -->
                                    <p class="text-end"><button onclick="document.getElementById('billingDetailsForm').submit()" class="btn btn-primary">Place an order</button></p>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-5">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="cart-detail">
                                        <h2>Cart Total</h2>
                                        <ul>
                                            <li>
                                                <% 
                                                        List<ShoppingCartItem> cartItems = (List<ShoppingCartItem>) request.getAttribute("cartItems");
												
                                                %>

                                                <ul>
                                                    <% if (cartItems != null) { 
                                                            for (ShoppingCartItem cartItem : cartItems) {
                                                                    double finalPrice = cartItem.getPrice() - ((cartItem.getPrice() * cartItem.getDiscountAmount()) / 100); %>
                                                    <li><span style="width: 50px"><img width="50px" height="50px" class="product-img" src="${pageContext.request.contextPath}/<%=cartItem.getImageURL() %>"></span> <span style="width: calc(100% - 150px); padding-bottom: 14px; padding-top: 10px;"><%=cartItem.getQuantity() %> x <%=cartItem.getProductName() %> - <%=cartItem.getColor() %> - <%=cartItem.getSize() %></span> <span style="padding-bottom: 14px; padding-top: 10px;">$<%=finalPrice * cartItem.getQuantity() %></span></li>
                                                            <%  } 
												   } %>
                                                    <!-- <li><span>1 x Product Name</span> <span>$78.00</span></li> -->
                                                </ul>
                                            </li>
                                            <% double subTotal = 0.0;
                                                       for (ShoppingCartItem cartItem : cartItems) {
                                                                    subTotal += (cartItem.getPrice() - ((cartItem.getPrice() * cartItem.getDiscountAmount()) / 100)) * cartItem.getQuantity();
                                                       } %>
                                            <!-- <li><span>Subtotal</span> <span>$<%=subTotal %></span></li> -->


                                                                                <!-- <li><span>Shipping</span> <span>$<%=shippingFee %></span></li> -->
                                            <li><span>Order Total</span> <span>$<%=subTotal %></span></li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="w-100"></div>

                                <!-- <div class="col-md-12">
                                             <div class="cart-detail">
                                                     <h2>Payment Method</h2>
                                                     <div class="form-group">
                                                             <div class="col-md-12">
                                                                     <div class="radio">
                                                                        <label><input type="radio" name="optradio"> Direct Bank Tranfer</label>
                                                                     </div>
                                                             </div>
                                                     </div>
                                                     <div class="form-group">
                                                             <div class="col-md-12">
                                                                     <div class="radio">
                                                                        <label><input type="radio" name="optradio"> Check Payment</label>
                                                                     </div>
                                                             </div>
                                                     </div>
                                                     <div class="form-group">
                                                             <div class="col-md-12">
                                                                     <div class="radio">
                                                                        <label><input type="radio" name="optradio"> Paypal</label>
                                                                     </div>
                                                             </div>
                                                     </div>
                                                     <div class="form-group">
                                                             <div class="col-md-12">
                                                                     <div class="checkbox">
                                                                        <label><input type="checkbox" value=""> I have read and accept the terms and conditions</label>
                                                                     </div>
                                                             </div>
                                                     </div>
                                             </div>
                                     </div> -->
                            </div>

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

