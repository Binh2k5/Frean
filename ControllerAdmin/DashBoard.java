package ControllerAdmin;

import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DashBoard", urlPatterns = {"/Admin/DashBoard"})
public class DashBoard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        try {            
            // Đếm số lượng users
            int totalUsers = DashBoardDAO.INS.getNumberUsers(2);            
            // Đếm tổng số món ăn
            int totalFoods = DishDAO.INS.getAllDishes().size();            
            // Đếm tổng số đơn hàng
            int totalOrders = OrderDAO.INS.getAllOrder().size();            
            // Tính tổng doanh thu (chỉ đơn hàng đã giao - statusId = 4)
            double totalRevenue = OrderDAO.INS.getAllOrder().stream()
                .filter(o -> o.getStatus() != null && o.getStatus().getStatusId() == 4)
                .mapToDouble(o -> o.getTotalPrice())
                .sum();
            
            // Đặt attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalFoods", totalFoods);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", String.format("%.0f", totalRevenue));            
            request.getRequestDispatcher("/Admin/dashBoard.jsp").forward(request, response);            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}