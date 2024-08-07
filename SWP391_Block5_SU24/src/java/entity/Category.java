/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class Category {
    private int categoryId;
    private String categoryName;
    
    public Category(){
        
    }
    public Category(int categoryId, String categoryName){
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }
    // Getters and setters
    public int getCategoryId(){
        return categoryId;
    }
    public void setCategoryId(int catrgoryId) {
       this.categoryId = categoryId;
    }
    public String getCategoryName(){
        return categoryName;
    }
    public void setCategoryName(String string) {
        this.categoryName = categoryName;
    }
}