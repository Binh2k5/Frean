package ControllerLogin;

import Models.Account;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Login/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u = request.getParameter("txtEmail");
        String p = request.getParameter("txtPassword");
        boolean loggedIn = false;
        for (Account a : UserDAO.INS.getAllUsers()) {
            if (a.getEmail().equals(u) && a.getPassword().equals(p)) {
                HttpSession ses = request.getSession();
                ses.setAttribute("author", a);
                if(a.getRoleId() == 1)response.sendRedirect(request.getContextPath() + "/Admin/DashBoard");
                else if (a.getRoleId() == 2)response.sendRedirect(request.getContextPath() + "/User/HomePage");
                loggedIn = true;
                return;
            }
        }
        if (!loggedIn) {
            request.setAttribute("err", "Username or password is incorrect");
            request.getRequestDispatcher("/Login/Login.jsp").forward(request, response);
        }
    }
}
