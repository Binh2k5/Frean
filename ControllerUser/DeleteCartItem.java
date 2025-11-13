package ControllerUser;

import Models.CartItem;
import dal.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="DeleteCartItem", urlPatterns={"/User/DeleteCartItem"})
public class DeleteCartItem extends HttpServlet {
       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String cartItemId = request.getParameter("cartItemId");
        
        try {
            int id = Integer.parseInt(cartItemId);            
            CartItem item = CartDAO.INS.getCartItemByCartItemId(id);
            if(item != null) {
                CartDAO.INS.deleteCartItem(item.getUserId(), item.getDish().getId());
            }
        } catch(NumberFormatException e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/User/Cart");
    } 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    }
