<%-- 
    Document   : editproduct
    Created on : Aug 24, 2024, 7:32:09 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="entity.Product"%>
<%@page import="model.ProductDetailsDAO"%>

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDetailsDAO dao = new ProductDetailsDAO();
    Product product = dao.getProductById(productId);
    List<Brand> brands = dao.getAllBrands();
    List<Category> categories = dao.getAllCategories();
%>

<form action="EditProductController" method="post">
    <input type="hidden" name="productId" value="<%= product.getProductId() %>">

    <label for="productName">Product Name:</label>
    <input type="text" name="productName" value="<%= product.getProductName() %>"><br>

    <label for="origin">Origin:</label>
    <input type="text" name="origin" value="<%= product.getOrigin() %>"><br>

    <label for="material">Material:</label>
    <input type="text" name="material" value="<%= product.getMaterial() %>"><br>

    <label for="price">Price:</label>
    <input type="number" name="price" value="<%= product.getPrice() %>" step="0.01"><br>

    <label for="brandId">Brand:</label>
    <select name="brandId">
        <% for (Brand brand : brands) { %>
        <option value="<%= brand.getBrandId() %>" <%= product.getBrandId() == brand.getBrandId() ? "selected" : "" %>><%= brand.getBrandName() %></option>
        <% } %>
    </select><br>

    <label for="categoryId">Category:</label>
    <select name="categoryId">
        <% for (Category category : categories) { %>
        <option value="<%= category.getCategoryId() %>" <%= product.getCategoryId() == category.getCategoryId() ? "selected" : "" %>><%= category.getCategoryName() %></option>
        <% } %>
    </select><br>

    <button type="submit">Save Changes</button>
</form>
