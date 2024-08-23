<%@ page import="model.ProductDetailsDAO" %>
<%@ page import="entity.Brand" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Fetch brands and categories from the database
    ProductDetailsDAO dao = new ProductDetailsDAO();
    List<Brand> brands = dao.getAllBrands();
    List<Category> categories = dao.getAllCategories();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product</title>
</head>
<body>
    <h1>Add New Product</h1>
    <form action="${pageContext.request.contextPath}/AddProductController" method="post" enctype="multipart/form-data"> 
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" name="productName" required><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" required min="0" max="100000000"><br>

        <label for="brand">Brand:</label>
        <select id="brand" name="brandId" required>
            <option value="">Select a brand</option>
            <% for(Brand brand : brands) { %>
                <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName() %></option>
            <% } %>
        </select><br>

        <label for="category">Category:</label>
        <select id="category" name="categoryId" required>
            <option value="">Select a category</option>
            <% for(Category category : categories) { %>
                <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
            <% } %>
        </select><br>

        <label for="material">Material:</label>
        <input type="text" id="material" name="material" required><br>

        <label for="origin">Origin:</label>
        <input type="text" id="origin" name="origin" required><br>

        <label for="image">Product Image:</label>
        <input type="file" id="image" name="image" required><br>

        <button type="submit">Add Product</button>
    </form>
</body>
</html>
