/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Date;

public class Cart implements Serializable {
    
    private int cartID;
    private Account customer;
    private int stockID;
    private int quantity;
    private double discount;
    private Date dateAdded;

    // Getters and Setters
}
