<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🛒Shopping Cart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #e6f5ea, #c5eddc);
            color: #333;
            margin: 0;
            min-height: 100vh;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(0, 128, 0, 0.1);
            box-shadow: 0 0 25px rgba(0, 128, 0, 0.1);
        }

        .btn-custom {
            border-radius: 12px;
            font-weight: 600;
            background-color: #27ae60;
            color: #fff;
            padding: 10px 20px;
        }

        .btn-custom:hover {
            background-color: #1e8e50;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .quantity-input {
            width: 60px;
            text-align: center;
            border-radius: 50px;
            border: 1px solid #27ae60;
            background-color: #ffffff;
            color: #000;
            padding: 4px 12px;
            font-weight: 600;
        }

        .quantity-btn {
            background-color: #27ae60;
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn:hover {
            background-color: #1e8e50;
        }

        .form-check-input {
            border: 2px solid #27ae60;
            width: 1.2em;
            height: 1.2em;
        }

        .form-check-input:checked {
            background-color: #27ae60;
            border-color: #27ae60;
        }

        .table thead {
            background-color: rgba(39, 174, 96, 0.1);
        }

        .toggle-theme {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 128, 0, 0.1);
            color: #333;
            border: 1px solid #27ae60;
            border-radius: 50px;
            padding: 10px 20px;
            cursor: pointer;
            z-index: 999;
        }

        .dark-mode {
            background: #0b0c10;
            color: #fff;
        }
    </style>

    <script>
        function toggleTheme() {
            const body = document.body;
            body.classList.toggle("dark-mode");
        }

        function changeQuantity(button, increment) {
            const input = button.parentElement.querySelector('input[type="number"]');
            let value = parseInt(input.value);
            if (isNaN(value)) value = 1;
            value += increment;
            if (value < 1) value = 1;
            if (value > 10) value = 10;
            input.value = value;
        }
    </script>
</head>
<body>
    <div class="toggle-theme" onclick="toggleTheme()">
        <i class="fas fa-circle-half-stroke me-1"></i> Theme
    </div>

    <div class="container py-5">
        <div class="text-center mb-4">
            <h2 class="fw-bold">🛒 Product Store</h2>
        </div>

        <div class="glass-card mx-auto" style="max-width: 960px;">
            <form action="CartServlet" method="post">
                <div class="table-responsive">
                    <table class="table table-hover text-center align-middle">
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Product</th>
                                <th>Price (₹)</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Connection conn = DBUtil.getConnection();
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM products");

                                    while (rs.next()) {
                            %>
                            <tr>
                                <td>
                                    <input class="form-check-input" type="checkbox" name="productId" value="<%= rs.getInt("id") %>">
                                </td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getDouble("price") %></td>
                                <td>
                                    <div class="quantity-control">
                                        <button type="button" class="quantity-btn" onclick="changeQuantity(this, -1)">−</button>
                                        <input type="number" name="quantity" class="quantity-input" min="1" max="10" value="1" required>
                                        <button type="button" class="quantity-btn" onclick="changeQuantity(this, 1)">+</button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='4' class='text-danger'>Error loading products.</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="text-center mt-4 d-flex justify-content-center gap-3 flex-wrap">
                    <button type="submit" class="btn btn-custom">
                        <i class="fas fa-cart-plus me-1"></i> Add to Cart
                    </button>
                    <a href="cart.jsp" class="btn btn-outline-success">
                        <i class="fas fa-shopping-basket me-1"></i> View Cart
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
