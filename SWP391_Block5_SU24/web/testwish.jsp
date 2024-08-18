<%-- 
    Document   : testwish
    Created on : Aug 19, 2024, 1:45:30 AM
    Author     : nobbe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
    // Database connection details
    String url = "jdbc:sqlserver://localhost:1433;databaseName=ECommerceStore";
    String user = "sa";
    String password = "your_password";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    // Get the current user's AccountID from session (assume it's stored in session)
    int accountId = (int) session.getAttribute("AccountID");
    
    try {
        // Establish connection
        conn = DriverManager.getConnection(url, user, password);
        
        // Prepare the SQL statement
        String sql = "SELECT p.ProductName, p.Price, s.Size, s.Color, pi.ImageURL " +
                     "FROM Wishlist w " +
                     "JOIN Stock s ON w.StockID = s.StockID " +
                     "JOIN Products p ON s.ProductID = p.ProductID " +
                     "JOIN ProductImages pi ON p.ProductID = pi.ProductID " +
                     "WHERE w.AccountID = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, accountId);
        
        // Execute the query
        rs = ps.executeQuery();
%>
        <div class="colorlib-product">
            <div class="container">
                <div class="row row-pb-lg">
                    <div class="col-md-12">
                        <div class="product-name d-flex">
                            <div class="one-forth text-left px-4">
                                <span>Product Details</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Price</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Size</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Color</span>
                            </div>
                            <div class="one-eight text-center px-4">
                                <span>Actions</span>
                            </div>
                        </div>
                        
                        <% 
                        // Iterate through the result set and display the wishlist items
                        while(rs.next()) { 
                        %>
                        <div class="product-cart d-flex">
                            <div class="one-forth">
                                <div class="product-img" style="background-image: url(<%= rs.getString("ImageURL") %>);">
                                </div>
                                <div class="display-tc">
                                    <h3><%= rs.getString("ProductName") %></h3>
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="price">$<%= rs.getDouble("Price") %></span>
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="size"><%= rs.getString("Size") %></span>
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="color"><%= rs.getString("Color") %></span>
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <form method="post" action="AddToCartServlet">
                                        <input type="hidden" name="productId" value="<%= rs.getInt("ProductID") %>">
                                        <button class="btn btn-primary btn-add-cart">Add to Cart</button>
                                    </form>
                                    <form method="post" action="RemoveFromWishlistServlet">
                                        <input type="hidden" name="wishlistId" value="<%= rs.getInt("WishlistID") %>">
                                        <button class="btn btn-danger btn-remove-wishlist">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% 
                        } 
                        %>
                    </div>
                </div>
            </div>
        </div>
<%
    } catch(SQLException e) {
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch(SQLException ignore) {}
        if(ps != null) try { ps.close(); } catch(SQLException ignore) {}
        if(conn != null) try { conn.close(); } catch(SQLException ignore) {}
    }
%>

<!DOCTYPE HTML>
<html>
<head>
	<title>Wishlist - Footwear</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">

	<!-- Additional CSS files (keep as they are) -->
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/icomoon.css">
	<link rel="stylesheet" href="css/ionicons.min.css">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/magnific-popup.css">
	<link rel="stylesheet" href="css/flexslider.css">
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">
	<link rel="stylesheet" href="css/bootstrap-datepicker.css">
	<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    

<div class="colorlib-loader"></div>

<div id="page">
	<nav class="colorlib-nav" role="navigation">
		<!-- Navigation bar content (keep as it is) -->
	</nav>

	<div class="breadcrumbs">
		<div class="container">
			<div class="row">
				<div class="col">
					<p class="bread"><span><a href="index.jsp">Home</a></span> / <span>Wishlist</span></p>
				</div>
			</div>
		</div>
	</div>

	<div class="colorlib-product">
		<div class="container">
			<div class="row row-pb-lg">
                            
			</div>
			<div class="row row-pb-lg">
				<div class="col-md-12">
					<div class="product-name d-flex">
						<div class="one-forth text-left px-4">
							<span>Product Details</span>
						</div>
						<div class="one-eight text-center">
							<span>Price</span>
						</div>
						<div class="one-eight text-center">
							<span>Size</span>
						</div>
						<div class="one-eight text-center">
							<span>Color</span>
						</div>
						<div class="one-eight text-center px-4">
							<span>Actions</span>
						</div>
					</div>
					
					<!-- Example Product Item -->
					<div class="product-cart d-flex">
						<div class="one-forth">
							<div class="product-img" style="background-image: url(images/item-6.jpg);">
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
								<span class="size">M</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="color">Red</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<button class="btn btn-primary btn-add-cart">Add to Cart</button>
								<button class="btn btn-danger btn-remove-wishlist">Remove</button>
							</div>
						</div>
					</div>
					<!-- Repeat Product Item structure as needed -->
					
				</div>
			</div>
		</div>
	</div>

	<footer id="colorlib-footer" role="contentinfo">
		<!-- Footer content (keep as it is) -->
	</footer>
</div>

<div class="gototop js-top">
	<a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
</div>

<!-- Additional JS files (keep as they are) -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/magnific-popup-options.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/jquery.stellar.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>

