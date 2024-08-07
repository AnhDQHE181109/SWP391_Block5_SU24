<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Category" %>
<%@ page import="entity.Brand" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
</head>
<body>
    <form action="addproduct" method="post">
        <div>
            <label for="categoryId" class="form-label">Category</label>
            <select class="form-control" id="categoryId" name="categoryId">
                <%
                    List<Category> categories = (List<Category>) request.getAttribute("category");
                    for (Category category : category) {
                %>
                    <option value="<%=category.getCategoryId()%>"><%=category.getCategoryName()%></option>
                <%
                    }
                %>
            </select>
        </div>
        <div>
            <label for="brandId" class="form-label">Brand</label>
            <select class="form-control" id="brandId" name="brandId">
                <%
                    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
                    for (Brand brand : brands) {
                %>
                    <option value="<%=brand.getBrandId()%>"><%=brand.getBrandName()%></option>
                <%
                    }
                %>
            </select>
        </div>
        <!-- Add other form fields here -->
        <button type="submit">Add Product</button>
    </form>
</body>
</html>
