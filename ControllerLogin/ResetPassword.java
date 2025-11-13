package ControllerLogin;

import MyTools.EmailUtility;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;

@WebServlet(name = "ResetPassword", urlPatterns = {"/ResetPassword"})
public class ResetPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        try {
            // Kiểm tra đã verify OTP chưa
            Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
            String storedEmail = (String) session.getAttribute("resetEmail");
            
            if (otpVerified == null || !otpVerified || !email.equals(storedEmail)) {
                request.setAttribute("error", "Unauthorized access. Please verify OTP first.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword");
                return;
            }
            
            // Validate mật khẩu
            if (newPassword == null || newPassword.isEmpty()) {
                request.setAttribute("error", "Password cannot be empty");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra độ mạnh mật khẩu
            if (!isStrongPassword(newPassword)) {
                request.setAttribute("error", "Password does not meet security requirements");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
                return;
            }
            
            // Mã hóa mật khẩu mới
            //String hashedPassword = hashPassword(newPassword);
            
            // Cập nhật mật khẩu trong database            
            boolean updated = UserDAO.INS.updatePassword(email, newPassword);
            
            if (updated) {
                // Xóa thông tin session
                session.removeAttribute("resetOTP");
                session.removeAttribute("resetEmail");
                session.removeAttribute("otpTimestamp");
                session.removeAttribute("otpVerified");
                
                // Gửi email thông báo
                EmailUtility.sendPasswordResetSuccess(email);
                
                // Chuyển về trang login với thông báo thành công
                session.setAttribute("success", "Password reset successfully! You can now login with your new password.");
                response.sendRedirect(request.getContextPath() + "/Login");
            } else {
                request.setAttribute("error", "Failed to update password. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về trang forgot password nếu truy cập trực tiếp
        response.sendRedirect(request.getContextPath() + "/ForgotPassword");
    }
    
    /**
     * Kiểm tra độ mạnh của mật khẩu
     * - Ít nhất 8 ký tự
     * - Có chữ hoa
     * - Có chữ thường
     * - Có số
     */
    private boolean isStrongPassword(String password) {
        if (password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            if (Character.isLowerCase(c)) hasLower = true;
            if (Character.isDigit(c)) hasDigit = true;
        }
        
        return hasUpper && hasLower && hasDigit;
    }
    
    /**
     * Mã hóa mật khẩu bằng SHA-256
     * (Nên dùng BCrypt hoặc Argon2 trong production)
     */
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        StringBuilder hexString = new StringBuilder();
        
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        
        return hexString.toString();
    }
}