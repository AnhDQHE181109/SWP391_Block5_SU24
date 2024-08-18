/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;


public class StockImportDetail implements Serializable {

    private int stockImportDetailID;
    private int stockID;
    private int importID;
    private int stockQuantity;

    public StockImportDetail() {
    }

    public StockImportDetail(int stockImportDetailID, int stockID, int importID, int stockQuantity) {
        this.stockImportDetailID = stockImportDetailID;
        this.stockID = stockID;
        this.importID = importID;
        this.stockQuantity = stockQuantity;
    }

    public int getStockImportDetailID() {
        return stockImportDetailID;
    }

    public void setStockImportDetailID(int stockImportDetailID) {
        this.stockImportDetailID = stockImportDetailID;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

      

    
}
