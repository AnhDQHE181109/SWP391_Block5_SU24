
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Insert Product</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="staff2/css/main.css">
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
        </style>
        <!-- Navbar-->

        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://thumbs.dreamstime.com/b/admin-sign-laptop-icon-stock-vector-166205404.jpg" width="50px"
                                                alt="User Image">

            </div>
            <hr>
                    <ul class="app-menu">
                        <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                                    class="app-menu__label">Dashboard</span></a></li>
                        <li><a class="app-menu__item" href="customer_manage"><i class='app-menu__icon bx bx-user-voice'></i><span
                                    class="app-menu__label">Customers</span></a></li>
                        <li><a class="app-menu__item" href="stocksManager"><i
                                    class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Products</span></a>
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
            <div class="tile">
                <h3 class="tile-title">Stock Update Details</h3>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Stock Import Detail ID</th>
                            <th>Stock ID</th>
                            <th>Import ID</th>
                            <th>Product ID</th>
                            <th>Import Size</th>
                            <th>Import Color</th>
                            <th>Import Stock Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty stockImportDetails}">
                                <c:forEach var="detail" items="${stockImportDetails}">
                                    <tr>
                                        <!-- Displaying Stock Import Detail Information -->
                                        <td><c:out value="${detail.stockImportDetailID}" /></td>
                                        <td><c:out value="${detail.stockID}" /></td>
                                        <td><c:out value="${detail.importID}" /></td>
                                        <td>
                                            <!-- Fetching Product ID from Stock -->
                                            <c:choose>
                                                <c:when test="${not empty stockDetailsMap[detail.stockID]}">
                                                    <c:out value="${stockDetailsMap[detail.stockID].getProductID()}" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <!-- Fetching Import Size from Stock -->
                                            <c:choose>
                                                <c:when test="${not empty stockDetailsMap[detail.stockID]}">
                                                    <c:out value="${stockDetailsMap[detail.stockID].getSize()}" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <!-- Fetching Import Color from Stock -->
                                            <c:choose>
                                                <c:when test="${not empty stockDetailsMap[detail.stockID]}">
                                                    <c:out value="${stockDetailsMap[detail.stockID].getColor()}" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><c:out value="${detail.stockQuantity}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7">No details available for this import ID.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <a href="productStockImport" class="btn btn-primary">Return</a>
            </div>
        </div>
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
                            window.location.href = 'index.html';
                        }
                        function cancelLogout() {
                            window.location.href = 'productinsert';
                        }
                    </script>

                    </body>

                    </html>
