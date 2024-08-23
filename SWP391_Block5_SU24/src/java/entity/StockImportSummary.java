/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author asus
 */
public class StockImportSummary {
    private int productID;
    private int stockBeforeImport;
    private int stockAfterImport;

    public StockImportSummary(int productID, int stockBeforeImport, int stockAfterImport) {
        this.productID = productID;
        this.stockBeforeImport = stockBeforeImport;
        this.stockAfterImport = stockAfterImport;
    }

    // Getter và Setter
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getStockBeforeImport() {
        return stockBeforeImport;
    }

    public void setStockBeforeImport(int stockBeforeImport) {
        this.stockBeforeImport = stockBeforeImport;
    }

    public int getStockAfterImport() {
        return stockAfterImport;
    }

    public void setStockAfterImport(int stockAfterImport) {
        this.stockAfterImport = stockAfterImport;
    }

    @Override
    public String toString() {
        return "StockImportSummary{" +
                "productID=" + productID +
                ", stockBeforeImport=" + stockBeforeImport +
                ", stockAfterImport=" + stockAfterImport +
                '}';
    }
}

