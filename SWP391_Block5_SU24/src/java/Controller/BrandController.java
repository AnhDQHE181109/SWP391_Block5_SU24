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
        if (account.getRole() == 1 || account.getRole() == 2) {
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
            case "change":
                updateBrandStatus(request, response);
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
        System.out.println("brands" + brands);
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
    }

    private void updateBrandStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int status = Integer.parseInt(request.getParameter("status")); // Assuming status is passed as a parameter

        Brand brand = new Brand();
        brand.setBrandId(brandId);
        brand.setBrandstatus(status); // Assuming setBrandStatus is available in the Brand class
        brandDAO.updateBrandStatus(brand);

        response.sendRedirect("BrandController?action=list");
    }

    private void searchBrands(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Brand> brands = brandDAO.searchBrands(keyword);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("manager/Brand.jsp").forward(request, response);
    }
}
