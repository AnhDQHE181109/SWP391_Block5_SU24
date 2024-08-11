/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author asus
 */
@WebServlet(name = "importimage", urlPatterns = {"/importimage"})
public class importimage extends HttpServlet {

    private static final String SAVE_DIR = "D:\\file luu de\\swp\\SWP391_Block5_SU24\\SWP391_Block5_SU24\\web\\shoeimage";

      protected void doPost(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {

          String imageId = request.getParameter("imageId");
          Part filePart = request.getPart("newImageFile");

          // Kiểm tra xem imageId có tồn tại không
          if (imageId == null || imageId.trim().isEmpty()) {
              sendError(request, response, "Image ID is missing.");
              return;
          }

          // Kiểm tra xem file ảnh có được chọn không
          if (filePart == null || filePart.getSize() == 0) {
              sendError(request, response, "No image file was uploaded.");
              return;
          }

          String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

          // Kiểm tra xem file có phải là ảnh không
          if (!isImageFile(fileName)) {
              sendError(request, response, "Uploaded file is not an image.");
              return;
          }

          // Create save directory if it doesn't exist
          File saveDir = new File(SAVE_DIR);
          if (!saveDir.exists()) {
              saveDir.mkdirs();
          }

          // Write the file
          String filePath = SAVE_DIR + fileName;
          try (InputStream input = filePart.getInputStream()) {
              Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
          }

          // Redirect back to the edit page
          response.sendRedirect("ImageController?service=edit&imageId=" + imageId);
      }

      private void sendError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
              throws ServletException, IOException {
          request.setAttribute("error", errorMessage);
          request.getRequestDispatcher("ImageController?service=edit&imageId=" + request.getParameter("imageId"))
                 .forward(request, response);
      }

      private boolean isImageFile(String fileName) {
          String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif"};
          for (String extension : allowedExtensions) {
              if (fileName.toLowerCase().endsWith(extension)) {
                  return true;
              }
          }
          return false;
      }
  }