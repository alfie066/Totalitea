package model;

import static org.junit.Assert.*;
import org.junit.Test;

public class BasketItemTest {

    private BasketItem item;

    @Test
    public void constructorTest() {
        BasketItem testItem = new BasketItem(5, 99, "Espresso", 300, 100, 1);

        assertEquals(5, testItem.getBasketItemId());
        assertEquals(99, testItem.getProductId());
        assertEquals("Espresso", testItem.getName());
        assertEquals(300, testItem.getPriceInPencePer100g());
        assertEquals(100, testItem.getGrams());
        assertEquals(1, testItem.getQuantity());
    }


    @Test
    public void getBasketItemIdTest() {
        assertEquals(1, item.getBasketItemId());
    }

    @Test
    public void getProductIdTest() {
        assertEquals(10, item.getProductId());
    }

    @Test
    public void getNameTest() {
        assertEquals("Test Coffee", item.getName());
    }

    @Test
    public void getPriceInPenceTest() {
        assertEquals(250, item.getPriceInPencePer100g());
    }

    @Test
    public void getGramsTest() {
        assertEquals(200, item.getGrams());
    }

    @Test
    public void getQuantityTest() {
        assertEquals(2, item.getQuantity());
    }

    @Test
    public void getPriceInPoundsTest() {
        double result = item.getPriceInPoundsPer100g();
        assertEquals(2.50, result, 0.001);
    }


    @Test
    public void getTotalPriceTest() {
        double result = item.getTotalPrice();

        assertEquals(5.00, result, 0.001);
    }


    @Test
    public void zeroQuantityTest() {
        BasketItem zeroItem = new BasketItem(1, 1, "Tea", 200, 100, 0);

        assertEquals(0.0, zeroItem.getTotalPrice(), 0.001);
    }

    @Test
    public void largeValuesTest() {
        BasketItem bigItem = new BasketItem(1, 1, "Bulk Coffee", 500, 1000, 10);

        double total = bigItem.getTotalPrice();
        assertEquals(50.0, total, 0.001);
        
    }
    

	@Test
	    public void roundingTest() {
	        BasketItem small = new BasketItem(1, 1, "Cheap Tea", 123, 100, 1);
	
	        double price = small.getPriceInPoundsPer100g();
	
	        assertEquals(1.23, price, 0.001);
	    }

    
}

