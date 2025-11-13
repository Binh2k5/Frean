package ControllerUser;

import dal.UserDAO;
import Models.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ChangePassword",urlPatterns = {"/User/ChangePassword"})
public class ChangePassword extends HttpServlet {    
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, Account user)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");      
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMsg", "All fields are required");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            return;
        }
        
        if (!user.getPassword().equals(currentPassword)) {
            request.setAttribute("errorMsg", "Current password is incorrect");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("errorMsg", "New password must be at least 6 characters long");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMsg", "New password and confirmation do not match");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            return;
        }
        
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("errorMsg", "New password must be different from current password");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            return;
        }
        
        try {                        
            UserDAO.INS.changePassword(user.getId(), newPassword);                      
            
            request.setAttribute("successMsg", "Password changed successfully");
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Failed to change password: " + e.getMessage());
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("author");               
        
        String action = request.getParameter("action");
        
        try {
            if ("change".equals(action)) {
                changePassword(request, response, user);
            } else {
                request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/Client/changePassword.jsp").forward(request, response);
        }
    }
}
