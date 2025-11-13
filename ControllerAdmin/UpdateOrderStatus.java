package ControllerAdmin;

import Models.Order;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UpdateOrderStatus", urlPatterns = {"/Admin/UpdateOrderStatus"})
public class UpdateOrderStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();        
        try {
            String orderIdParam = request.getParameter("orderId");
            String statusIdParam = request.getParameter("statusId");            
            // Validate input
            if (orderIdParam == null || orderIdParam.trim().isEmpty() ||
                statusIdParam == null || statusIdParam.trim().isEmpty()) {
                session.setAttribute("error", "Invalid order or status ID");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }            
            int orderId = Integer.parseInt(orderIdParam);
            int statusId = Integer.parseInt(statusIdParam);            
            // Validate status ID (1-5)
            if (statusId < 1 || statusId > 5) {
                session.setAttribute("error", "Invalid status ID");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }                   
            Order currentOrder = OrderDAO.INS.getOrderById(orderId);
            if (currentOrder == null) {
                session.setAttribute("error", "Order not found");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }            
            int currentStatusId = currentOrder.getStatus().getStatusId();            
            if (!isValidStatusTransition(currentStatusId, statusId)) {
                session.setAttribute("error", "Invalid status transition. Orders can only move forward: Pending → Processing → Shipping → Delivered/Cancelled");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }            
            // Update status            
            OrderDAO.INS.updateStatusOrder(orderId, statusId);
            
            session.setAttribute("success", "Order status updated successfully");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid number format");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to update order status: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
    }
    
    private boolean isValidStatusTransition(int currentStatus, int newStatus) {        
        if (currentStatus == newStatus) return false;                                   
        if (currentStatus == 1) return newStatus == 2 || newStatus == 5;      
        if (currentStatus == 2) return newStatus == 3 || newStatus == 5;              
        if (currentStatus == 3) return newStatus == 4 || newStatus == 5;  
        if (currentStatus == 4 || currentStatus == 5) return false;
        return false;
    }
    
}