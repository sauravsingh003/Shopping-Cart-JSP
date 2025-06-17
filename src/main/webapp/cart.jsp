<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🛒 Your Shopping Cart</title>
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
            padding: 8px 16px;
        }

        .btn-custom:hover {
            background-color: #1e8e50;
        }

        .quantity-control {
            display: flex;
            align-items: center;
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
            background: #0b0c10 !important;
            color: #fff !important;
        }

        .dark-mode .glass-card {
            background: rgba(20, 20, 20, 0.7);
            border-color: rgba(39, 174, 96, 0.4);
            color: #fff;
        }

        .dark-mode .table {
            color: #fff;
        }

        .dark-mode .btn-outline-danger,
        .dark-mode .btn-outline-success,
        .dark-mode .btn-outline-primary {
            color: #fff;
            border-color: #27ae60;
        }

        .summary-section {
            background: rgba(255,255,255,0.4);
            border-radius: 15px;
            padding: 15px;
        }

        .dark-mode .summary-section {
            background: rgba(20,20,20,0.5);
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
        <h2 class="fw-bold text-success">🛒 Your Shopping Cart</h2>
    </div>

    <div class="glass-card">
        <%
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="alert alert-warning">Your cart is empty.</div>
            <div class="text-center mt-4">
                <a href="index.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-home me-1"></i> Back to Home
                </a>
            </div>
        <%
            } else {
        %>
        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    double total = 0;
                    int totalItems = 0;
                    for (Map<String, Object> item : cart) {
                        int id = (int) item.get("id");
                        String name = (String) item.get("name");
                        double price = (double) item.get("price");
                        int quantity = item.get("quantity") != null ? (int) item.get("quantity") : 1;
                        double subtotal = price * quantity;
                        total += subtotal;
                        totalItems += quantity;
                %>
                    <tr>
                        <td><%= name %></td>
                        <td><%= price %></td>
                        <td>
                            <form action="CartServlet" method="post" class="quantity-control justify-content-center">
                                <input type="hidden" name="updateId" value="<%= id %>">
                                <button type="button" class="quantity-btn" onclick="changeQuantity(this, -1)">−</button>
                                <input type="number" name="newQuantity" value="<%= quantity %>" min="1" required class="quantity-input">
                                <button type="button" class="quantity-btn" onclick="changeQuantity(this, 1)">+</button>
                                <button type="submit" class="btn btn-sm btn-success ms-2">✔️</button>
                            </form>
                        </td>
                        <td><%= subtotal %></td>
                        <td>
                            <form action="CartServlet" method="post" class="d-flex justify-content-center align-items-center flex-wrap gap-2">
                                <input type="hidden" name="removeId" value="<%= id %>">
                                <input type="number" name="removeQty" value="1" min="1" max="<%= quantity %>" class="form-control form-control-sm" style="width: 80px;" required>
                                <button type="submit" class="btn btn-sm btn-outline-danger">🗑 Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                    <tr class="fw-bold">
                        <td colspan="3">Total</td>
                        <td colspan="2">₹<%= total %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Cart Summary Toggle -->
        <div class="text-center my-3">
            <button class="btn btn-outline-info" type="button" data-bs-toggle="collapse" data-bs-target="#cartSummary">
                🧾 Show Cart Summary
            </button>
        </div>

        <div id="cartSummary" class="collapse summary-section text-center mb-4">
            <p><strong>Total Items:</strong> <%= totalItems %></p>
            <p><strong>Total Price:</strong> ₹<%= total %></p>
        </div>

        <div class="d-flex flex-wrap gap-2 mt-4 justify-content-center">
            <form action="CartServlet" method="post" onsubmit="return confirm('Empty your cart?');">
                <input type="hidden" name="action" value="emptyCart">
                <button type="submit" class="btn btn-outline-danger">
                    <i class="fas fa-trash-alt me-1"></i> Empty Cart
                </button>
            </form>
            <a href="index.jsp" class="btn btn-outline-success">
                <i class="fas fa-arrow-left me-1"></i> Continue Shopping
            </a>
            <a href="checkout.jsp" class="btn btn-custom">
                <i class="fas fa-money-check-alt me-1"></i> Checkout
            </a>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- Toast -->
<%
    String toast = (String) session.getAttribute("toast");
    if (toast != null) {
%>
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
    <div class="toast show bg-success text-white align-items-center" role="alert">
        <div class="d-flex">
            <div class="toast-body"><%= toast %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>
<script>
    const toastEl = document.querySelector('.toast');
    if (toastEl) new bootstrap.Toast(toastEl).show();
</script>
<% session.removeAttribute("toast"); } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
