package ControllerUser;

import Models.Account;
import dal.DishDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="HomePage", urlPatterns={"/User/HomePage"})
public class HomePage extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account u = (Account) ses.getAttribute("author");        
        
        ses.setAttribute("DB", DishDAO.INS.getAllDishes());        
        ses.setAttribute("top2", DishDAO.INS.getTop2DishesExp());
        ses.setAttribute("top3", DishDAO.INS.getTop3DishesCheapest());
        ses.setAttribute("top9", DishDAO.INS.getTop9DishesExp());
        request.getRequestDispatcher("/Client/index.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }
}
