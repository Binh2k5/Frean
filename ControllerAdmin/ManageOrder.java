package ControllerAdmin;

import dal.OrderDAO;
import Models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageOrder", urlPatterns = {"/Admin/ManageOrder"})
public class ManageOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        try {                        
            // Lấy filter status từ parameter (nếu có)
            String statusFilter = request.getParameter("status");
            List<Order> orderList;            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                int statusId = Integer.parseInt(statusFilter);
                orderList = OrderDAO.INS.getOrderByStatus(statusId);
            } else {
                // Lấy tất cả orders
                orderList = OrderDAO.INS.getAllOrder();
            }            
            // Đếm số lượng orders theo từng status
            int pendingCount = 0;
            int processingCount = 0;
            int shippingCount = 0;
            int deliveredCount = 0;
            int cancelledCount = 0;            
            for (Order o : OrderDAO.INS.getAllOrder()) {
                if (o.getStatus() != null) {
                    switch (o.getStatus().getStatusId()) {
                        case 1: pendingCount++; break;
                        case 2: processingCount++; break;
                        case 3: shippingCount++; break;
                        case 4: deliveredCount++; break;
                        case 5: cancelledCount++; break;
                    }
                }
            }
            
            request.setAttribute("orderList", orderList);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("processingCount", processingCount);
            request.setAttribute("shippingCount", shippingCount);
            request.setAttribute("deliveredCount", deliveredCount);
            request.setAttribute("cancelledCount", cancelledCount);            
            request.getRequestDispatcher("/Admin/manageOrder.jsp").forward(request, response);            
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