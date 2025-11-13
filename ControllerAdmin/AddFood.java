package ControllerAdmin;

import dal.DishDAO;
import Models.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet(name = "AddFood", urlPatterns = {"/Admin/AddFood"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AddFood extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();        
        try {
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");            
            String category = request.getParameter("newCategory");
            if (category == null || category.trim().isEmpty()) {
                category = request.getParameter("category");
            }
            
            Part filePart = request.getPart("image");            
            if (name == null || name.trim().isEmpty() || 
                priceStr == null || priceStr.trim().isEmpty()) {
                session.setAttribute("error", "Name and price are required");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
                return;
            }            
            // Validate category
            if (category.trim().isEmpty()) {
                session.setAttribute("error", "Please select or enter a category");
                response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
                return;
            }           
            category = category.trim().toLowerCase();            
            double price = Double.parseDouble(priceStr);
            String imageName = "default.png";                        
            // Xử lý upload file
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Lưu file vào thư mục images trong webapp
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }                    
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    imageName = fileName;
                }
            }
            
            Dish newDish = new Dish();
            newDish.setName(name);
            newDish.setPrice(price);
            newDish.setDescription(description != null ? description : "");
            newDish.setImage(imageName);
            newDish.setCategory(category);
            newDish.setQuantity(100);            
            DishDAO.INS.addNewDish(newDish);
            
            session.setAttribute("success", "Dish added successfully with category: " + category);
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid price format");
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to add dish: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Admin/ManageDish");
        }
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }
}