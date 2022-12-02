/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import spals.shaded.com.google.common.io.ByteStreams;
import util.BlobToImage;
import ws.ActividadCreateDTO;
import ws.DtInstitucion;
import ws.ProfesorCreateDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioCreateDTO;
import ws.UsuarioCreateDTO;

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
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();
        HashMap<Integer, DtInstitucion> ins = new HashMap();
        publicador.listarInstituciones().forEach((DtInstitucion inst) -> {
            ins.put(inst.getId(), inst);
        });

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
        response.setContentType("text/html");
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();
        String tipoUsuario = request.getParameter("tipoUsuario");
        String nickname = request.getParameter("nickname");
        String Nombre = request.getParameter("Nombre");
        String Apellido = request.getParameter("Apellido");
        String Email = request.getParameter("Email");
        String Contraseña = request.getParameter("confirmPassword");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        Date fechaNacimientoDate = null;

        Part filePart = request.getPart("file_upload");
        InputStream fileContent = null;
        File avatar = null;
        if (filePart.getSize() > 0) {
            BlobToImage blobToImg = new BlobToImage();
            fileContent = filePart.getInputStream();
            byte[] bytes = ByteStreams.toByteArray(fileContent);
            avatar = blobToImg.writeBytesToFile(nickname, bytes);
        }
        try {
            fechaNacimientoDate = new SimpleDateFormat("dd/MM/yyyy").parse(fechaNacimiento);
        } catch (Exception e) {
            response.sendError(500, "Ha ocurrido un error inesperado");
        }
        try {
            GregorianCalendar fechaNacimientoParssed = new GregorianCalendar();
            fechaNacimientoParssed.setTime(fechaNacimientoDate);
            XMLGregorianCalendar fechaParssed;
            fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fechaNacimientoParssed);

            if (tipoUsuario.equals("Socio")) {
                SocioCreateDTO socioData = new SocioCreateDTO();
                socioData.setNombre(Nombre);
                socioData.setApellido(Apellido);
                socioData.setEmail(Email);
                socioData.setImage(avatar.toString());
                socioData.setNacimiento(fechaParssed);
                // socioData.setContrase{a
                
                publicador.crearSocio(socioData, Contraseña);
                System.out.println("Socio Creado");
                request.setAttribute("signUpSucces", true);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else { //es un profesor
                String descripcion = request.getParameter("description");
                String biografia = request.getParameter("about");
                String website = request.getParameter("website");
                int idInstitucion = Integer.parseInt(request.getParameter("institucion"));
                ProfesorCreateDTO socioData = new ProfesorCreateDTO();
                socioData.setIdInstitucion(idInstitucion);
                socioData.setNombre(Nombre);
                socioData.setApellido(Apellido);
                socioData.setEmail(Email);
                socioData.setImage(avatar.toString());
                socioData.setNacimiento(fechaParssed);
                socioData.setBiografia(biografia);
                socioData.setLinkSitioWeb(website);
                socioData.setDescripcionGeneral(descripcion);
                publicador.crearProfe(socioData, Contraseña);
                request.setAttribute("signUpSucces", true);
                System.out.println("Profe Creado");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("invalid-signup", e.getMessage());
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
