package ControllerLogin;

import Models.Account;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.getRequestDispatcher("/Login/Register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String firstName = request.getParameter("txtFirstName");
        String lastName = request.getParameter("txtLastName");
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");
        String confirm = request.getParameter("txtConfirmPassword");
        String phone = request.getParameter("txtPhone");
        String address = request.getParameter("txtAddress");
        if(!confirm.equals(password)){
            request.setAttribute("conErr", "The confirmation password does not match!");
            request.getRequestDispatcher("Login/Register.jsp").forward(request, response);
            return;
        }
        for (String e : UserDAO.INS.getEmailOfUsers()) {
            if (email.equals(e)) {
                request.setAttribute("err", "Email's already existed!");
                request.getRequestDispatcher("Login/Register.jsp").forward(request, response);
                return;
            }
        }
        Account user = new Account(email, password, firstName, lastName, address, phone);
        UserDAO.INS.registNewUser(user);
        response.sendRedirect(request.getContextPath() + "/Login");
    }
}
