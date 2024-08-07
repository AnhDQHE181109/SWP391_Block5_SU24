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
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                    + "c.CategoryName, b.BrandName, p.ImportID, p.ImageID "
                    + "FROM Product p "
                    + "LEFT JOIN Category c ON p.CategoryID = c.CategoryID "
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
                p.setImportId(rs.getInt("ImportID"));
                p.setImageId(rs.getInt("ImageID"));
                list.add(p);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
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

    public void insertProduct(Product product) {
        String sql = "INSERT INTO Product (ProductName, Origin, Material, Price, TotalQuantity, CategoryID, BrandID, ImportID, ImageID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getTotalQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getBrandId());
            ps.setInt(8, product.getImportId());
            ps.setInt(9, product.getImageId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting product");
        }
    }
}
