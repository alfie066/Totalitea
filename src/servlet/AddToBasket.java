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


    	HttpSession session = request.getSession();
    	model.User currentUser = (model.User) session.getAttribute("user");
    	String userEmail = (currentUser != null) ? currentUser.getEmail() : null;

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

        String pidParam = request.getParameter("pid");
        String qtyParam = request.getParameter("qty");
        String gramsParam = request.getParameter("grams");
        

        if (pidParam == null || qtyParam == null || gramsParam == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        int pid, qty, grams;
        try {
            pid = Integer.parseInt(pidParam);
            qty = Integer.parseInt(qtyParam);
            grams = Integer.parseInt(gramsParam);
            

            System.out.println("User ID: " + userId);
            System.out.println("Product ID: " + pid);
            System.out.println("Grams: " + grams);
            System.out.println("Quantity: " + qty);

            
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
            return;
        }

        if (pid < 1 || qty < 1) {
            response.sendRedirect("error.jsp");
            return;
        }


        try {
            BasketHandler.addToBasket(userId, pid, grams, qty);
            response.sendRedirect("basket.jsp");
            return;

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("error.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error.jsp");
    }
}