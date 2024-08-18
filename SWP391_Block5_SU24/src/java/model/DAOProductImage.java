package model;

import java.sql.SQLException;

public class DAOProductImage extends MyDAO {
    
    // Constructor
    public DAOProductImage() {
        super();
    }

    // Method to add a new image to the database for a given product
    public boolean addProductImage(int productId, String imagePath) {
        boolean isSuccess = false;
        try {
            String sql = "INSERT INTO ProductImages (product_id, image_path) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setString(2, imagePath);
            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to retrieve the image path for a given product
    public String getProductImage(int productId) {
        String imagePath = null;
        try {
            String sql = "SELECT image_path FROM ProductImages WHERE product_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                imagePath = rs.getString("image_path");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return imagePath;
    }

    // Method to update the image path for a given product
    public boolean updateProductImage(int productId, String newImagePath) {
        boolean isSuccess = false;
        try {
            String sql = "UPDATE ProductImages SET image_path = ? WHERE product_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, newImagePath);
            ps.setInt(2, productId);
            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to delete an image entry for a given product
    public boolean deleteProductImage(int productId) {
        boolean isSuccess = false;
        try {
            String sql = "DELETE FROM ProductImages WHERE product_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Close resources to prevent memory leaks
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
