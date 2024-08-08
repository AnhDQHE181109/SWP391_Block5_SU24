/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO extends DBConnect {
    public List<Brand> getAllBrands() throws Exception {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Brand brand = new Brand();
            brand.setBrandId(rs.getInt("brandId"));
            brand.setBrandName(rs.getString("brandName"));
            brands.add(brand);
        }
        rs.close();
        ps.close();
        return brands;
    }
}
