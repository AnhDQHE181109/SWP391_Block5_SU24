/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class Category {
    private int categoryId;
    private String categoryName;

<<<<<<< Updated upstream

    public int getCategoryId() {
        return categoryId;
=======
    public Category() {
    }

    public Category(int categoryID, String categoryName) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
>>>>>>> Stashed changes
    }

    public String getCategoryName() {
        return categoryName;
    }

<<<<<<< Updated upstream
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

=======
>>>>>>> Stashed changes
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
}