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


            String cardNumber = request.getParameter("cardNumber");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            java.sql.Connection conn = util.DbConnector.getConnection();


            String sqlUser = "UPDATE User SET CardNumber = ?, ExpiryDate = ?, CVV = ? WHERE Id = ?";
            java.sql.PreparedStatement psUser = conn.prepareStatement(sqlUser);

            psUser.setString(1, cardNumber);
            psUser.setString(2, expiry);
            psUser.setString(3, cvv);
            psUser.setInt(4, userId);

            psUser.executeUpdate();


            int orderId = OrderHandler.getOpenOrderId(userId);

            if (orderId == -1) {
                response.sendRedirect("basket.jsp");
                return;
            }

            String sql = "UPDATE Orders SET Status = 'PAID', PlacedAt = CURRENT_TIMESTAMP WHERE Id = ?";
            java.sql.PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();

            request.getSession().setAttribute("message", "Payment complete! Your order has been placed.");

            response.sendRedirect("basket.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
