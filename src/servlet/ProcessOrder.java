package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import model.BasketItem;
import model.User;
import util.BasketHandler;
import util.OrderHandler;
import util.UserHandler;

@WebServlet("/ProcessOrder")
public class ProcessOrder extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
   
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = UserHandler.getUserIdByEmail(user.getEmail());

    
            int basketId = BasketHandler.getOrCreateBasket(userId);
            ArrayList<BasketItem> items = BasketHandler.getItemsFromBasket(basketId);


            double total = 0;
            for (BasketItem b : items) {
                total += b.getTotalPrice();
            }

            int orderId = OrderHandler.createOrder(userId, total);


            for (BasketItem b : items) {
                OrderHandler.insertOrderItem(orderId, b);
            }


            BasketHandler.clearBasket(basketId);


            request.getSession().setAttribute("message", "✅ Payment complete! Your order has been placed.");

            response.sendRedirect("basket.jsp");
            

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
