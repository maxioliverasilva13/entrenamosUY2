/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Profesor.ProfesorBO;
import Profesor.dtos.ProfesorEditDTO;
import Socio.SocioBO;
import Socio.dtos.SocioDTO;
import Socio.dtos.SocioEditDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import util.BlobToImage;

/**
 *
 * @author mandi
 */
@WebServlet(name = "EditInfo", urlPatterns = {"/EditInfo"})
@MultipartConfig(maxFileSize = 160177215)
public class EditInfo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditInfo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        // Asignación de variables en común para ambos tipos d usuario
        String userType = request.getParameter("userType");
        String nickname = request.getParameter("nickname");
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String mail = request.getParameter("email");
        String fnacimientoStr = request.getParameter("fechaNacimiento");
        Date fechaNacimientoDate = null;
        try {
            fechaNacimientoDate = new SimpleDateFormat("dd/MM/yyyy").parse(fnacimientoStr);
        } catch (Exception e) {
            System.err.println("fechaNacimiento parse error catched, file: EditInfo.java");
        }
        

        String pass = request.getParameter("password");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if (userType.equals("Profesor")) {
            try {
                ProfesorEditDTO data;
                ProfesorBO profBO = new ProfesorBO();

                String description = request.getParameter("description");
                String biography = request.getParameter("biography");
                String website = request.getParameter("website");
                
                Part filePart = request.getPart("selected_file");
                System.out.println(filePart.getSize());
                InputStream fileContent = null;
                File avatar = null;
                if(filePart.getSize() > 0){
                    BlobToImage blobToImg = new BlobToImage();
                    fileContent = filePart.getInputStream();
                    byte[] targetArray = fileContent.readAllBytes();
                    avatar = blobToImg.writeBytesToFile(nickname, targetArray);
                }
                
                if (pass == null || request.getParameter("confirmPassword").equals("")) {
                    // NO modifico password
                    data = new ProfesorEditDTO(name, lastname, nickname, null, description, biography, website, mail, fechaNacimientoDate, avatar != null ? avatar : null);
                    profBO.editProfesorById(userId, data);
                    //System.out.println("profesor editado correctamente! (no editaste password)");
                    response.sendRedirect("verPerfil");
                } else {
                    // SI modifico password
                    char[] charPass = request.getParameter("confirmPassword").toCharArray();
                    data = new ProfesorEditDTO(name, lastname, nickname, charPass, description, biography, website, mail, fechaNacimientoDate, avatar != null ? avatar : null);
                    profBO.editProfesorById(userId, data);
                    System.out.println("PASS: " + request.getParameter("confirmPassword"));
                    //System.out.println("profesor editado correctamente! (SI editaste password)");
                    response.sendRedirect("verPerfil");
                }
            } catch (Exception e) {
                System.out.println("ERROR EN SERVLET EditInfo " + e.getMessage());
            }
        }
        
        if (userType.equals("Socio")) {
            try {
                SocioEditDTO dataSocio;
                SocioBO socioBO = new SocioBO();

                Part filePart = request.getPart("selected_file");
                System.out.println(filePart.getSize());
                InputStream fileContent = null;
                File avatar = null;
                if(filePart.getSize() > 0){
                    BlobToImage blobToImg = new BlobToImage();
                    fileContent = filePart.getInputStream();
                    byte[] targetArray = fileContent.readAllBytes();
                    avatar = blobToImg.writeBytesToFile(nickname, targetArray);
                }
                
                if (pass == null || request.getParameter("confirmPassword").equals("")) {
                    // NO modifico password
                    dataSocio = new SocioEditDTO(name, lastname, nickname, null, mail, fechaNacimientoDate, avatar != null ? avatar : null);
                    socioBO.editar(userId, dataSocio);
                    System.out.println("profesor editado correctamente! (no editaste password)");
                    response.sendRedirect("verPerfil");
                } else {
                    // SI modifico password
                    char[] charPass = request.getParameter("confirmPassword").toCharArray();
                    dataSocio = new SocioEditDTO(name, lastname, nickname, charPass, mail, fechaNacimientoDate, avatar != null ? avatar : null);
                    socioBO.editar(userId, dataSocio);
                    System.out.println("PASS: " + request.getParameter("confirmPassword"));
                    System.out.println("socio editado correctamente! (SI editaste password)");
                    response.sendRedirect("verPerfil");
                }
            } catch (Exception e) {
                System.out.println("ERROR EN SERVLET EditInfo " + e.getMessage());
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
