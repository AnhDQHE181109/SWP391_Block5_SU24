<%@ page import="java.util.List" %>
<%@ page import="entity.Brand" %>
<%@ page import="entity.Category" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Discount</title>
    <!-- Include your CSS and JS files here -->
</head>
<body>
    <h2>Update Discount</h2>
    <form action="DiscountServlet" method="get">
        <input type="hidden" name="action" value="updateby">
        
        <label for="discount_amount">New Discount Amount:</label>
        <input type="number" name="discount_amount" id="discount_amount" step="0.01" required><br>

        <label for="brand">Brand:</label>
        <select name="brand_id" id="brand">
            <option value="">None</option>
            <% for (Brand brand : (List<Brand>) request.getAttribute("brands")) { %>
                <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName() %></option>
            <% } %>
        </select><br>

        <label for="category">Category:</label>
        <select name="category_id" id="category">
            <option value="">None</option>
            <% for (Category category : (List<Category>) request.getAttribute("categories")) { %>
                <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
            <% } %>
        </select><br>

        <input type="submit" value="Update Discount">
    </form>
</body>
</html>
