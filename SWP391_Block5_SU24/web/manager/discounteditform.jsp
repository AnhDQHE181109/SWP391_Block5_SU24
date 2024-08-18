<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Discount</title>
    <link rel="stylesheet" type="text/css" href="path/to/your/styles.css"> <!-- Thay đổi đường dẫn nếu cần -->
    <script type="text/javascript">
        function validateForm() {
            var discountAmount = document.getElementById("discount_amount").value;

            // Kiểm tra không được để rỗng
            if (discountAmount.trim() === "") {
                alert("Discount amount cannot be empty or contain only spaces.");
                return false;
            }

            // Kiểm tra không được là ký tự đặc biệt và chữ
            var numberPattern = /^[0-9]+$/;
            if (!numberPattern.test(discountAmount)) {
                alert("Discount amount must be a number and cannot contain letters or special characters.");
                return false;
            }

            // Kiểm tra không được quá 100
            if (parseInt(discountAmount) > 100) {
                alert("Discount amount cannot be more than 100.");
                return false;
            }

            return true; // Nếu tất cả kiểm tra đều ok, cho phép gửi form
        }
    </script>
</head>
<body>
    <h2>Edit Discount for ${productName}</h2> <!-- Display the product name here -->

    <c:choose>
        <c:when test="${not empty discountList}">
            <form action="DiscountServlet" method="post" onsubmit="return validateForm();">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="discountID" value="${discountList.discountID}">

                <label for="product_id">Product ID:</label>
                <input type="text" id="product_id" name="product_id" value="${discountList.productID}" readonly><br><br>

                <label for="product_name">Product Name:</label>
                <input type="text" id="product_name" name="product_name" value="${productName}" readonly><br><br> <!-- New field for product name -->

                <label for="discount_amount">Discount Amount:</label>
                <input type="text" id="discount_amount" name="discount_amount" value="${discountList.discountAmount}"><br><br>

                <input type="submit" value="Update Discount">
                <div><a href="DiscountServlet?action=list">Cancel</a></div>
            </form>
        </c:when>
    </c:choose>
</body>
</html>
