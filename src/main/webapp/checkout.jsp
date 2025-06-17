<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🧾 Checkout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <!-- Custom Glassmorphism + Theme Styling -->
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #e6f5ea, #c5eddc);
            min-height: 100vh;
            margin: 0;
            padding: 0;
            color: #222;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(0, 128, 0, 0.1);
            box-shadow: 0 0 25px rgba(0, 128, 0, 0.1);
        }

        .form-label, h2, h5 {
            color: #222;
        }

        .list-group-item {
            background-color: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            color: #222;
        }

        .btn-custom {
            border-radius: 12px;
            font-weight: 600;
            background-color: #27ae60;
            color: #fff;
        }

        .btn-custom:hover {
            background-color: #1e8e50;
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

        .dark-mode .form-control,
        .dark-mode .list-group-item {
            background-color: rgba(30, 30, 30, 0.8);
            color: #fff;
        }

        .dark-mode .form-label,
        .dark-mode h2,
        .dark-mode h5 {
            color: #f1f1f1;
        }
    </style>

    <!-- Theme Script -->
    <script>
        function toggleTheme() {
            document.body.classList.toggle('dark-mode');
        }
    </script>
</head>
<body>

    <!-- Theme Toggle -->
    <div class="toggle-theme" onclick="toggleTheme()">
        <i class="fas fa-circle-half-stroke me-1"></i> Theme
    </div>

    <div class="container py-5">
        <div class="text-center mb-4">
            <h2 class="text-success fw-bold">🧾 Checkout</h2>
        </div>

        <form action="ConfirmOrderServlet" method="post" class="glass-card mx-auto" style="max-width: 600px;">
            <div class="mb-3">
                <label for="name" class="form-label">👤 Full Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">📧 Email Address</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">🏠 Shipping Address</label>
                <textarea name="address" rows="3" class="form-control" required></textarea>
            </div>

            <h5 class="text-muted mt-4">🛒 Order Summary:</h5>
            <ul class="list-group mb-4">
                <%
                    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
                    double total = 0;
                    if (cart != null) {
                        for (Map<String, Object> item : cart) {
                            String name = (String) item.get("name");
                            double price = (double) item.get("price");
                            int quantity = (int) item.get("quantity");
                            double subtotal = price * quantity;
                            total += subtotal;
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <span><%= name %> × <%= quantity %></span>
                    <span>&#8377;<%= subtotal %></span>
                </li>
                <%  
                        }
                    }
                %>
                <li class="list-group-item fw-bold d-flex justify-content-between">
                    <span>Total</span>
                    <span>&#8377;<%= total %></span>
                </li>
            </ul>

            <button type="submit" class="btn btn-custom w-100">✅ Confirm Order</button>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
