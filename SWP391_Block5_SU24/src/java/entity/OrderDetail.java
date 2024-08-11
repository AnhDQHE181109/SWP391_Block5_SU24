/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;


import java.io.Serializable;

public class OrderDetail implements Serializable {
    

    private int orderDetailID;
    private int  orderID;
    private int stockID;
    private int quantity;
    private double salePrice;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailID, int orderID, int stockID, int quantity, double salePrice) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.stockID = stockID;
        this.quantity = quantity;
        this.salePrice = salePrice;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

        
}
