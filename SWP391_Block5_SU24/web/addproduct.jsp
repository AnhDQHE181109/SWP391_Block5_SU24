<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Category" %>
<%@ page import="entity.Brand" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>

<%
    CategoryDAO categoryDAO = new CategoryDAO();
    BrandDAO brandDAO = new BrandDAO();
    List<Category> categories = categoryDAO.getAllCategories();
    List<Brand> brands = brandDAO.getAllBrands();
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Product</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <button name="goBack" class="btn btn-success" id="goBack" onclick="history.back()">Go back</button>
            <h3 class="mt-5">Add Product</h3>
            <form action="AddProductController" method="post">
                <%
                    String productNameError = (String) request.getAttribute("productNameError");
                    String priceError = (String) request.getAttribute("priceError");
                    String validationError = (String) request.getAttribute("validationError");
                %>

                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" required>
                    <% if (productNameError != null) { %>
                    <div class="text-danger"><%= productNameError %></div>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="origin">Origin</label>
                    <input type="text" class="form-control" id="origin" name="origin" required>
                    <% if (validationError != null) { %>
                    <div class="text-danger"><%= validationError %></div>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" class="form-control" id="price" name="price" required min="0" max="100000000" step="0.01">
                    <% if (priceError != null) { %>
                    <div class="text-danger"><%= priceError %></div>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select class="form-control" id="categoryId" name="categoryId">
                        <%
                            for (Category category : categories) {
                        %>
                        <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="brandId">Brand</label>
                    <select class="form-control" id="brandId" name="brandId">
                        <%
                            for (Brand brand : brands) {
                        %>
                        <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="material">Material</label>
                    <input type="text" class="form-control" id="material" name="material" required>
                    <% if (validationError != null) { %>
                    <div class="text-danger"><%= validationError %></div>
                    <% } %>
                </div>
                <div class="button-group">
                    <input type="submit" value="Add" class="btn btn-primary">
                    <input type="reset" value="Reset" class="btn btn-secondary">
                </div>
            </form>
        </div>

        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
