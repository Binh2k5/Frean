package ControllerAdmin;

import Models.Dish;
import dal.DishDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageDish", urlPatterns = {"/Admin/ManageDish"})
public class ManageDish extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Dish> foodList = DishDAO.INS.getAllDishes();
            List<String> categories = DishDAO.INS.getCategories();
            
            request.setAttribute("foodList", foodList);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/Admin/manageDish.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dishes: " + e.getMessage());
            request.getRequestDispatcher("/Admin/manageDish.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}