<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.*"%>
<%@page import="model.ProductDetailsDAO"%>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDetailsDAO dao = new ProductDetailsDAO();
    Product product = dao.getProductById(productId);
    List<Brand> brands = dao.getAllBrands();
    List<Category> categories = dao.getAllCategories();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
        <style>
            /* General Page Styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            /* Container Styling */
            .container {
                width: 50%;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 30px;
                transition: box-shadow 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            /* Form Group Styling */
            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
                color: #333;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px;
                border-radius: 4px;
                border: 1px solid #ddd;
                font-size: 16px;
                color: #333;
                transition: border-color 0.3s ease;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #007bff;
            }

            /* Button Styling */
            .btn {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 4px;
                color: white;
                background-color: #007bff;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% String errorMessage = request.getParameter("error"); %>
            <% if (errorMessage != null) { %>
            <div style="color: red; margin-bottom: 20px;"><%= errorMessage %></div>
            <% } %>
            <form name="editProductForm" action="${pageContext.request.contextPath}/EditProductController" method="post" onsubmit="return validateForm()">

                <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" name="productName" value="<%= product.getProductName() %>">
                </div>

                <div class="form-group">
                    <label for="origin">Origin:</label>
                    <input type="text" name="origin" value="<%= product.getOrigin() %>">
                </div>

                <div class="form-group">
                    <label for="material">Material:</label>
                    <input type="text" name="material" value="<%= product.getMaterial() %>">
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" name="price" value="<%= product.getPrice() %>" step="0.01">
                </div>

                <div class="form-group">
                    <label for="brandId">Brand:</label>
                    <select name="brandId">
                        <% for (Brand brand : brands) { %>
                        <option value="<%= brand.getBrandId() %>" <%= product.getBrandId() == brand.getBrandId() ? "selected" : "" %>><%= brand.getBrandName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select name="categoryId">
                        <% for (Category category : categories) { %>
                        <option value="<%= category.getCategoryId() %>" <%= product.getCategoryId() == category.getCategoryId() ? "selected" : "" %>><%= category.getCategoryName() %></option>
                        <% } %>
                    </select>
                </div>
                    
                <div class="form-group">
                    <label for="productStatus">Product Status:</label>
                    <select name="productStatus">
                        <% 
                            int currentStatus = product.getProductStatus(); 
                            if (currentStatus == 1) { 
                        %>
                            <option value="1" selected>Active</option>
                            <option value="0">Inactive</option>
                        <% 
                            } else { 
                        %>
                            <option value="1">Active</option>
                            <option value="0" selected>Inactive</option>
                        <% 
                            } 
                        %>
                    </select>
                </div>

                <button type="submit" class="btn">Save Changes</button>
            </form>
        </div>

    </body>
    <script>
        function validateForm() {
            const form = document.forms["editProductForm"];
            const productName = form["productName"].value.trim();
            const origin = form["origin"].value.trim();
            const material = form["material"].value.trim();
            const price = form["price"].value.trim();
            const priceValue = parseFloat(price);
            const currentStatus = <%= product.getProductStatus() %>;
            const newStatus = form["productStatus"].value;

            if (!productName || !origin || !material || !price) {
                alert("All fields must be filled out.");
                return false;
            }

            if (isNaN(priceValue) || priceValue <= 0 || priceValue > 100000000) {
                alert("Price must be a positive number between 0 and 100,000,000 VND.");
                return false;
            }

            // Check if status has changed
            if (currentStatus != newStatus) {
                return confirm("Changing the product status will affect its visibility. Are you sure you want to proceed?");
            }

            return true;
        }
    </script>
</html>
