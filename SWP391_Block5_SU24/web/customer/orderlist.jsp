<%-- 
    Document   : orderlist
    Created on : Aug 22, 2024, 11:26:33 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #f4f4f4;
            border-bottom: 1px solid #ccc;
        }

        header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        header .search-bar input {
            width: 400px;
            padding: 5px;
        }

        header .cart button {
            padding: 10px;
        }

        .nav-bar {
            width: 200px;
            background-color: #ddd;
            padding: 20px;
        }

        .nav-bar .user-profile {
            margin-bottom: 20px;
            text-align: center;
        }

        .nav-bar .user-profile img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }

        .nav-bar nav ul {
            list-style-type: none;
            padding: 0;
        }

        .nav-bar nav ul li {
            margin: 10px 0;
        }

        .nav-bar nav ul li a {
            text-decoration: none;
            color: #333;
        }

        main {
            flex: 1;
            padding: 20px;
        }

        .filter-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .filter-bar button {
            padding: 10px 20px;
            background-color: #f4f4f4;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        .order-section {
            background-color: #eee;
            padding: 20px;
            border: 1px solid #ccc;
        }

        .order-section .order {
            background-color: #ccc;
            padding: 20px;
            border: 1px solid #999;
        }

        .order-section .order-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .order-section .order-actions button {
            padding: 10px 20px;
            border: 1px solid #666;
            background-color: #fff;
            cursor: pointer;
        }

    </style>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <div class="logo">Footwear</div>
            <div class="search-bar">
                <input type="text" placeholder="Search...">
            </div>
            <div class="cart">
                <button>Cart</button>
            </div>
        </header>

        <aside class="nav-bar">
            <div class="user-profile">
                <img src="user-placeholder.png" alt="User Profile">
            </div>
            <nav>
                <ul>
                    <li><a href="#">Nav Item 1</a></li>
                    <li><a href="#">Nav Item 2</a></li>
                    <li><a href="#">Nav Item 3</a></li>
                </ul>
            </nav>
        </aside>

        <main>
            <div class="filter-bar">
                <button>All</button>
                <button>Pending</button>
                <button>On delivery</button>
                <button>Completed</button>
                <button>Canceled</button>
                <button>Return</button>
            </div>

            <div class="order-section">
                <div class="order">
                    <h2>Order</h2>
                    <div class="order-actions">
                        <button>Buy again</button>
                        <button>Return request</button>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
