package ControllerUser;

import Models.*;
import MyTools.MyTool;
import dal.DishDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="Menu", urlPatterns={"/User/Menu"})
public class Menu extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession ses = request.getSession();
        Account u = (Account) ses.getAttribute("author");
        
        int nrpp = Integer.parseInt(request.getServletContext().getInitParameter("nrpp"));        
        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "all";
        }        
        List<Dish> allDishes;
        if (filter.equalsIgnoreCase("all")) {
            allDishes = DishDAO.INS.getAllDishes();
        } else {
            allDishes = DishDAO.INS.getDishesByCategory(filter);
        }
        int size = allDishes.size();
        request.setAttribute("nrpp", nrpp);
        int index;
        try {
            index = Integer.parseInt(request.getParameter("index"));
            index = index < 0 ? 0 : index;
        } catch (Exception e) {
            index = 0;
        }
        MyTool my = new MyTool(size, nrpp, index);
        my.calc();        

        request.setAttribute("cate", DishDAO.INS.getCategories());
        request.setAttribute("tool", my);
        request.setAttribute("filter", filter);
        ses.setAttribute("DB", allDishes);
        request.getRequestDispatcher("/Client/menu.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}
