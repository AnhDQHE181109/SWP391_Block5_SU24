<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import = "entity.*" %>
<%@page import = "java.util.*" %>

<!DOCTYPE HTML>
<html>
    <head>
        <title>Shopping cart</title>
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
                                <!-- <form action="#" class="search-wrap">
                                   <div class="form-group">
                                      <input type="search" class="form-control search" placeholder="Search">
                                      <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
                                   </div>
                                </form> -->
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li><a href="index.jsp">Home</a></li>
                                    <!-- <li class="has-dropdown active">
                                            <a href="men.html">Men</a>
                                            <ul class="dropdown">
                                                    <li><a href="product-detail.html">Product Detail</a></li>
                                                    <li><a href="cart.html">Shopping Cart</a></li>
                                                    <li><a href="checkout.html">Checkout</a></li>
                                                    <li><a href="order-complete.html">Order Complete</a></li>
                                                    <li><a href="add-to-wishlist.html">Wishlist</a></li>
                                            </ul>
                                    </li> -->
                                    <li class="active"><a href="products.jsp">Products</a></li>
                                    <!-- <li><a href="women.html">Women</a></li> -->
                                    <li><a href="about.html">About</a></li>
                                    <li><a href="contact.html">Contact</a></li>
                                        <%
                                                Integer cartItemsCount = (Integer) request.getAttribute("cartItemsCount");
                                        %>
                                    <li class="cart"><a href="shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>
                                    <li class="cart"><a href="customer/wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>
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
                            <p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Shopping Cart</span></p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="colorlib-product">
                <div class="container">
                    <div class="row row-pb-lg">
                        <div class="col-md-10 offset-md-1">
                            <div class="process-wrap">
                                <div class="process text-center active">
                                    <p><span>01</span></p>
                                    <h3>Shopping Cart</h3>
                                </div>
                                <div class="process text-center">
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
                    <div class="row row-pb-lg">
                        <div class="col-md-12">
                            <% 
                                    List<ShoppingCartItem> cartItems = (List<ShoppingCartItem>) request.getAttribute("cartItems");
							
                            %>
                            <% if (cartItems != null) { 
                                if (!cartItems.isEmpty()) { %>

                            <div class="product-name d-flex">
                                <div class="one-forth text-left px-4">
                                    <span>Product Details</span>
                                </div>
                                <div class="one-eight text-center">
                                    <span>Color</span>
                                </div>
                                <div class="one-eight text-center">
                                    <span>Size</span>
                                </div>
                                <div class="one-eight text-center">
                                    <span>Price</span>
                                </div>
                                <div class="one-eight text-center">
                                    <span>Quantity</span>
                                </div>
                                <div class="one-eight text-center">
                                    <span>Total</span>
                                </div>
                                <div class="one-eight text-center px-4">
                                    <span>Remove</span>
                                </div>
                            </div>

                            
							<% for (ShoppingCartItem cartItem : cartItems) { %>
                            <div class="product-cart d-flex">

                                <div class="one-forth">
                                        <!-- <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/<%=cartItem.getImageURL() %>);">
                                                <a href="ProductDetailsController?productID=<%=cartItem.getProductID() %>"></a>
                                        </div> -->
                                    <a class="product-img" href="ProductDetailsController?productID=<%=cartItem.getProductID() %>&selectedColor=<%=cartItem.getColor() %>&selectedSize=<%=cartItem.getSize() %>">
                                        <img class="product-img" src="${pageContext.request.contextPath}/<%=cartItem.getImageURL() %>"></a>

                                    <div class="display-tc">
                                        <h3><a href="ProductDetailsController?productID=<%=cartItem.getProductID() %>&selectedColor=<%=cartItem.getColor() %>&selectedSize=<%=cartItem.getSize() %>"><%=cartItem.getProductName() %></a></h3>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="color"><%=cartItem.getColor() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="size"><%=cartItem.getSize() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <% double discountedPriced = cartItem.getPrice() - ((cartItem.getPrice() * cartItem.getDiscountAmount()) / 100); %>
                                        <span class="price">$<%=discountedPriced %></span>

                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>
                                            <button type="button" id="decrement_<%=cartItem.getStockID() %>" class="items-count decrement_<%=cartItem.getProductName() %>" onclick="decrementQuantity('decrement_<%=cartItem.getStockID() %>', 'quantity_<%=cartItem.getStockID() %>')" style="cursor:pointer;" data-type="minus" data-field="">
                                                <i class="icon-minus2"></i>
                                            </button>
                                        </span>

                                        <!-- <span>
                                                <input type="text" id="quantity" name="quantity" size="2" class="form-control input-number text-center" value="1" min="1" max="100">
                                        </span> -->

                                        <span id="quantity_<%=cartItem.getStockID() %>"><%=cartItem.getQuantity() %></span>

                                        <span>
                                            <button type="button" id="increment_<%=cartItem.getStockID() %>" class="items-count increment_<%=cartItem.getProductName() %>" onclick="incrementQuantity('increment_<%=cartItem.getStockID() %>', 'quantity_<%=cartItem.getStockID() %>')" style="cursor:pointer;" data-type="plus" data-field="">
                                                <i class="icon-plus2"></i>
                                            </button>
                                        </span>

                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">$<%=discountedPriced * cartItem.getQuantity() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <a href="#" onclick="openModal('confirmRemoval_<%=cartItem.getStockID() %>')" class="closed"></a>

                                        <div id="confirmRemoval_<%=cartItem.getStockID() %>" class="modal fade" tabindex="-1" role="dialog" style="display: none;">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Removing product from your shopping cart</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <img class="product-img" src="${pageContext.request.contextPath}/<%=cartItem.getImageURL() %>"></a>
                                                        <h2>Are you sure you want to remove <strong><%=cartItem.getProductName() %></strong> ?</h2>
                                                        <p>Size: <strong><%=cartItem.getSize() %></strong> | Color: <strong><%=cartItem.getColor() %></strong></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-success" onclick="location.href = 'shoppingCart?removedProduct=<%=cartItem.getStockID() %>';">Yes</button>
                                                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                            <% } %>

                            <!-- <div class="product-cart d-flex">
                                    <div class="one-forth">
                                            <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/images/item-7.jpg);">
                                            </div>
                                            <div class="display-tc">
                                                    <h3>Product Name</h3>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <span class="price">$68.00</span>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <form action="#">
                                                            <input type="text" name="quantity" class="form-control input-number text-center" value="1" min="1" max="100">
                                                    </form>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <span class="price">$120.00</span>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <a href="#" class="closed"></a>
                                            </div>
                                    </div>
                            </div>

                            <div class="product-cart d-flex">
                                    <div class="one-forth">
                                            <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/images/item-8.jpg);">
                                            </div>
                                            <div class="display-tc">
                                                    <h3>Product Name</h3>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <span class="price">$68.00</span>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <input type="text" id="quantity" name="quantity" class="form-control input-number text-center" value="1" min="1" max="100">
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <span class="price">$120.00</span>
                                            </div>
                                    </div>
                                    <div class="one-eight text-center">
                                            <div class="display-tc">
                                                    <a href="#" class="closed"></a>
                                            </div>
                                    </div>
                            </div> -->
                            
                        </div>
                    </div>

                    <div class="row row-pb-lg">
                        <div class="col-md-12">
                            <div class="total-wrap">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <!-- <form action="#">
                                                <div class="row form-group" style="background-color: rgb(185, 185, 185);">
                                                <div class="col-sm-9">
                                                        <input type="text" name="quantity" class="form-control input-number" placeholder="Your Coupon Number...">
                                                </div>
                                                <div class="col-sm-3">
                                                        <input type="submit" value="Apply Coupon" class="btn btn-primary">
                                                </div>
                                        </div>
                                        </form> -->

                                        <!-- <div class="row form-group" style="background-color: rgb(220, 220, 220);">
                                            <div class="col-sm-9">
                                                <h5>Please select a type of shipping:</h5>
                                            </div>
                                            <div class="col-sm-3">
                                                <% String shippingType = (String) request.getAttribute("shippingType");
											   //if (shippingType.equalsIgnoreCase("ecoRadioBox")) { %>
                                                <p style="width: 1000px;" onclick="selectAndSendShippingType('ecoRadioBox')"> <input id="ecoRadioBox" type="radio" value="eco" name="shippingMethod" checked> <b>Eco</b>: Free shipping but may take longer to delivery to you (8-10 days)</p>
                                                <p style="width: 1000px;" onclick="selectAndSendShippingType('fastRadioBox')"> <input id="fastRadioBox" type="radio" value="fast" name="shippingMethod"> <b>Fast shipping</b>: Express shipping, should take (1-2 days) </p>
                                                    <% //} else { %>
                                                <p style="width: 1000px;" onclick="selectAndSendShippingType('ecoRadioBox')"> <input id="ecoRadioBox" type="radio" value="eco" name="shippingMethod"> <b>Eco</b>: Free shipping but may take longer to delivery to you (8-10 days)</p>
                                                <p style="width: 1000px;" onclick="selectAndSendShippingType('fastRadioBox')"> <input id="fastRadioBox" type="radio" value="fast" name="shippingMethod" checked> <b>Fast shipping</b>: Express shipping, should take (1-2 days) </p>
                                                    <% //} %>

                                            </div>
                                        </div> -->
                                    </div>
                                    <div class="col-sm-4 text-center">
                                        <div class="total">
                                            <div class="sub">
                                                <% double subTotal = 0.0;
                                                   for (ShoppingCartItem cartItem : cartItems) {
                                                                subTotal += (cartItem.getPrice() - ((cartItem.getPrice() * cartItem.getDiscountAmount()) / 100)) * cartItem.getQuantity();
                                                   } %>
                                                <p><span>Subtotal:</span> <span>$<%=subTotal %></span></p>
                                                <!-- <% Double shippingFee = (Double) request.getAttribute("shippingFee"); %>
                                                <p><span>Delivery:</span> <span id="">$<%=shippingFee %></span></p> -->
                                                <!-- <p><span>Discount:</span> <span>$45.00</span></p> -->
                                            </div>
                                            <div class="grand-total">
                                                <p><span><strong>Total:</strong></span> <span>$<%=subTotal %></span></p>
                                            </div>
                                        </div>
                                        <div style="padding: 10px">
                                            <!-- <button onclick="location.href='CheckoutController?shippingFee=<%=shippingFee %>'" class="btn btn-success">Continue</button> -->
                                            <button onclick="location.href='CheckoutController'" class="btn btn-success">Continue</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <% } else { %>
                        <div class="d-flex">
                            <h1>There are no products in your shopping cart yet, come back later when you add one into it!</h1>
                        </div>
                    <% }
                    } %>

                    <div class="row">
                        <div class="col-sm-8 offset-sm-2 text-center colorlib-heading colorlib-heading-sm">
                            <h2>Related Products</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="#" class="prod-img">
                                    <img src="${pageContext.request.contextPath}/images/item-1.jpg" class="img-fluid" alt="Free html5 bootstrap 4 template">
                                </a>
                                <div class="desc">
                                    <h2><a href="#">Women's Boots Shoes Maca</a></h2>
                                    <span class="price">$139.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="#" class="prod-img">
                                    <img src="${pageContext.request.contextPath}/images/item-2.jpg" class="img-fluid" alt="Free html5 bootstrap 4 template">
                                </a>
                                <div class="desc">
                                    <h2><a href="#">Women's Minam Meaghan</a></h2>
                                    <span class="price">$139.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="#" class="prod-img">
                                    <img src="${pageContext.request.contextPath}/images/item-3.jpg" class="img-fluid" alt="Free html5 bootstrap 4 template">
                                </a>
                                <div class="desc">
                                    <h2><a href="#">Men's Taja Commissioner</a></h2>
                                    <span class="price">$139.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3 mb-4 text-center">
                            <div class="product-entry border">
                                <a href="#" class="prod-img">
                                    <img src="${pageContext.request.contextPath}/images/item-4.jpg" class="img-fluid" alt="Free html5 bootstrap 4 template">
                                </a>
                                <div class="desc">
                                    <h2><a href="#">Russ Men's Sneakers</a></h2>
                                    <span class="price">$139.00</span>
                                </div>
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

        <script>
            function incrementQuantity(incrementButton, quantityBox) {
                // Get the field name
                var quantitiy = 0;

                // If is not undefined		
                var quantity = parseInt(document.getElementById(quantityBox).innerHTML);

                // Increment
                if (parseInt(document.getElementById(quantityBox).innerHTML) != 10) {
                    document.getElementById(quantityBox).innerHTML = quantity + 1;
                    location.href = "shoppingCart?quantityUpdateFor=" + incrementButton + "&quantityAmount=" + document.getElementById(quantityBox).innerHTML;
                }




            }

            function decrementQuantity(decrementButton, quantityBox) {

                var quantitiy = 0;

                // Get the field name
                var quantity = parseInt(document.getElementById(quantityBox).innerHTML);

                // If is not undefined

                // Decrement
                if (quantity > 0) {
                    document.getElementById(quantityBox).innerHTML = quantity - 1;
                    location.href = "shoppingCart?quantityUpdateFor=" + decrementButton + "&quantityAmount=" + document.getElementById(quantityBox).innerHTML;
                }


            }

            function openPopup(popupID) {
                // Display the popup
                document.getElementById(popupID).style.display = "block";
            }

            function closePopup(popupID) {
                // Hide the popup
                document.getElementById(popupID).style.display = "none";
            }

            function openModal(modalID) {
                // Display the modal
                $('#' + modalID).modal('show');
            }

            function closeModal(modalID) {
                // Hide the modal
                $('#' + modalID).modal('hide');
            }

            function showRemovalDialog(modalID) {

            }

            function selectAndSendShippingType(radioBox) {
                document.getElementById(radioBox).checked = true;
                location.href = "shoppingCart?shippingType=" + radioBox;
            }

        </script>

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

        <% String removalConfirmation = (String) request.getAttribute("removalConfirmation");
	if (removalConfirmation != null) { %>
        <script>openModal('<%=removalConfirmation %>');</script>
        <% } %>

    </body>
</html>

