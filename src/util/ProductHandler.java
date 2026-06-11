package util;

import java.sql.ResultSet;


import java.sql.SQLException;
import java.util.ArrayList;

import model.Product;

/*
 * This class handles all operations related to products.
 * It retrieves products from the database, converts database results
 * into Product objects, and supports searching, inserting, and updating products.
 */

public class ProductHandler {

	
	/*
	 * @return a list of all products
	 *
	 * This method retrieves all products from the database.
	 * It executes a query and converts the results into Product objects.
	 */

	public static ArrayList<Product> getProducts() throws SQLException {
		
		String query = "SELECT * FROM Product";
		ResultSet rs = DbConnector.runSqlPrepared(query);
		return resultSetToProducts(rs);
		
	}
	
	/*
	 * @param rs  the ResultSet returned from a database query
	 * @return    a list of Product objects
	 *
	 * This method converts a ResultSet into a list of Product objects.
	 * Each row from the database is turned into a Product instance.
	 */
	
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
	
	/*
	 * @param searchTerm  the text to search for
	 * @return            a list of matching products
	 *
	 * This method searches for products by name or description.
	 * The search is case-insensitive and supports partial matches.
	 * If the search term is empty, all products are returned.
	 */
	
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
	
	
	/*
	 * @param name        the name of the product
	 * @param description the product description
	 * @param price       the price in pence per 100g
	 * @return            the ID of the newly created product
	 *
	 * This method inserts a new product into the database by calling
	 * a stored procedure. It returns the generated product ID.
	 */
	
	
	public static int insertProduct(String name, String description, int price) throws SQLException {

	    java.sql.CallableStatement stmt = DbConnector.getCallableStatement("{CALL insertNewProduct(?, ?, ?, ?)}");

	    stmt.setString(1, name);
	    stmt.setInt(2, price);
	    stmt.setString(3, description);
	    stmt.registerOutParameter(4, java.sql.Types.INTEGER);

	    stmt.execute();

	    return stmt.getInt(4);
	}
	
	/*
	 * @param id          the ID of the product to update
	 * @param name        the new product name
	 * @param description the new description
	 * @param price       the updated price in pence per 100g
	 *
	 * This method updates an existing product in the database
	 * using a stored procedure.
	 */
	
	
	public static void updateProduct(int id, String name, String description, int price) throws SQLException {

	    java.sql.CallableStatement stmt = DbConnector.getCallableStatement("{CALL updateExistingProduct(?, ?, ?, ?)}");

	    stmt.setString(1, name);
	    stmt.setString(2, description);
	    stmt.setInt(3, price);
	    stmt.setInt(4, id);

	    stmt.execute();
	}

}


