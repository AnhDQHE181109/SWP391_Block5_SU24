package model;

import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO extends MyDAO {

    public List<Product> getWishlistItems(int accountId, String sort) {
        List<Product> wishlistItems = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, pi.ImageURL, s.Size, s.Color, s.StockID, w.DateAdded "
                   + "FROM Wishlist w "
                   + "JOIN Stock s ON w.StockID = s.StockID "
                   + "JOIN Products p ON s.ProductID = p.ProductID "
                   + "JOIN ProductImages pi ON s.StockID = pi.StockID "
                   + "WHERE w.AccountID = ? ";

        // Append ORDER BY clause based on the sort parameter
        if (sort != null) {
            switch (sort) {
                case "name_asc":
                    sql += "ORDER BY p.ProductName ASC";
                    break;
                case "name_desc":
                    sql += "ORDER BY p.ProductName DESC";
                    break;
                case "price_asc":
                    sql += "ORDER BY p.Price ASC";
                    break;
                case "price_desc":
                    sql += "ORDER BY p.Price DESC";
                    break;
                case "date_asc":
                    sql += "ORDER BY w.DateAdded ASC";
                    break;
                case "date_desc":
                    sql += "ORDER BY w.DateAdded DESC";
                    break;
                default:
                    sql += "ORDER BY p.ProductName ASC"; // Default sort
                    break;
            }
        } else {
            sql += "ORDER BY p.ProductName ASC"; // Default sort
        }

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
                product.setDateAdded(rs.getTimestamp("DateAdded"));
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
    
    
    public List<Product> getTopWishlistedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 5 p.ProductID, p.ProductName, pi.ImageURL, s.Color, s.Size, COUNT(DISTINCT w.StockID) AS WishlistedCount "
                   + "FROM Wishlist w "
                   + "JOIN Stock s ON w.StockID = s.StockID "
                   + "JOIN Products p ON s.ProductID = p.ProductID "
                   + "JOIN ProductImages pi ON s.StockID = pi.StockID "
                   + "GROUP BY p.ProductID, p.ProductName, pi.ImageURL, s.Color, s.Size "
                   + "ORDER BY WishlistedCount DESC";

        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setColor(rs.getString("Color"));
                product.setSize(rs.getInt("Size"));
                product.setWishlistedCount(rs.getInt("WishlistedCount"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return products;
    }

    public List<Product> searchWishlistItemsByName(int accountID, String search) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }


}
