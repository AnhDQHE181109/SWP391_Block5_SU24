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
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, pi.ImageURL, s.Size, s.Color "
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
                wishlistItems.add(product);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return wishlistItems;
    }

    public List<Product> searchWishlistItemsByName(int accountId, String search) {
        List<Product> wishlistItems = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, p.ImageURL, s.Size, s.Color "
                + "FROM Wishlist w "
                + "JOIN Stock s ON w.StockID = s.StockID "
                + "JOIN Products p ON s.ProductID = p.ProductID "
                + "WHERE w.AccountID = ? AND p.ProductName LIKE ?";

        try (Connection con = this.conn; PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setString(2, "%" + search + "%");

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishlistItems;
    }
}
