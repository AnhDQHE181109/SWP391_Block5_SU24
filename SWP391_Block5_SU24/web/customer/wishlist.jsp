<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@ page import="model.WishlistDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%
    // Retrieve the sorting parameter from the request
    String sort = request.getParameter("sort");

    // Initialize the wishlistItems variable
    List<Product> wishlistItems = new ArrayList<>();

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
    }
%>

<html>
    <head>
        <title>Wishlist - Footwear</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Include your existing CSS files -->
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
    </head>
    <body>

        <div class="colorlib-loader"></div>

        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <!-- Navigation content -->
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

            <!-- Search Bar with Icon -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-12 text-center">
                        <div class="input-group mb-3">
                            <input type="text" id="search-bar" class="form-control" placeholder="Search for more products..." onkeyup="searchProducts()">
                            <div id="suggestions" class="list-group"></div>
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
                                        <option value="price_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("price_asc") ? "selected" : "" %>>Price: Low to High</option>
                                        <option value="price_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("price_desc") ? "selected" : "" %>>Price: High to Low</option>
                                        <option value="date_desc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_desc") ? "selected" : "" %>>Date: Latest</option>
                                        <option value="date_asc" <%= request.getParameter("sort") != null && request.getParameter("sort").equals("date_asc") ? "selected" : "" %>>Date: Earliest</option>
                                    </select>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="row row-pb-lg"></div>
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
                                <div class="one-eight text-center">
                                    <span>Date</span>
                                </div>
                                <div class="one-eight text-center px-4">
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
                                        <span class="price">$<%= product.getPrice() %></span>
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
                                            <button type="submit" class="btn btn-primary">Add to Cart</button>
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

            <footer id="colorlib-footer" role="contentinfo">
                <!-- Footer content -->
            </footer>
        </div>

        <div class="gototop js-top">
            <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
        </div>
        <!-- Include your existing JS files -->
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
                                                    url: '${pageContext.request.contextPath}/SearchSuggestionsServlet',
                                                    data: {query: searchTerm},
                                                    success: function (response) {
                                                        $('#suggestions').empty();
                                                        $('#suggestions').append(response); // Append the HTML suggestions
                                                    }
                                                });
                                            } else {
                                                $('#suggestions').empty(); // Clear suggestions if the search bar is empty
                                            }
                                        }
        </script>

    </body>
</html>
