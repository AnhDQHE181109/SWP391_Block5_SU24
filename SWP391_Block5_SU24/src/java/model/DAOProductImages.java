package model;

import entity.ProductImage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOProductImages extends MyDAO {

    // Constructor
    public DAOProductImages() {
        super();
    }

    // Method to add a new ProductImage
    public boolean addProductImage(ProductImage productImage) {
        boolean result = false;
        String sql = "INSERT INTO ProductImages (imageID, stockID, imageURL) VALUES (?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, productImage.getImageID());
            ps.setInt(2, productImage.getStockID());
            ps.setString(3, productImage.getImageURL());
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return result;
    }

    // Method to update a ProductImage
    public boolean updateProductImage(ProductImage productImage) {
        boolean result = false;
        String sql = "UPDATE ProductImages SET stockID = ?, imageURL = ? WHERE imageID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, productImage.getStockID());
            ps.setString(2, productImage.getImageURL());
            ps.setInt(3, productImage.getImageID());
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return result;
    }

    // Method to delete a ProductImage by imageID
    public boolean deleteProductImage(int imageID) {
        boolean result = false;
        String sql = "DELETE FROM ProductImages WHERE imageID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, imageID);
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return result;
    }

    // Method to get a ProductImage by imageID
    public ProductImage getProductImage(int imageID) {
        ProductImage productImage = null;
        String sql = "SELECT * FROM ProductImages WHERE imageID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, imageID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int stockID = rs.getInt("stockID");
                String imageURL = rs.getString("imageURL");
                
                productImage = new ProductImage(imageID, stockID, imageURL);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return productImage;
    }

    // Method to close resources
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
