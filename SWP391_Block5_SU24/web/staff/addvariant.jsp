<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product Variant</title>
    <script>
        function validateForm() {
            const colorInputs = document.querySelectorAll('input[name="colors[]"]');
            const imageURLInputs = document.querySelectorAll('input[name="imageURLs[]"]');

            // Regular expression to check for special characters and multiple spaces
            const specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/g;
            const multipleSpacesRegex = /\s{2,}/g;
            const colorSet = new Set();

            for (let i = 0; i < colorInputs.length; i++) {
                const color = colorInputs[i].value.trim();

                // Kiểm tra rỗng
                if (color === "") {
                    alert("Color field cannot be empty.");
                    return false;
                }

                // Kiểm tra ký tự đặc biệt
                if (specialCharRegex.test(color)) {
                    alert("Color field cannot contain special characters.");
                    return false;
                }

                // Kiểm tra khoảng trắng liên tục
                if (multipleSpacesRegex.test(color)) {
                    alert("Color field cannot contain consecutive spaces.");
                    return false;
                }

                // Kiểm tra trùng màu
                if (colorSet.has(color.toLowerCase())) {
                    alert("Duplicate colors are not allowed.");
                    return false;
                }
                colorSet.add(color.toLowerCase());

                // Kiểm tra URL hình ảnh
                const imageURL = imageURLInputs[i].value.trim();
                if (imageURL === "") {
                    alert("Image URL cannot be empty.");
                    return false;
                }
            }

            return true;
        }
    </script>
</head>
<body>
    <h2>Add Product Variants</h2>
    <form action="AddVariantController" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="productID" value="${productID}">
        
        <!-- Add a hidden input to specify the action -->
        <input type="hidden" name="action" value="create">
        
        <table>
            <tr>
                <th>Color</th>
                <th>Image URL</th>
            </tr>
            <%-- Loop to create 5 rows for color and image URL inputs --%>
            <%
                for (int i = 0; i < 5; i++) {
            %>
            <tr>
                <td>
                    <input type="text" name="colors[]" placeholder="Enter color" required>
                </td>
                <td>
                    <input type="text" name="imageURLs[]" placeholder="Enter image URL" required>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <br>
        <input type="submit" value="Add Variants">
        <!-- Return button -->
        <button type="button" onclick="returnProduct()">Return</button>
    </form>

    <script>
        function returnProduct() {
            var productID = document.querySelector('input[name="productID"]').value;
            window.location.href = 'AddVariantController?service=delete&productID=' + productID;
        }
    </script>
</body>
</html>
