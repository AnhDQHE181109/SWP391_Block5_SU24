/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.ProductStockImport;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.ProductStocksImportDAO;

/**
 *
 * @author ASUS
 */
public class ProductStocksImportController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductVariantsImportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductVariantsImportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You must be logged in to do that!')");
            out.println("location.href=\"login.jsp\"");
            out.println("</script>");
            return;
        }
        int accountID = account.getAccountID();

        ProductStocksImportDAO psiDAO = new ProductStocksImportDAO();

        List<ProductStockImport> productsList = (List<ProductStockImport>) session.getAttribute("productsList");

        String removeProductIn = request.getParameter("removeProduct");
        if (removeProductIn != null) {
            int removeProduct = 0;

            try {
                removeProduct = Integer.parseInt(removeProductIn);
            } catch (NumberFormatException e) {
                System.out.println("removeProduct: " + e);
                request.setAttribute("productsList", productsList);
                request.setAttribute("errorMessage", "Invalid request parameter!");
                request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
                return;
            }

            productsList.remove(removeProduct - 1);
        }
        
        String productName = request.getParameter("productName");
        if (productName != null) {
            int productID = psiDAO.getProductIDbyProductName(productName);
            
            //Debugging
            System.out.println("Product ID fetched from productName: " + productID);
            
            List<ProductStockImport> productColors = psiDAO.getProductColors(productID);
            List<ProductStockImport> productSizes = psiDAO.getSizesByColorAndProductID(productID, productColors.get(0).getProductColor());
            
            request.setAttribute("selectedColor", productColors.get(0).getProductColor());
            request.setAttribute("productColors", productColors);
            request.setAttribute("productSizes", productSizes);
        }   

        String saveChanges = request.getParameter("saveChanges");
        if (saveChanges != null) {
            if (productsList == null) {
                request.setAttribute("errorMessage", "There is nothing on the list!");
                request.setAttribute("productsList", productsList);
                request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
                return;
            } else if (productsList.size() == 0) {
                request.setAttribute("errorMessage", "There is nothing on the list!");
                request.setAttribute("productsList", productsList);
                request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
                return;
            }

            psiDAO.logUpdatedProducts(accountID, productsList.get(0).getSupplierName(), productsList);

            for (ProductStockImport productStock : productsList) {
                int productID = psiDAO.getProductIDbyProductName(productStock.getProductName());
                int stockID = psiDAO.getStockIDbyColorSizeProductID(productStock.getProductColor(),
                        productStock.getProductSize(), productID);

                psiDAO.incrementQuantityToStockID(productStock.getQuantity(), stockID);
            }

            request.setAttribute("displayMessage", "Written changes into the system!");
            productsList.clear();
        }

        String searchTerms = request.getParameter("search");
        if (searchTerms != null) {
            List<ProductStockImport> resultsList = psiDAO.findProductsByCriteria(searchTerms);
            List<String> suggestions = new ArrayList<>();

            for (ProductStockImport productStock : resultsList) {
                String suggestionHTML = "<div class='dropdown-item d-flex align-items-center'>"
                        + "<img src='" + productStock.getImageURL() + "' alt='" + productStock.getProductName() + "' class='img-thumbnail' style='width: 50px; height: 50px; margin-right: 10px;'>"
                        + "<span>" + productStock.getProductName() + "</span></div>";
                suggestions.add(suggestionHTML);
            }

            response.setContentType("text/html");

            // Output the suggestions as HTML
            for (String suggestion : suggestions) {
                out.println(suggestion);
            }

            return;

        }

        request.setAttribute("productsList", productsList);
        request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You must be logged in to do that!')");
            out.println("location.href=\"login.jsp\"");
            out.println("</script>");
            return;
        }
        int accountID = account.getAccountID();

        ProductStocksImportDAO psiDAO = new ProductStocksImportDAO();

        String productName = request.getParameter("productName");
        String productColor = request.getParameter("productColor");
        String productSizeIn = request.getParameter("productSize");
        String supplierName = request.getParameter("supplierName");
        String productQuantityIn = request.getParameter("productQuantity");

//        out.println("POSTED");
        List<ProductStockImport> productsList = (List<ProductStockImport>) session.getAttribute("productsList");

        if (productsList == null) {
            productsList = new ArrayList<>();
            session.setAttribute("productsList", productsList);
        }

        int productSize = 0;
        int productQuantity = 0;
        try {
            productSize = Integer.parseInt(productSizeIn);
            productQuantity = Integer.parseInt(productQuantityIn);
        } catch (NumberFormatException e) {
            System.out.println("productSize / productQuantity: " + e);
            request.setAttribute("errorMessage", "Product size or quantity is invalid!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        if (productSize < 38 || productSize > 42) {
            request.setAttribute("errorMessage", "The product size must be between 38 and 42!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        if (productQuantity < 1 || productQuantity > 1000) {
            request.setAttribute("errorMessage", "The product quantity must be between 1 and 1000!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        int productID = psiDAO.getProductIDbyProductName(productName);
        String imageURL = psiDAO.getImageURLbyProductID(productID);
        if (productID == 0) {
            System.out.println("ERR: Product with such name doesnt exist!");
            request.setAttribute("errorMessage", "Product with such name does not exist!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        if (!psiDAO.checkIfStockExists(productID, productSize, productColor)) {
            request.setAttribute("errorMessage", "Product with such size and color does not exist!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        if (supplierName.trim().equalsIgnoreCase("")) {
            request.setAttribute("errorMessage", "Invalid supplier name!");
            request.setAttribute("productsList", productsList);
            request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
            return;
        }

        ProductStockImport productStock = new ProductStockImport(imageURL, supplierName, productName, productColor, productSize, productQuantity);

        productsList.add(productStock);

        request.setAttribute("productsList", productsList);
        request.getRequestDispatcher("staff/importProductStocks.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
