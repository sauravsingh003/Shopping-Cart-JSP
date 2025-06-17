package com.example;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Clear the cart
        session.removeAttribute("cart");

        // You can save order to DB here if needed

        // Show confirmation message
        request.setAttribute("message", "🎉 Thank you for your order!");
        RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation.jsp");
        dispatcher.forward(request, response);
    }
}
