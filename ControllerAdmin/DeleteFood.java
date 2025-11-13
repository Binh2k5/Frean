package ControllerAdmin;

import dal.DishDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteFood", urlPatterns = {"/Admin/DeleteFood"})
public class DeleteFood extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        HttpSession session = request.getSession();        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                session.setAttribute("error", "Invalid dish ID");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
                return;
            }            
            int dishId = Integer.parseInt(idParam);            
            DishDAO.INS.deleteDishById(dishId);
            
            session.setAttribute("success", "Dish deleted successfully");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid dish ID format");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to delete dish: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
        }
    }
}