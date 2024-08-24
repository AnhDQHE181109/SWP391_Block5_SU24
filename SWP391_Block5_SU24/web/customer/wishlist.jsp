<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.*" %>
<%@ page import="entity.Account" %>
<%@ page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%
    // Retrieve the sorting parameter from the request
    String sort = request.getParameter("sort");

    // Initialize the wishlistItems variable
    List<Product> wishlistItems = new ArrayList<>();

    int cartItemsCount = 0;
    // Retrieve the account ID from the session using the correct attribute name
    Account loggedInUser = (Account) session.getAttribute("account");
    if (loggedInUser == null) {
        out.println("No user logged in, redirecting to login page...");
        response.sendRedirect("login.jsp");
        return; // Stop further execution of JSP
    } else {
        int accountId = loggedInUser.getAccountID();
        WishlistDAO wishlistDAO = new WishlistDAO();
        wishlistItems = wishlistDAO.getWishlistItems(accountId, sort); // Pass the sort parameter
        
        ShoppingCartDAO scDAO = new ShoppingCartDAO();
        cartItemsCount = scDAO.getCartItemsByAccountID(loggedInUser.getAccountID()).size();
    }
%>

<html>
    <head>
        <title>Footwear - Wishlist</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://kit.fontawesome.com/c630e9f862.js" crossorigin="anonymous"></script>
        <!-- Include existing CSS files -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icomoon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flexslider.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/flaticon/font/flaticon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <!-- Custom CSS for Suggestions -->
        <style>
            #suggestions {
                position: absolute;
                width: 100%; 
                z-index: 1000; 
                background-color: white; 
                border: 1px solid #ddd; 
            }

            #suggestions .list-group-item {
                padding: 10px;
                cursor: pointer;
            }

            #suggestions .list-group-item:hover {
                background-color: #f1f1f1; /* Highlight effect */
            }

            .search-wrap {
                position: relative; /* Required to position suggestions relative to search bar */
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
    </head>
    <body>

        <div class="colorlib-loader"></div>

        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <div class="top-menu">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-7 col-md-9">
                                <div id="colorlib-logo"><a href="${pageContext.request.contextPath}/index.jsp">Footwear</a></div>
                            </div>
                            <div class="col-sm-5 col-md-3">
                                <form action="${pageContext.request.contextPath}/products.jsp" class="search-wrap" method="get">
                                    <div class="form-group">
                                        <input type="text" id="search-bar" name="query" class="form-control" placeholder="Search for more products..." onkeyup="searchProducts()">
                                        <div id="suggestions" class="list-group"></div>
                                        <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
                                    
                                    <li class="cart dropdown">
                                        <a href="#" class="dropdown-toggle" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fa-regular fa-user"></i> <%= ((Account) session.getAttribute("account")).getUsername() %>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/customer_profile.jsp">Profile</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutController">Logout</a>
                                        </div>
                                    </li>

                                    <li class="cart"><a href="${pageContext.request.contextPath}/shoppingCart"><i class="icon-shopping-cart"></i> Cart [<%=cartItemsCount %>]</a></li>

                                    <li class="cart"><a href="wishlist.jsp"><i class="fa fa-heart"></i> Wishlist</a></li>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span><a href="${pageContext.request.contextPath}/index.jsp">Home</a></span> / <span>Wishlist</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="colorlib-product">
                <div class="container">
                    <div class="row">
                        <div class="col-md-20 text-center">
                            <form method="get" action="wishlist.jsp">
                                <label for="sort">Sort by:</label>
                                <select name="sort" id="sort" onchange="this.form.submit()">
                                    <option value="name_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("name_asc") ? "selected" : "" %>>Name: A-Z</option>
                                    <option value="name_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("name_desc") ? "selected" : "" %>>Name: Z-A</option>
                                    <option value="date_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_desc") ? "selected" : "" %>>Date: Latest</option>
                                    <option value="date_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_asc") ? "selected" : "" %>>Date: Earliest</option>
                                </select>
                            </form>
                        </div>
                    </div>


                    <div class="row row-pb-lg wishlist-table">
                        <div class="col-md-12">
                            <div class="product-name d-flex wishlist-table">
                                <div class="one-forth text-left px-4 wishlist-table">
                                    <span>Product Details</span>
                                </div>
                                <div class="one-eight text-center wishlist-table">
                                    <span>Size</span>
                                </div>
                                <div class="one-eight text-center wishlist-table">
                                    <span>Color</span>
                                </div>
                                <div class="one-eight text-center wishlist-table">
                                    <span>Date</span>
                                </div>
                                <div class="one-eight text-center px-4 wishlist-table">
                                    <span>Actions</span>
                                </div>
                            </div>

                            <%
                            for (Product product : wishlistItems) {
                            %>
                            <div class="product-cart d-flex">
                                <div class="one-forth">
                                    <div class="product-img" style="background-image: url(${pageContext.request.contextPath}/<%= product.getImageURL() %>);">
                                    </div>
                                    <div class="display-tc">
                                        <a href="${pageContext.request.contextPath}/ProductDetailsController?productID=<%=product.getProductId() %>"><h3><%= product.getProductName() %></h3></a>
                                    </div>
                                </div>

                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="size"><%= product.getSize() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="color"><%= product.getColor() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="date"><%= product.getDateAdded() %></span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <form action="${pageContext.request.contextPath}/shoppingCart" method="post">
                                            <input type="hidden" name="selectedColor" value="<%= product.getColor() %>">
                                            <input type="hidden" name="selectedSize" value="<%= product.getSize() %>">
                                            <input type="hidden" name="selectedProductID" value="<%= product.getProductId() %>">
                                            <input type="hidden" name="quantity" value="1"> <!-- Default to 1 -->
                                            <button type="submit" class="btn btn-primary wishlist-table">Add to Cart</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/RemoveWishlistController" method="post">
                                            <input type="hidden" name="stockId" value="<%= product.getStockID() %>">
                                            <button type="submit" class="btn btn-danger btn-remove-wishlist">Remove</button>
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
        </div>


        <footer id="colorlib-footer" role="contentinfo">
            <div class="container">
                <div class="row row-pb-md">
                    <!-- Footer content -->
                </div>
            </div>
        </footer>
    </div>

    <div class="gototop js-top">
        <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
    </div>

    <!-- Include existing JS files -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.flexslider-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/magnific-popup-options.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>

    <!-- Add the search functionality -->
    <script>
                                    function searchProducts() {
                                        const searchTerm = document.getElementById('search-bar').value;
                                        if (searchTerm.length > 0) {
                                            $.ajax({
                                                type: 'GET',
                                                url: '${pageContext.request.contextPath}/SearchingController',
                                                data: {query: searchTerm},
                                                success: function (response) {
                                                    $('#suggestions').empty();
                                                    $('#suggestions').append(response); // Append the HTML suggestions
                                                    // Add click event listener to each suggestion item
                                                    $('#suggestions .list-group-item').on('click', function () {
                                                        const productUrl = $(this).data('url');
                                                        window.location.href = productUrl; // Navigate to the product details page
                                                    });
                                                }
                                            });
                                        } else {
                                            $('#suggestions').empty(); // Clear suggestions if the search bar is empty
                                        }
                                    }
    </script>
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
