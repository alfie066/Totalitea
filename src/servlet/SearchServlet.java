package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Product;
import util.ProductHandler;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String query = request.getParameter("query");
        
        if (query == null) {
            query = "";
        }
        
        try {
        	
            ArrayList<Product> results = ProductHandler.searchProducts(query);
            
            // Pass the data over to the JSP page
            request.setAttribute("searchResults", results);
            request.setAttribute("query", query);
            
            // Forward the user to the results page
            request.getRequestDispatcher("/search-results.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}