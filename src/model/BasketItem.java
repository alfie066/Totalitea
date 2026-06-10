package model;

public class BasketItem {

    private int basketItemId;
    private int productId;
    private String name;
    private int priceInPencePer100g;
    private int grams;
    private int quantity;

    public BasketItem(int basketItemId, int productId, String name,
            int priceInPencePer100g, int grams, int quantity) {
				this.basketItemId = basketItemId;
				this.productId = productId;
				this.name = name;
				this.priceInPencePer100g = priceInPencePer100g;
				this.grams = grams;
				this.quantity = quantity;
				}

    public int getBasketItemId() {
        return basketItemId;
    }

    public int getProductId() {
        return productId;
    }

    public String getName() {
        return name;
    }

    public int getPriceInPencePer100g() {
        return priceInPencePer100g;
    }

    public double getPriceInPoundsPer100g() {
        return priceInPencePer100g / 100.0;
    }

    public double getTotalPrice() {
        return (priceInPencePer100g * quantity) / 100.0;
    }

    public int getGrams() {
        return grams;
    }

    public int getQuantity() {
        return quantity;
    }
}