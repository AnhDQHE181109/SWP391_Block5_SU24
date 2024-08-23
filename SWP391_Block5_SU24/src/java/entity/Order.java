/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

public class Order {
    private int orderID;
    private Integer accountID;
    private Date orderDate;
    private String status;
    private String productname;
    private double saleprice;
    private String imageURL;
    private int quantity;
    private double producttotal;
    private double ordertotal;

    public String getProductName() {
        return productname;
    }

    public double getSalePrice() {
        return saleprice;
    }

    public String getImageUrl() {
        return imageURL;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getProducttotal() {
        return producttotal;
    }

    public double getOrdertotal() {
        return ordertotal;
    }

    public void setProductName(String productname) {
        this.productname = productname;
    }

    public void setSalePrice(double saleprice) {
        this.saleprice = saleprice;
    }

    public void setImageUrl(String imageURL) {
        this.imageURL = imageURL;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setProducttotal(double producttotal) {
        this.producttotal = producttotal;
    }

    public void setOrdertotal(double ordertotal) {
        this.ordertotal = ordertotal;
    }
    
    public Order() {
    }

    public Order(int orderID, Integer accountID, Date orderDate, String status) {
        this.orderID = orderID;
        this.accountID = accountID;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Integer getAccountID() {
        return accountID;
    }

    public void setAccountID(Integer accountID) {
        this.accountID = accountID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
}
