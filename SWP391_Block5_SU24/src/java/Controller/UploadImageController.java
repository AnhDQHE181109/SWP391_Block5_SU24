package Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.UUID;

@MultipartConfig
public class UploadImageController extends HttpServlet {
        private static final String UPLOAD_DIRECTORY = "D:/file luu de/swp/SWP391_Block5_SU24_main/SWP391_Block5_SU24/SWP391_Block5_SU24/web/images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Process file upload
        Part filePart = request.getPart("image");
        String fileName = UUID.randomUUID().toString() + ".jpg"; // Generate a unique file name
        File fileSaveDir = new File(UPLOAD_DIRECTORY);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        File file = new File(fileSaveDir, fileName);
        filePart.write(file.getAbsolutePath());

        // Get other parameters from request
        String productID = request.getParameter("productID");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String stockQuantity = request.getParameter("stockQuantity");

        // Generate image URL relative to web root
        String imageURL = "/images/" + fileName;

        // Redirect to addvariant.jsp with image URL and all other data
        response.sendRedirect("staff/addvariant.jsp?productID=" + productID + "&imageURL=" + imageURL +
                "&size=" + size + "&color=" + color + "&stockQuantity=" + stockQuantity);
    }
}