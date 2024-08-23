/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

public class ProductStockImport {

    private int importID;
    private int accountID;
    private Date importDate;
    private int ImportAction;
    private String SupplierName;
    private String imageURL;
    private String productName;
    private String productColor;
    private int productSize;
    private int quantity;

    public ProductStockImport() {
    }

    public ProductStockImport(int importID, int accountID, Date importDate, int ImportAction, String SupplierName) {
        this.importID = importID;
        this.accountID = accountID;
        this.importDate = importDate;
        this.ImportAction = ImportAction;
        this.SupplierName = SupplierName;
    }

    public ProductStockImport(String imageURL, String SupplierName, String productName, String productColor, int productSize, int quantity) {
        this.imageURL = imageURL;
        this.SupplierName = SupplierName;
        this.productName = productName;
        this.productColor = productColor;
        this.productSize = productSize;
        this.quantity = quantity;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public int getImportAction() {
        return ImportAction;
    }

    public void setImportAction(int ImportAction) {
        this.ImportAction = ImportAction;
    }

    public String getSupplierName() {
        return SupplierName;
    }

    public void setSupplierName(String SupplierName) {
        this.SupplierName = SupplierName;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public int getProductSize() {
        return productSize;
    }

    public void setProductSize(int productSize) {
        this.productSize = productSize;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    

    @Override
    public String toString() {
        return "ProductStockImport{" + "importID=" + importID + ", accountID=" + accountID + ", importDate=" + importDate + ", ImportAction=" + ImportAction + ", SupplierName=" + SupplierName + '}';
    }

}
