<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Brand" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
    <!-- Include CSS and JavaScript as needed -->
    <link rel="stylesheet" href="path/to/bootstrap.css"> <!-- Add Bootstrap for styling (optional) -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            color: white;
            background-color: #007bff;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Product</h2>
        <form action="${pageContext.request.contextPath}/AddProductController" method="post">
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            
            <div class="form-group">
                <label for="origin">Origin:</label>
                <input type="text" id="origin" name="origin">
            </div>
            
            <div class="form-group">
                <label for="material">Material:</label>
                <input type="text" id="material" name="material">
            </div>
            
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" required>
            </div>
            

            
            <div class="form-group">
                <label for="brand">Brand:</label>
                <select id="brand" name="brandId" required>
                    <option value="">Select a brand</option>
                    <% 
                        ProductDetailsDAO dao = new ProductDetailsDAO();
                        List<Brand> brands = dao.getAllBrands();
                        for (Brand brand : brands) {
                    %>
                        <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName() %></option>
                    <% 
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="categoryId" required>
                    <option value="">Select a category</option>
                    <% 
                        List<Category> categories = dao.getAllCategories();
                        for (Category category : categories) {
                    %>
                        <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                    <% 
                        }
                    %>
                </select>
            </div>
            
            
            <div class="form-group">
                <label for="productStatus">Product Status:</label>
                <select id="productStatus" name="productStatus">
                    <option value="1">Available</option>
                    <option value="0">Unavailable</option>
                </select>
            </div>
            
            <button type="submit" class="btn">Add Product</button>
        </form>
    </div>
</body>
</html>
