<%@ page import="java.sql.*, java.util.*, model.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Manage Requests</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/manager.css" rel="stylesheet">
    </head>

    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="manager_home.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"></i>Manager Site</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="${pageContext.request.contextPath}/images/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Jhon Doe</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="manager_home.jsp" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>

                        <a href="${pageContext.request.contextPath}/BrandController?action=list" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Brand </a>
                        <a href="${pageContext.request.contextPath}/CategoryController" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Category</a>
                        <a href="${pageContext.request.contextPath}/DiscountServlet?action=list" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Discount</a>
                        <a href="${pageContext.request.contextPath}/FeedbackController?username=&productName=&sortBy=rating" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Feedback</a>

                        <a href="productmanage.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Products</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Manage Requests</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="manage_request.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>View Requests</a>
                                <a href="history_requests.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Request History</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.jsp" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control border-0" type="search" placeholder="Search">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-envelope me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Message</span>
                            </a>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-bell me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Notification</span>
                            </a>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/images/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">Manager</span>
                            </a>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->

                <!-- Manage Requests Table Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light rounded h-100 p-4">
                        <h6 class="mb-4">Return Requests</h6>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Request ID</th>
                                        <th scope="col">Order ID</th>
                                        <th scope="col">Customer</th>
                                        <th scope="col">Reason</th>
                                        <th scope="col">Refund Amount</th>
                                        <th scope="col">Date Submitted</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        // Retrieve current page number from request
                                        int currentPage = 1;
                                        if (request.getParameter("page") != null) {
                                            currentPage = Integer.parseInt(request.getParameter("page"));
                                        }

                                        // Calculate the offset for the SQL query
                                        int recordsPerPage = 10;
                                        int offset = (currentPage - 1) * recordsPerPage;

                                        DBConnect dbConnect = new DBConnect();
                                        Connection conn = dbConnect.conn;
                                        String sql = "SELECT r.RequestID, r.OrderID, a.Name, r.Reason, r.Description, r.RefundAmount, r.DateSubmitted, r.Status " +
                                                     "FROM ReturnRequests r " +
                                                     "JOIN Accounts a ON r.AccountID = a.AccountID " +
                                                     "WHERE r.Status = 'Pending' " +
                                                     "ORDER BY r.DateSubmitted DESC " +
                                                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                                        PreparedStatement ps = conn.prepareStatement(sql);
                                        ps.setInt(1, offset);
                                        ps.setInt(2, recordsPerPage);
                                        ResultSet rs = ps.executeQuery();
                                    
                                        while (rs.next()) {
                                            int requestId = rs.getInt("RequestID");
                                            int orderId = rs.getInt("OrderID");
                                            String customerName = rs.getString("Name");
                                            String reason = rs.getString("Reason");
                                            String description = rs.getString("Description");
                                            double refundAmount = rs.getDouble("RefundAmount");
                                            java.sql.Date dateSubmitted = rs.getDate("DateSubmitted");
                                            String status = rs.getString("Status");
                                    %>
                                    <tr>
                                        <td><%= requestId %></td>
                                        <td><%= orderId %></td>
                                        <td><%= customerName %></td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewReasonModal<%= requestId %>">
                                                View
                                            </button>
                                            <!-- Reason Modal -->
                                            <div class="modal fade" id="viewReasonModal<%= requestId %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Reason for Return</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p><strong>Reason:</strong> <%= reason %></p>
                                                            <p><strong>Description:</strong> <%= description %></p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>$<%= refundAmount %></td>
                                        <td><%= dateSubmitted %></td>
                                        <td><%= status %></td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/ManageRequestController">
                                                <input type="hidden" name="requestId" value="<%= requestId %>">
                                                <button type="submit" name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                                                <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                        rs.close();
                                        ps.close();
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination Start -->
                        <div class="pagination">
                            <ul class="pagination">
                                <%
                                String countQuery = "SELECT COUNT(*) FROM ReturnRequests WHERE Status = 'Pending'";
                                PreparedStatement countStmt = conn.prepareStatement(countQuery);
                                ResultSet countRs = countStmt.executeQuery();
                                countRs.next();
                                int totalRecords = countRs.getInt(1);
                                int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
                                countRs.close();
                                countStmt.close();

                                for (int i = 1; i <= totalPages; i++) {
                                %>
                                <li class="<%= (i == currentPage) ? "active" : "" %>">
                                    <a href="manage_request.jsp?page=<%= i %>"><%= i %></a>
                                </li>
                                <%
                                }
                                %>
                            </ul>
                        </div>
                        <!-- Pagination End -->
                    </div>
                </div>
                <!-- Manage Requests Table End -->

                <!-- Footer Start -->
                <!-- Footer End -->
            </div>
            <!-- Content End -->
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
