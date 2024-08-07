/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class ProductDetailsDAO extends DBConnect {


    public ArrayList<Product> getAllProducts() {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Products";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setOrigin(rs.getString("Origin"));
                p.setMaterial(rs.getString("Material"));
                p.setTotalQuantity(rs.getInt("TotalQuantity"));
                p.setCategoryId(rs.getInt("CategoryID"));
                p.setBrandId(rs.getInt("BrandID"));
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
}
