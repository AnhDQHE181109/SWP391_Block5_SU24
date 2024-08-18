/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.Product;
import entity.Wishlist;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
/**
 *
 * @author nobbe
 */
public class WishlistDAO extends MyDAO{
    
    public List<Product> getWishlistItems(int accountId) {
        List<Product> wishlistItems = new ArrayList<>();
    String sql = "SELECT p.*, w.DateAdded FROM Wishlist w JOIN Stock s ON w.StockID = s.StockID "
               + "JOIN Products p ON s.ProductID = p.ProductID WHERE w.AccountID = ?";

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
            wishlistItems.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return wishlistItems;
}
    
   public List<Product> searchWishlistItemsByName(int accountId, String search) {
    List<Product> wishlistItems = new ArrayList<>();
    String sql = "SELECT p.* FROM Wishlist w JOIN Stock s ON w.StockID = s.StockID "
               + "JOIN Products p ON s.ProductID = p.ProductID WHERE w.AccountID = ? AND p.ProductName LIKE ?";

    try (Connection con = this.con;
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setInt(1, accountId);
        ps.setString(2, "%" + search + "%");

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                // Map the result set to the product entity
                wishlistItems.add(product);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return wishlistItems;
    }
}
