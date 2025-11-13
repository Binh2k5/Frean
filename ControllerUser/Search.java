package ControllerUser;

import Models.Dish;
import dal.DishDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Vector;

@WebServlet(name="Search", urlPatterns={"/User/Search"})
public class Search extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { 
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String search = request.getParameter("txtSearch").toLowerCase();
        String current = request.getParameter("currentPage");
        List<Dish> list = new Vector<Dish>();
        for(Dish d: DishDAO.INS.getAllDishes()){
            if(d.getName().toLowerCase().contains(search)){                
                list.add(d);
            }
        }
        if(!list.isEmpty()){
            request.setAttribute("searchResults", list);
            request.setAttribute("current", current);
        }
        else request.setAttribute("err", "Doesn't have this dish");
        switch (current) {
            case "index":
                request.getRequestDispatcher("/Client/index.jsp").forward(request, response);
                break;
            case "menu":
                request.getRequestDispatcher("/Client/menu.jsp").forward(request, response);
                break;
            case "about":
                request.getRequestDispatcher("/Client/about.jsp").forward(request, response);
                break;
            default:
                break;
        }
    }
    
}
