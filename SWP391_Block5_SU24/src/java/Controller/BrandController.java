/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Brand;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DAOBrand;

/**
 *
 * @author asus
 */
public class BrandController extends HttpServlet {

     private DAOBrand brandDAO;

    @Override
    public void init() throws ServletException {
        brandDAO = new DAOBrand();
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

        switch (action) {
            case "list":
                listBrands(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBrand(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "search":
                searchBrands(request, response);
                break;

            default:
                listBrands(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "insert":
                insertBrand(request, response);
                break;
            case "update":
                updateBrand(request, response);
                break;
            case "updatestatus":
                updateBrandstatus(request, response);
                break;

            default:
                listBrands(request, response);
                break;
        }
    }

    private void listBrands(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Brand> brands = brandDAO.getAllBrands();
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("manager/Brand.jsp").forward(request, response);
        System.out.println("brands"+brands);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("manager/brand-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        Brand existingBrand = brandDAO.getBrandById(brandId);
        request.setAttribute("brand", existingBrand);
        request.getRequestDispatcher("manager/brand-form.jsp").forward(request, response);
    }

 
    private void insertBrand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String brandName = request.getParameter("brandName");
        if (brandDAO.brandExists(brandName)) {
            request.setAttribute("errorMessage", "Brand already exists.");
            request.getRequestDispatcher("manager/brand-form.jsp").forward(request, response);
            return;
        }

        Brand brand = new Brand();
        brand.setBrandName(brandName);
        brandDAO.insertBrand(brand);
        response.sendRedirect("BrandController?action=list");
    }

    private void updateBrand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        String brandName = request.getParameter("brandName");

        if (brandDAO.brandExistsExcept(brandId, brandName)) {
            request.setAttribute("errorMessage", "Brand already exists.");
            Brand oldBrand = brandDAO.getBrandById(brandId);
            request.setAttribute("brand", oldBrand);
            request.getRequestDispatcher("manager/brand-form.jsp").forward(request, response);
            return;
        }

        Brand brand = new Brand();
        brand.setBrandId(brandId);
        brand.setBrandName(brandName);
        brandDAO.updateBrand(brand);
        response.sendRedirect("BrandController?action=list");
        System.out.println("brand: "+brand);
    }
private void updateBrandstatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int brandstatus = Integer.parseInt(request.getParameter("brandstatus")); // Fix here

        brandDAO.updateBrandStatus(brandId,brandstatus);
        response.sendRedirect("BrandController?action=list");
    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "Invalid input.");
        request.getRequestDispatcher("manager/Brand.jsp").forward(request, response);
    }
}

    private void deleteBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        brandDAO.deleteBrand(brandId);
        response.sendRedirect("BrandController?action=list");
    }
    
        private void searchBrands(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Brand> brands = brandDAO.searchBrands(keyword);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("manager/Brand.jsp").forward(request, response);
    }
}