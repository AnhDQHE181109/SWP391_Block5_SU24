<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Image</title>
    <script>
        // Function to close the window and pass the image URL back to the parent page
        function closeWindow(imageUrl) {
            if (imageUrl) {
                window.opener.setImageUrl(imageUrl);
                window.close();
            }
        }
    </script>
</head>
<body>
    <h1>Upload Image</h1>

    <!-- Form to upload the image -->
    <form action="${pageContext.request.contextPath}/UploadImageController" method="post" enctype="multipart/form-data">
        <label for="imageFile">Select Image:</label>
        <input type="file" id="imageFile" name="imageFile" accept="image/*" required /><br/><br/>
        
        <input type="submit" value="Upload" />
    </form>

    <!-- Check if the imageUrl is set, then close the window -->
    <c:if test="${not empty imageUrl}">
        <script>
            closeWindow("${imageUrl}");
        </script>
    </c:if>
</body>
</html>
