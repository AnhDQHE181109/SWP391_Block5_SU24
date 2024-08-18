/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.DAOCategory;

/**
 *
 * @author asus
 */
public class CategoryController extends HttpServlet {

     private static final long serialVersionUID = 1L;
    private DAOCategory categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new DAOCategory(); // Initialize the CategoryDAO
    }

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
            HttpSession session = request.getSession();
    Account account = (Account) session.getAttribute("account");
    if (account == null) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
        return;
    }
    if (account.getRole() == 1) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
        return;
    }
    if (account.getRole() == 2) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
        return;
    }
        
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listCategories(request, response);
                break;
            case "showForm":
                showForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "change":
                changeCategoryStatus(request, response);
                break;
            case "search":
                searchCategory(request, response);
                break;
            default:
                listCategories(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                createCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategories(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);
        System.out.println("categories"+categories);
        request.getRequestDispatcher("manager/category.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("manager/category_form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getById(categoryId);
        request.setAttribute("category", category);
        request.getRequestDispatcher("manager/category_form.jsp").forward(request, response);
    }

 private void createCategory(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String categoryName = request.getParameter("categoryName");
    Category category = new Category();
    category.setCategoryName(categoryName);
    
    if (categoryDAO.isCategoryNameExists(categoryName, null)) {
        request.setAttribute("error", "Category name already exists");
        request.setAttribute("category", category);
        request.getRequestDispatcher("/manager/category_form.jsp").forward(request, response);
    } else if (categoryDAO.insert(category)) {
        response.sendRedirect(request.getContextPath() + "/CategoryController?action=listt");
    } else {
        request.setAttribute("error", "Failed to create category");
        request.setAttribute("category", category);
        request.getRequestDispatcher("manager/category_form.jsp").forward(request, response);
    }
}

private void updateCategory(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    String categoryName = request.getParameter("categoryName");
    int categorystatus = Integer.parseInt(request.getParameter("categorystatus")) ; 
    Category category = new Category(categoryId, categoryName,categorystatus);
    
    if (categoryDAO.isCategoryNameExists(categoryName, categoryId)) {
        request.setAttribute("error", "Category name already exists");
        request.setAttribute("category", category);
        request.getRequestDispatcher("manager/category_form.jsp").forward(request, response);
    } else if (categoryDAO.update(category)) {
        response.sendRedirect(request.getContextPath() + "/CategoryController?action=list");
    } else {
        request.setAttribute("error", "Failed to update category");
        request.setAttribute("category", category);
        request.getRequestDispatcher("manager/category_form.jsp").forward(request, response);
    }
}

private void changeCategoryStatus(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int categoryId = Integer.parseInt(request.getParameter("id"));
    int newStatus = Integer.parseInt(request.getParameter("newStatus")); // Lấy trạng thái mới từ request
    
    if (categoryDAO.updateCategoryStatus(categoryId, newStatus)) {
        response.sendRedirect(request.getContextPath() + "/CategoryController?action=list");
    } else {
        request.setAttribute("error", "Failed to change category status");
        listCategories(request, response);
    }
}


private void searchCategory(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String searchTerm = request.getParameter("searchTerm");
    List<Category> categories = new ArrayList<>();
    
    try {
        categories = categoryDAO.searchByCategoryName(searchTerm);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Error occurred while searching for categories.");
    }

    request.setAttribute("categories", categories);
    System.out.println("categories"+categories);
    request.getRequestDispatcher("manager/category.jsp").forward(request, response);
}

}