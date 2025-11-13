package dal;

import java.sql.*;
import java.util.*;
import Models.*;

public class UserDAO {

    private Connection con;
    private List<Account> acc;
    private List<Dish> dishes;

    public static UserDAO INS = new UserDAO();

    public UserDAO() {
        try {            
            con = new DBContext().connection;
            if (INS == null) {
                INS = this;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Failed to initialize database connection in UserDAO");
        }
    }

    public UserDAO(Connection con, List<Account> acc, List<Dish> dishes) {
        this.con = con;
        this.acc = acc;
        this.dishes = dishes;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public List<Account> getAcc() {
        return acc;
    }

    public void setAcc(List<Account> acc) {
        this.acc = acc;
    }

    public List<Dish> getDishes() {
        return dishes;
    }

    public void setDishes(List<Dish> dishes) {
        this.dishes = dishes;
    }

    public List<Account> getAllUsers() {
        List<Account> list = new ArrayList<>();
        String sql = "select * from [User]";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account user = new Account();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public Account getUserById(int id) {
        String sql = "select * from [User] where id=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account user = new Account();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void deleteUserById(int id) {
        String sql = "DELETE FROM [User] WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " user(s).");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void registNewUser(Account user) {
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]\n"
                + "           ,[address]\n"
                + "           ,[phone]\n"                
                + "           ,[roleId])\n"
                + "     VALUES\n"
                + "           (? , ?, ? ,? ,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setInt(7, 2);

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }
    
    public void updateProfile(Account user) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [email] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[avatar] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAvatar());
            ps.setInt(7, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void checkAuthen(String email, String password) {
        acc = new Vector<Account>();
        String sql = "select * from User where username = ? and password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(
                        rs.getInt("id"),
                        email,
                        password,
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("avatar"),
                        rs.getInt("roleId")
                );
                acc.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }   
    
    public List<String> getEmailOfUsers() {
        List<String> list = new ArrayList<>();
        String sql = "select email from [User]";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("email"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void changePassword(int userId, String newPassword) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [password] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    //add by admin
    public void addNewUser(Account user) {
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]\n"
                + "           ,[address]\n"
                + "           ,[phone]\n"
                + "           ,[avatar]\n"
                + "           ,[roleId])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setString(7, user.getAvatar());
            ps.setInt(8, user.getRoleId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    //update by admin
    public void updateUser(Account user) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [email] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[avatar] = ?\n"
                + "      ,[roleId] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setString(7, user.getAvatar());
            ps.setInt(8, user.getRoleId());
            ps.setInt(9, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public Account getAccountByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Account account = new Account();
                account.setId(rs.getInt("id"));                
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setFirstName(rs.getString("firstName"));
                account.setLastName(rs.getString("lastName"));
                account.setRoleId(rs.getInt("roleId"));
                account.setPhone(rs.getString("phone"));
                account.setAddress(rs.getString("address"));
                account.setAvatar(rs.getString("avatar"));
                return account;
            }
        } catch (SQLException e) {
            System.err.println("Error getting account by email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Cập nhật mật khẩu mới cho account
     */
    public boolean updatePassword(String email, String newHashedPassword) {
        String sql = "UPDATE [User] SET password = ? WHERE email = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newHashedPassword);
            ps.setString(2, email);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }                
}