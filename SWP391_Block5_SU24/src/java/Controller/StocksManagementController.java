/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import entity.Account;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import model.StocksManagementDAO;

public class StocksManagementController extends HttpServlet {

    List<Product> outOfStocksList = new ArrayList<>();
    int loggedImportID = 0;
    List<Product> loggedProducts = new ArrayList<>();

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
            out.println("<title>Servlet StocksManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StocksManagementController at " + request.getContextPath() + "</h1>");
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        if (account.getRole() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        int accountID = account.getAccountID();

        StocksManagementDAO smDAO = new StocksManagementDAO();

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();

        // Phân trang
        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int totalRecords = productsList.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        // Tính toán chỉ mục bắt đầu và kết thúc cho trang hiện tại
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);

        String newVariantProductID = request.getParameter("newVariantProductID");
        if (newVariantProductID != null) {
//            int size = Integer.parseInt(request.getParameter("newVariantSize"));
//            String color = request.getParameter("newVariantColor");
//            int quantity = Integer.parseInt(request.getParameter("newVariantQuantity"));
//            int productID = Integer.parseInt(request.getParameter("newVariantProductID"));

            Map newVariantData = request.getParameterMap();
            int size = 0, quantity = 0;
            int productID = Integer.parseInt(request.getParameter("newVariantProductID"));
            String color = "";

            for (Object key : newVariantData.keySet()) {
                String keyString = (String) key;
                String[] value = (String[]) newVariantData.get(keyString);

                if (value[0].trim().equalsIgnoreCase("")) {
//                    List<Product> productsList = smDAO.getAllProducts();
//                    List<Product> productsStocksList = smDAO.getProductsStocks();
                    List<Product> paginatedOrderList = productsList.subList(start, end);
                    request.setAttribute("productsList", paginatedOrderList);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);

                    request.setAttribute("alertMessage", "Please input valid data for the variant!");
                    request.setAttribute("openPopup", "popup_" + productID);
                    request.setAttribute("productsStocksList", productsStocksList);
                    request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
                    return;
                }

                if (keyString.startsWith("newVariantSize")) {
                    try {
                        size = Integer.parseInt(value[0]);
                    } catch (NumberFormatException e) {
                        System.out.println(e);

                        List<Product> paginatedOrderList = productsList.subList(start, end);
                        request.setAttribute("productsList", paginatedOrderList);
                        request.setAttribute("currentPage", page);
                        request.setAttribute("totalPages", totalPages);

                        request.setAttribute("alertMessage", "Please input valid data for the variant!");
                        request.setAttribute("openPopup", "popup_" + productID);
                        request.setAttribute("productsStocksList", productsStocksList);
                        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
                        return;
                    }
                } else if (keyString.startsWith("newVariantColor")) {
                    color = value[0];
                } else if (keyString.startsWith("newVariantQuantity")) {
                    try {
                        quantity = Integer.parseInt(value[0]);
                    } catch (NumberFormatException e) {
                        System.out.println(e);

                        List<Product> paginatedOrderList = productsList.subList(start, end);
                        request.setAttribute("productsList", paginatedOrderList);
                        request.setAttribute("currentPage", page);
                        request.setAttribute("totalPages", totalPages);

                        request.setAttribute("alertMessage", "Please input valid data for the variant!");
                        request.setAttribute("openPopup", "popup_" + productID);
                        request.setAttribute("productsStocksList", productsStocksList);
                        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
                        return;
                    }
                }

            }

            if (smDAO.checkIfStockExists(size, color)) {
//                List<Product> productsList = smDAO.getAllProducts();
//                List<Product> productsStocksList = smDAO.getProductsStocks();

                List<Product> paginatedOrderList = productsList.subList(start, end);
                request.setAttribute("productsList", paginatedOrderList);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                request.setAttribute("alertMessage", "Product variant already exists!");
                request.setAttribute("productsStocksList", productsStocksList);
                request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
                return;
            } else {
                int importID = smDAO.logAccountAndGetImportID(accountID);
                smDAO.addNewProductVariant(productID, size, color, quantity, importID);
                productsStocksList = smDAO.getProductsStocks();
                request.setAttribute("openPopup", "popup_" + productID);
            }

        }

        List<Product> paginatedOrderList = productsList.subList(start, end);
        request.setAttribute("productsList", paginatedOrderList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        //Debugging
//        request.setAttribute("openPopup", "popup_" + 1);
//        request.setAttribute("productsList", productsList);
        request.setAttribute("productsStocksList", productsStocksList);
        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        if (account.getRole() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
            return;
        }
        int accountID = account.getAccountID();

        StocksManagementDAO smDAO = new StocksManagementDAO();

        List<Product> productsList = smDAO.getAllProducts();
        List<Product> productsStocksList = smDAO.getProductsStocks();

        // Phân trang
        int page = 1;
        int recordsPerPage = 10;

        int totalRecords = productsList.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        // Tính toán chỉ mục bắt đầu và kết thúc cho trang hiện tại
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);

        List<Product> paginatedOrderList = productsList.subList(start, end);
        request.setAttribute("productsList", paginatedOrderList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

//        request.setAttribute("productsList", productsList);
        request.setAttribute("productsStocksList", productsStocksList);

        String confirmYes = request.getParameter("confirmYes");
        String confirmNo = request.getParameter("confirmNo");
        if (confirmYes != null) {
            //Debugging
            System.out.println("confirmYes: " + confirmYes);

            for (Product product : outOfStocksList) {
                smDAO.setProductStock(product.getStockID(), 0);
                product.setStockQuantity(0);
                loggedProducts.add(product);
            }
            outOfStocksList.clear();
            smDAO.logUpdatedProducts(accountID, loggedImportID, loggedProducts);
            loggedProducts.clear();

            productsStocksList = smDAO.getProductsStocks();
            request.setAttribute("productsStocksList", productsStocksList);
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        } else if (confirmNo != null) {
            //Debugging
            System.out.println("confirmNo: " + confirmNo);

            for (Product product : outOfStocksList) {
                loggedProducts.add(product);
            }

            outOfStocksList.clear();
            smDAO.logUpdatedProducts(accountID, loggedImportID, loggedProducts);
            loggedProducts.clear();

            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        }

        String outOfStocksProductName = null;
        Map stocksData = request.getParameterMap();
        loggedImportID = smDAO.logAccountAndGetImportID(accountID);
        for (Object key : stocksData.keySet()) {
            String keyString = (String) key;
            String[] value = (String[]) stocksData.get(keyString);
            keyString = keyString.replaceAll("[^\\d]", "");
            System.out.println("Key " + keyString + "   :   " + value[0]);

            if (value[0].trim().equalsIgnoreCase("")) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('One or more quantities is empty!');");
                out.println("</script>");
                return;
            } else {
                try {
                    Integer.parseInt(value[0]);
                } catch (NumberFormatException e) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('One or more quantities is invalid!');");
                    out.println("</script>");
                    return;
                }
            }

            int stockID = Integer.parseInt(keyString);
            int quantity = Integer.parseInt(value[0]);

            if (quantity == 0) {
                Product outOfStockProduct = smDAO.getProductStockByStockID(stockID);
                if (smDAO.getProductStockQuantityByID(stockID) != 0) {
                    outOfStocksList.add(outOfStockProduct);
                    outOfStocksProductName = smDAO.getProductNameByID(outOfStockProduct.getProductId());
                    //Debugging
                    System.out.println(outOfStocksProductName);
                } else {
                    loggedProducts.add(outOfStockProduct);
                }
                continue;
            }

            smDAO.setProductStock(stockID, quantity);
            loggedProducts.add(smDAO.getProductStockByStockID(stockID));
        }
        smDAO.logUpdatedProducts(accountID, loggedImportID, loggedProducts);
        loggedProducts.clear();

        if (outOfStocksList.size() != 0) {
            request.setAttribute("outOfStocksList", outOfStocksList);
            request.setAttribute("outOfStocksProductName", outOfStocksProductName);
            request.setAttribute("popupDisplay", "display: block;");
            //Debugging
            System.out.println("Products variants out of stock:");
            for (Product product : outOfStocksList) {
                System.out.println(smDAO.getProductNameByID(product.getProductId())
                        + " : " + product.getSize() + " : " + product.getColor());
            }
            request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
            return;
        }

        productsStocksList = smDAO.getProductsStocks();
        request.setAttribute("productsStocksList", productsStocksList);
        request.getRequestDispatcher("staff/stocksManager.jsp").forward(request, response);
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
