package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author FPT University - PRJ30X
 */
public class DBContext {
    protected Connection connection;
    public DBContext() {
        //@Students: You are not allowed to edit this method  
        try {
            String user = "sa";
            String pass = "zhongqin050205";
            String url = "jdbc:sqlserver://LAPTOP-9U124OPE\\SQLEXPRESS01:1433;databaseName=SE1979_Project";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("Successful");
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error");
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        DBContext d = new DBContext();
    }
}
