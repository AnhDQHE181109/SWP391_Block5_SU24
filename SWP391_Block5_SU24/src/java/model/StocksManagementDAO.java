/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import entity.Stock;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class StocksManagementDAO extends DBConnect {

public static void main(String[] args) {
    StocksManagementDAO smDAO = new StocksManagementDAO();

    // Tạo một danh sách các Stock đã được cập nhật
    List<Stock> updatedStocks = new ArrayList<>();
    
    // Tạo một Stock mới (giả sử stockID là 5)
    Stock stock = new Stock(5, 1, 45, "White", 20);
    // Trong đó: 5 là stockID, 1 là productID, 45 là size, "White" là color, 20 là stockQuantity
    
    updatedStocks.add(stock);

    // Gọi phương thức logUpdatedStocks với accountID là 3
    smDAO.logUpdatedStocks(3, updatedStocks);
}


    public List<Product> getAllProducts() {
        String sql = "SELECT p.ProductID, ProductName, Origin, Material, Price, TotalQuantity, "
                + "CategoryID, BrandID, ImageID, ProductStatus, BrandName, CategoryName, ImageURL "
                + "FROM Products p "
                + "JOIN Brand b ON b.BrandID = p.BrandID "
                + "JOIN Categories c ON c.CategoryID = p.CategoryID "
                + "JOIN ProductImages pi ON p.ImageID = pi.ImageID";

        List<Product> list = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("Origin"),
                    rs.getString("Material"),
                    rs.getDouble("Price"),
                    rs.getInt("TotalQuantity"),
                    rs.getInt("CategoryID"),
                    rs.getInt("BrandID"),
                    rs.getInt("ImageID"),
                    rs.getInt("ProductStatus")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println("getAllProducts(): " + e);
        }

        return list;
    }
public List<Product> getProductsStocks() {
    String sql = "SELECT s.StockID, p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, "
            + "s.Size, s.Color, s.StockQuantity, p.CategoryID, p.BrandID, p.ImageID, p.ProductStatus "
            + "FROM Products p JOIN Stock s ON p.ProductID = s.ProductID";

    List<Product> productsStocksList = new ArrayList<>();

    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Product product = new Product(
                rs.getInt("ProductID"),
                rs.getString("ProductName"),
                rs.getString("Origin"),
                rs.getString("Material"),
                rs.getDouble("Price"),
                rs.getInt("StockQuantity"), // Using StockQuantity instead of TotalQuantity
                rs.getInt("CategoryID"),
                rs.getInt("BrandID"),
                rs.getInt("ImageID"),
                rs.getInt("ProductStatus")
            );

            productsStocksList.add(product);
        }
    } catch (SQLException e) {
        System.out.println("getProductsStocks(): " + e);
    }

    return productsStocksList;
}

    public void setProductStock(int stockID, int quantity) {

        String sql = "update Stock\n"
                + "set StockQuantity = ?\n"
                + "where StockID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("setProductStock(): " + e);
        }
    }

public Product getProductStockByStockID(int stockID) {
    String sql = "SELECT s.StockID, p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, "
            + "s.Size, s.Color, s.StockQuantity, p.CategoryID, p.BrandID, p.ImageID, p.ProductStatus "
            + "FROM Products p JOIN Stock s ON p.ProductID = s.ProductID "
            + "WHERE s.StockID = ?";

    Product product = null;

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, stockID);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                product = new Product(
                    rs.getInt("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("Origin"),
                    rs.getString("Material"),
                    rs.getDouble("Price"),
                    rs.getInt("StockQuantity"), // Using StockQuantity instead of TotalQuantity
                    rs.getInt("CategoryID"),
                    rs.getInt("BrandID"),
                    rs.getInt("ImageID"),
                    rs.getInt("ProductStatus")
                );

            }
        }
    } catch (SQLException e) {
        System.out.println("getProductStockByStockID(): " + e);
    }

    return product;
}

    public String getProductNameByID(int productID) {

        String sql = "select ProductName\n"
                + "from Products\n"
                + "where ProductID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductNameByID(): " + e);
        }

        return null;
    }

    public int getProductStockQuantityByID(int stockID) {

        String sql = "select s.StockID, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and s.StockID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(2);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductStockQuantityByID(): " + e);
        }

        return 0;
    }

    public void addNewProductVariant(int productID, int size, String color, int quantity, int importID) {

        String sql = "insert into Stock(ProductID, Size, Color, StockQuantity, ImportID) \n"
                + "values (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setInt(2, size);
            ps.setString(3, color);
            ps.setInt(4, quantity);
            ps.setInt(5, importID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("addNewProductVariant(): " + e);
        }
    }

    public boolean checkIfStockExists(int productID, int size, String color) {
        String sql = "SELECT * FROM Stock WHERE ProductID = ? AND Size = ? AND Color = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setInt(2, size);
            ps.setString(3, color);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println("checkIfStockExists(): " + e);
        }

        return false;
    }

    //User activity logging functions
    public void logAccount(int accountID) {

        String sql = "insert into ProductStockImport(AccountID, ImportDate) \n"
                + "values (?, getdate())";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("logAccount(): " + e);
        }
    }

    public int logAccountAndGetImportID(int accountID) {
        logAccount(accountID);

        String sql = "select top 1 ImportID, AccountID\n"
                + "from ProductStockImport\n"
                + "order by ImportID desc";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("logAccountAndGetImportID(): " + e);
        }

        return -1;
    }

    public void logUserUpdateActivity(int stockID, int importID, int stockQuantity) {

        String sql = "insert into StockImportDetail(StockID, ImportID, StockQuantity)\n"
                + "values (?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);
            ps.setInt(2, importID);
            ps.setInt(3, stockQuantity);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("logUserUpdateActivity(): " + e);
        }
    }

    // Log methods can remain largely the same, but adjust to use the new Product structure
    public void logUpdatedProducts(int accountID, List<Product> loggedProducts) {
        int importID = logAccountAndGetImportID(accountID);
        System.out.println("logUpdatedProducts(): accountID: " + accountID + ", importID: " + importID);
        for (Product product : loggedProducts) {
            logUserUpdateActivity(product.getProductId(), importID, product.getTotalQuantity());
        }
    }
    
       // User activity logging functions
    public int logStockImport(int accountID) {
        String sql = "INSERT INTO ProductStockImport(AccountID, ImportDate) VALUES (?, GETDATE()); SELECT SCOPE_IDENTITY()";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("logStockImport(): " + e);
        }

        return -1;
    }

    public void logStockImportDetail(int stockID, int importID, int stockQuantity) {
        String sql = "INSERT INTO StockImportDetail(StockID, ImportID, StockQuantity) VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stockID);
            ps.setInt(2, importID);
            ps.setInt(3, stockQuantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("logStockImportDetail(): " + e);
        }
    }

    public void logUpdatedStocks(int accountID, List<Stock> updatedStocks) {
        int importID = logStockImport(accountID);
        for (Stock stock : updatedStocks) {
            logStockImportDetail(stock.getStockID(), importID, stock.getStockQuantity());
        }
    }
}
