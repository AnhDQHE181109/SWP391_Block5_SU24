/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;

public class Discount implements Serializable {
    
    private int discountID;
    private int productID;
    private double discountAmount;

    public Discount() {
    }

    public Discount(int discountID, int productID, double discountAmount) {
        this.discountID = discountID;
        this.productID = productID;
        this.discountAmount = discountAmount;
    }

    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    @Override
    public String toString() {
        return "Discount{" + "discountID=" + discountID + ", productID=" + productID + ", discountAmount=" + discountAmount + '}';
    }

    

    
}
