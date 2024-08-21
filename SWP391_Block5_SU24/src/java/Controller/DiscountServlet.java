package Controller;

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
import model.DAODiscount;
import model.DAOProduct;

public class DiscountServlet extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 10; // Number of items per page

    private DAODiscount daoDiscount;
    private DAOProduct daoProducts;

    @Override
    public void init() throws ServletException {
        // Initialize DAODiscount and DAOProducts
        daoDiscount = new DAODiscount();
        daoProducts = new DAOProduct();
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
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            handleListDiscounts(request, response);
        } else if ("showeditform".equals(action)) {
            showEditForm(request, response);
        } else if ("showadform".equals(action)) {
            showAddForm(request, response);
        } else if ("search".equals(action)) {
            handleSearchDiscounts(request, response);
        } else {
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

        request.setAttribute("discountList", discountList);
        request.setAttribute("productMap", productMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
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
            request.getRequestDispatcher("manager/Discount.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
