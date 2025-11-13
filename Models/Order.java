package Models;

import java.sql.Date;

public class Order {

    private int orderId;
    private int userId;
    private Date date;
    private String name;
    private String phone;
    private String address;
    private double shipPrice;
    private double totalPrice;
    private Status status;
    private String note;

    public Order() {
    }

    public Order(int orderId, int userId, Date date, String name, String phone, String address, double shipPrice, double totalPrice, Status status, String note) {
        this.orderId = orderId;
        this.userId = userId;
        this.date = date;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.shipPrice = shipPrice;
        this.totalPrice = totalPrice;
        this.status = status;
        this.note = note;
    }

    public Order(int userId, Date date, String name, String phone, String address, double shipPrice, double totalPrice, Status status, String note) {
        this.userId = userId;
        this.date = date;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.shipPrice = shipPrice;
        this.totalPrice = totalPrice;
        this.status = status;
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getShipPrice() {
        return shipPrice;
    }

    public void setShipPrice(double shipPrice) {
        this.shipPrice = shipPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }    
}
