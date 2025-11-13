package ControllerUser;

import Models.Account;
import Models.CartItem;
import Models.Dish;
import dal.CartDAO;
import dal.DishDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Cart", urlPatterns = {"/User/Cart"})
public class Cart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account u = (Account) ses.getAttribute("author");        
        String dish = request.getParameter("dishId");
        try {
            int d = Integer.parseInt(dish);
            CartDAO.INS.addToCart(u.getId(), d, 1);
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/HomePage");
            return;
        } catch (NumberFormatException e) {
        }
        double result = CartDAO.INS.getTotalPriceOfCart(u.getId());
        ses.setAttribute("sum", result);
        request.setAttribute("cart", CartDAO.INS.getAllCartItemsByUserId(u.getId()));
        request.getRequestDispatcher("/Client/Cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account u = (Account) ses.getAttribute("author");

        String dishId = request.getParameter("dishId");
        String quantity = request.getParameter("quantity");
        if (dishId != null && !dishId.isEmpty()) {
            try {
                int id = Integer.parseInt(dishId);
                if(quantity == null || quantity.isEmpty()){
                    quantity = "1";
                }
                int quan = Integer.parseInt(quantity);
                Dish dish = DishDAO.INS.getDishById(id);
                CartItem cartItem = CartDAO.INS.getCartItemByDishIdUserId(id, u.getId());
                if ((cartItem != null && (cartItem.getQuantity() + quan) > dish.getQuantity()) || (cartItem == null && quan > dish.getQuantity())) {
                    request.setAttribute("message", "Sorry you can only buy up to " + dish.getQuantity() + " this dish.");
                    request.getRequestDispatcher("/Client/Cart.jsp").forward(request, response);
                } else {
                    CartDAO.INS.addToCart(u.getId(), id, quan);
                    request.setAttribute("message", "Dish has been added to cart!");
                    request.getRequestDispatcher("/Client/Cart.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
            }
        }
    }
}
