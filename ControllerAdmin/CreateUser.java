package ControllerAdmin;

import dal.UserDAO;
import Models.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CreateUser", urlPatterns = {"/Admin/CreateUser"})
public class CreateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");            
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                session.setAttribute("error", "Username and password are required");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
                return;
            }            
            // Kiểm tra email đã tồn tại
            if (UserDAO.INS.getEmailOfUsers().contains(username)) {
                session.setAttribute("error", "Email already exists");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
                return;
            }            
            // Tạo user mới
            Account newAcc = new Account();
            newAcc.setEmail(username);
            newAcc.setPassword(password);
            newAcc.setFirstName("");
            newAcc.setLastName("");
            newAcc.setAddress("");
            newAcc.setPhone("");
            newAcc.setAvatar("");
            newAcc.setRoleId(role.equals("Admin") ? 1 : 2);            
            UserDAO.INS.addNewUser(newAcc);
            
            session.setAttribute("success", "User created successfully");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to create user: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
        }
    }
}