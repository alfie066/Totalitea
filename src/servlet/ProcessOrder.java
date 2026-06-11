package servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import util.OrderHandler;
import util.PaymentHandler;

@WebServlet("/ProcessOrder")
public class ProcessOrder extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");


            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = user.getID();

            String nameOnCard = request.getParameter("nameOnCard");
            String cardNumber = request.getParameter("cardNumber");
            String expiryRaw = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            String expiry = expiryRaw + "-01";


            int orderId = OrderHandler.getOpenOrderId(userId);

            if (orderId == -1) {
                response.sendRedirect("basket.jsp");
                return;
            }

  
            PaymentHandler.insertPayment(orderId, nameOnCard, cardNumber, expiry, cvv);


            OrderHandler.completeOrder(orderId);


            session.setAttribute("message", "Payment complete! Your order has been placed.");

            response.sendRedirect("basket.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
