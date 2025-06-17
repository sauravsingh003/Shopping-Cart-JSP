<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Glassmorphism Styling -->
    <style>
        body {
            background: linear-gradient(to bottom right, #e6f5ea, #c5eddc);
            color: #333;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.25);
            border-radius: 20px;
            padding: 40px;
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        .btn {
            border-radius: 10px;
        }
    </style>
</head>

<body>
    <div class="glass-card text-center">
        <h4 class="text-success">✅ Order Confirmed!</h4>
        <h5 class="mt-3 text-success"><%= request.getAttribute("message") %></h5>
        <p class="mt-3">We will deliver your order soon. You can continue shopping now.</p>
        <a href="index.jsp" class="btn btn-primary mt-4">🏠 Back to Home</a>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
