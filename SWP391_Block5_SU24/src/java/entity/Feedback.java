/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author asus
 */
import java.sql.Date;
import java.sql.Timestamp;

public class Feedback {
    private int productID;
    private int accountID;
    private String username;
    private String color;
    private int size;
    private int rating;
    private String comment;
    private java.sql.Date createdAt;
    
    private int feedbackId;
    private int customerId;
    
//    private Timestamp createdAt;

    public Feedback() {}

//    public Feedback(int feedbackId, int customerId, int productId, int rating, String comment, Timestamp createdAt) {
//        this.feedbackId = feedbackId;
//        this.customerId = customerId;
//        this.productId = productId;
//        this.rating = rating;
//        this.comment = comment;
//        this.createdAt = createdAt;
//    }

    public Feedback(int productID, int accountID, String username, String color, int size, int rating, String comment, Date createdAt) {
        this.productID = productID;
        this.accountID = accountID;
        this.username = username;
        this.color = color;
        this.size = size;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

//    public Timestamp getCreatedAt() {
//        return createdAt;
//    }
//
//    public void setCreatedAt(Timestamp createdAt) {
//        this.createdAt = createdAt;
//    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    
}

