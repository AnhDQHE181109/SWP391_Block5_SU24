package model;


import model.MyDAO;
import entity.Stock;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOStock extends MyDAO {

    // Add new stock
    public boolean addStock(Stock stock) {
        String sql = "INSERT INTO stock (productID, size, color, stockQuantity) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, stock.getProductID());
            ps.setInt(2, stock.getSize());
            ps.setString(3, stock.getColor());
            ps.setInt(4, stock.getStockQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get stock by ID
    public Stock getStockById(int stockID) {
        String sql = "SELECT * FROM stock WHERE stockID = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, stockID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Stock(
                    rs.getInt("stockID"),
                    rs.getInt("productID"),
                    rs.getInt("size"),
                    rs.getString("color"),
                    rs.getInt("stockQuantity")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update stock
    public boolean updateStock(Stock stock) {
        String sql = "UPDATE stock SET productID = ?, size = ?, color = ?, stockQuantity = ? WHERE stockID = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, stock.getProductID());
            ps.setInt(2, stock.getSize());
            ps.setString(3, stock.getColor());
            ps.setInt(4, stock.getStockQuantity());
            ps.setInt(5, stock.getStockID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete stock
    public boolean deleteStock(int stockID) {
        String sql = "DELETE FROM stock WHERE stockID = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, stockID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all stock
    public List<Stock> getAllStocks() {
        List<Stock> stock = new ArrayList<>();
        String sql = "SELECT * FROM stock";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stock.add(new Stock(
                    rs.getInt("stockID"),
                    rs.getInt("productID"),
                    rs.getInt("size"),
                    rs.getString("color"),
                    rs.getInt("stockQuantity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stock;
    }
    
    public boolean reduceStockQuantity(int stockID, int quantity) {
    // First, get the current stock quantity
    Stock stock = getStockById(stockID);
    if (stock == null) {
        return false; // Stock with the given ID does not exist
    }
    
    // Check if the reduction is possible
    int newQuantity = stock.getStockQuantity() - quantity;
    if (newQuantity < 0) {
        return false; // Not enough stock to reduce
    }

    // Update the stock quantity
    String sql = "UPDATE stock SET stockQuantity = ? WHERE stockID = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, newQuantity);
        ps.setInt(2, stockID);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
}
