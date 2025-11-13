package MyTools;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtility {
    
    // Cấu hình email - Thay bằng thông tin email thực của bạn
    private static final String FROM_EMAIL = "nguyenhuubinh2k5@gmail.com"; // Email của bạn
    private static final String PASSWORD = "dwym vfxd eczo pbzr"; // App password của Gmail
    
    /**
     * Gửi OTP qua email
     */
    public static boolean sendOTP(String toEmail, String otp) {
        String subject = "Password Reset OTP - Feane Restaurant";
        String htmlContent = buildOTPEmailTemplate(otp);
        
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Gửi thông báo reset password thành công
     */
    public static boolean sendPasswordResetSuccess(String toEmail) {
        String subject = "Password Reset Successful - Feane Restaurant";
        String htmlContent = buildSuccessEmailTemplate();
        
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Gửi email với HTML content
     */
    private static boolean sendEmail(String toEmail, String subject, String htmlContent) {
        try {
            // Cấu hình properties
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            // Tạo session với authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                }
            });
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Feane Restaurant"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Template email cho OTP
     */
    private static String buildOTPEmailTemplate(String otp) {
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
            ".container { max-width: 600px; margin: 40px auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
            ".header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 40px 30px; }" +
            ".otp-box { background: #f8f9fa; border: 2px dashed #667eea; border-radius: 10px; padding: 20px; text-align: center; margin: 30px 0; }" +
            ".otp-code { font-size: 32px; font-weight: bold; color: #667eea; letter-spacing: 8px; }" +
            ".footer { background: #f8f9fa; padding: 20px; text-align: center; color: #666; font-size: 14px; }" +
            ".warning { color: #dc3545; font-weight: bold; margin-top: 20px; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Password Reset Request</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<p>Hello,</p>" +
            "<p>You have requested to reset your password. Please use the OTP code below to verify your identity:</p>" +
            "<div class='otp-box'>" +
            "<p>Your OTP Code:</p>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "</div>" +
            "<p>This code will expire in <strong>5 minutes</strong>.</p>" +
            "<p>If you didn't request this password reset, please ignore this email or contact support if you have concerns.</p>" +
            "<div class='warning'>⚠️ Never share this code with anyone!</div>" +
            "</div>" +
            "<div class='footer'>" +
            "<p>© 2024 Feane Restaurant. All rights reserved.</p>" +
            "<p>This is an automated message, please do not reply.</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
    }
    
    /**
     * Template email cho thông báo đổi mật khẩu thành công
     */
    private static String buildSuccessEmailTemplate() {
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
            ".container { max-width: 600px; margin: 40px auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
            ".header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 40px 30px; }" +
            ".success-icon { font-size: 60px; text-align: center; color: #28a745; margin: 20px 0; }" +
            ".footer { background: #f8f9fa; padding: 20px; text-align: center; color: #666; font-size: 14px; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Password Reset Successful</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<div class='success-icon'>✓</div>" +
            "<p>Hello,</p>" +
            "<p>Your password has been successfully reset. You can now login with your new password.</p>" +
            "<p>If you didn't make this change, please contact our support team immediately.</p>" +
            "<p><strong>Security Tips:</strong></p>" +
            "<ul>" +
            "<li>Never share your password with anyone</li>" +
            "<li>Use a unique password for each account</li>" +
            "<li>Change your password regularly</li>" +
            "</ul>" +
            "</div>" +
            "<div class='footer'>" +
            "<p>© 2024 Feane Restaurant. All rights reserved.</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
    }
}