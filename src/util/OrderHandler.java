package util;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



/*
 * This class handles all operations related to orders.
 * It is responsible for creating orders, adding and removing items,
 * retrieving order data, and completing an order when a user checks out.
 */
public class OrderHandler {
	
	/*
	 * @param userId     the user adding the item
	 * @param productId  the product being added
	 * @param grams      the selected weight of the item
	 * @param quantity   how many of the item to add
	 * @return           the ID of the inserted order item
	 *
	 * This method calls a stored procedure to add an item to the user's current order.
	 * If the item already exists in the order, the quantity is updated instead.
	 */
    public static int addItemToOrder(int userId, int productId, int grams, int quantity) throws SQLException {

        CallableStatement stmt = DbConnector.getCallableStatement(
            "{CALL insertItemIntoOrder(?, ?, ?, ?, ?)}"
        );

        stmt.setInt(1, userId);
        stmt.setInt(2, productId);
        stmt.setInt(3, grams);
        stmt.setInt(4, quantity);
        stmt.registerOutParameter(5, java.sql.Types.INTEGER);

        stmt.execute();

        return stmt.getInt(5);
    }


    /*
     * @param userId  the user whose order is being checked
     * @return        the ID of the current OPEN order, or -1 if none exists
     *
     * This method retrieves the user's current open order.
     * It is used to determine which basket/order items should be added to.
     */
    public static int getOpenOrderId(int userId) throws SQLException {

        String sql = "SELECT Id FROM Orders WHERE UserId = ? AND Status = 'OPEN' LIMIT 1";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt("Id");
        }

        return -1; // no open order
    }


    /*
     * @param orderId  the order to retrieve items from
     * @return         a ResultSet containing all order items
     *
     * This method gets all items that belong to a specific order.
     * It is mainly used when displaying the contents of a basket.
     */
    public static ResultSet getOrderItems(int orderId) throws SQLException {

        String sql = "SELECT * FROM OrderItem WHERE OrderId = ?";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);

        return ps.executeQuery();
    }


    /*
     * @param orderId   the order the item belongs to
     * @param productId the product to remove
     * @param grams     the weight of the item to remove
     *
     * This method removes a specific item from an order
     * by calling a stored procedure in the database.
     */

    public static void removeItem(int orderId, int productId, int grams) throws SQLException {

        CallableStatement stmt = DbConnector.getCallableStatement(
            "{CALL removeOrderItem(?, ?, ?)}"
        );

        stmt.setInt(1, orderId);
        stmt.setInt(2, productId);
        stmt.setInt(3, grams);

        stmt.execute();
    }
    
    /*
     * @param orderID
     * @returns nothing (void)
     * 
     * this method sets the status of an order from open to paid whenever a user checks out the basket
     */
    
    public static void completeOrder(int orderId) throws SQLException {

        String sql = "UPDATE Orders SET Status = 'PAID', PlacedAt = CURRENT_TIMESTAMP WHERE Id = ?";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);
        ps.executeUpdate();
    }
}