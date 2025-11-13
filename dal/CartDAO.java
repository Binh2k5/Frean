package dal;

import java.sql.*;
import java.util.*;
import Models.*;

public class CartDAO {
    
    private Connection con;
    
    public static CartDAO INS = new CartDAO();
    
    public CartDAO() {        
        if(INS == null) {
            con = new DBContext().connection;
            INS = this;
        } else {
            con = INS.con;
        }
    }
    
    public CartDAO(Connection con) {
        this.con = con;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public void addToCart(int userId, int dishId, int quantity ){
        String sql = "IF EXISTS (SELECT * FROM CartItem WHERE userId = ? AND dishId = ?)\n"
                + "BEGIN\n"
                + "    UPDATE CartItem\n"
                + "    SET quantity = quantity + ?\n"
                + "    WHERE userId = ? AND dishId = ?;\n"
                + "END\n"
                + "ELSE\n"
                + "BEGIN\n"
                + "    INSERT INTO CartItem (userId, dishId, quantity) \n"
                + "    VALUES (?, ?, ?); \n"
                + "END";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, dishId);
            ps.setInt(3, quantity);
            ps.setInt(4, userId);
            ps.setInt(5, dishId);
            ps.setInt(6, userId);
            ps.setInt(7, dishId);
            ps.setInt(8, quantity);
            ps.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    
    public void deleteCartItem(int userId, int dishId) {
        String sql = "delete from CartItem where userId = ? and dishId  = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, dishId);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
    public void clearCartItem(int userId) {
        String sql = "delete from CartItem where userId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
    public List<CartItem> getAllCartItemsByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "select  * from CartItem where userId = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setDish(DishDAO.INS.getDishById(rs.getInt("dishId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                
                list.add(cartItem);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public CartItem getCartItemByCartItemId(int cartItemId) {
        String sql = "select * from CartItem \n"
                + "where cartItemId = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, cartItemId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setDish(DishDAO.INS.getDishById(rs.getInt("dishId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                return cartItem;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void updateQuantityOfCartItem(int cartItemId, int quantity) {
        String sql = "UPDATE [dbo].[CartItem]\n"
                + "   SET [quantity] = ?"
                + " WHERE cartItemId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public CartItem getCartItemByDishIdUserId(int dishId, int userId) {
        String sql = "select * from CartItem \n"
                + "where dishId = ? and userId = ? ";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, dishId);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setDish(DishDAO.INS.getDishById(rs.getInt("dishId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                return cartItem;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public int getTotalQuantityOfDishInCart(int userId) {
        int total = 0;
        String sql = "select SUM(quantity) as total from CartItem \n"
                + "where userId = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }
    
    public double getTotalPriceOfCart(int userId) {
        double total = 0;
        String sql = "SELECT SUM(c.quantity * d.price) as totalPrice " +
                     "FROM CartItem c " +
                     "JOIN Dish d ON c.dishId = d.id " +
                     "WHERE c.userId = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("totalPrice");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }
}