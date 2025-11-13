package Models;

public class OrderDetail {

    private int orderDetailId;
    private int orderId;
    private Dish dish;
    private int quantity;
    private double priceDish;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, Dish dish, int quantity, double priceDish) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.dish = dish;
        this.quantity = quantity;
        this.priceDish = priceDish;
    }

    public OrderDetail(int orderId, Dish dish, int quantity, double priceDish) {
        this.orderId = orderId;
        this.dish = dish;
        this.quantity = quantity;
        this.priceDish = priceDish;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public double getPriceDish() {
        return priceDish;
    }

    public void setPriceDish(double priceDish) {
        this.priceDish = priceDish;
    }

}
