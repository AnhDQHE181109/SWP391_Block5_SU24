/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class Stock {
    private int stockID;
    private int productID;
    private int size;
    private String color;
    private int stockQuantity;

    public Stock() {
    }

    public Stock(int stockID, int productID, int size, String color, int stockQuantity) {
        this.stockID = stockID;
        this.productID = productID;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
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

    @Override
    public String toString() {
        return "Stock{" + "stockID=" + stockID + ", productID=" + productID + ", size=" + size + ", color=" + color + ", stockQuantity=" + stockQuantity + '}';
    }

    

    
}