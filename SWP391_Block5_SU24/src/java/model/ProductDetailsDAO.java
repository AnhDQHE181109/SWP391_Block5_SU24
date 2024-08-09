/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import entity.Category;
import entity.Product;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;


/**
 *
 * @author ASUS
 */
public class ProductDetailsDAO extends DBConnect {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                    + "c.CategoryName, b.BrandName, p.ImageID "
                    + "FROM Products p "
                    + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                    + "LEFT JOIN Brand b ON p.BrandID = b.BrandID";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setOrigin(rs.getString("Origin"));
                p.setMaterial(rs.getString("Material"));
                p.setPrice(rs.getDouble("Price"));
                p.setTotalQuantity(rs.getInt("TotalQuantity"));
                p.setCategoryName(rs.getString("CategoryName"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageId(rs.getInt("ImageID"));
                products.add(p);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return products;
    }

    public List<Brand> getAllBrands() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM Brand";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("BrandId"));
                brand.setBrandName(rs.getString("BrandName"));
                list.add(brand);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));
                list.add(category);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public void addProduct(Product product) {
        try {
            String sql = "INSERT INTO Products (ProductName, Origin, Material, Price, CategoryID, BrandID) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getCategoryId());
            ps.setInt(6, product.getBrandId());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {

            System.out.println("Error inserting product: " + e.getMessage());
        }
    }

    public void updateProduct(Product product) {
        try {
            String sql = "UPDATE product SET productName = ?, price = ?, totalQuantity = ? WHERE productId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getTotalQuantity());
            ps.setInt(4, product.getProductId());
            // Set other parameters
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        try {
            String sql = "DELETE FROM product WHERE productId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProductById(int id) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * From Products WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setOrigin(rs.getString("Origin"));
                p.setMaterial(rs.getString("Material"));
                p.setPrice(rs.getDouble("Price"));
                p.setTotalQuantity(rs.getInt("TotalQuantity"));
                p.setCategoryName(rs.getString("CategoryName"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageId(rs.getInt("ImageID"));
                products.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return products;
    }
}
