<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Variant</title>
</head>
<body>
    <h2>Add Variant</h2>

    <form action="AddVariantController" method="post">
        <input type="text" name="productID" value="${param.productID}" />

        <!-- Container for color and image URL fields -->
        <div id="color-container">
            <!-- 5 fixed color and image URL fields -->
            <div>
                <label for="color0">Color 1:</label>
                <input type="text" name="colors[]" id="color0" required />
                <label for="imageURL0">Image URL 1:</label>
                <input type="text" name="imageURLs[]" id="imageURL0" required />
            </div>
            <div>
                <label for="color1">Color 2:</label>
                <input type="text" name="colors[]" id="color1" required />
                <label for="imageURL1">Image URL 2:</label>
                <input type="text" name="imageURLs[]" id="imageURL1" required />
            </div>
            <div>
                <label for="color2">Color 3:</label>
                <input type="text" name="colors[]" id="color2" required />
                <label for="imageURL2">Image URL 3:</label>
                <input type="text" name="imageURLs[]" id="imageURL2" required />
            </div>
            <div>
                <label for="color3">Color 4:</label>
                <input type="text" name="colors[]" id="color3" required />
                <label for="imageURL3">Image URL 4:</label>
                <input type="text" name="imageURLs[]" id="imageURL3" required />
            </div>
            <div>
                <label for="color4">Color 5:</label>
                <input type="text" name="colors[]" id="color4" required />
                <label for="imageURL4">Image URL 5:</label>
                <input type="text" name="imageURLs[]" id="imageURL4" required />
            </div>
        </div>

        <input type="submit" value="Add Variant" />
    </form>
</body>
</html>
