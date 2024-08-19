/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;
import java.util.Date;

public class Products {

    private int productId;
    private String productName;
    private String Origin;
    private String Material ; 
    private double Price;
    private int TotalQuantity;
    private int CategoryID ; 
    private int  BrandID;
    private int ImageID ; 
    private int ProductStatus;
    private Date dateAdded;

    // Constructor không tham số
    public Products() {
    }

    public Products(int productId, String productName, String Origin, String Material, double Price, int TotalQuantity, int CategoryID, int BrandID, int ImageID, int ProductStatus) {
        this.productId = productId;
        this.productName = productName;
        this.Origin = Origin;
        this.Material = Material;
        this.Price = Price;
        this.TotalQuantity = TotalQuantity;
        this.CategoryID = CategoryID;
        this.BrandID = BrandID;
        this.ImageID = ImageID;
        this.ProductStatus = ProductStatus;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getOrigin() {
        return Origin;
    }

    public void setOrigin(String Origin) {
        this.Origin = Origin;
    }

    public String getMaterial() {
        return Material;
    }

    public void setMaterial(String Material) {
        this.Material = Material;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public int getTotalQuantity() {
        return TotalQuantity;
    }

    public void setTotalQuantity(int TotalQuantity) {
        this.TotalQuantity = TotalQuantity;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public int getBrandID() {
        return BrandID;
    }

    public void setBrandID(int BrandID) {
        this.BrandID = BrandID;
    }

    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int ImageID) {
        this.ImageID = ImageID;
    }

    public int getProductStatus() {
        return ProductStatus;
    }

    public void setProductStatus(int ProductStatus) {
        this.ProductStatus = ProductStatus;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", Origin=" + Origin + ", Material=" + Material + ", Price=" + Price + ", TotalQuantity=" + TotalQuantity + ", CategoryID=" + CategoryID + ", BrandID=" + BrandID + ", ImageID=" + ImageID + ", ProductStatus=" + ProductStatus + '}';
    }
    

   }
