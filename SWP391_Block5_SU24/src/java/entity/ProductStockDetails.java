/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author ASUS
 */
public class ProductStockDetails {
    private int productID;
    private int size;
    private String color;
    private int stockQuantity;
    private String imageURL;

    public ProductStockDetails(int productID, int size, String color, int stockQuantity, String imageURL) {
        this.productID = productID;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
        this.imageURL = imageURL;
    }

    public ProductStockDetails(int productID, String color, String imageURL) {
        this.productID = productID;
        this.color = color;
        this.imageURL = imageURL;
    }

    public ProductStockDetails(int size, int stockQuantity) {
        this.size = size;
        this.stockQuantity = stockQuantity;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
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

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
    
}
