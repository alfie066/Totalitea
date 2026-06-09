package model;

public class BasketItem {

    private int basketItemId;
    private String name;
    private int grams;
    private int quantity;

    public BasketItem(int productId, String name, int grams, int quantity) {
        this.basketItemId = productId;
        this.name = name;
        this.grams = grams;
        this.quantity = quantity;
    }

    public int getBasketItemId() {
    	return basketItemId;
    	}
    
    public String getName() {
    	return name;
    	}
    
    public int getGrams() {
    	return grams;
    	}
    
    public int getQuantity() {
    	return quantity; 
    	}
}