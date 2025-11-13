package ControllerAdmin;

import dal.*;
import Models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "Report", urlPatterns = {"/Admin/Report"})
public class Report extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        try {            
            // Lấy tất cả đơn hàng đã giao (statusId = 4)
            List<Order> allOrders = OrderDAO.INS.getAllOrder();
            int totalOrders = 0;
            double totalRevenue = 0;            
            for (Order o : allOrders) {
                if (o.getStatus() != null && o.getStatus().getStatusId() == 4) {
                    totalOrders++;
                    totalRevenue += o.getTotalPrice();
                }
            }            
            // Lấy doanh thu theo tháng
            LinkedHashMap<String, Double> revenueByMonth = DashBoardDAO.INS.getRevenueByMonth();
            
            // Tạo JSON arrays cho Chart.js
            StringBuilder monthLabels = new StringBuilder("[");
            StringBuilder monthRevenue = new StringBuilder("[");
            
            int count = 0;
            for (Map.Entry<String, Double> entry : revenueByMonth.entrySet()) {
                if (count > 0) {
                    monthLabels.append(", ");
                    monthRevenue.append(", ");
                }
                monthLabels.append("\"").append(entry.getKey()).append("\"");
                monthRevenue.append(entry.getValue());
                count++;
            }
            
            monthLabels.append("]");
            monthRevenue.append("]");
            
            // Set attributes
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", String.format("%.0f", totalRevenue));
            request.setAttribute("monthLabels", monthLabels.toString());
            request.setAttribute("monthRevenue", monthRevenue.toString());
            
            request.getRequestDispatcher("/Admin/report.jsp").forward(request, response);            
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