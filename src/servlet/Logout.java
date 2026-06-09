package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import util.UserHandler;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 1. Instantly clears out the session data, logging the user out
        request.getSession().invalidate();
        
        // 2. Kicks the user's browser back to the main homepage
        response.sendRedirect("index.jsp");
    }
}