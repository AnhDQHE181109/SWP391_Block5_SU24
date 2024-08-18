/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class Category {
    private int categoryId;
    private String categoryName;
    private int categorystatus ; 

    public Category() {
    }

    public Category(int categoryId, String categoryName, int categorystatus) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categorystatus = categorystatus;
    }
    



    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getCategorystatus() {
        return categorystatus;
    }

    public void setCategorystatus(int categorystatus) {
        this.categorystatus = categorystatus;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", categoryName=" + categoryName + ", categorystatus=" + categorystatus + '}';
    }

    

}