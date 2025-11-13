package Models;

public class CartItem {

    private int cartItemId;
    private int userId;
    private Dish dish;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int cartItemId, int userId, Dish dish, int quantity) {
        this.cartItemId = cartItemId;
        this.userId = userId;
        this.dish = dish;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Dish getDish() {
        return dish;
    }

    public void setDish(Dish dish) {
        this.dish = dish;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
