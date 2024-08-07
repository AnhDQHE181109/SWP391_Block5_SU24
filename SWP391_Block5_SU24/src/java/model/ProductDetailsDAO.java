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
                p.setProductId(rs.getInt(1));
                p.setProductName(rs.getString(2));
                p.setPrice(rs.getBigDecimal(3));
                p.setOrigin(rs.getString(4));
                p.setMaterial(rs.getString(5));
                p.setTotalQuantity(rs.getInt(6));
                p.setCategoryId(rs.getInt(7));
                p.setBrandId(rs.getInt(8));
                p.setImportId(rs.getInt(9));
                p.setImageId(rs.getInt(10));
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
