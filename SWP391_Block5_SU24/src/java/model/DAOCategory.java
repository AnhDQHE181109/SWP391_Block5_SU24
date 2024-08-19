package model;



import entity.Category;
import model.MyDAO;
import java.util.ArrayList;
import java.util.List;

public class DAOCategory extends MyDAO {

    public DAOCategory() {
        super();
    }

    // Create a new category
    public boolean insert(Category category) {
        xSql = "INSERT INTO Categories (CategoryName) VALUES (?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update an existing category
    public boolean update(Category category) {
        xSql = "UPDATE Categories SET CategoryName = ? WHERE CategoryID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            ps.setInt(2, category.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a category
    public boolean delete(int categoryId) {
        xSql = "DELETE FROM Categories WHERE CategoryID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get a category by ID
    public Category getById(int categoryId) {
        xSql = "SELECT * FROM Categories WHERE CategoryID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all categories
    public List<Category> getAll() {
        List<Category> categories = new ArrayList<>();
        xSql = "SELECT * FROM Categories";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    public boolean isCategoryNameExists(String categoryName, Integer excludeId) {
    xSql = "SELECT COUNT(*) FROM Categories WHERE CategoryName = ? AND CategoryID != COALESCE(?, -1)";
    try {
        ps = con.prepareStatement(xSql);
        ps.setString(1, categoryName);
        ps.setObject(2, excludeId);
        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
     // Search categories by partial category name
    public List<Category> searchByCategoryName(String searchTerm) throws Exception {
        List<Category> categories = new ArrayList<>();
        xSql = "SELECT * FROM Categories WHERE CategoryName LIKE ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + searchTerm + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    
}