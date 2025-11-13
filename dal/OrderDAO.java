package dal;

import Models.*;
import java.util.*;
import java.sql.*;

public class OrderDAO {
    
    private Connection con;
    
    public static OrderDAO INS = new OrderDAO();
    
    public OrderDAO() {        
        con = new DBContext().connection;        
    }
    
    public OrderDAO(Connection con) {
        this.con = con;  
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }
    
    public Status getStatusById(int id) {
        String sql = "SELECT * FROM [dbo].[Status] where statusId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Status s = new Status();
                s.setStatusId(rs.getInt("statusId"));
                s.setStatus(rs.getString("status"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Order> getOrderByStatus(int statusId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where statusId = ? order by [date] desc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getDate("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(OrderDAO.INS.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getOrderByStatus(int statusId, int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where statusId = ? and userId = ? order by [date] desc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getDate("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(OrderDAO.INS.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order]order by [date] desc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getDate("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(OrderDAO.INS.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }        

public List<OrderDetail> getDetailsByOrderId(int orderId) {
    List<OrderDetail> list = new ArrayList<>();
    
    String sql = "SELECT od.orderDetailId, od.orderId, od.quantity, od.priceDish, " +
                 "d.id as dishId, d.name, d.price, d.description, d.image, d.category, d.quantity as dishQuantity " +
                 "FROM OrderDetail od " +
                 "INNER JOIN Dish d ON od.dishId = d.id " +
                 "WHERE od.orderId = ?";    
    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();        
        while (rs.next()) {            
            Dish dish = new Dish();
            dish.setId(rs.getInt("dishId"));
            dish.setName(rs.getString("name"));
            dish.setPrice(rs.getDouble("price"));
            dish.setDescription(rs.getString("description"));
            dish.setImage(rs.getString("image"));
            dish.setCategory(rs.getString("category"));
            dish.setQuantity(rs.getInt("dishQuantity"));
                        
            OrderDetail detail = new OrderDetail();
            detail.setOrderDetailId(rs.getInt("orderDetailId"));
            detail.setOrderId(rs.getInt("orderId"));
            detail.setDish(dish);  // ← QUAN TRỌNG: Gán object Dish
            detail.setQuantity(rs.getInt("quantity"));
            detail.setPriceDish(rs.getDouble("priceDish"));
            
            list.add(detail);
        }
        
        rs.close();
        ps.close();
    } catch (SQLException e) {
        System.err.println("Error in getDetailsByOrderId: " + e.getMessage());
        e.printStackTrace();
    }
    
    return list;
}
    
    public int addOrder(Order order) {
        int orderId = -1;
        ResultSet rs = null;
        String sql = "INSERT INTO [Order] (userId, date, name, phone, address, shipPrice, totalPrice, statusid, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, new java.sql.Timestamp(order.getDate().getTime()));  // Giả sử order.getDate() trả về java.sql.Timestamp
            ps.setString(3, order.getName());
            ps.setString(4, order.getPhone());
            ps.setString(5, order.getAddress());
            ps.setDouble(6, order.getShipPrice());
            ps.setDouble(7, order.getTotalPrice());
            ps.setInt(8, order.getStatus().getStatusId());
            ps.setString(9, order.getNote());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [dbo].[Order] where orderId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getDate("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(OrderDAO.INS.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO [dbo].[OrderDetail]\n"
                + "           ([orderId]\n"
                + "           ,[dishId]\n"
                + "           ,[quantity]\n"
                + "           ,[priceDish])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";

        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, orderDetail.getOrderId());
            ps.setInt(2, orderDetail.getDish().getId());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getPriceDish());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateStatusOrder(int orderId, int statusId) {
        String sql = "UPDATE [Order]\n"
                + "SET statusId = ? \n"
                + "WHERE orderId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusId);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}