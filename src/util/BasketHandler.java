package util;

import java.sql.PreparedStatement;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.BasketItem;
/*
 * This class handles all operations related to a user's basket.
 * It is responsible for retrieving basket items, adding/removing items,
 * and calculating totals such as weight, subtotal, and shipping cost.
 */
public class BasketHandler {
	
	/*
	 * @param userId     the user adding the item
	 * @param productId  the product being added
	 * @param grams      the selected weight of the product
	 * @param quantity   how many items are being added
	 *
	 * This method adds a product to the user's basket by calling the
	 * OrderHandler, which manages the database interaction.
	 */

    public static void addToBasket(int userId, int productId, int grams, int quantity) throws SQLException {

        OrderHandler.addItemToOrder(userId, productId, grams, quantity);
    }
    
    /*
     * @param itemId  the ID of the basket item to remove
     *
     * This method removes a specific item from the basket by deleting it
     * from the database using its unique ID.
     */
    
    public static void removeFromBasket(int itemId) {
        try {
            String sql = "DELETE FROM OrderItem WHERE Id = ?";
            PreparedStatement stmt = DbConnector.getConnection().prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /*
     * @param userId  the user whose basket is being retrieved
     * @return        a list of BasketItem objects
     *
     * This method gets all the items in the user's current open order (basket).
     * If the user has no open order, an empty list is returned.
     */



    public static ArrayList<BasketItem> getBasketItems(int userId) throws SQLException {

        int orderId = OrderHandler.getOpenOrderId(userId);

        ArrayList<BasketItem> items = new ArrayList<>();

        if (orderId == -1) {
            return items; // empty basket
        }

        String query =
            "SELECT oi.Id, p.Id AS productId, p.Name, " +
            "oi.PriceInPencePer100g, oi.Grams, oi.Quantity " +
            "FROM OrderItem oi " +
            "JOIN Product p ON oi.ProductId = p.Id " +
            "WHERE oi.OrderId = ?";

        PreparedStatement ps = DbConnector.getConnection().prepareStatement(query);
        ps.setInt(1, orderId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            items.add(new BasketItem(
                rs.getInt("Id"),
                rs.getInt("productId"),
                rs.getString("Name"),
                rs.getInt("PriceInPencePer100g"),
                rs.getInt("Grams"),
                rs.getInt("Quantity")
            ));
        }

        return items;
    }
    
    /*
     * @param items  the list of basket items
     * @return       the total weight in grams
     *
     * This method calculates the total weight of all items in the basket
     * by multiplying each item's grams by its quantity.
     */
    
    public static int calculateTotalWeight(ArrayList<BasketItem> items) {
        int totalWeight = 0;

        for (BasketItem item : items) {
            totalWeight += item.getGrams() * item.getQuantity();
        }

        return totalWeight;
    }
    
    /*
     * @param totalWeight  the total weight of the basket in grams
     * @param subtotal     the total cost of the basket before shipping
     * @return             the shipping cost in pounds
     *
     * This method calculates the shipping cost based on weight.
     * Shipping is free if the subtotal is £100 or more.
     * Otherwise, the cost depends on the weight of the basket.
     */
    
    public static double calculateShipping(int totalWeight, double subtotal) {

        if (subtotal >= 100) {
            return 0;
        }

        if (totalWeight == 0) return 0;

        double weightKg = totalWeight / 1000.0;

        if (weightKg <= 5) {
            return 1.0;
        } else if (weightKg <= 10) {
            return 10.0;
        } else {
            return 15.0;
        }
    }
    
    /*
     * @param items  the list of basket items
     * @return       the total cost of all items in pounds
     *
     * This method calculates the subtotal of the basket by converting
     * each item's price from pence to pounds and adjusting for weight
     * and quantity.
     */
    
    public static double calculateSubtotal(ArrayList<BasketItem> items) {

        double subtotal = 0;

        for (BasketItem item : items) {
            double pricePer100g = item.getPriceInPencePer100g() / 100.0;
            double gramsFactor = item.getGrams() / 100.0;

            subtotal += pricePer100g * gramsFactor * item.getQuantity();
        }

        return subtotal;
    }
    

    

}
