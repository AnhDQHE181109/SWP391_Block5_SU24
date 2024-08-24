/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;


/**
 *
 * @author asus
 */
public class Product {

    private int productId;
    private String productName;
    private double price;
    private String origin;
    private String material;
    private int totalQuantity;
    private int categoryId;
    private String categoryName;
    private String brandName; 
    private int brandId;
    private int importId;
    private int imageId;
    private String imageURL;
    private int size;
    private String color;
    private int stockID;
    private int stockQuantity;
    private String imageUrl;
    private Date dateAdded;
    private int wishlistedCount;
    private int productstatus;

    public int getProductStatus() {
        return productstatus;
    }

    public void setProductStatus(int productstatus) {
        this.productstatus = productstatus;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public Product() {
    }

    public Product(int productId, String productName, double price) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
    }

    public Product(int productId, String brandName, String productName, String categoryName, String imageURL, int productstatus) {
        this.productId = productId;
        this.brandName = brandName;
        this.productName = productName;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.productstatus = productstatus;
    }

    public Product(int stockID, int productID, String productName, int size, String color, int totalQuantity) {
        this.stockID = stockID;
        this.productId = productID;
        this.productName = productName;
        this.totalQuantity = totalQuantity;
        this.size = size;
        this.color = color;
    }

    public Product(int stockID, int productId, int size, String color, int stockQuantity) {
        this.stockID = stockID;
        this.productId = productId;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
    }
    public Product(String productName, String origin, String material, double price, int categoryId, int brandId, int productstatus){
        this.productName = productName;
        this.origin = origin;
        this.material = material;
        this.price = price;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.productstatus = productstatus;
    }
    public Product(String productName, String origin, String material, double price, String categoryName, String brandName){
        this.productName = productName;
        this.origin = origin;
        this.material = material;
        this.price = price;
        this.categoryName = categoryName;
        this.brandName = brandName;
    }
    public Product(int productId, String productName, String origin, String material, double price, int categoryId, int brandId){
        this.productId = productId;
        this.productName = productName;
        this.origin = origin;
        this.material = material;
        this.price = price;
        this.categoryId = categoryId;
        this.brandId = brandId;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
}

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
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

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public Date getDateAdded() {
        return dateAdded;
    }
    
    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

     public int getWishlistedCount() {
        return wishlistedCount;
    }

    public void setWishlistedCount(int wishlistedCount) {
        this.wishlistedCount = wishlistedCount;
    }
    
    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", price=" + price + ", origin=" + origin + ", material=" + material + ", totalQuantity=" + totalQuantity + ", categoryId=" + categoryId + ", brandId=" + brandId + ", importId=" + importId + ", imageId=" + imageId + ", imageURL=" + imageURL + ", size=" + size + ", color=" + color + '}';
    }


}
