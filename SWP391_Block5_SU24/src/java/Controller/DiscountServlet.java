package Controller;

import entity.Account;
import entity.Brand;
import entity.Category;
import entity.Discount;
import entity.Product;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOBrand;
import model.DAOCategory;
import model.DAODiscount;
import model.DAOProduct;

public class DiscountServlet extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 10; // Number of items per page

    private DAODiscount daoDiscount;
    private DAOProduct daoProducts;
    private DAOCategory DAOCategory;
    private DAOBrand DAOBrand ; 

    @Override
    public void init() throws ServletException {
        // Initialize DAODiscount and DAOProducts
        daoDiscount = new DAODiscount();
        daoProducts = new DAOProduct();
        DAOCategory= new DAOCategory() ; 
        DAOBrand = new DAOBrand() ; 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        
        
        
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddDiscount(request, response);
                break;
            case "update":
                handleUpdateDiscount(request, response);
                break;
            case "delete":
                handleDeleteDiscount(request, response);
                break;
            default:
                response.sendRedirect("erroraction.jsp");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        
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
        
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            handleListDiscounts(request, response);
        } else if ("showeditform".equals(action)) {
            showEditForm(request, response);
        } else if ("showadform".equals(action)) {
            showAddForm(request, response);
        } else if ("search".equals(action)) {
            handleSearchDiscounts(request, response);
        } else if ("filterByCategory".equals(action)) {
            filterByCategory(request, response);
        }else if ("filterByBrand".equals(action)) {
            filterByBrandID(request, response);
         }else if ("showaddform".equals(action)) {
            showaddform(request, response);
         }else if ("updateby".equals(action)) {
            updateby(request, response);
         }else {
            response.sendRedirect("errorllisy.jsp");
        }
    }

    private void handleAddDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productID = Integer.parseInt(request.getParameter("product_id"));
            double discountAmount = Double.parseDouble(request.getParameter("discount_amount"));
            
            Discount discount = new Discount(0, productID, discountAmount);
            boolean isSuccess = daoDiscount.addDiscount(discount);
            
            if (isSuccess) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
            
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void handleUpdateDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int discountID = Integer.parseInt(request.getParameter("discountID"));
            int productID = Integer.parseInt(request.getParameter("product_id"));
            double discountAmount = Double.parseDouble(request.getParameter("discount_amount"));

            Discount discount = new Discount(discountID, productID, discountAmount);
            boolean isSuccess = daoDiscount.updateDiscount(discount);

            if (isSuccess) {
                response.sendRedirect("DiscountServlet?action=list");
            } else {
                response.sendRedirect("errorfail.jsp");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("errornumber.jsp");
        }
    }

    private void handleDeleteDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int discountID = Integer.parseInt(request.getParameter("discount_id"));

            boolean isSuccess = daoDiscount.deleteDiscount(discountID);

            if (isSuccess) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

 private void handleListDiscounts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int pageSize = 10; // Number of discounts per page
        int page = 1; // Default to page 1
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Discount> discountList = daoDiscount.getDiscountsByPage(page, pageSize);
        int totalDiscounts = daoDiscount.getTotalDiscountCount();
        int totalPages = (int) Math.ceil((double) totalDiscounts / pageSize);

        Map<Integer, Product> productMap = new HashMap<>();
        Set<Integer> productIds = new HashSet<>();
        for (Discount discount : discountList) {
            productIds.add(discount.getProductID());
        }

        for (Integer productId : productIds) {
            Product product = daoProducts.getProductById(productId);
            if (product != null) {
                productMap.put(productId, product);
            }
        }
        
          List<Brand> brands = DAOBrand.getAllBrandbystatus(0); // Lấy danh sách các Brand có trạng thái = 1
          List<Category> categories = DAOCategory.getAllbystatus(0); // Lấy danh sách các Category có trạng thái = 1


            request.setAttribute("discountList", discountList);
            request.setAttribute("productMap", productMap);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("brands", brands); // Thêm danh sách Brand vào request
            request.setAttribute("categories", categories); // Thêm danh sách Category vào request
            request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);
            
            System.out.println("brands :" + brands);
            System.out.println("categories : " + categories);


    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorhandleListDiscounts.jsp");
    }
}

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int discountID = Integer.parseInt(request.getParameter("discountID"));
            String productname = request.getParameter("productname"); 
            Discount discount = daoDiscount.getDiscountByID(discountID);
            if (discount != null) {
                request.setAttribute("discountList", discount);
                 request.setAttribute("productname", productname);
                 System.out.println("productname "+productname);
                request.getRequestDispatcher("manager/discounteditform.jsp").forward(request, response);
            } else {
                response.sendRedirect("null.jsp");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("errornay.jsp");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Product> productList = daoProducts.getAllProducts(); // Assuming this method exists
            request.setAttribute("productList", productList);
            request.getRequestDispatcher("manager/discounteditform.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void handleSearchDiscounts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productName = request.getParameter("product_name");
            List<Discount> discountList = daoDiscount.searchDiscountsByProductName(productName);

            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            int totalItems = discountList.size();
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);

            int startIndex = (page - 1) * ITEMS_PER_PAGE;
            int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);

            List<Discount> paginatedDiscounts = discountList.subList(startIndex, endIndex);

            Map<Integer, Product> productMap = new HashMap<>();
            Set<Integer> productIds = new HashSet<>();
            for (Discount discount : paginatedDiscounts) {
                productIds.add(discount.getProductID());
            }

            for (Integer productId : productIds) {
                Product product = daoProducts.getProductById(productId);
                if (product != null) {
                    productMap.put(productId, product);
                }
            }

            request.setAttribute("discountList", paginatedDiscounts);
            request.setAttribute("productMap", productMap);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
                        List<Brand> brands = DAOBrand.getAllBrandbystatus(0);
            List<Category> categories = DAOCategory.getAllbystatus(0);

            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

private void filterByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        // Lấy toàn bộ danh sách giảm giá cho categoryId
        List<Discount> allDiscounts = daoDiscount.getDiscountsByCategoryID(categoryId);

        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        int pageSize = 10; // Số lượng mục trên mỗi trang
        int totalItems = allDiscounts.size(); // Tổng số mục
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // Tính toán vị trí bắt đầu và kết thúc của trang hiện tại
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalItems);

        // Lấy danh sách giảm giá cho trang hiện tại
        List<Discount> paginatedDiscounts = allDiscounts.subList(startIndex, endIndex);

        Map<Integer, Product> productMap = new HashMap<>();
        Set<Integer> productIds = new HashSet<>();
        for (Discount discount : paginatedDiscounts) {
            productIds.add(discount.getProductID());
        }

        for (Integer productId : productIds) {
            Product product = daoProducts.getProductById(productId);
            if (product != null) {
                productMap.put(productId, product);
            }
        }

        request.setAttribute("discountList", paginatedDiscounts);
        request.setAttribute("productMap", productMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        List<Brand> brands = DAOBrand.getAllBrandbystatus(0);
        List<Category> categories = DAOCategory.getAllbystatus(0);

        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorfilterByCategory.jsp");
    }
}

    private void filterByBrandID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int brandId = Integer.parseInt(request.getParameter("brandId"));

            // Get the list of discounts for the selected brand
            List<Discount> allDiscounts = daoDiscount.filterByBrandID(brandId);

            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            int pageSize = 10; // Number of items per page
            int totalItems = allDiscounts.size(); // Total number of items
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            // Calculate start and end index for current page
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalItems);

            // Get the sublist for the current page
            List<Discount> paginatedDiscounts = allDiscounts.subList(startIndex, endIndex);

            Map<Integer, Product> productMap = new HashMap<>();
            Set<Integer> productIds = new HashSet<>();
            for (Discount discount : paginatedDiscounts) {
                productIds.add(discount.getProductID());
            }

            for (Integer productId : productIds) {
                Product product = daoProducts.getProductById(productId);
                if (product != null) {
                    productMap.put(productId, product);
                }
            }

            request.setAttribute("discountList", paginatedDiscounts);
            request.setAttribute("productMap", productMap);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            List<Brand> brands = DAOBrand.getAllBrandbystatus(0);
            List<Category> categories = DAOCategory.getAllbystatus(0);

            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorfilterByBrandID.jsp");
        }
    }

 private void showaddform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                    List<Product> productList = daoProducts.getAllProducts();
                List<Brand> brands = DAOBrand.getAllBrandbystatus(0); // Lấy danh sách các Brand có trạng thái = 1
                List<Category> categories = DAOCategory.getAllbystatus(0); // Lấy danh sách các Category có trạng thái = 1

                    request.setAttribute("productList", productList);
                    request.setAttribute("brands", brands);
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("manager/addform.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("errorhandleListDiscounts.jsp");
                }
            }


 private void updateby(HttpServletRequest request, HttpServletResponse response) throws IOException {
     try {
        String brandID = request.getParameter("brand_id");
        String categoryID = request.getParameter("category_id");
        double newDiscountAmount = Double.parseDouble(request.getParameter("discount_amount"));

        boolean isSuccess = false;

        if (!brandID.isEmpty() && !categoryID.isEmpty()) {
            // Both brand and category selected
            int brandId = Integer.parseInt(brandID);
            int categoryId = Integer.parseInt(categoryID);
            isSuccess = daoDiscount.updateDiscountByBoth(categoryId, brandId, newDiscountAmount);
        } else if (!brandID.isEmpty()) {
            // Only brand selected
            int brandId = Integer.parseInt(brandID);
            isSuccess = daoDiscount.updateDiscountByBrand(brandId, newDiscountAmount);
        } else if (!categoryID.isEmpty()) {
            // Only category selected
            int categoryId = Integer.parseInt(categoryID);
            isSuccess = daoDiscount.updateDiscountByCategory(categoryId, newDiscountAmount);
        } else {
            // No brand or category selected
            response.sendRedirect("errorupdateby.jsp");
            return;
        }

        if (isSuccess) {
            response.sendRedirect("DiscountServlet?action=list");
        } else {
            response.sendRedirect("errorupdateby.jsp");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("errornumber.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorupdateby.jsp");
    }
}



}
