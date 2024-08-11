
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
        <link rel="stylesheet" type="text/css" href="css/main.css">
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
                        <h3 class="tile-title">Add products</h3>
                        <div class="tile-body">
                            <!-- Form for inserting a new product -->
                            <form class="row" action="product_manage?action=insertproduct" method="POST">
                                <div class="form-group col-md-3">
                                    <label class="control-label">Book ID</label>
                                    <input class="form-control" name="bookID" type="text" placeholder="Enter Book ID">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Book Name</label>
                                    <input class="form-control" name="bookName" type="text" placeholder="Enter Book Name">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Author Name</label>
                                    <input class="form-control" name="authorName" type="text" placeholder="Enter Author Name">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Publisher Name</label>
                                    <input class="form-control" name="publisherName" type="text" placeholder="Enter Publisher Name">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Publisher Date</label>
                                    <input class="form-control" name="publisherDate" type="date">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Price</label>
                                    <input class="form-control" name="price" type="text" placeholder="Enter Price">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Quantity</label>
                                    <input class="form-control" name="quantity" type="number" placeholder="Enter Quantity">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Detail Book</label>
                                    <textarea class="form-control" name="detailbook" rows="4" placeholder="Enter Book Details"></textarea>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Genre</label>
                                    <select class="form-control" name="genres">
                                        <option value="">-- Choose Genre --</option>
                                        <c:forEach items="${genreList2}" var="genre">
                                            <option value="${genre.genreName}">${genre.genreName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Image 1</label>
                                    <div class="thumbbox">
                                        <input type="text" id="uploadfile1" name="image1" onchange="readURL(this, 'thumbimage1');" />
                                        <img height="150" width="150" alt="Thumb image" id="thumbimage1" style="display: none" />
                                        <a class="removeimg" href="javascript:removeImage('thumbimage1');">Remove Image</a>
                                    </div>
                                    <div>
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose Image</a>
                                    </div>
                                </div>

                                <!-- Image 2 -->
                                <div class="form-group col-md-3">
                                    <label class="control-label">Image 2</label>
                                    <div class="thumbbox">
                                        <input type="text" id="uploadfile2" name="image2" onchange="readURL(this, 'thumbimage2');" />
                                        <img height="150" width="150" alt="Thumb image" id="thumbimage2" style="display: none" />
                                        <a class="removeimg" href="javascript:removeImage('thumbimage2');">Remove Image</a>
                                    </div>
                                    <div>
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose Image</a>
                                    </div>
                                </div>

                                <!-- Image 3 -->
                                <div class="form-group col-md-3">
                                    <label class="control-label">Image 3</label>
                                    <div class="thumbbox">
                                        <input type="text" id="uploadfile3" name="image3" onchange="readURL(this, 'thumbimage3');" />
                                        <img height="150" width="150" alt="Thumb image" id="thumbimage3" style="display: none" />
                                        <a class="removeimg" href="javascript:removeImage('thumbimage3');">Remove Image</a>
                                    </div>
                                    <div>
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose Image</a>
                                    </div>
                                </div>

                                <!-- Image 4 -->
                                <div class="form-group col-md-3">
                                    <label class="control-label">Image 4</label>
                                    <div class="thumbbox">
                                        <input type="text" id="uploadfile4" name="image4" onchange="readURL(this, 'thumbimage4');" />
                                        <img height="150" width="150" alt="Thumb image" id="thumbimage4" style="display: none" />
                                        <a class="removeimg" href="javascript:removeImage('thumbimage4');">Remove Image</a>
                                    </div>
                                    <div>
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose Image</a>
                                    </div>
                                </div>

                                <button class="btn btn-save" type="submit">Save</button>
                                <a class="btn btn-cancel" href="product_manage?action=null">Cancel</a>
                            </form>
                        </div>

                    </div>
                    </main>
                    <script>
                        function showLogoutBox() {
                            document.getElementById('logoutBox').style.display = 'block';
                        }
                        function logout() {
                            window.location.href = 'index.jsp';
                        }
                        function cancelLogout() {
                            window.location.href = 'productinsert';
                        }
                    </script>

                    </body>

                    </html>
