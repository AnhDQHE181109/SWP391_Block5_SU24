<%-- 
    Document   : return_product
    Created on : Aug 21, 2024, 11:05:48 PM
    Author     : nobbe
--%>

<%@ page import="java.sql.*" %>
<%@ page import="entity.Account" %>
<%@ page import="model.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    Account loggedInUser = (Account) session.getAttribute("account");
    int accountId = loggedInUser.getAccountID();
    String userPhoneNumber = loggedInUser.getPhoneNumber();
    String userEmail = loggedInUser.getEmail();

    DBConnect dbConnect = new DBConnect();
    Connection conn = dbConnect.conn;

    // Query to get the product details and sale price associated with this order
    String sql = "SELECT p.ProductName, s.Size, s.Color, o.OrderID, pi.ImageURL, od.SalePrice " +
                 "FROM OrderDetails od " +
                 "JOIN Stock s ON od.StockID = s.StockID " +
                 "JOIN Products p ON s.ProductID = p.ProductID " +
                 "JOIN Orders o ON od.OrderID = o.OrderID " +
                 "LEFT JOIN ProductImages pi ON s.StockID = pi.StockID " +
                 "WHERE o.OrderID = ?";

    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, orderId);
    ResultSet rs = ps.executeQuery();

    String productName = "";
    int size = 0;
    String color = "";
    String imageUrl = "images/product-placeholder.png";  // Default image placeholder
    double salePrice = 0.00;

    if (rs.next()) {
        productName = rs.getString("ProductName");
        size = rs.getInt("Size");
        color = rs.getString("Color");
        salePrice = rs.getDouble("SalePrice");
        String fetchedImageUrl = rs.getString("ImageURL");
        if (fetchedImageUrl != null && !fetchedImageUrl.isEmpty()) {
            imageUrl = fetchedImageUrl;  // Use the actual product image if available
        }
    }

    rs.close();
    ps.close();
%>

<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Footwear - Return Product</title>

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

        <!-- Custom CSS for Return Product -->
        <style>
            /* Your existing CSS styles here */
            .return-product-box {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                padding: 20px;
                margin-bottom: 20px;
                border-radius: 8px;
            }

            .product-img {
                width: 100px;
                height: 100px;
                background-size: cover;
                background-position: center;
                margin-right: 20px;
            }

            .return-product-box h3 {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .return-product-box p {
                margin: 5px 0;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: 600;
                margin-bottom: 5px;
                display: block;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            #description {
                resize: none;
                max-height: 200px;
                overflow-y: auto;
            }

            .btn-submit {
                width: 100%;
                padding: 15px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 20px;
            }

            .btn-submit:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <div class="top-menu">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-7 col-md-9">
                                <div id="colorlib-logo"><a href="${pageContext.request.contextPath}/index.jsp">Footwear</a></div>
                            </div>
                            
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-left menu-1">
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
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
                            <p class="bread"><span><a href="${pageContext.request.contextPath}/index.jsp">Home</a></span> / <span>Request Return</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container">
                <!-- Selected Product Box -->
                <div class="return-product-box d-flex">
                    <div class="product-img" style="background-image: url('<%= imageUrl %>');"></div>
                    <div class="product-details">
                        <h3><%= productName %></h3>
                        <p>Size: <%= size %></p>
                        <p>Color: <%= color %></p>
                        <p>Order Number: #<%= orderId %></p>
                    </div>
                </div>

                <!-- Reason and Description Box -->
                <form method="post" action="${pageContext.request.contextPath}/ReturnRequestController">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <div class="return-product-box">
                        <div class="form-group">
                            <label for="return-reason">Reason for Return:</label>
                            <select id="return-reason" name="reason" class="form-control">
                                <option value="Damaged">Damaged Product</option>
                                <option value="Wrong Item">Wrong Item Delivered</option>
                                <option value="Not as Described">Product Not as Described</option>
                                <!-- Add more options as needed -->
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" class="form-control" maxlength="2000" placeholder="Describe the issue..."></textarea>
                            <small id="char-count">0/2000 characters</small> <!-- Character count display -->
                        </div>
                    </div>

                    <!-- Refund Details Box -->
                    <div class="return-product-box">
                        <div class="form-group">
                            <label for="refund-amount">Refund Amount:</label>
                            <input type="text" id="refund-amount" name="refund_amount" class="form-control" value="<%= salePrice %>" readonly>
                        </div>

                        <div class="form-group">
                            <label for="phone-number">Phone Number:</label>
                            <input type="text" id="phone-number" name="phone_number" class="form-control" value="<%= userPhoneNumber %>" readonly>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" class="form-control" value="<%= userEmail %>" readonly>
                        </div>

                        <button type="submit" class="btn-submit">Submit Return Request</button>
                    </div>
                </form>
            </div>
        </div>

        <footer id="colorlib-footer" role="contentinfo">
            <div class="container">
                <div class="row row-pb-md">
                    <!-- Footer content -->
                </div>
            </div>
        </footer>

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

        <!-- Character Count Script -->
        <script>
            const description = document.getElementById('description');
            const charCount = document.getElementById('char-count');

            description.addEventListener('input', function () {
                const currentLength = description.value.length;
                charCount.textContent = `${currentLength}/2000 characters`;
            });
        </script>
    </body>
</html>
