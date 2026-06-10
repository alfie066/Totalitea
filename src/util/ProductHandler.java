package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Product;

public class ProductHandler {

	
	public static ArrayList<Product> getProducts() throws SQLException {
		
		/* The below, run as a prepared statement */
		//String query = "SELECT * FROM Product";
		//ResultSet rs = DbConnector.runSqlPrepared(query);
		
		/* ... would do the same as calling this stored procedure via a callable statement */
		ResultSet rs = DbConnector.runSqlCallable("{call readFullProducts()}");
		return resultSetToProducts(rs);
		
	}
	
	public static ArrayList<Product> resultSetToProducts(ResultSet rs) throws SQLException{
		ArrayList<Product> products = new ArrayList<Product>();
		
		while(rs.next()){
			Product p = new Product(rs.getInt("Id"),
						rs.getString("Name"),
						rs.getString("Description"),
						rs.getInt("PriceInPencePer100g")
					);
			products.add(p);		
		}
		return products;
	
	}
	
	public static String escapeRegex(String input) {
	    return input.replaceAll("([\\\\.*+?\\[^\\]$(){}=!<>|:-])", "\\\\$1");
	}
	
	public static ArrayList<Product> searchProducts(String searchTerm) throws SQLException {

	    // ✅ handle empty search safely
	    if (searchTerm == null || searchTerm.trim().isEmpty()) {
	        return getProducts();
	    }

	    String sql = "SELECT * FROM Product WHERE Name REGEXP ? OR Description REGEXP ?";

	    java.sql.Connection conn = DbConnector.getConnection();
	    java.sql.PreparedStatement ps = conn.prepareStatement(sql);


	    String cleaned = searchTerm.toLowerCase().replaceAll("[^a-z0-9 ]", "");

	    String regex = "(^|[[:space:]])" + cleaned + "($|[[:space:]])";

	    ps.setString(1, regex);
	    ps.setString(2, regex);

	    ResultSet rs = ps.executeQuery();

	    return resultSetToProducts(rs);
	}
}


