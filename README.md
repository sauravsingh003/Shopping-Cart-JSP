<h1 align="center">🛒 Shopping Cart JSP Web App</h1>

<p align="center">
  A sleek and modern shopping cart application built using <strong>JSP, Servlets, JDBC, and MySQL</strong>. <br/>
  Designed with Glassmorphism UI, Bootstrap 5, and Dark Mode support.
</p>

<p align="center">
  <img src="https://img.shields.io/github/languages/top/niteshchauhan0/shopping-cart-jsp?style=for-the-badge" />
  <img src="https://img.shields.io/github/last-commit/niteshchauhan0/shopping-cart-jsp?style=for-the-badge" />
  <img src="https://img.shields.io/github/issues/niteshchauhan0/shopping-cart-jsp?style=for-the-badge" />
</p>

---

## 🚀 Features

- ✅ Product selection and quantity update
- ✅ Add to cart and live cart preview
- ✅ Checkout page with order summary
- ✅ Responsive glassmorphism UI
- ✅ Dark mode toggle
- ✅ Toast notifications
- ✅ Cart persistence using `HttpSession`
- ✅ Built using MVC pattern

---

## 🛠️ Tech Stack

| Technology     | Purpose                        |
|----------------|--------------------------------|
| **JSP/Servlet**| Backend rendering & logic      |
| **JDBC**       | Database connectivity          |
| **MySQL**      | Product & cart data storage    |
| **Bootstrap 5**| Styling and responsiveness     |
| **FontAwesome**| Icons                          |
| **Java (Servlets)** | Controller logic          |
| **HTML/CSS/JS**| Frontend interactivity         |

---

## ⚙️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/niteshchauhan0/shopping-cart-jsp.git
cd shopping-cart-jsp
```

### 2. Import in Eclipse or IntelliJ
- Use Dynamic Web Project in Eclipse.
- Add Tomcat Server Runtime.
- Add mysql-connector-j.jar to /WEB-INF/lib/.

### 3. Create MySQL Database
Run this SQL:
```bash
CREATE DATABASE shopping_cart;
USE shopping_cart;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DOUBLE
);

INSERT INTO products (name, price) VALUES
('Red T-Shirt', 499.00),
('Blue Jeans', 799.00),
('Sneakers', 1299.00),
('Hoodie', 999.00);
```

### 4. Update DB Credentials
Update your DBUtil.java file with:
```bash
String url = "jdbc:mysql://localhost:3306/shopping_cart";
String user = "root";
String password = "your_mysql_password";
```

### 5. Run the Project
Right-click → Run on Server (Tomcat)

Visit ``` http://localhost:8080/ShoppingAssessment/```

---

👨‍💻 Author
Made with ❤️ by Nitesh Singh

