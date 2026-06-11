package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Product;

public class ProductHandler {

	
	public static ArrayList<Product> getProducts() throws SQLException {
		
		String query = "SELECT * FROM Product";
		ResultSet rs = DbConnector.runSqlPrepared(query);
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
	
	
	public static ArrayList<Product> searchProducts(String searchTerm) throws SQLException {


	    if (searchTerm == null || searchTerm.trim().isEmpty()) {
	        return getProducts();
	    }

	    String sql = "SELECT * FROM Product " +
	                 "WHERE LOWER(Name) LIKE ? OR LOWER(Description) LIKE ?";

	    java.sql.Connection conn = DbConnector.getConnection();
	    java.sql.PreparedStatement ps = conn.prepareStatement(sql);


	    String cleaned = searchTerm.trim().toLowerCase();


	    String likePattern = "%" + cleaned + "%";

	    ps.setString(1, likePattern);
	    ps.setString(2, likePattern);

	    ResultSet rs = ps.executeQuery();

	    return resultSetToProducts(rs);
	}
	
	
	public static int insertProduct(String name, String description, int price) throws SQLException {

	    java.sql.CallableStatement stmt = DbConnector.getCallableStatement("{CALL insertNewProduct(?, ?, ?, ?)}");

	    stmt.setString(1, name);
	    stmt.setInt(2, price);
	    stmt.setString(3, description);
	    stmt.registerOutParameter(4, java.sql.Types.INTEGER);

	    stmt.execute();

	    return stmt.getInt(4);
	}
	
	public static void updateProduct(int id, String name, String description, int price) throws SQLException {

	    java.sql.CallableStatement stmt = DbConnector.getCallableStatement("{CALL updateExistingProduct(?, ?, ?, ?)}");

	    stmt.setString(1, name);
	    stmt.setString(2, description);
	    stmt.setInt(3, price);
	    stmt.setInt(4, id);

	    stmt.execute();
	}

}


