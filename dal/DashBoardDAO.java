package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

public class DashBoardDAO {
    private Connection con;
    
    public static DashBoardDAO INS = new DashBoardDAO();
    
    public DashBoardDAO() {        
        con = new DBContext().connection;        
    }
    
    public DashBoardDAO(Connection con) {
        this.con = con;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public int getNumberUsers(int roleId) {
        int number = 0;
        String sql = "select COUNT(*) as number from [User]\n"
                + "where roleId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                number = rs.getInt("number");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return number;
    }
    
    public int getNumberDish() {
        int number = 0;
        String sql = "select COUNT(*) as number from [Dish]";
        try {
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                number = rs.getInt("number");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return number;
    }
    
    public double getRevenueThisMonth() {
        double total = 0;
        String sql = "SELECT SUM(totalPrice) AS TotalRevenue\n"
                + "FROM [Order]\n"
                + "WHERE MONTH(date) = MONTH(GETDATE()) AND YEAR(date) = YEAR(GETDATE()) and statusId = 4;";
        try {
            PreparedStatement st = con.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                total = rs.getDouble("TotalRevenue");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }
    
    public LinkedHashMap<String, Double> getRevenueByMonth() {
        LinkedHashMap<String, Double> map = new LinkedHashMap<>();
        String sql = "WITH Months AS (\n"
                + "    SELECT 1 AS Month\n"
                + "    UNION ALL\n"
                + "    SELECT Month + 1\n"
                + "    FROM Months\n"
                + "    WHERE Month < 12\n"
                + ")\n"
                + "SELECT DATENAME(MONTH, DATEADD(MONTH, m.Month - 1, '1900-01-01')) AS MonthName,\n"
                + "       ISNULL(SUM(o.totalPrice), 0) AS TotalRevenue\n"
                + "FROM Months m\n"
                + "LEFT JOIN [Order] o ON MONTH(o.date) = m.Month AND YEAR(o.date) = YEAR(GETDATE()) and o.statusId = 4\n"
                + "GROUP BY m.Month\n"
                + "ORDER BY m.Month;";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("MonthName"), rs.getDouble("TotalRevenue"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return map;
    }
    
    public LinkedHashMap<String, Double> getLast7Days() {
        LinkedHashMap<String, Double> map = new LinkedHashMap<>();
        String sql = ";WITH DateRange AS (\n"
                + "    SELECT CAST(DATEADD(DAY, -number, CAST(GETDATE() AS DATE)) AS DATE) AS Date\n"
                + "    FROM master..spt_values\n"
                + "    WHERE type = 'P' AND number BETWEEN 0 AND 6 -- Điều chỉnh số ngày cần thiết\n"
                + ")\n"
                + "SELECT \n"
                + "    FORMAT(dr.Date, 'MMMM dd') + ' (' + DATENAME(WEEKDAY, dr.Date) + ')' AS Date,  -- Định dạng tháng, ngày và ngày trong tuần\n"
                + "    COALESCE(SUM(o.totalPrice), 0) AS TotalRevenue\n"
                + "FROM \n"
                + "    DateRange dr\n"
                + "LEFT JOIN \n"
                + "    [Order] o ON CAST(o.date AS DATE) = dr.Date AND o.statusId = 4\n"
                + "WHERE \n"
                + "    dr.Date <= CAST(GETDATE() AS DATE) -- Giới hạn ngày từ hôm nay trở về trước\n"
                + "GROUP BY \n"
                + "    dr.Date\n"
                + "ORDER BY \n"
                + "    dr.Date DESC; -- Sắp xếp từ hôm nay về trước";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("Date"), rs.getDouble("TotalRevenue"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return map;
    }
    
}
