package model;

import entity.Product;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOProduct extends MyDAO {

    // Lấy tất cả các sản phẩm từ cơ sở dữ liệu
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            xSql = "SELECT [ProductID], [ProductName], [Origin], [Material], [Price], [TotalQuantity], [CategoryID], [BrandID], [ImageID], [ProductStatus] FROM [ECommerceStore].[dbo].[Products]";
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setOrigin(rs.getString("Origin"));
                product.setMaterial(rs.getString("Material"));
                product.setPrice(rs.getDouble("Price"));
                product.setTotalQuantity(rs.getInt("TotalQuantity"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setBrandId(rs.getInt("BrandID"));
                product.setImageId(rs.getInt("ImageID"));
                product.setProductStatus(rs.getInt("ProductStatus"));  // Updated to include ProductStatus
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    // Thêm sản phẩm mới vào cơ sở dữ liệu
    public void addProduct(Product product) {
        try {
            xSql = "INSERT INTO [ECommerceStore].[dbo].[Products] ([ProductName], [Origin], [Material], [Price], [TotalQuantity], [CategoryID], [BrandID],  [ProductStatus]) VALUES (?, ?, ?, ?, ?, ?, ?,  ?)";
            ps = con.prepareStatement(xSql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getTotalQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getBrandId());
            ps.setInt(8, product.getProductStatus());  // Updated to include ProductStatus
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Cập nhật thông tin sản phẩm
    public void updateProduct(Product product) {
        try {
            xSql = "UPDATE [ECommerceStore].[dbo].[Products] SET [ProductName] = ?, [Origin] = ?, [Material] = ?, [Price] = ?, [TotalQuantity] = ?, [CategoryID] = ?, [BrandID] = ?, [ImageID] = ?, [ProductStatus] = ? WHERE [ProductID] = ?";
            ps = con.prepareStatement(xSql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getTotalQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getBrandId());
            ps.setInt(8, product.getImageId());
            ps.setInt(9, product.getProductStatus());  // Updated to include ProductStatus
            ps.setInt(10, product.getProductId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Xóa sản phẩm theo ProductID
    public void deleteProduct(int productId) {
        try {
            xSql = "DELETE FROM [ECommerceStore].[dbo].[Products] WHERE [ProductID] = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Lấy thông tin sản phẩm dựa trên ProductID
    public Product getProductById(int productId) {
        Product product = null;
        try {
            xSql = "SELECT [ProductID], [ProductName], [Origin], [Material], [Price], [TotalQuantity], [CategoryID], [BrandID], [ImageID], [ProductStatus] FROM [ECommerceStore].[dbo].[Products] WHERE [ProductID] = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setOrigin(rs.getString("Origin"));
                product.setMaterial(rs.getString("Material"));
                product.setPrice(rs.getDouble("Price"));
                product.setTotalQuantity(rs.getInt("TotalQuantity"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setBrandId(rs.getInt("BrandID"));
                product.setImageId(rs.getInt("ImageID"));
                product.setProductStatus(rs.getInt("ProductStatus"));  // Updated to include ProductStatus
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return product;
    }
    
    
       // Cập nhật ImageID cho sản phẩm dựa trên ProductID
    public void updateProductImage(int productId, int imageId) {
        try {
            xSql = "UPDATE [ECommerceStore].[dbo].[Products] SET [ImageID] = ? WHERE [ProductID] = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, imageId);
            ps.setInt(2, productId);
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }
    
    
    // Lấy ra productID mới nhất
public int getLatestProductId() {
    int latestProductId = -1;
    try {
        xSql = "SELECT TOP 1 [ProductID] FROM [ECommerceStore].[dbo].[Products] ORDER BY [ProductID] DESC";
        ps = con.prepareStatement(xSql);
        rs = ps.executeQuery();
        if (rs.next()) {
            latestProductId = rs.getInt("ProductID");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return latestProductId;
}
    

    // Đóng các tài nguyên sau khi sử dụng
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
