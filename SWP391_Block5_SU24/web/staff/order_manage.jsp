
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Manage Order</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="staff/css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script>
            function readURL(input, thumbimageId) {
                var imageUrl = input.value.trim(); // Get the URL from the input
                if (imageUrl !== "") {
                    // Check if a URL is provided
                    $("#" + thumbimageId).attr('src', imageUrl).show(); // Set the src attribute and display the image
                } else {
                    $("#" + thumbimageId).attr('src', '').hide(); // If no URL provided, hide the image
                }
            }
            function removeImage(thumbimageId) {
                $("#" + thumbimageId).attr('src', '').hide();
                var uploadFileId = thumbimageId.replace("thumbimage", "uploadfile");
                $("#" + uploadFileId).val('');
            }

            $(document).ready(function () {
                $(".Choicefile").click(function () {
                    var uploadFileId = $(this).siblings("input[type='file']").attr("id");
                    $("#" + uploadFileId).click();
                });

                $(".removeimg").click(function () {
                    var thumbimageId = $(this).siblings("img").attr("id");
                    removeImage(thumbimageId);
                });
            });
        </script>
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <style>
            .Choicefile {
                display: none;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
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
        <!-- Navbar-->

        <%if("true".equals(request.getAttribute("auth_error"))){%>
        <div class="alert" id="alertDiv">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
            You do not have permission to access this pages.
            <div class="alert-timer">
                <div class="alert-timer-fill" id="timerFill"></div>
            </div>
        </div>
        <%}%>


        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://thumbs.dreamstime.com/b/admin-sign-laptop-icon-stock-vector-166205404.jpg" width="50px"
                                                alt="User Image">

            </div>
            <hr>
                    <ul class="app-menu">

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
        
        
        <main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item">All Products</li>
            <li class="breadcrumb-item"><a href="#">Add products</a></li>
        </ul>
    </div>
    <div class="row">
        <div class="col-md-12">

            <!-- Search Form -->
            <div class="row">
                <div class="col-md-12">
                    <form action="Ordercontroller" method="get">
                        <label for="username">orderid</label>
                        <input type="text" id="orderid" name="orderid" />

                        <label for="orderDate">Order Date:</label>
                        <input type="date" id="orderDate" name="orderDate" />

                        <label for="status">Status:</label>
                        <select id="status" name="status">
                            <option value="">All</option>
                            <option value="0">Pending</option>
                            <option value="1">processing</option>
                            <option value="2">shipping</option>
                            <option value="3">done</option>
                            <option value="4">Cancelled</option>
                        </select>

                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" />

                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" />
                        
                           <select name="sortOrder">
                        <option value="desc">order date desc</option>
                        <option value="asc">order date asc</option>
                    </select>


                        <button type="submit">Search</button>
                    </form>
                </div>
            </div>

            <!-- Order List Table -->
            <div class="tile">
                <h3 class="tile-title">Order List</h3>
                <table border="1" class="table table-striped">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Username</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                                    <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.id}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.status}</td>
                </tr>
            </c:forEach>
                        <c:forEach var="order" items="${orderList}">
                            <tr>
                                <td>${order.orderID}</td>
                                <td>${usernameMap[order.accountID]}</td> <!-- Assuming usernameMap contains usernames -->
                                 <td hidden>${addressMap[order.accountID]}</td>
                                 <td hidden>${phoneMap[order.accountID]}</td>
                                <td>${order.orderDate}</td>
                                <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">Pending</c:when>
                                    <c:when test="${order.status == 1}">Processing</c:when>
                                    <c:when test="${order.status == 2}">Shipping</c:when>
                                    <c:when test="${order.status == 3}">Done</c:when>
                                    <c:when test="${order.status == 4}">Cancelled</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                                <td>
                                    <form action="Orderdetailcontroller" method="get">
                                        <input type="hidden" name="adress" value="${addressMap[order.accountID]}" />
                                         <input type="hidden" name="phone" value="${phoneMap[order.accountID]}" />
                                        <input type="hidden" name="status" value="${order.status}" />
                                        <input type="hidden" name="id" value="${order.orderID}" />
                                        <input type="hidden" name="user" value="${usernameMap[order.accountID]}" />
                                        <input type="hidden" name="service" value="detailService" />
                                        <button type="submit">Detail</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination Navigation -->
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="Ordercontroller?page=${currentPage - 1}">Previous</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="Ordercontroller?page=${i}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="Ordercontroller?page=${currentPage + 1}">Next</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>

         <script>
            function showLogoutBox() {
                document.getElementById('logoutBox').style.display = 'block';
            }
            function logout() {
                window.location.href = 'LogoutController';
            }
            function cancelLogout() {
                window.location.href = 'productinsert';
            }
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
                    </script>

                    </body>

                    </html>

