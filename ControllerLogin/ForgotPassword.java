package ControllerLogin;

import Models.Account;
import MyTools.EmailUtility;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet(name = "ForgotPassword", urlPatterns = {"/ForgotPassword"})
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang forgot password
        request.getRequestDispatcher("/Login/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        try {
            // Kiểm tra email có tồn tại không            
            Account account = UserDAO.INS.getAccountByEmail(email);
            
            if (account == null) {
                request.setAttribute("error", "Email not found in our system");
                request.getRequestDispatcher("/Login/forgotPassword.jsp").forward(request, response);
                return;
            }
            
            // Tạo OTP 6 số
            String otp = generateOTP();
            
            // Lưu OTP vào session với thời gian hết hạn
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            session.setAttribute("resetOTP", otp);
            session.setAttribute("otpTimestamp", System.currentTimeMillis());
            
            // Gửi OTP qua email
            boolean emailSent = EmailUtility.sendOTP(email, otp);
            
            if (emailSent) {
                // Chuyển đến trang verify OTP
                request.setAttribute("email", email);
                request.setAttribute("success", "OTP has been sent to your email");
                request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to send email. Please try again later.");
                request.getRequestDispatcher("/Login/forgotPassword.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/Login/forgotPassword.jsp").forward(request, response);
        }
    }
    
    /**
     * Tạo mã OTP 6 số ngẫu nhiên
     */
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}