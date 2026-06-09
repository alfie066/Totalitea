package model;

import static org.junit.Assert.*;
import org.junit.Test;


public class BasketItemTest {

    @Test
    public void testGetters() {
        BasketItem item = new BasketItem(1, "Coffee", 200, 3);

        assertEquals(1, item.getBasketItemId());
        assertEquals("Coffee", item.getName());
        assertEquals(200, item.getGrams());
        assertEquals(3, item.getQuantity());
    }
}