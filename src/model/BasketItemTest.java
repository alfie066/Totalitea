package model;

import static org.junit.Assert.*;
import org.junit.Test;

public class BasketItemTest {

    @Test
    public void testGetters() {
        BasketItem item = new BasketItem(1, 10, "Coffee", 350, 200, 3);

        assertEquals(1, item.getBasketItemId());
        assertEquals(10, item.getProductId());
        assertEquals("Coffee", item.getName());
        assertEquals(350, item.getPriceInPencePer100g());
        assertEquals(200, item.getGrams());
        assertEquals(3, item.getQuantity());
    }
}