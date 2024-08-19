package model;

import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO extends MyDAO {

    public List<Product> getWishlistItems(int accountId) {
    List<Product> wishlistItems = new ArrayList<>();
    String sql = "SELECT p.ProductID, p.ProductName, p.Price, pi.ImageURL, s.Size, s.Color, s.StockID "
               + "FROM Wishlist w "
               + "JOIN Stock s ON w.StockID = s.StockID "
               + "JOIN Products p ON s.ProductID = p.ProductID "
               + "JOIN ProductImages pi ON s.StockID = pi.StockID "
               + "WHERE w.AccountID = ?";

    try {
        ps = con.prepareStatement(sql);
        ps.setInt(1, accountId);
        rs = ps.executeQuery();
        while (rs.next()) {
            Product product = new Product();
            product.setProductId(rs.getInt("ProductID"));
            product.setProductName(rs.getString("ProductName"));
            product.setPrice(rs.getDouble("Price"));
            product.setImageURL(rs.getString("ImageURL"));
            product.setSize(rs.getInt("Size"));
            product.setColor(rs.getString("Color"));
            product.setStockID(rs.getInt("StockID")); // Set the stock ID
            wishlistItems.add(product);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return wishlistItems;
}


    
    
    
    public void removeFromWishlist(int accountId, int stockId) {
    try {
        xSql = "DELETE FROM Wishlist WHERE AccountID = ? AND StockID = ?";
        ps = con.prepareStatement(xSql);
        
        // Setting parameters
        ps.setInt(1, accountId);
        ps.setInt(2, stockId);

        System.out.println("Executing SQL: " + ps.toString());
        int rowsAffected = ps.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected);
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


}
