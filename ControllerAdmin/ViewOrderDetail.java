package ControllerAdmin;

import dal.*;
import Models.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewOrderDetail", urlPatterns = {"/Admin/ViewOrderDetail"})
public class ViewOrderDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        try {
            String orderIdParam = request.getParameter("id");            
            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }            
            int orderId = Integer.parseInt(orderIdParam);                        
            // Lấy thông tin order
            Order order = OrderDAO.INS.getOrderById(orderId);            
            if (order == null) {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Order not found");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
                return;
            }            
            // Lấy chi tiết order
            List<OrderDetail> orderDetails = OrderDAO.INS.getDetailsByOrderId(orderId);            
            // Lấy thông tin user
            Account user = UserDAO.INS.getUserById(order.getUserId());
            
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.setAttribute("user", user);            
            request.getRequestDispatcher("/Admin/viewOrderDetail.jsp").forward(request, response);            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Admin/ManageOrder");
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