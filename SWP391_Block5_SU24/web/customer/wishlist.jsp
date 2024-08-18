<%-- 
    Document   : wishlist
    Created on : Aug 17, 2024, 6:38:33 PM
    Author     : nobbe
--%>

<%@ page import="java.util.List" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
    <title>Wishlist - Footwear</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">
    
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

    
    <script>
        function validateSearch() {
            var searchInput = document.getElementById("search-input").value;
            var regex = /^[a-zA-Z0-9\-]+$/; // Cho phép chỉ nhập ký tự chữ, số, và dấu gạch ngang

            if (!regex.test(searchInput)) {
                alert("Invalid input");
                return false;
            }
            return true;
        }
    </script>
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

    <div class="colorlib-product">
        <div class="container">
            <% 
                Account account = (Account) session.getAttribute("account");
                if (account == null) {
                    response.sendRedirect("../login.jsp");
                }
            %>

            <!-- Thanh tìm kiếm và sắp xếp -->
            <div class="row mb-4">
                <div class="col-md-12 d-flex justify-content-between">
                    <!-- Search bar -->
                    <form action="WishlistController" method="get" class="search-wrap d-flex" onsubmit="return validateSearch()">
                        <div class="form-group d-flex">
                            <input type="search" id="search-input" name="search" class="form-control search" placeholder="Seach">
                            <button class="btn btn-primary submit-search" type="submit" style="margin-left: 5px;">
                                <i class="icon-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Sorting options -->
                    <form method="get" action="WishlistController" class="d-flex align-items-center">
                        <label for="sort" class="mr-2">Sắp xếp theo:</label>
                        <select name="sort" id="sort" class="form-control" onchange="this.form.submit()">
                            <option value="name">Tên</option>
                            <option value="price">Giá</option>
                        </select>
                    </form>
                </div>
            </div>

            <div class="row row-pb-lg">
                <div class="col-md-12">
                    <div class="product-name d-flex">
                        <div class="one-forth text-left px-4">
                            <span>Chi tiết sản phẩm</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Giá</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Kích thước</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Màu sắc</span>
                        </div>
                        <div class="one-eight text-center">
                            <span>Thêm vào giỏ</span>
                        </div>
                        <div class="one-eight text-center px-4">
                            <span>Xóa</span>
                        </div>
                    </div>

                    <!-- Hiển thị các sản phẩm trong wishlist -->
                    <c:if test="${wishlistItems != null && !wishlistItems.isEmpty()}">
                        <c:forEach var="item" items="${wishlistItems}">
                            <div class="product-cart d-flex">
                                <div class="one-forth">
                                    <div class="product-img" style="background-image: url(${item.imageURL});"></div>
                                    <div class="display-tc">
                                        <h3>${item.productName}</h3>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span class="price">${item.price}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>${item.size}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <span>${item.color}</span>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <a href="CartController?action=add&stockId=${item.stockID}" class="btn btn-primary">Thêm vào giỏ</a>
                                    </div>
                                </div>
                                <div class="one-eight text-center">
                                    <div class="display-tc">
                                        <a href="WishlistController?action=remove&wishlistId=${item.wishlistID}" class="closed"></a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!-- Nếu wishlist trống -->
                    <c:if test="${wishlistItems == null || wishlistItems.isEmpty()}">
                        <p>Danh sách yêu thích của bạn trống.</p>
                    </c:if>
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


