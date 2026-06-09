package servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.BasketHandler;
import util.UserHandler;


@WebServlet("/AddToBasket")
public class AddToBasket extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Check user is logged in
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");

        if (userEmail == null) {
            session.setAttribute("loginMessage", "You must be logged in to add items to your basket.");
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = 0;
		try {
			userId = UserHandler.getUserIdByEmail(userEmail);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (userId == -1) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 2. Validate parameters
        String pidParam = request.getParameter("pid");
        String qtyParam = request.getParameter("qty");

        if (pidParam == null || qtyParam == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 3. Parse safely
        int pid, qty;
        try {
            pid = Integer.parseInt(pidParam);
            qty = Integer.parseInt(qtyParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
            return;
        }

        if (pid < 1 || qty < 1) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 4. Get or create basket, then add item
        try {
            int basketId = BasketHandler.getOrCreateBasket(userId);
            if (BasketHandler.addToBasket(basketId, pid, qty)) {
                response.sendRedirect("basket.jsp");
                return;
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        response.sendRedirect("error.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error.jsp");
    }
}