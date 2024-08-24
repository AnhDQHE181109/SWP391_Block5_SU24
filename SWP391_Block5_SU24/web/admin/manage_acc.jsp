<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.AccountDAO" %>
<%@ page import="entity.Account" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Admin Home</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="${pageContext.request.contextPath}/images/favicon.ico" rel="icon">

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

        <script>
            function filterAccounts() {
                const role = document.getElementById("roleFilter").value;
                window.location.href = `manage_acc.jsp?role=` + role;
            }

            function editAccount(accountId, username, name, email, phoneNumber, address) {
                document.querySelector('#editForm [name="accountId"]').value = accountId;
                document.querySelector('#editForm #username').value = username;
                document.querySelector('#editForm #name').value = name;
                document.querySelector('#editForm #email').value = email;
                document.querySelector('#editForm #phoneNumber').value = phoneNumber;
                document.querySelector('#editForm #address').value = address;

                // Show the modal
                $('#editModal').modal('show');
            }

            function updateStatus(accountId, status) {
                if (confirm("Are you sure you want to " + (status === 1 ? "activate" : "deactivate") + " this account?")) {
                    window.location.href = `${pageContext.request.contextPath}/UpdateAccountController?action=updateStatus&accountId=${accountId}&status=${status}`;
                            }
                        }
        </script>
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
                        <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>DASHMIN</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="ms-3">
                            <h4 class="mb-0">Welcome Admin</h4>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Account Management</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="manage_acc.jsp" class="dropdown-item">View all account</a>
                                <a href="addStaffAccount.jsp" class="dropdown-item">Create account</a>
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
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="images/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="images/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        
                                    </div>
                                </a>
                                
                        </div>
                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/images/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">Admin</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="${pageContext.request.contextPath}/LogoutController" class="dropdown-item">Log Out</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->

                <!-- Error message display -->

                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
                <% } %>

                <!-- Success message display -->
                <%
                    String success = request.getParameter("success");
                    if (success != null) {
                %>
                <div class="alert alert-success">
                    Account updated successfully!
                </div>
                <% } %> <!-- Make sure this is closed properly -->

                <!-- Table Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="bg-light rounded h-100 p-4">
                                <h6 class="mb-4">Account Management</h6>

                                <!-- Role Filter Dropdown -->
                                <div class="mb-3">
                                    <label for="roleFilter" class="form-label">Choose Account Role</label>
                                    <select id="roleFilter" class="form-select" onchange="filterAccounts()">
                                        <option value="all" <% if (request.getParameter("role") == null || request.getParameter("role").equals("all")) { %> selected <% } %>>All</option>
                                        <option value="1" <% if ("1".equals(request.getParameter("role"))) { %> selected <% } %>>Customer</option>
                                        <option value="2" <% if ("2".equals(request.getParameter("role"))) { %> selected <% } %>>Staff</option>
                                        <option value="3" <% if ("3".equals(request.getParameter("role"))) { %> selected <% } %>>Manager</option>
                                        <option value="4" <% if ("4".equals(request.getParameter("role"))) { %> selected <% } %>>Admin</option>
                                    </select>
                                </div>

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Account ID</th>
                                                <th scope="col">Username</th>
                                                <th scope="col">Phone Number</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Address</th>
                                                <th scope="col">Role</th>
                                                <th scope="col">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Account rows based on role -->
                                            <% 
                                                AccountDAO accountDAO = new AccountDAO();
                                                List<Account> accounts;
                                                String selectedRole = request.getParameter("role");

                                                if (selectedRole == null || selectedRole.equals("all")) {
                                                    accounts = accountDAO.getAccounts(); // Assuming this method exists
                                                } else {
                                                    int role = Integer.parseInt(selectedRole);
                                                    accounts = accountDAO.getAccountsByRole(role);
                                                }

                                                for (Account account : accounts) {
                                            %>
                                            <tr>
                                                <td><%= account.getAccountID() %></td>
                                                <td><%= account.getUsername() %></td>
                                                <td><%= account.getPhoneNumber() %></td>
                                                <td><%= account.getEmail() %></td>
                                                <td><%= account.getAddress() %></td>
                                                <td>
                                                    <% 
                                                        String roleText;
                                                        switch (account.getRole()) {
                                                            case 1:
                                                                roleText = "Customer";
                                                                break;
                                                            case 2:
                                                                roleText = "Staff";
                                                                break;
                                                            case 3:
                                                                roleText = "Manager";
                                                                break;
                                                            case 4:
                                                                roleText = "Admin";
                                                                break;
                                                            default:
                                                                roleText = "Unknown";
                                                        }
                                                    %>
                                                    <%= roleText %>
                                                </td>
                                                <td>
                                                    <% if (account.getRole() != 1) { %>
                                                    <button class="btn btn-primary btn-sm" 
                                                            onclick="editAccount(
                                                            <%= account.getAccountID() %>,
                                                                            '<%= account.getUsername() %>',
                                                                            '<%= account.getName() %>',
                                                                            '<%= account.getEmail() %>',
                                                                            '<%= account.getPhoneNumber() %>',
                                                                            '<%= account.getAddress() %>'
                                                                            )">Edit</button>
                                                    <% } %>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- Table End -->

                <!-- Edit Account Modal -->
                <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel">Edit Account</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editForm" action="${pageContext.request.contextPath}/UpdateAccountController" method="post">
                                    <input type="hidden" name="accountId" />

                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" disabled>
                                    </div>

                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" name="name">
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password">
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email">
                                    </div>

                                    <div class="mb-3">
                                        <label for="phoneNumber" class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
                                    </div>

                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address">
                                    </div>

                                    <!-- Role selection -->
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Role</label>
                                        <select class="form-control" id="role" name="role">
                                            <option value="2">Staff</option>
                                            <option value="3">Manager</option>
                                            <option value="4">Admin</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Edit Account Modal End -->

                <!-- Footer Start -->

                <!-- Footer End -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
       
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
