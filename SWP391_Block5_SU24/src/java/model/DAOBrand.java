package model;

import entity.Brand;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOBrand extends MyDAO {

    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        xSql = "SELECT * FROM Brand";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brandId"));
                brand.setBrandName(rs.getString("brandName"));
                brand.setBrandstatus(rs.getInt("brandStatus")); // Fixed field name

                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return brands;
    }

    public Brand getBrandById(int brandId) {
        Brand brand = null;
        xSql = "SELECT * FROM Brand WHERE brandId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, brandId);
            rs = ps.executeQuery();
            if (rs.next()) {
                brand = new Brand();
                brand.setBrandId(rs.getInt("brandId"));
                brand.setBrandName(rs.getString("brandName"));
                brand.setBrandstatus(rs.getInt("brandStatus")); // Fixed field name
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return brand;
    }

    public boolean brandExists(String brandName) {
        boolean exists = false;
        xSql = "SELECT COUNT(*) FROM Brand WHERE brandName = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, brandName);
            rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return exists;
    }

    public boolean brandExistsExcept(int brandId, String brandName) {
        boolean exists = false;
        xSql = "SELECT COUNT(*) FROM Brand WHERE brandName = ? AND brandId <> ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, brandName);
            ps.setInt(2, brandId);
            rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return exists;
    }

    public void insertBrand(Brand brand) {
        xSql = "INSERT INTO Brand (brandName) VALUES (?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, brand.getBrandName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public void updateBrand(Brand brand) {
        xSql = "UPDATE Brand SET brandName = ? WHERE brandId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, brand.getBrandName());
            ps.setInt(2, brand.getBrandId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public void updateBrandStatus(Brand brand) {
        xSql = "UPDATE Brand SET brandStatus = ? WHERE brandId = ?"; // Removed square brackets
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, brand.getBrandstatus()); // Corrected method name
            ps.setInt(2, brand.getBrandId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Removed deleteBrand method as per your request
    
    public List<Brand> searchBrands(String keyword) {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand WHERE brandName LIKE ?";
        
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brandId")); // Fixed field name
                brand.setBrandName(rs.getString("brandName")); // Fixed field name
                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return brands;
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
