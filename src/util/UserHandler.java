package util;

import java.sql.*;
import model.User;

/*
 * This class handles all operations related to users.
 * It is responsible for logging users in, registering new users,
 * and retrieving user information from the database.
 */
public class UserHandler {

	
	/*
	 * @param email     the user's email
	 * @param password  the user's password
	 * @return          a User object if login is successful, or null if not
	 *
	 * This method checks the database for a user with the given email
	 * and password. If a match is found, a User object is created and returned.
	 */

    public static User loginUser(String email, String password) throws SQLException {
        Connection conn = DbConnector.getConnection();
        String query = "SELECT * FROM user WHERE email=? AND password=?";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            User user = new User(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("dob"),
                rs.getString("address"),
                rs.getString("cardNumber"),
                rs.getString("expiryDate"),
                rs.getString("cvv")
            );
            user.setID(rs.getInt("id"));
            return user;
        }
        return null;
    }
    
    /*
     * @param name        the user's name
     * @param email       the user's email
     * @param password    the user's password
     * @param dob         the user's date of birth
     * @param address     the user's address
     * @param cardNumber  the user's card number
     * @param expiryDate  the card expiry date
     * @param cvv         the card CVV
     * @return            true if the user was successfully registered
     *
     * This method inserts a new user into the database with the
     * provided details.
     */


    public static boolean registerUser(String name, String email, String password, String dob, String address, String cardNumber, String expiryDate, String cvv) throws SQLException {
        Connection conn = DbConnector.getConnection();
        String query = "INSERT INTO user (name, email, password, dob, address, cardNumber, expiryDate, cvv) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, dob);
        ps.setString(5, address);
        ps.setString(6, cardNumber);
        ps.setString(7, expiryDate);
        ps.setString(8, cvv);

        int result = ps.executeUpdate();
        return result > 0;
    }
    
    
    
}