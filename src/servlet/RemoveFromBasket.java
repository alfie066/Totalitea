package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.BasketHandler;

@WebServlet("/RemoveFromBasket")
public class RemoveFromBasket extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemIdStr = request.getParameter("itemId");

        if (itemIdStr != null) {
            int itemId = Integer.parseInt(itemIdStr);
            BasketHandler.removeFromBasket(itemId);
        }

        response.sendRedirect("basket.jsp");
    }
}