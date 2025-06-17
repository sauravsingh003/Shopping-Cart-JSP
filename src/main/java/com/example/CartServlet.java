package com.example;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        if ("emptyCart".equals(action)) {
            cart.clear();
            session.setAttribute("cart", cart);
            session.setAttribute("toast", "🧺 Cart has been emptied.");
            response.sendRedirect("cart.jsp");
            return;
        }

        String removeIdStr = request.getParameter("removeId");
        String removeQtyStr = request.getParameter("removeQty");
        if (removeIdStr != null) {
            int removeId = Integer.parseInt(removeIdStr);
            int removeQty = 1;
            try {
                removeQty = Integer.parseInt(removeQtyStr);
            } catch (NumberFormatException ignored) {}

            Iterator<Map<String, Object>> iterator = cart.iterator();
            while (iterator.hasNext()) {
                Map<String, Object> item = iterator.next();
                if ((int) item.get("id") == removeId) {
                    int currentQty = item.get("quantity") != null ? (int) item.get("quantity") : 1;
                    if (currentQty <= removeQty) {
                        iterator.remove();
                        session.setAttribute("toast", "🗑️ Item removed from cart.");
                    } else {
                        item.put("quantity", currentQty - removeQty);
                        session.setAttribute("toast", removeQty + " unit(s) removed from cart.");
                    }
                    break;
                }
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");
            return;
        }

 
        String updateIdStr = request.getParameter("updateId");
        String newQtyStr = request.getParameter("newQuantity");
        if (updateIdStr != null && newQtyStr != null) {
            try {
                int updateId = Integer.parseInt(updateIdStr);
                int newQty = Integer.parseInt(newQtyStr);

                if (newQty <= 0) {
                    cart.removeIf(item -> (int) item.get("id") == updateId);
                    session.setAttribute("toast", "❌ Item removed due to zero quantity.");
                } else {
                    for (Map<String, Object> item : cart) {
                        if ((int) item.get("id") == updateId) {
                            item.put("quantity", newQty);
                            session.setAttribute("toast", "🔄 Quantity updated.");
                            break;
                        }
                    }
                }

            } catch (NumberFormatException e) {
                session.setAttribute("toast", "⚠️ Invalid quantity update.");
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");
            return;
        }

        String[] selectedIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");

        if (selectedIds != null && quantities != null) {
            try (Connection conn = DBUtil.getConnection()) {
                for (int i = 0; i < selectedIds.length; i++) {
                    int id = Integer.parseInt(selectedIds[i]);
                    int quantity = 1;

                    if (i < quantities.length) {
                        try {
                            quantity = Integer.parseInt(quantities[i]);
                        } catch (NumberFormatException ignored) {
                            quantity = 1;
                        }
                    }

                    boolean exists = false;
                    for (Map<String, Object> item : cart) {
                        if ((int) item.get("id") == id) {
                            int existingQty = item.get("quantity") != null ? (int) item.get("quantity") : 1;
                            item.put("quantity", existingQty + quantity);
                            exists = true;
                            break;
                        }
                    }

                    if (!exists) {
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
                        ps.setInt(1, id);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("id", rs.getInt("id"));
                            item.put("name", rs.getString("name"));
                            item.put("price", rs.getDouble("price"));
                            item.put("quantity", quantity);
                            cart.add(item);
                        }
                        rs.close();
                        ps.close();
                    }
                }
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }

        session.setAttribute("cart", cart);
        session.setAttribute("toast", "✅ Product(s) added to cart!");
        response.sendRedirect("cart.jsp");
    }
}
