<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import = "entity.*" %>
<%@page import = "java.util.*" %>
<%@page import = "jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
    <%Account account = (Account) session.getAttribute("account");%>
    <head>
        <title>Stocks management</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/staff/css/customer_m.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/staff/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/staff/font/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/staff/css/review_m.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

        <style>
            /* Chrome, Safari, Edge, Opera */
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }

            th {
                cursor: pointer;
            }
            .alert {
                padding: 20px;
                background-color: #f44336;
                color: white;
                margin-bottom: 15px;
                position: fixed;

                width:100%;
                z-index: 9999;
            }

            .closebtn {
                margin-left: 15px;
                color: white;
                font-weight: bold;
                float: right;
                font-size: 22px;
                line-height: 20px;
                cursor: pointer;
                transition: 0.3s;
            }

            .closebtn:hover {
                color: black;
            }
            .alert-timer {
                height: 5px;
                background-color: #f1f1f1;
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
            }

            .alert-timer-fill {
                height: 100%;
                background-color: orange; /* Green */
                width: 100%;
                transition: width 5s linear;
            }
        </style>

    </head>
<%if("true".equals(request.getParameter("auth_error"))){%>
        <div class="alert" id="alertDiv">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
            You do not have permission to access this pages.
            <div class="alert-timer">
                <div class="alert-timer-fill" id="timerFill"></div>
            </div>
        </div>
        <%}%>
    <body onload="time()" class="app sidebar-mini rtl">
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
                    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://thumbs.dreamstime.com/b/admin-sign-laptop-icon-stock-vector-166205404.jpg" width="50px"
                                                        alt="User Image">

                    </div>
                    <hr>
                    <ul class="app-menu">
                        <!-- <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                                    class="app-menu__label">Dashboard</span></a></li>
                        <li><a class="app-menu__item" href="customer_manage"><i class='app-menu__icon bx bx-user-voice'></i><span
                                    class="app-menu__label">Customers</span></a></li> -->
                        <li><a class="app-menu__item" href="stocksManager"><i
                                    class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Products</span></a>
                        </li>
                        <li><a class="app-menu__item" href="importProductStocks"><i
                                    class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Import product variants</span></a>
                        </li>
                        <li><a class="app-menu__item" href="Ordercontroller"><i class='app-menu__icon bx bx-task'></i><span
                                    class="app-menu__label">Orders</span></a></li>
                        <li><a class="app-menu__item" href="productStockImport"><i class='app-menu__icon bx bx-task'></i><span
                                    class="app-menu__label">Reviews</span></a></li>

                        <button class="admin_logout" onclick="showLogoutBox()">Logout</button>
                        <div class="logout-box" id="logoutBox" style="display: none">
                            <h2>Logout</h2>
                            <p>Are you sure you want to logout?</p>
                            <button onclick="logout()">Logout</button>
                            <button onclick="cancelLogout()">Cancel</button>
                        </div>
                    </ul>
                </aside>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>All Products</b></a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-md-4" style="display: flex; justify-content: flex-start; align-items: center;">
                                    <!-- <a class="btn btn-add btn-sm" href="product_manage?action=insert" title="Thêm">
                                        <i class="fas fa-plus"></i> Add a new product
                                    </a> -->
                                </div> 
                                <div class="col-md-4" style="display: flex; justify-content: center; align-items: center;">
                                    <!-- Button for sorting -->
                                    <!-- <button onclick="sortTableByNameAscendingDescending()" class="btn btn-primary btn-sm" id="sortButton">
                                        <i class="fas fa-sort-amount-down"></i> Sort by Name (Asc)
                                    </button> -->
                                </div>
                                <div class="col-md-4" style="display: flex; justify-content: flex-end; align-items: center;">
                                    <input type="text" id="searchInput" class="form-control" onkeyup="searchProductsByName()" placeholder="Search by name.." style="margin-right: 5px;">
                                    <button onclick="searchProductsByName()" class="btn btn-primary btn-sm">
                                        <i class="ti-search"></i> Search
                                    </button>
                                </div>
                            </div>


                            <div id="popupAddNewProductForm" class="popup" style="display: none;">
                                <!-- Popup content for each order -->
                                <div class="popup-content">
                                    <div class="row">
                                        <p class="h2">Add a new product model </p>

                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1">Name</span>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Name" aria-label="Name" aria-describedby="basic-addon1">
                                        </div>

                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1">Origin</span>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Origin" aria-label="Origin" aria-describedby="basic-addon1">
                                        </div>

                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1">Material</span>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Material" aria-label="Material" aria-describedby="basic-addon1">
                                        </div>

                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1">Picture</span>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Picture" aria-label="Picture" aria-describedby="basic-addon1">
                                        </div>

                                    </div>
                                    <div id="submit-type">
                                        <button type="button" onclick="closePopup('popup_${order.orderID}')">Close</button>
                                        <button type="button" class="btn btn-success">ADD</button>
                                    </div>
                                </div>
                            </div>


                            <%
                                List<Product> productsList = (List<Product>) request.getAttribute("productsList");
                                List<Product> productsStocksList = (List<Product>) request.getAttribute("productsStocksList");
                            %>

                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Picture</th>
                                        <th onclick="sortTableAscendingDescending(1)">Brand</th>
                                        <th onclick="sortTableAscendingDescending(2)">Name</th>
                                        <th onclick="sortTableAscendingDescending(3)">Category</th>
                                        <th> Status </th>
                                        <th> </th>
                                        <th> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  if (productsList == null || productsList.isEmpty()) { %>
                                    <tr>
                                        <td class="col-sm-8 col-md-6">No products available in the system!</td>
                                    </tr>
                                    <%
                                        } else { 
                                            for (Product product : productsList) { %>
                                    <tr>
                                        <td><img style="width: 60px; height: 60px;" src="<%=product.getImageURL() %>"></td>
                                        <td><%=product.getBrandName() %></td>
                                        <td><%=product.getProductName() %></td>
                                        <td><%=product.getCategoryName() %></td>
                                        <td><%=product.getProductStatus() %></td>
                                        <td>
                                            <a href="staff/editproduct.jsp?productId=<%=product.getProductId() %>" class="btn btn-primary">Edit</a>
                                        </td>
                                        <% if (account.getRole() == 2) { %>
                                        <td class="col-1">
                                            <button class="btn btn-info" onclick="openPopup('popup_<%=product.getProductId() %>')">View variants</button>
                                            <div id="popup_<%=product.getProductId() %>" class="popup" style="display: none;">
                                                <!-- Popup content for each order -->
                                                <div class="popup-content">
                                                    <form id="stocksForm_<%=product.getProductName() %>" action="stocksManager" method="post">
                                                        <div class="row">
                                                            <p class="h2">Stocks available for <%=product.getProductName() %></p>
                                                            <table class="table">
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col">#</th>
                                                                        <th scope="col">Size</th>
                                                                        <th scope="col">Color</th>
                                                                        <th scope="col">Quantity</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% if (productsStocksList == null || productsStocksList.isEmpty()) { %>
                                                                    <tr>
                                                                        <th>Error! Product's stocks are empty!</th>
                                                                    </tr>
                                                                    <% } else { 
                                                                           int i = 1;
                                                                           for (Product productStocks : productsStocksList) {
                                                                            if (product.getProductName().equalsIgnoreCase(productStocks.getProductName())) {
                                                                    %>
                                                                    <tr>
                                                                        <th scope="row"><%=i %></th>
                                                                        <td><%=productStocks.getSize() %></td>
                                                                        <td><%=productStocks.getColor() %></td>
                                                                        <!-- <td><input type="number" class="form-control" 
                                                                                   name="<%=productStocks.getStockID()%>_quantity"
                                                                                   id="<%=productStocks.getStockID()%>_quantity" 
                                                                                   value="<%=productStocks.getTotalQuantity() %>" required min="0" max="99" onkeypress="return event.charCode >= 48 && event.charCode <= 57"
                                                                                   onfocusout="checkIfFieldEmpty('<%=productStocks.getStockID()%>_quantity', '<%=productStocks.getTotalQuantity() %>')"
                                                                                   readonly></td> -->
                                                                        <td><input type="number" class="form-control" 
                                                                                   name="<%=productStocks.getStockID()%>_quantity"
                                                                                   id="<%=productStocks.getStockID()%>_quantity" 
                                                                                   value="<%=productStocks.getTotalQuantity() %>" required min="0" max="99" onkeypress="return event.charCode >= 48 && event.charCode <= 57"
                                                                                   readonly></td>
                                                                    </tr>
                                                                    <%      i++;
                                                                            }
                                                                           }
                                                                       } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </form>
                                                    <div id="submit-type" class="col-md-12">
                                                        <button type="button" class="btn btn-danger col-md-3" onclick="closePopup('popup_<%=product.getProductId() %>')">Close</button>
                                                         <!-- <button type="button" onclick="document.getElementById( & quot; stocksForm_<%=product.getProductName() %> & quot; ).submit()" class="btn btn-primary col-md-3">Update</button> -->
                                                        <!-- <button type="button" class="btn btn-success col-md-6" onclick="openPopup('popupAddNewVariantForm_<%=product.getProductId() %>')">Add a new variant</button> -->
                                                    </div>

                                                </div>
                                            </div>

                                            <div id="popupAddNewVariantForm_<%=product.getProductId() %>" class="popup" style="display: none;">
                                                <!-- Popup content for each order -->
                                                <div class="popup-content">
                                                    <div class="row">
                                                        <p class="h2">Add a new variant for <%=product.getProductName() %></p>

                                                        <form id="addNewVariantForm_<%=product.getProductId() %>" action="stocksManager" method="get">
                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">Size</span>
                                                                </div>
                                                                <input type="number" id="newVariantSize_<%=product.getProductId() %>" name="newVariantSize_<%=product.getProductId() %>" class="form-control" placeholder="Size"
                                                                       aria-label="Size" aria-describedby="basic-addon1" required min="28" max="40"
                                                                       onblur="validateEmptyMinMax('newVariantSize_<%=product.getProductId() %>', 28, 40, 'Size')"
                                                                       onkeypress="return event.charCode >= 48 && event.charCode <= 57">
                                                            </div>

                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">Color</span>
                                                                </div>
                                                                <!-- <input type="text" id="newVariantColor_<%=product.getProductId() %>" name="newVariantColor_<%=product.getProductId() %>" class="form-control" placeholder="Color" 
                                                                aria-label="Color" aria-describedby="basic-addon1" required
                                                                onfocusout="checkIfFieldEmpty('newVariantColor_<%=product.getProductId() %>', 'Size')"> -->
                                                                <select class="form-select" name="newVariantColor_<%=product.getProductId() %>" id="newVariantColor_<%=product.getProductId() %>"
                                                                        aria-label="Color" aria-describedby="basic-addon1">
                                                                    <option value="White">White</option>
                                                                    <option value="Black">Black</option>
                                                                    <option value="Red">Red</option>
                                                                    <option value="Pink">Pink</option>
                                                                    <option value="Yellow">Yellow</option>
                                                                </select>
                                                            </div>

                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">Quantity</span>
                                                                </div>
                                                                <input type="number" id="newVariantQuantity_<%=product.getProductId() %>" name="newVariantQuantity_<%=product.getProductId() %>" class="form-control" placeholder="Quantity" 
                                                                       aria-label="Quantity" aria-describedby="basic-addon1" required min="1" max="99"
                                                                       onblur="validateEmptyMinMax('newVariantQuantity_<%=product.getProductId() %>', 1, 99, 'Quantity')"
                                                                       onkeypress="return event.charCode >= 48 && event.charCode <= 57">
                                                            </div>

                                                            <input type="text" name="newVariantProductID" value="<%=product.getProductId() %>" hidden>

                                                        </form>

                                                        <div id="submit-type" class="col-md-12">
                                                            <button type="button" class="btn btn-danger col-md-3" onclick="closePopup('popupAddNewVariantForm_<%=product.getProductId() %>')">Close</button>
                                                            <button type="button" class="btn btn-success col-md-9" onclick="document.getElementById( & quot; addNewVariantForm_<%=product.getProductId() %> & quot; ).submit()">ADD</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </td>

                                        <!-- <td>
                                            <button class="update-product-btn" onclick="showUpdateForm('${product.bookID}', '${product.bookName}', '${product.authorName}', '${product.publisherName}', '${product.publisherDate}', '${product.price}', '${product.quantity}', '${product.detailbook}', '${product.img_1}', '${product.img_2}', '${product.img_3}', '${product.img_4}')">Update</button>
                                            <form method="post" action="product_manage?action=updateproduct" style="display: none;" id="updateForm${product.bookID}">
                                                <input type="hidden" name="action" value="updateproduct">
                                                <input type="hidden" name="bookID" value="${product.bookID}">
                                                Name: <input type="text" name="bookName" value="${product.bookName}"><br>
                                                Author: <input type="text" name="authorName" value="${product.authorName}"><br>
                                                Publisher: <input type="text" name="publisherName" value="${product.publisherName}"><br>
                                                Publisher Date: <input type="text" name="publisherDate" value="${product.publisherDate}"><br>
                                                Genre: <select class="form-control" name="genres">
                                                    <option value="">-- Choose Genre --</option>
                                        <c:forEach items="${genreList3}" var="genre">
                                            <option value="${genre.genreName}">${genre.genreName}</option>
                                        </c:forEach>
                                    </select>
                                    Price: <input type="text" name="price" value="${product.price}"><br>
                                    Quantity: <input type="text" name="quantity" value="${product.quantity}"><br>
                                    Details: <input type="text" name="detailbook" value="${product.detailbook}"><br>
                                    Image 1: <input type="text" name="image1" value="${product.img_1}"><br>
                                    Image 2: <input type="text" name="image2" value="${product.img_2}"><br>
                                    Image 3: <input type="text" name="image3" value="${product.img_3}"><br>
                                    Image 4: <input type="text" name="image4" value="${product.img_4}"><br>
                                    <input type="submit" value="update">
                                </form>
                                <form method="post" action="product_manage?action=deleteproduct" style="display: inline;" id="deleteForm${product.bookID}">
                                    <input type="hidden" name="action" value="deleteproduct">
                                    <input type="hidden" name="bookID" value="${product.bookID}">
                                    <button type="button" class="delete-product-btn" onclick="confirmDelete('${product.bookID}')">Delete</button>
                                </form>

                            </td> -->
                                    </tr>
                                    <% } %>
                                    <% }
                                        } %>
                                </tbody>
                            </table>

                            <div>
                                <c:if test="${currentPage > 1}">
                                    <a href="stocksManager?page=${currentPage - 1}">Previous</a>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="stocksManager?page=${i}">${i}</a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="stocksManager?page=${currentPage + 1}">Next</a>
                                </c:if>
                            </div>

                            <%
                                List<Product> outOfStocksList = (List<Product>) request.getAttribute("outOfStocksList");
                                String outOfStocksProductName = (String) request.getAttribute("outOfStocksProductName");
                                String popupDisplay = (String) request.getAttribute("popupDisplay");
                                if (outOfStocksProductName == null) {
                                    outOfStocksProductName = "";
                                }
                                if (popupDisplay == null) {
                                    popupDisplay = "display: none;";
                                }
                            %>
                            <div id="popup_outOfStockConfirm" class="popup" style="<%=popupDisplay %>">
                                <!-- Popup content for each order -->
                                <div class="popup-content">
                                    <form action="stocksManager" method="post">
                                        <div class="row">
                                            <p class="h2">Are you sure these items are out of stock for <%=outOfStocksProductName %>?</p>

                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">#</th>
                                                        <th scope="col">Size</th>
                                                        <th scope="col">Color</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% int i = 1;
                                                    if (outOfStocksList != null) {
                                                        for (Product outOfStocks : outOfStocksList) { %>
                                                    <tr>
                                                        <th scope="col"><%=i++ %></th>
                                                        <th scope="col"><%=outOfStocks.getSize() %></th>
                                                        <th scope="col"><%=outOfStocks.getColor() %></th>
                                                    </tr>
                                                    <% 
                                                        }
                                                    } %>
                                                </tbody>
                                            </table>

                                            <div id="submit-type" class="col-md-12">
                                                <button type="submit" name="confirmYes" value="yes" class="btn btn-success col-md-6">Yes</button>
                                                <button type="submit" name="confirmNo" value="no" class="btn btn-danger col-md-6">No</button>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <a href="staff/addproduct.jsp" class="btn btn-add btn-sm">
                <i class="fas fa-plus"></i> Add New Product
            </a>
        </main>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <script>
                                                                var ascDescStat = 1;
                                                                function sortTableAscendingDescending(column) {
                                                                    //Debugging
                                                                    console.log('Executed sort function');
                                                                    var table, rows, switching, i, x, y, shouldSwitch, dir, switchCount = 0;
                                                                    table = document.getElementById("sampleTable");
                                                                    switching = true;
                                                                    // Set the sorting direction to ascending:
                                                                    dir = "asc";
                                                                    /* Make a loop that will continue until
                                                                     no switching has been done: */
                                                                    while (switching) {
                                                                        switching = false;
                                                                        rows = table.rows;
                                                                        for (i = 1; i < (rows.length - 1); i++) {
                                                                            shouldSwitch = false;
                                                                            x = rows[i].getElementsByTagName("td")[column]; // Column index for Name (change if needed)
                                                                            y = rows[i + 1].getElementsByTagName("td")[column]; // Column index for Name (change if needed)
                                                                            if (dir == "asc") {
                                                                                if (x.innerHTML > y.innerHTML) {
                                                                                    shouldSwitch = true;
                                                                                    break;
                                                                                }
                                                                            } else if (dir == "desc") {
                                                                                if (x.innerHTML < y.innerHTML) {
                                                                                    shouldSwitch = true;
                                                                                    break;
                                                                                }
                                                                            }

                                                                        }
                                                                        if (shouldSwitch) {
                                                                            /* If a switch has been marked, make the switch
                                                                             and mark that a switch has been done: */
                                                                            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                                                                            switching = true;
                                                                            //Each time a switch is done, switchCount is incremented
                                                                            switchCount++;
                                                                        } else {
                                                                            /* If no switching has been done AND the direction is "asc",
                                                                             set the direction to "desc" and run the while loop again. */
                                                                            if (dir == "asc" && switchCount == 0) {
                                                                                dir = "desc";
                                                                                switching = true;
                                                                            }
                                                                        }
                                                                    }
                                                                    // if (ascDescStat == 1) {
                                                                    //     ascDescStat = 0;
                                                                    //     document.querySelector('#sortButton').innerHTML = '<i class="fas fa-sort-amount-down"></i> Sort by Name (Asc)';
                                                                    // } else {
                                                                    //     ascDescStat = 1;
                                                                    //     document.querySelector('#sortButton').innerHTML = '<i class="fas fa-sort-amount-up"></i> Sort by Name (Desc)';
                                                                    // }
                                                                }

                                                                function showUpdateForm(bookID, bookName, authorName, publisherName, publisherDate, price, quantity, detailbook, img_1, img_2, img_3, img_4) {
                                                                    // Hide all other update forms first
                                                                    jQuery("form[id^='updateForm']").hide();
                                                                    // Show the form for this product
                                                                    var formID = "updateForm" + bookID;
                                                                    var form = document.getElementById(formID);
                                                                    // Pre-fill the form with current product details
                                                                    form.elements["bookName"].value = decodeURIComponent(bookName);
                                                                    form.elements["authorName"].value = authorName;
                                                                    form.elements["publisherName"].value = publisherName;
                                                                    form.elements["publisherDate"].value = publisherDate;
                                                                    form.elements["price"].value = price;
                                                                    form.elements["quantity"].value = quantity;
                                                                    form.elements["detailbook"].value = detailbook;
                                                                    form.elements["image1"].value = img_1;
                                                                    form.elements["image2"].value = img_2;
                                                                    form.elements["image3"].value = img_3;
                                                                    form.elements["image4"].value = img_4;
                                                                    // Show the form
                                                                    jQuery("#" + formID).show();
                                                                }
        </script>

        <script>
            function showLogoutBox() {
                document.getElementById('logoutBox').style.display = 'block';
            }

            function logout() {
                window.location.href = 'LogoutController';
            }

            function cancelLogout() {
                window.location.href = 'stocksManager';
            }

            function openPopup(popupID) {
                // Display the popup
                document.getElementById(popupID).style.display = "block";
            }

            function closePopup(popupID) {
                // Hide the popup
                document.getElementById(popupID).style.display = "none";
            }

            function searchProductsByName() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("sampleTable");
                tr = table.getElementsByTagName("tr");
                if (/[\/\\<>&$#%"()!?|`~]/.test(filter)) {
                    alert('The search term cannot contain special characters!')
                } else {
                    if (filter.trim() == '') {
                        input.value = '';
                        filter = '';
                    }
                    // Loop through all table rows, and hide those that don't match the search query
                    for (i = 0; i < tr.length; i++) {
                        td = tr[i].getElementsByTagName("td")[2]; // Column index for book name, change if needed

                        if (td) {
                            txtValue = td.textContent || td.innerText;
                            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                tr[i].style.display = "";
                            } else {
                                tr[i].style.display = "none";
                            }
                        }
                    }
                }
            }

            function checkIfFieldEmpty(fieldID, initialValue) {
                //document.getElementById(fieldID).value = document.getElementById(fieldID).value.trim();
                // if (document.getElementById(fieldID).value == "") {
                //     alert("One or more quantities is empty!");
                // }
                if ($('#' + fieldID).val() == '') {
                    alert("One or more quantities is empty!");
                    document.getElementById(fieldID).value = initialValue;
                } else if ($('#' + fieldID).val() < 0) {
                    alert("One or more quantities cannot be less than 0!");
                    document.getElementById(fieldID).value = initialValue;
                } else if ($('#' + fieldID).val() > 99) {
                    alert("One or more quantities cannot be more than 99!");
                    document.getElementById(fieldID).value = initialValue;
                }
            }

            // function checkIfFieldEmpty(fieldID, type) {
            //     //document.getElementById(fieldID).value = document.getElementById(fieldID).value.trim();
            //     // if (document.getElementById(fieldID).value == "") {
            //     //     alert("One or more quantities is empty!");
            //     // }
            //     if (document.getElementById(fieldID).value.trim() == '') {
            //         alert(type + " cannot be empty!");
            //         document.getElementById(fieldID).value = '';
            //     }
            // }

            function validateQuantity(fieldID) {
                var quantity = parseInt($('#' + fieldID).val());
                if (isNaN(quantity)) {
                    document.getElementById(fieldID).value = 1;
                    alert("Invalid quantity!");
                } else if (quantity <= 0) {
                    document.getElementById(fieldID).value = 1;
                    alert("Quantity can't be less than or equal to 0!");
                } else if (quantity > 100) {
                    document.getElementById(fieldID).value = 100;
                    alert("Quantity can't be more than the stock available!");
                }
            }

            function validateQuantityInput(fieldID, initialValue) {
                checkIfFieldEmpty(fieldID, initialValue);
                validateQuantity(fieldID);
            }

            function validateEmptyMinMax(fieldID, min, max, type) {
                // var value = parseInt($('#' + fieldID).val());
                var value = document.getElementById(fieldID).value;
                if (value.trim() == '') {
                    document.getElementById(fieldID).value = '';
                    alert("Invalid " + type + "!");
                } else if (value < min) {
                    document.getElementById(fieldID).value = min;
                    alert(type + " can't be less than " + min + "!");
                } else if (value > max) {
                    document.getElementById(fieldID).value = max;
                    alert(type + " can't be more than " + max + "!");
                }
            }

        </script>
        <script>
            function confirmDelete(bookID) {
                var result = window.confirm("Are you sure you want to delete this product?");
                if (result) {
                    // Submit the form to delete the product
                    document.getElementById("deleteForm" + bookID).submit();
                }
            }
        </script>
        <script>
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
        </script>

        <% String openPopup = (String) request.getAttribute("openPopup");
if (openPopup != null) { %>
        <script>openPopup('<%=openPopup %>')</script>
        <% } %>

        <% String alertMessage = (String) request.getAttribute("alertMessage");
if (alertMessage != null) { %>
        <script>alert('<%=alertMessage %>')</script>
        <% } %>

    </body>
    <script>
        function startAlertTimer() {
            const timerFill = document.getElementById('timerFill');
            const alertBox = document.getElementById('alertDiv');

            // Start the timer
            setTimeout(function () {
                alertBox.style.display = 'none'; // Hide the alert
            }, 5000);

            // Start the progress bar animation
            timerFill.style.width = '0%';
        }

        // Start the timer when the page loads
        window.onload = startAlertTimer;
        document.getElementById('search-bar').addEventListener('input', function () {
            let query = this.value;
            if (query.length > 0) {
                fetchSuggestions(query);
            } else {
                document.getElementById('alertDiv').style.display = 'none';
            }
        });

        function fetchSuggestions(query) {
            fetch('SearchSuggestionsServlet?query=' + encodeURIComponent(query))
                    .then(response => response.text())
                    .then(data => {
                        let suggestionsBox = document.getElementById('suggestions');
                        suggestionsBox.innerHTML = data;
                        if (data.trim().length > 0) {
                            suggestionsBox.style.display = 'block';
                            // Add click event to each suggestion
                            suggestionsBox.querySelectorAll('.dropdown-item').forEach(item => {
                                item.addEventListener('click', function () {
                                    document.getElementById('search-bar').value = this.innerText.trim();
                                    suggestionsBox.style.display = 'none';
                                });
                            });
                        } else {
                            suggestionsBox.style.display = 'none';
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching suggestions:', error);
                    });
        }
    </script>
</html>

