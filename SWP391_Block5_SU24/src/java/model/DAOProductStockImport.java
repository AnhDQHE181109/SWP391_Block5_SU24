package model;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.ProductStockImport;

public class DAOProductStockImport extends MyDAO {

    // Constructor
    public DAOProductStockImport() {
        super();
    }

 // Method to add a ProductStockImport to the database
    public boolean addProductStockImport(ProductStockImport stockImport) {
        xSql = "INSERT INTO ProductStockImport (AccountID,ImportDate, ImportAction, Actorname) VALUES (?, GETDATE(), ?, ?)";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, stockImport.getAccountID());
            ps.setInt(2, stockImport.getImportAction());
            ps.setString(3, stockImport.getActorname());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }




    // Method to retrieve all ProductStockImport records
    public List<ProductStockImport> getAllProductStockImports() {
        List<ProductStockImport> stockImports = new ArrayList<>();
        xSql = "SELECT * FROM ProductStockImport ORDER BY ImportDate DESC";
        
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                stockImport.setImportAction(rs.getInt("ImportAction"));
                stockImport.setActorname(rs.getString("Actorname"));


                stockImports.add(stockImport);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return stockImports;
    }
    
        // Method to retrieve all ProductStockImport records
    public List<ProductStockImport> getAllProductStockImportsTOP1() {
        List<ProductStockImport> stockImports = new ArrayList<>();
        xSql = "SELECT TOP 1* FROM ProductStockImport ORDER BY [ImportID] DESC";
        
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                stockImport.setImportAction(rs.getInt("ImportAction"));
                stockImport.setActorname(rs.getString("Actorname"));


                stockImports.add(stockImport);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return stockImports;
    }

    // Method to update a ProductStockImport record
    public boolean updateProductStockImport(ProductStockImport stockImport) {
        xSql = "UPDATE ProductStockImport SET AccountID = ?, ImportDate = ? WHERE ImportID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, stockImport.getAccountID());
            ps.setDate(2, new Date(stockImport.getImportDate().getTime()));
            ps.setInt(3, stockImport.getImportID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // Method to delete a ProductStockImport record by ID
    public boolean deleteProductStockImport(int importId) {
        xSql = "DELETE FROM ProductStockImport WHERE ImportID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, importId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // Method to retrieve a ProductStockImport record by ID
    public ProductStockImport getProductStockImportById(int importId) {
        xSql = "SELECT * FROM ProductStockImport WHERE ImportID = ?";
        ProductStockImport stockImport = null;

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, importId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                stockImport.setImportAction(rs.getInt("ImportAction"));
                stockImport.setActorname(rs.getString("Actorname"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return stockImport;
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


 // Method to get ProductStockImport records by a list of account IDs
    public List<ProductStockImport> getProductStockImportsByAccountIDs(List<Integer> accountIDs) throws SQLException {
        List<ProductStockImport> stockImports = new ArrayList<>();
        
        if (accountIDs == null || accountIDs.isEmpty()) {
            return stockImports; // Return empty list if no account IDs are provided
        }
        
        // Construct SQL query with placeholders for account IDs
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM ProductStockImport WHERE AccountID IN (");
        for (int i = 0; i < accountIDs.size(); i++) {
            queryBuilder.append("?");
            if (i < accountIDs.size() - 1) {
                queryBuilder.append(", ");
            }
        }
        queryBuilder.append(") ORDER BY ImportDate DESC");
        
        String query = queryBuilder.toString();
        
        try {
            ps = con.prepareStatement(query);
            
            // Set account IDs in the prepared statement
            for (int i = 0; i < accountIDs.size(); i++) {
                ps.setInt(i + 1, accountIDs.get(i));
            }
            
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                // Add more fields as needed
                
                stockImports.add(stockImport);
            }
        } finally {
            closeResources(); // Ensure resources are closed
        }
        
        return stockImports;
    }
    
     public List<ProductStockImport> getProductStockImportsByDateRange(Date startDate, Date endDate) {
        List<ProductStockImport> stockImports = new ArrayList<>();
        xSql = "SELECT * FROM ProductStockImport WHERE ImportDate BETWEEN ? AND ?  ORDER BY ImportDate DESC";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                
                stockImports.add(stockImport);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return stockImports;
    }

    // You might also want to add a method to get imports for a specific date
    public List<ProductStockImport> getProductStockImportsByDate(Date date) {
        List<ProductStockImport> stockImports = new ArrayList<>();
        xSql = "SELECT * FROM ProductStockImport WHERE ImportDate = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, date);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));
                
                stockImports.add(stockImport);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return stockImports;
    }

public List<ProductStockImport> getAllProductStockImportssort(String sortOrder) {
    List<ProductStockImport> stockImports = new ArrayList<>();
    String xSql = "SELECT * FROM ProductStockImport ORDER BY ImportDate " + sortOrder;

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductStockImport stockImport = new ProductStockImport();
                stockImport.setImportID(rs.getInt("ImportID"));
                stockImport.setAccountID(rs.getInt("AccountID"));
                stockImport.setImportDate(rs.getDate("ImportDate"));

                stockImports.add(stockImport);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return stockImports;
    }
}




