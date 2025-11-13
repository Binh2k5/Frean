package ControllerUser;

import dal.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author BINH
 */
@WebServlet(name="UpdateCartItem", urlPatterns={"/User/UpdateCartItem"})
public class UpdateCartItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String cartItemId = request.getParameter("cartItemId");
        String quantity = request.getParameter("quantity");
        
        try {
            int id = Integer.parseInt(cartItemId);
            int quan = Integer.parseInt(quantity);
            CartDAO.INS.updateQuantityOfCartItem(id, quan);
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
