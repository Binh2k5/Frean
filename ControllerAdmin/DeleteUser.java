package ControllerAdmin;

import dal.UserDAO;
import Models.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteUser", urlPatterns = {"/Admin/DeleteUser"})
public class DeleteUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                session.setAttribute("error", "Invalid user ID");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
                return;
            }
            int userId = Integer.parseInt(idParam);
            // Không cho phép xóa chính mình
            Account user = (Account) session.getAttribute("author");
            if (user != null && user.getId() == userId) {
                session.setAttribute("error", "Cannot delete your own account");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
                return;
            }
            if (UserDAO.INS.getUserById(userId).getRoleId() == 1) {
                session.setAttribute("error", "Cannot delete admin account");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
                return;
            }
            UserDAO.INS.deleteUserById(userId);

            session.setAttribute("success", "User deleted successfully");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid user ID format");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to delete user: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Admin/ManageUser");
        }
    }
}
