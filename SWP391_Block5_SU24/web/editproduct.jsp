<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProductDetailsDAO"%>
<%@page import="entity.Product"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <!-- Include necessary styles and scripts here -->
</head>
<body>
    <h3>Edit Product</h3>
    <form action="EditProduct?id=${p.productId}" method="post">
        <input type="hidden" name="action" value="edit">
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" name="productName" value="${p.productName}" required>
        
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="${p.price}" required>        
        
        <!-- Add other fields as necessary -->
        
        <button type="submit">Save Changes</button>
        <a href="productmanage.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</body>
</html>
