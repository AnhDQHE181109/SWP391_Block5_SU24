<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product Variant</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin-top: 20px;
        }
        .table th, .table td {
            text-align: center;
        }
    </style>
    <script>
        function validateForm() {
            const colorInputs = document.querySelectorAll('input[name="colors[]"]');
            const imageURLInputs = document.querySelectorAll('input[name="imageURLs[]"]');
            const specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/g;
            const multipleSpacesRegex = /\s{2,}/g;
            const colorSet = new Set();

            for (let i = 0; i < colorInputs.length; i++) {
                const color = colorInputs[i].value.trim();

                if (color === "") {
                    alert("Color field cannot be empty.");
                    return false;
                }

                if (specialCharRegex.test(color)) {
                    alert("Color field cannot contain special characters.");
                    return false;
                }

                if (multipleSpacesRegex.test(color)) {
                    alert("Color field cannot contain consecutive spaces.");
                    return false;
                }

                if (colorSet.has(color.toLowerCase())) {
                    alert("Duplicate colors are not allowed.");
                    return false;
                }
                colorSet.add(color.toLowerCase());

                const imageURL = imageURLInputs[i].value.trim();
                if (imageURL === "") {
                    alert("Image URL cannot be empty.");
                    return false;
                }
            }

            return true;
        }

        function returnProduct() {
            window.location.href = 'stocksManager'; // Thay đổi liên kết tại đây
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4">Add Product Variants</h2>
        <form action="AddVariantController" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="productID" value="${productID}">
            <input type="hidden" name="action" value="create">

            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Color</th>
                        <th>Image URL</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Loop to create 5 rows for color and image URL inputs --%>
                    <%
                        for (int i = 0; i < 5; i++) {
                    %>
                    <tr>
                        <td>
                            <input type="text" class="form-control" name="colors[]" placeholder="Enter color" required>
                        </td>
                        <td>
                            <input type="text" class="form-control" name="imageURLs[]" placeholder="Enter image URL" required>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Add Variants</button>
                <button type="button" class="btn btn-secondary" onclick="returnProduct()">Return</button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
