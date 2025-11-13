package dal;

import java.sql.*;
import java.util.*;
import Models.*;

public class DishDAO {
    
    private Connection con;
    private List<Dish> dishes;
    
    public static DishDAO INS = new DishDAO();
    
    public DishDAO() {        
        con = new DBContext().connection;        
    }
    
    public DishDAO(Connection con, List<Dish> dishes) {
        this.con = con;
        this.dishes = dishes;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public List<Dish> getDishes() {
        return dishes;
    }

    public void setDishes(List<Dish> dishes) {
        this.dishes = dishes;
    }
    
    public void addDish(int id, String name, double price, String des, String image, int quantity, String category){
        String sql = "Insert into Dish values(?,?,?,?,?,?,?)";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setDouble(3, price);
            ps.setString(4, des);
            ps.setString(5, image);
            ps.setInt(6, quantity);
            ps.setString(7, category);
            ps.execute();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    
    public List<Dish> getAllDishes(){
        List<Dish> list = new ArrayList<>();
        String sql = "select * from Dish";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Dish d = new Dish(
                        rs.getInt("id"),
                        rs.getString("name"), 
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"), 
                        rs.getString("image"),
                        rs.getString("category"));
                
                list.add(d);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return list;
    }     
    
    public List<String> getCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM Dish;";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public List<Dish> getDishesByCategory(String category) {
    List<Dish> list = new ArrayList<>();
    String sql = "SELECT * FROM Dish WHERE category = ?";
    try (
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Dish d = new Dish(
                        rs.getInt("id"),
                        rs.getString("name"), 
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"), 
                        rs.getString("image"),
                        rs.getString("category"));
            
            list.add(d);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    
    public Dish getDishById(int id) {
        String sql = "select * from Dish where id=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Dish d = new Dish();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDescription(rs.getString("description"));
                d.setImage(rs.getString("image"));
                d.setCategory(rs.getString("category"));
                return d;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void deleteDishById(int id) {
        String sql = "delete from Dish where id=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
    public void addNewDish(Dish dish) {
        String sql = "INSERT INTO [dbo].[Dish]\n"
                + "           ([name]\n"
                + "           ,[price]\n"
                + "           ,[quantity]\n"
                + "           ,[description]\n"
                + "           ,[image]\n"
                + "           ,[category])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ? ,?);";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dish.getName());
            ps.setDouble(2,dish.getPrice());
            ps.setInt(3, dish.getQuantity());
            ps.setString(4, dish.getDescription());
            ps.setString(5, dish.getImage());
            ps.setString(6, dish.getCategory());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateDish(Dish dish) {
        String sql = "UPDATE [dbo].[Dish]\n"
                + "   SET [name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[quantity] = ?\n"  
                + "      ,[description] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[category] = ?\n"
                + " WHERE id=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dish.getName());
            ps.setDouble(2, dish.getPrice());
            ps.setInt(3, dish.getQuantity());
            ps.setString(4, dish.getDescription());
            ps.setString(5, dish.getImage());
            ps.setString(6, dish.getCategory());
            ps.setInt(7, dish.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }
    
    public List<Dish> getTop9DishesExp() {
        List<Dish> list = new ArrayList<>();
        String sql = "select top 9 * from Dish order by price asc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Dish d = new Dish();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDescription(rs.getString("description"));
                d.setImage(rs.getString("image"));
                d.setCategory(rs.getString("category"));
                
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Dish> getTop3DishesCheapest() {
        List<Dish> list = new ArrayList<>();
        String sql = "select top 3 * from Dish order by price asc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Dish d = new Dish();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDescription(rs.getString("description"));
                d.setImage(rs.getString("image"));
                d.setCategory(rs.getString("category"));
                
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Dish> getTop2DishesExp() {
        List<Dish> list = new ArrayList<>();
        String sql = "select top 2 * from Dish order by price desc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Dish d = new Dish();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDescription(rs.getString("description"));
                d.setImage(rs.getString("image"));
                d.setCategory(rs.getString("category"));
                
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}