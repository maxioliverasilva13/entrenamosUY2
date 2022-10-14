/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Institucion.InterfaceInstitucionBO;
import Profesor.dtos.ProfesorCreateDTO;
import Socio.dtos.SocioCreateDTO;
import Usuario.IUsuarioBO;
import Usuario.UsuarioBO;
import Usuario.dtos.UsuarioCreateDTO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import static java.lang.System.in;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import util.BlobToImage;

/**
 *
 * @author rodrigo
 */

@MultipartConfig(maxFileSize = 160177215) 
public class SignUp extends HttpServlet {

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
            out.println("<title>Servlet SignUp</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUp at " + request.getContextPath() + "</h1>");
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
        
        InterfaceInstitucionBO insBo = new InstitucionBO();
        HashMap<Integer,DtInstitucion> ins = insBo.listarInstituciones();
        request.setAttribute("instituciones", ins);
        request.getRequestDispatcher("/signup.jsp").forward(request, response);

       
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
      boolean isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
                
      
        
      
        String tipoUsuario = request.getParameter("tipoUsuario");
        String  nickname = request.getParameter("nickname");
        String Nombre = request.getParameter("Nombre");
        String Apellido = request.getParameter("Apellido");
        String Email = request.getParameter("Email");
        char[] Contraseña = request.getParameter("Contraseña").toCharArray();
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        Date fechaNacimientoDate = null;
        
       
        Part filePart = request.getPart("file_upload");
        InputStream fileContent = null;
        File avatar = null;
        if(filePart.getSize() > 0){
            BlobToImage blobToImg = new BlobToImage();
            fileContent = filePart.getInputStream();
            byte[] targetArray = new byte[fileContent.available()];
            // byte[] bytes = fileContent.readAllBytes();
            avatar = blobToImg.writeBytesToFile(nickname, targetArray);
        }
        IUsuarioBO usuarioBo = new UsuarioBO();
        try{
            fechaNacimientoDate =new SimpleDateFormat("dd/MM/yyyy").parse(fechaNacimiento); 
        }catch(Exception e){
            response.sendError(500,"Ha ocurrido un error inesperadoooooooooo");
        }
        UsuarioCreateDTO userData;
        if(tipoUsuario.equals("Socio")){
            userData = new SocioCreateDTO(
             Nombre,
             Apellido,
             nickname,
             Contraseña,
             Email,
             fechaNacimientoDate,
              avatar
          );
        }else{ //es un profesor
            String descripcion = request.getParameter("description");
            String biografia = request.getParameter("about");
            String website = request.getParameter("website");
            int idInstitucion = Integer.parseInt(request.getParameter("institucion"));
            userData = new ProfesorCreateDTO(Nombre,Apellido,nickname,Contraseña,descripcion,biografia,Email,website,fechaNacimientoDate,idInstitucion,avatar);         
        }
        try{
            usuarioBo.create(userData);
            request.setAttribute("signUpSucces", true);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }catch(Exception e){
            request.setAttribute("invalid-signup",e.getMessage());
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
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
