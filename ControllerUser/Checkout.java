package ControllerUser;

import Models.*;
import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@WebServlet(name="Checkout", urlPatterns={"/User/Checkout"})
public class Checkout extends HttpServlet {
       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account user = (Account) ses.getAttribute("author");
        
        request.setAttribute("cart", CartDAO.INS.getAllCartItemsByUserId(user.getId()));
        request.getRequestDispatcher("/Client/Checkout.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account user = (Account) ses.getAttribute("author");
        
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            String note = request.getParameter("note");
            
            // Lấy giỏ hàng của user
            List<CartItem> cartItems = CartDAO.INS.getAllCartItemsByUserId(user.getId());
            double totalPrice = CartDAO.INS.getTotalPriceOfCart(user.getId());
            
            // Kiểm tra giỏ hàng có sản phẩm không
            if (cartItems == null || cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty!");
                request.setAttribute("cart", cartItems);
                request.setAttribute("sum", totalPrice);
                request.getRequestDispatcher("/Client/Checkout.jsp").forward(request, response);
                return;
            }
            
            Order order = new Order();
            order.setUserId(user.getId());
            order.setDate(new java.sql.Date(System.currentTimeMillis()));
            order.setName(fullName);
            order.setPhone(phone);
            order.setAddress(address);
            order.setShipPrice(0.0);
            order.setTotalPrice(totalPrice);
            order.setNote(note);
            
            // Set status (1 = Pending, 2 = Confirmed, 3 = Shipping, 4 = Completed, 5 = Cancelled)
            Status status = new Status();
            status.setStatusId(1); // Pending
            status.setStatus("Pending");
            order.setStatus(status);
            
            // Thêm Order vào database và lấy orderId
            int orderId = OrderDAO.INS.addOrder(order);
            
            if (orderId != -1) {
                // Thêm OrderDetails
                for (CartItem cartItem : cartItems) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrderId(orderId);
                    orderDetail.setDish(cartItem.getDish());
                    orderDetail.setQuantity(cartItem.getQuantity());
                    orderDetail.setPriceDish(cartItem.getDish().getPrice());
                    
                    OrderDAO.INS.addOrderDetail(orderDetail);
                }
                
                // Xóa giỏ hàng sau khi đặt hàng thành công
                CartDAO.INS.clearCartItem(user.getId());
                
                // Chuyển hướng đến trang thành công
                response.sendRedirect(request.getContextPath() + "/User/HomePage");
            } else {
                // Xử lý lỗi khi tạo order
                request.setAttribute("error", "Failed to create order. Please try again.");
                request.setAttribute("cart", cartItems);
                request.setAttribute("sum", totalPrice);
                request.getRequestDispatcher("/Client/Checkout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            List<CartItem> cartItems = CartDAO.INS.getAllCartItemsByUserId(user.getId());
            double totalPrice = CartDAO.INS.getTotalPriceOfCart(user.getId());
            request.setAttribute("cart", cartItems);
            request.setAttribute("sum", totalPrice);
            request.getRequestDispatcher("/Client/Checkout.jsp").forward(request, response);
        }
    }
}
