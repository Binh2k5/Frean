package ControllerUser;

import dal.UserDAO;
import Models.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "UpdateProfile", urlPatterns = {"/User/UpdateProfile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UpdateProfile extends HttpServlet {    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.getRequestDispatcher("/Client/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("author");                        
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty()) {
                request.setAttribute("errorMsg", "First name and last name are required!");
                request.getRequestDispatcher("/Client/profile.jsp").forward(request, response);
                return;
            }
            user.setFirstName(firstName.trim());
            user.setLastName(lastName.trim());
            user.setPhone(phone != null ? phone.trim() : "");
            user.setAddress(address != null ? address.trim() : "");
            
            // Handle avatar upload
            Part avatarPart = request.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();                
                // Validate file type
                String fileExtension = getFileExtension(fileName);
                if (!isValidImageExtension(fileExtension)) {
                    request.setAttribute("errorMsg", "Invalid file type! Only JPG, JPEG, PNG, GIF are allowed.");
                    request.getRequestDispatcher("/Client/profile.jsp").forward(request, response);
                    return;
                }                
                // Generate unique filename
                String uniqueFileName = "avatar_" + user.getId() + "_" + System.currentTimeMillis() + fileExtension;                
                // Get upload path
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";                
                // Create directory if it doesn't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }                
                // Delete old avatar if exists
                if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
                    File oldFile = new File(uploadPath + File.separator + user.getAvatar());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }                
                // Save new avatar
                String filePath = uploadPath + File.separator + uniqueFileName;
                avatarPart.write(filePath);                
                // Update avatar in user object
                user.setAvatar(uniqueFileName);
            }           
            UserDAO.INS.updateProfile(user);            
            
            session.setAttribute("author", user);            
            request.setAttribute("successMsg", "Profile updated successfully!");
            request.getRequestDispatcher("/Client/profile.jsp").forward(request, response);            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "An error occurred while updating profile: " + e.getMessage());
            request.getRequestDispatcher("/Client/profile.jsp").forward(request, response);
        }
    }
    
    /**
     * Get file extension from filename
     */
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1) {
            return "";
        }
        return fileName.substring(lastDotIndex);
    }
    
    /**
     * Validate image file extension
     */
    private boolean isValidImageExtension(String extension) {
        if (extension == null || extension.isEmpty()) {
            return false;
        }
        extension = extension.toLowerCase();
        return extension.equals(".jpg") || 
               extension.equals(".jpeg") || 
               extension.equals(".png") || 
               extension.equals(".gif");
    }    
}