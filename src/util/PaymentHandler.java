package util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*
 * This class handles all operations related to payments.
 * It stores payment details for an order when a user checks out.
 */
public class PaymentHandler {

    /*
     * @param orderId    the order being paid for
     * @param nameOnCard
     * @param cardNumber the card number used
     * @param expiryDate the expiry date (YYYY-MM-DD)
     * @param cvv        the CVV code
     *
     * This method inserts payment details for a completed order
     * into the Payment table.
     */
    public static void insertPayment(int orderId, String nameOnCard, String cardNumber, String expiryDate, String cvv) throws SQLException {

        Connection conn = DbConnector.getConnection();

        String sql = "INSERT INTO Payment (OrderId, NameOnCard, CardNumber, ExpiryDate, CVV) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);
        ps.setString(2, nameOnCard);
        ps.setString(3, cardNumber);
        ps.setString(4, expiryDate);
        ps.setString(5, cvv);

        ps.executeUpdate();
    }
}
