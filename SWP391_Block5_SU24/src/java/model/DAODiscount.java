package model;

import entity.Discount;
import entity.Product;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAODiscount extends MyDAO {

    // Constructor
    public DAODiscount() {
        super();
    }

    // Method to add a new discount to the database
    public boolean addDiscount(Discount discount) {
        boolean isSuccess = false;
        try {
            String sql = "INSERT INTO Discounts (productID, discountAmount) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, discount.getProductID());
            ps.setDouble(2, discount.getDiscountAmount());
            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to get a discount by ID
    public Discount getDiscountByID(int discountID) {
        Discount discount = null;
        try {
            String sql = "SELECT * FROM Discounts WHERE [discount_id] = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, discountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int productID = rs.getInt("product_id");
                double discountAmount = rs.getDouble("discount_amount");
                
                discount = new Discount(discountID, productID, discountAmount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return discount;
    }

    // Method to update an existing discount
    public boolean updateDiscount(Discount discount) {
        boolean isSuccess = false;
        try {
            String sql = "  UPDATE  Discounts set  [discount_amount] = ? WHERE [discount_id] = ?";
            ps = con.prepareStatement(sql);
            ps.setDouble(1, discount.getDiscountAmount());
            ps.setInt(2, discount.getDiscountID());
            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to delete a discount by ID
    public boolean deleteDiscount(int discountID) {
        boolean isSuccess = false;
        try {
            String sql = "DELETE FROM Discounts WHERE discountID = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, discountID);
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

    // Method to get all discounts from the database
    public List<Discount> getAllDiscounts() {
        List<Discount> discountList = new ArrayList<>();
        try {
               String sql = "SELECT p.[ProductID], p.ProductName,d.discount_id, ISNULL(d.discount_amount, 0) AS discount_amount " +
                 "FROM Products p " +
                 "LEFT JOIN Discounts d ON p.[ProductID] = d.[product_id]";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productname = rs.getString("ProductName") ; 
                int discountID = rs.getInt("discount_id");
                double discountAmount = rs.getDouble("discount_amount");

                Discount discount = new Discount(discountID, productID, discountAmount);
                discountList.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return discountList;
    }
    
    // Method to get discounts by CategoryID
    public List<Discount> getDiscountsByCategoryID(int categoryID) {
        List<Discount> discountList = new ArrayList<>();
        try {
            String sql = "SELECT p.ProductID, p.ProductName, d.discount_id, d.discount_amount " +
                         "FROM Products p " +
                         "JOIN Discounts d ON p.ProductID = d.product_id " +
                         "JOIN Categories c ON p.CategoryID = c.categoryId " +
                         "WHERE c.categoryId = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, categoryID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int discountID = rs.getInt("discount_id");
                double discountAmount = rs.getDouble("discount_amount");

                Discount discount = new Discount(discountID, productID, discountAmount);
                Product Product = new Product() ;  
                Product.setProductName(productName); // Set product name to the Discount entity
                discountList.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return discountList;
    }
    
    // Method to search discounts based on product name
    public List<Discount> searchDiscountsByProductName(String searchTerm) {
        List<Discount> discountList = new ArrayList<>();
        try {
            // Prepare the search pattern
            String searchPattern = searchTerm.replace(" ", "% %");
            searchPattern = "%" + searchPattern + "%";

            // SQL query
            String sql = "SELECT d.discount_id, p.ProductID, d.discount_amount, p.ProductName " +
                         "FROM Products p " +
                         "JOIN Discounts d ON p.ProductID = d.product_id " +
                         "WHERE p.ProductName LIKE ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, searchPattern);

            rs = ps.executeQuery();
            while (rs.next()) {
                int discountID = rs.getInt("discount_id");
                int productID = rs.getInt("ProductID");
                double discountAmount = rs.getDouble("discount_amount");
                String productNameResult = rs.getString("ProductName");

                Discount discount = new Discount(discountID, productID, discountAmount);
                discountList.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return discountList;
    }

   // Method to get a page of discounts
    public List<Discount> getDiscountsByPage(int page, int size) {
        List<Discount> discountList = new ArrayList<>();
        int offset = (page - 1) * size; // Calculate the offset
        try {
            String sql = "SELECT d.discount_id, p.ProductID, d.discount_amount, p.ProductName " +
                         "FROM Products p " +
                         " JOIN Discounts d ON p.ProductID = d.product_id " +
                         "ORDER BY d.discount_id " +
                         "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, size);
            rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName"); 
                int discountID = rs.getInt("discount_id");
                double discountAmount = rs.getDouble("discount_amount");

                Discount discount = new Discount(discountID, productID, discountAmount);
                discountList.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return discountList;
    }
    
    // Method to filter discounts by BrandID
public List<Discount> filterByBrandID(int brandID) {
    List<Discount> discountList = new ArrayList<>();
    try {
        String sql = "SELECT p.ProductID, p.ProductName, d.discount_id, d.discount_amount " +
                     "FROM Products p " +
                     "INNER JOIN Discounts d ON p.ProductID = d.product_id " +
                     "WHERE p.BrandID = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, brandID);
        rs = ps.executeQuery();
        while (rs.next()) {
            int productID = rs.getInt("ProductID");
            String productName = rs.getString("ProductName");
            int discountID = rs.getInt("discount_id");
            double discountAmount = rs.getDouble("discount_amount");

            Discount discount = new Discount(discountID, productID, discountAmount);
            discountList.add(discount);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return discountList;
}


    // Method to get the total number of discounts
    public int getTotalDiscountCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM Discounts";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return count;
    }
    
      // Method to update discount amounts by BrandID
    public boolean updateDiscountByBrand(int brandID, double newDiscountAmount) {
        boolean isSuccess = false;
        try {
            // First, find all products with the given BrandID
            String sqlFindProducts = "SELECT ProductID FROM Products WHERE BrandID = ?";
            ps = con.prepareStatement(sqlFindProducts);
            ps.setInt(1, brandID);
            rs = ps.executeQuery();
            
            List<Integer> productIDs = new ArrayList<>();
            while (rs.next()) {
                productIDs.add(rs.getInt("ProductID"));
            }

            // If no products found for this BrandID, exit
            if (productIDs.isEmpty()) {
                return false;
            }

            // Now, update discount amounts for these products
            String sqlUpdateDiscounts = "UPDATE Discounts SET discount_amount = ? WHERE product_id = ?";
            ps = con.prepareStatement(sqlUpdateDiscounts);

            for (int productID : productIDs) {
                ps.setDouble(1, newDiscountAmount);
                ps.setInt(2, productID);
                ps.addBatch();
            }

            int[] rowsAffected = ps.executeBatch();
            isSuccess = (rowsAffected.length > 0);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }
    
    // Method to update discount amounts by CategoryID
public boolean updateDiscountByCategory(int categoryID, double newDiscountAmount) {
    boolean isSuccess = false;
    try {
        // First, find all products with the given CategoryID
        String sqlFindProducts = "SELECT ProductID FROM Products WHERE CategoryID = ?";
        ps = con.prepareStatement(sqlFindProducts);
        ps.setInt(1, categoryID);
        rs = ps.executeQuery();
        
        List<Integer> productIDs = new ArrayList<>();
        while (rs.next()) {
            productIDs.add(rs.getInt("ProductID"));
        }

        // If no products found for this CategoryID, exit
        if (productIDs.isEmpty()) {
            return false;
        }

        // Now, update discount amounts for these products
        String sqlUpdateDiscounts = "UPDATE Discounts SET discount_amount = ? WHERE product_id = ?";
        ps = con.prepareStatement(sqlUpdateDiscounts);

        for (int productID : productIDs) {
            ps.setDouble(1, newDiscountAmount);
            ps.setInt(2, productID);
            ps.addBatch();
        }

        int[] rowsAffected = ps.executeBatch();
        isSuccess = (rowsAffected.length > 0);
        
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return isSuccess;
}


    
}
