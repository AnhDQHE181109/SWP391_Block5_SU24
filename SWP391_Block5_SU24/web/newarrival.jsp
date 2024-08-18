<%@ page import="java.util.List" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Product" %>

<%
    ProductDetailsDAO pDAO = new ProductDetailsDAO();
    List<Product> newArrivals = pDAO.getNewArrivals();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Include your CSS and other head content here -->
</head>
<body>
    <!-- Include your navigation and other elements here -->

    <div class="container">
        <div class="row">
            <!-- Sidebar and other sections here -->

            <!-- Product List -->
            <div class="col-lg-9 col-xl-9">
                <div class="row row-pb-md">
                    <% for (Product product : newArrivals) { %>
                    <div class="col-lg-4 mb-4 text-center">
                        <div class="product-entry border">
                            <a href="#" class="prod-img">
                                <img src="<%= product.getImageURL() %>" class="img-fluid" alt="Product Image">
                            </a>
                            <div class="desc">
                                <h2><a href="#"><%= product.getProductName() %></a></h2>
                                <span class="price"><%= product.getPrice() %></span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Include your footer and other elements here -->
</body>
</html>
