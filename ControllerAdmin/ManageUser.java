package ControllerAdmin;

import dal.UserDAO;
import Models.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageUser", urlPatterns = {"/Admin/ManageUser"})
public class ManageUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        try {            
            List<Account> userList = UserDAO.INS.getAllUsers();
            
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/Admin/manageUser.jsp").forward(request, response);            
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