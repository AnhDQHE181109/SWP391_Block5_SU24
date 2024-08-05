/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author asus
 */
import java.math.BigDecimal;
import java.sql.Date;

public class Discount {
    private int discountId;
    private int productId;
    private int sizeId;
    private int colorId;
    private BigDecimal discountValue;
    private Date startDate;
    private Date endDate;

    public Discount() {}

    public Discount(int discountId, int productId, int sizeId, int colorId, BigDecimal discountValue, Date startDate, Date endDate) {
        this.discountId = discountId;
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.discountValue = discountValue;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters and Setters
    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}

