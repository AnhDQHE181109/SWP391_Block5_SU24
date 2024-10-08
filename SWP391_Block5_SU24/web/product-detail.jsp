<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import = "entity.*" %>
<%@page import = "java.util.*" %>

<!DOCTYPE HTML>
<html>
	<head>
	<% ProductDetails productDetails = (ProductDetails) request.getAttribute("productDetails"); %>
	<title><%=productDetails.getProductName() %></title>
	<script src="https://kit.fontawesome.com/c630e9f862.js" crossorigin="anonymous"></script>
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

	</head>
	<body>
		
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
								<!-- <li class="has-dropdown">
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
						<p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Product Details</span></p>
					</div>
				</div>
			</div>
		</div>

		<%
			List<ProductStockDetails> productColors = (List<ProductStockDetails>) request.getAttribute("productColors");
			List<ProductStockDetails> productSizes = (List<ProductStockDetails>) request.getAttribute("productSizes");
			String selectedColor = (String) request.getAttribute("selectedColor");
			String selectedSize = (String) request.getAttribute("selectedSize");

        %>
		<div class="colorlib-product">
			<div class="container">
				<div class="row row-pb-lg product-detail-wrap">
					<div class="col-sm-8">
						<div class="owl-carousel" id="img-slider">
							<% if (productColors != null) { 
								for (ProductStockDetails productStockDetail : productColors) { %>
									<div class="item">
										<div class="product-entry border">
											<a href="#" class="prod-img">
												<img src="<%=productStockDetail.getImageURL() %>" class="img-fluid" alt="<%=productStockDetail.getColor() %>" width="800" height="800">
											</a>
										</div>
									</div>
							<% }
							  } %>
						</div>
					</div>

					<div class="col-sm-4">
						<form action="shoppingCart" method="post">

						<div class="product-desc">
							<h3><%=productDetails.getProductName() %></h3>
							<h4>Brand: <%=productDetails.getBrandName() %></h4>
							<p class="price">
								<% double discountedPriced = productDetails.getPrice() - ((productDetails.getPrice() * productDetails.getDiscountAmount()) / 100); %>
								<span><s><em>$<%=productDetails.getPrice() %></em></s>   $<%=discountedPriced %>   <b style="font-size: 15px;">(-<%=productDetails.getDiscountAmount() %>% off)</b></span> 
								<!-- <span class="rate">
									<i class="icon-star-full"></i>
									<i class="icon-star-full"></i>
									<i class="icon-star-full"></i>
									<i class="icon-star-full"></i>
									<i class="icon-star-half"></i>
									(74 Rating)
								</span> -->
							</p>
							<!-- <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->

							<div class="block-26 mb-4">
								<h4>Color</h4>
						   	  <ul>
								<%  if (productColors == null || productColors.isEmpty()) { %>
									<p>Error, no colors available for this product!</p>
								<%
									} else { 
										for (ProductStockDetails productStockDetail : productColors) { %>
							  	<li><a id="<%=productStockDetail.getColor() %>_<%=productStockDetail.getProductID() %>" 
									href="ProductDetailsController?productID=<%=productStockDetail.getProductID() %>&selectedColor=<%=productStockDetail.getColor() %>"><%=productStockDetail.getColor() %></a></li>
								<%  	}
									} %>
						   	  </ul>	

							  	<input type="text" name="selectedColor" value="<%=selectedColor %>" hidden>

							</div>
							
							<div class="size-wrap">
								<div class="block-26 mb-2">
									<h4>Size</h4>
				               <ul id="sizesList">
								  <%	for (ProductStockDetails productStockDetail : productSizes) {
										 int productID = productColors.get(0).getProductID(); %>
				                  <li><a id="Size_<%=productStockDetail.getSize() %>" 
									href="ProductDetailsController?productID=<%=productID %>&selectedColor=<%=selectedColor %>
									&selectedSize=<%=productStockDetail.getSize() %>"><%=productStockDetail.getSize() %></a></li>
								  <%	} 
									  %>
				               </ul>

							   <input type="text" name="selectedSize" value="<%=selectedSize %>" hidden>

							   <input type="text" name="selectedProductID" value="<%=productColors.get(0).getProductID() %>" hidden>

				            	</div>
							</div>

							<div>
								<% int availableProducts = 0;
								for (ProductStockDetails productSize : productSizes) {
									if (Integer.parseInt(selectedSize) == productSize.getSize()) {
										availableProducts = productSize.getStockQuantity(); %>
										<p>Available products: <%=availableProducts %></p>
								<%	}
								} %>
							</div>

							<% if (availableProducts == 0) { %>
								<div class="row">
									<div class="col-sm-12 text-center">
										<h2>Product with such variant is sold out!</h2>
										<p class="text-left"><a href="ProductDetailsController?addToWishlistProduct=<%=productColors.get(0).getProductID() %>&addToWishlistColor=<%=selectedColor %>&addToWishlistSize=<%=selectedSize %>"><i class="fa fa-heart"></i> Add to wishlist	</a></p>
									</div>
								</div>
							<% } else { %>
								<div class="input-group mb-4">
									<span class="input-group-btn">
										<button type="button" class="quantity-left-minus btn"  data-type="minus" data-field="">
									<i class="icon-minus2"></i>
										</button>
										</span>
									<input type="text" id="quantity" name="quantity" class="form-control input-number" value="1" min="1" readonly onfocusout="validateQuantity()">
									<span class="input-group-btn ml-1">
										<button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
										<i class="icon-plus2"></i>
									</button>
									</span>
								</div>
	
								<div class="row">
									<div class="col-sm-12 text-center">
										<p class="addtocart"><button type="submit" class="btn btn-primary btn-addtocart"><span><i class="icon-shopping-cart"></i></span> Add to Cart</button> </p>
										<p class="text-left"><a href="ProductDetailsController?addToWishlistProduct=<%=productColors.get(0).getProductID() %>&addToWishlistColor=<%=selectedColor %>&addToWishlistSize=<%=selectedSize %>"><i class="fa fa-heart"></i> Add to wishlist</a></p>
									</div>
								</div>
							<% } %>

						</div>

						</form>

					</div>
				</div>

				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-md-12 pills">
								<div class="bd-example bd-example-tabs">
								  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

								    <!-- <li class="nav-item">
								      <a class="nav-link" id="pills-description-tab" data-toggle="pill" href="#pills-description" role="tab" aria-controls="pills-description" aria-expanded="true">Description</a>
								    </li>
								    <li class="nav-item">
								      <a class="nav-link" id="pills-manufacturer-tab" data-toggle="pill" href="#pills-manufacturer" role="tab" aria-controls="pills-manufacturer" aria-expanded="true">Manufacturer</a>
								    </li> -->
								    <li class="nav-item">
								      <a class="nav-link active" id="pills-review-tab" data-toggle="pill" href="#pills-review" role="tab" aria-controls="pills-review" aria-expanded="true">Review</a>
								    </li>
								  </ul>

								  <div class="tab-content" id="pills-tabContent">
								    <div class="tab-pane border fade" id="pills-description" role="tabpanel" aria-labelledby="pills-description-tab">
								      <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p>
										<p>When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane. Pityful a rethoric question ran over her cheek, then she continued her way.</p>
										<ul>
											<li>The Big Oxmox advised her not to do so</li>
											<li>Because there were thousands of bad Commas</li>
											<li>Wild Question Mar 	ks and devious Semikoli</li>
											<li>She packed her seven versalia</li>
											<li>tial into the belt and made herself on the way.</li>
										</ul>
								    </div>

								    <div class="tab-pane border fade" id="pills-manufacturer" role="tabpanel" aria-labelledby="pills-manufacturer-tab">
								      <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p>
										<p>When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane. Pityful a rethoric question ran over her cheek, then she continued her way.</p>
								    </div>

								    <div class="tab-pane border fade show active" id="pills-review" role="tabpanel" aria-labelledby="pills-review-tab">
								      <div class="row">
								   		<div class="col-md-8">
											<% List<Feedback> feedbacksList = (List<Feedback>) request.getAttribute("feedbacksList");
												if (feedbacksList != null) { %>
								   			<h3 class="head"><%=feedbacksList.size() %> review(s)</h3>
											<% for (Feedback feedback : feedbacksList) { %>
													<div class="review">
														<!-- <div class="user-img" style="background-image: url(images/person1.jpg)"></div> -->
														<div class="desc">
															<h4>
																<span class="text-left"><%=feedback.getUsername() %></span>
																<span class="text-right"><%=feedback.getCreatedAt() %></span>
															</h4>
															<p class="star">
																<span>
																	<% for (int i = 0; i < feedback.getRating(); i++) { %>
																		<i class="icon-star-full"></i>
																	<% } %>
																	
																	<!-- <i class="icon-star-full"></i>
																	<i class="icon-star-full"></i>
																	<i class="icon-star-half"></i>
																	<i class="icon-star-empty"></i> -->
																</span>
																<!-- <span class="text-right"><a href="#" class="reply"><i class="icon-reply"></i></a></span> -->
															</p>
															<p><%=feedback.getComment() %></p>
														</div>
													</div>
											<%		}  
												} %>

										   	<!-- <div class="review">
										   		<div class="user-img" style="background-image: url(images/person2.jpg)"></div>
										   		<div class="desc">
										   			<h4>
										   				<span class="text-left">Jacob Webb</span>
										   				<span class="text-right">14 March 2018</span>
										   			</h4>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-half"></i>
										   					<i class="icon-star-empty"></i>
									   					</span>
									   					<span class="text-right"><a href="#" class="reply"><i class="icon-reply"></i></a></span>
										   			</p>
										   			<p>When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrov</p>
										   		</div>
										   	</div>
										   	<div class="review">
										   		<div class="user-img" style="background-image: url(images/person3.jpg)"></div>
										   		<div class="desc">
										   			<h4>
										   				<span class="text-left">Jacob Webb</span>
										   				<span class="text-right">14 March 2018</span>
										   			</h4>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-half"></i>
										   					<i class="icon-star-empty"></i>
									   					</span>
									   					<span class="text-right"><a href="#" class="reply"><i class="icon-reply"></i></a></span>
										   			</p>
										   			<p>When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrov</p>
										   		</div>
										   	</div> -->
								   		</div>
								   		<!-- <div class="col-md-4">
								   			<div class="rating-wrap">
									   			<h3 class="head">Give a Review</h3>
									   			<div class="wrap">
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					(98%)
									   					</span>
									   					<span>20 Reviews</span>
										   			</p>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-empty"></i>
										   					(85%)
									   					</span>
									   					<span>10 Reviews</span>
										   			</p>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					(70%)
									   					</span>
									   					<span>5 Reviews</span>
										   			</p>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					(10%)
									   					</span>
									   					<span>0 Reviews</span>
										   			</p>
										   			<p class="star">
										   				<span>
										   					<i class="icon-star-full"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					<i class="icon-star-empty"></i>
										   					(0%)
									   					</span>
									   					<span>0 Reviews</span>
										   			</p>
										   		</div>
									   		</div>
								   		</div> -->
								   	</div>
								    </div>
								  </div>
								</div>
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
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
   <!-- popper -->
   <script src="js/popper.min.js"></script>
   <!-- bootstrap 4.1 -->
   <script src="js/bootstrap.min.js"></script>
   <!-- jQuery easing -->
   <script src="js/jquery.easing.1.3.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Flexslider -->
	<script src="js/jquery.flexslider-min.js"></script>
	<!-- Owl carousel -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	<!-- Date Picker -->
	<script src="js/bootstrap-datepicker.js"></script>
	<!-- Stellar Parallax -->
	<script src="js/jquery.stellar.min.js"></script>
	<!-- Main -->
	<script src="js/main.js"></script>

	<script>
		$(document).ready(function(){

		var quantitiy=0;
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined

				<% int maxAmount = 0;
				for (ProductStockDetails productSize : productSizes) {
									if (Integer.parseInt(selectedSize) == productSize.getSize()) {
										maxAmount = productSize.getStockQuantity();
				}
				} %>
		            
					if ($('#quantity').val() != <%=maxAmount %>) {
						$('#quantity').val(quantity + 1);
					}
					// $('#quantity').val(quantity + 1);
		            
		          
		            // Increment
		        
		    });

		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
		            if(quantity>1){
		            $('#quantity').val(quantity - 1);
		            }
		    });
		    
		});

		function validateQuantity() {
			var quantity = parseInt($('#quantity').val());
			if (isNaN(quantity)) {
				document.getElementById('quantity').value = 1;
				alert("Invalid quantity!");
			} else if (quantity <= 0) {
				document.getElementById('quantity').value = 1;
				alert("Quantity can't be less than or equal to 0!");
			} else if (quantity > 100) {
				document.getElementById('quantity').value = 100;
				alert("Quantity can't be more than the stock available!");
			}
        }

		function setSelectedColor(colorButton) {
			document.getElementById(colorButton).setAttribute("style", "background: #616161;");
		}

		<% String selectedColorButton = (String) request.getAttribute("selectedColorButton");
		   String selectedSizeButton = (String) request.getAttribute("selectedSizeButton");

		   if (selectedColorButton != null) { %>
			document.getElementById('<%=selectedColorButton %>').setAttribute("style", "background: #616161;");
		<% }
		   if (selectedSizeButton != null) { %>
			document.getElementById('<%=selectedSizeButton %>').setAttribute("style", "background: #616161;");
		<% } %>

	</script>

	<script defer>
		<%	String displayedImage = (String) request.getAttribute("displayedImage");
		
		if (displayedImage != null) {
			int displayedImageInt = Integer.parseInt(displayedImage); %>
			window.onload = function() {
				$("#img-slider").trigger('to.owl.carousel', <%=displayedImageInt %>);
			};
		<% } %>
	</script>


	</body>
</html>

