package ControllerLogin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "VerifyOTP", urlPatterns = {"/VerifyOTP"})
public class VerifyOTP extends HttpServlet {

    // Thời gian hết hạn OTP: 5 phút (300000 milliseconds)
    private static final long OTP_EXPIRATION_TIME = 5 * 60 * 1000;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        
        // Lấy các chữ số OTP từ form
        String otp1 = request.getParameter("otp1");
        String otp2 = request.getParameter("otp2");
        String otp3 = request.getParameter("otp3");
        String otp4 = request.getParameter("otp4");
        String otp5 = request.getParameter("otp5");
        String otp6 = request.getParameter("otp6");
        
        // Ghép thành mã OTP đầy đủ
        String enteredOTP = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
        
        // Lấy OTP và thông tin từ session
        String storedOTP = (String) session.getAttribute("resetOTP");
        String storedEmail = (String) session.getAttribute("resetEmail");
        Long otpTimestamp = (Long) session.getAttribute("otpTimestamp");
        
        try {
            // Kiểm tra OTP có tồn tại không
            if (storedOTP == null || storedEmail == null || otpTimestamp == null) {
                request.setAttribute("error", "Session expired. Please request a new OTP.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra email có khớp không
            if (!email.equals(storedEmail)) {
                request.setAttribute("error", "Invalid request. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra OTP có hết hạn không (5 phút)
            long currentTime = System.currentTimeMillis();
            if (currentTime - otpTimestamp > OTP_EXPIRATION_TIME) {
                session.removeAttribute("resetOTP");
                session.removeAttribute("resetEmail");
                session.removeAttribute("otpTimestamp");
                
                request.setAttribute("error", "OTP has expired. Please request a new one.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra OTP có đúng không
            if (!enteredOTP.equals(storedOTP)) {
                request.setAttribute("error", "Invalid OTP. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
                return;
            }
            
            // OTP đúng - đánh dấu đã verify và chuyển đến trang reset password
            session.setAttribute("otpVerified", true);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/Login/resetPassword.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/Login/verifyOTP.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về trang forgot password nếu truy cập trực tiếp
        response.sendRedirect(request.getContextPath() + "/ForgotPassword");
    }
}