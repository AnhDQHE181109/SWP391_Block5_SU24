/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;

/**
 *
 * @author asus
 */
public class Product {

    private int productId;
    private String productName;
    private BigDecimal price;
    private String origin;
    private String material;
    private int totalQuantity;
    private int categoryId;
    private int brandId;
    private int importId;
    private int imageId;
    private String imageURL;
    private int size;
    private String color;

    public Product() {
    }

    public Product(int productId, String productName, BigDecimal price) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
    }

    public Product(int productId, String productName, String imageURL) {
        this.productId = productId;
        this.productName = productName;
        this.imageURL = imageURL;
    }

    public Product(int productID, String productName, int size, String color, int totalQuantity) {
        this.productId = productID;
        this.productName = productName;
        this.totalQuantity = totalQuantity;
        this.size = size;
        this.color = color;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getImportId() {
        return importId;
    }

    public void setImportId(int importId) {
        this.importId = importId;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", price=" + price + ", origin=" + origin + ", material=" + material + ", totalQuantity=" + totalQuantity + ", categoryId=" + categoryId + ", brandId=" + brandId + ", importId=" + importId + ", imageId=" + imageId + ", imageURL=" + imageURL + ", size=" + size + ", color=" + color + '}';
    }


}
