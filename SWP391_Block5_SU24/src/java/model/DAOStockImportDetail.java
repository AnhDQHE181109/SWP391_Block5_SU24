package model;

import entity.StockImportDetail;
import entity.StockImportSummary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOStockImportDetail extends MyDAO {

    // Create a new stock import detail
    public boolean createnew(StockImportDetail stockImportDetail) {
        String sql = "INSERT INTO StockImportDetail (stockID, [ImportID], stockQuantity) VALUES (?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockImportDetail.getStockID());
            ps.setInt(2, stockImportDetail.getImportID());
            ps.setInt(3, stockImportDetail.getStockQuantity());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Read a stock import detail by ID
    public StockImportDetail read(int stockImportDetailID) {
        String sql = "SELECT * FROM StockImportDetail WHERE stockImportDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockImportDetailID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToStockImportDetail(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update an existing stock import detail
    public boolean update(StockImportDetail stockImportDetail) {
        String sql = "UPDATE StockImportDetail SET stockID = ?, productStockImportID = ?, stockQuantity = ? WHERE stockImportDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockImportDetail.getStockID());
            ps.setInt(2, stockImportDetail.getImportID());
            ps.setInt(3, stockImportDetail.getStockQuantity());
            ps.setInt(4, stockImportDetail.getStockImportDetailID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a stock import detail by ID
    public boolean delete(int stockImportDetailID) {
        String sql = "DELETE FROM StockImportDetail WHERE stockImportDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockImportDetailID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all stock import details
    public List<StockImportDetail> getAll() {
        List<StockImportDetail> stockImportDetails = new ArrayList<>();
        String sql = "SELECT * FROM StockImportDetail";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                stockImportDetails.add(mapResultSetToStockImportDetail(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockImportDetails;
    }
    
    
        // Get stock import details by ImportID
    public List<StockImportDetail> getByImportID(int importID) {
        List<StockImportDetail> stockImportDetails = new ArrayList<>();
        String sql = "SELECT * FROM StockImportDetail WHERE importID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, importID);
            rs = ps.executeQuery();
            while (rs.next()) {
                stockImportDetails.add(mapResultSetToStockImportDetail(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockImportDetails;
    }

    // Map ResultSet to StockImportDetail object
    private StockImportDetail mapResultSetToStockImportDetail(ResultSet rs) throws SQLException {
        StockImportDetail stockImportDetail = new StockImportDetail();
        stockImportDetail.setStockImportDetailID(rs.getInt("stockImportDetailID"));
        stockImportDetail.setStockID(rs.getInt("stockID"));
        stockImportDetail.setImportID(rs.getInt("importID"));
        stockImportDetail.setStockQuantity(rs.getInt("stockQuantity"));
        return stockImportDetail;
    }
    
      public List<StockImportSummary> getStockImportSummary(int importID) throws SQLException {
        List<StockImportSummary> summaries = new ArrayList<>();
        String sql = """
            WITH StockBefore AS (
                SELECT 
                    s.ProductID,
                    s.StockQuantity AS StockBeforeImport
                FROM 
                    Stock s
                WHERE 
                    s.ProductID IN (
                        SELECT 
                            d.StockID 
                        FROM 
                            StockImportDetail d 
                        WHERE 
                            d.ImportID = ?
                    )
            ),
            StockAfter AS (
                SELECT 
                    s.ProductID,
                    CASE 
                        WHEN p.ImportAction = 0 THEN s.StockQuantity - COALESCE(d.StockQuantity, 0)
                        WHEN p.ImportAction = 1 THEN s.StockQuantity + COALESCE(d.StockQuantity, 0)
                    END AS StockAfterImport
                FROM 
                    Stock s
                LEFT JOIN 
                    StockImportDetail d ON s.ProductID = d.StockID AND d.ImportID = ?
                JOIN 
                    ProductStockImport p ON p.ImportID = ?
                WHERE 
                    s.ProductID IN (
                        SELECT 
                            d.StockID 
                        FROM 
                            StockImportDetail d 
                        WHERE 
                            d.ImportID = ?
                    )
            )
            SELECT 
                b.ProductID,
                b.StockBeforeImport,
                a.StockAfterImport
            FROM 
                StockBefore b
            JOIN 
                StockAfter a ON b.ProductID = a.ProductID
        """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, importID);
            ps.setInt(2, importID);
            ps.setInt(3, importID);
            ps.setInt(4, importID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    int stockBeforeImport = rs.getInt("StockBeforeImport");
                    int stockAfterImport = rs.getInt("StockAfterImport");

                    summaries.add(new StockImportSummary(productID, stockBeforeImport, stockAfterImport));
                }
            }
        }
        return summaries;
    }
    
    
}
