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
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import spals.shaded.com.google.common.io.ByteStreams;
import util.BlobToImage;
import ws.ProfesorDTO;
import ws.ProfesorEditDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;
import ws.SocioEditDTO;

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
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        // Asignación de variables en común para ambos tipos d usuario
        String userType = request.getParameter("userType");
        String nickname = request.getParameter("nickname");
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String mail = request.getParameter("email");
        String fnacimientoStr = request.getParameter("fechaNacimiento");
        Date fechaNacimientoDate = null;
        HttpSession session = request.getSession(true);
        try {
            fechaNacimientoDate = new SimpleDateFormat("dd/MM/yyyy").parse(fnacimientoStr);
        } catch (Exception e) {
            System.err.println("fechaNacimiento parse error catched, file: EditInfo.java");
        }

        String pass = request.getParameter("password");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if (userType.equals("Profesor")) {
            try {
                ProfesorEditDTO data = new ProfesorEditDTO();

                String description = request.getParameter("description");
                String biography = request.getParameter("biography");
                String website = request.getParameter("website");
                String newPass = request.getParameter("confirmPassword");

                Part filePart = request.getPart("selected_file");
                InputStream fileContent = null;
                File avatar = null;
                if (filePart.getSize() > 0) {
                    BlobToImage blobToImg = new BlobToImage();
                    fileContent = filePart.getInputStream();
                    byte[] targetArray = ByteStreams.toByteArray(fileContent);
                    avatar = blobToImg.writeBytesToFile(nickname, targetArray);
                }
                GregorianCalendar fecha = new GregorianCalendar();
                fecha.setTime(fechaNacimientoDate);
                XMLGregorianCalendar fechaParssed;
                fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fecha);

                if (pass == null || request.getParameter("confirmPassword").equals("")) {
                    data.setNombre(name);
                    data.setApellido(lastname);
                    data.setNickname(nickname);
                    data.setDescripcionGeneral(description);
                    data.setBiografia(biography);
                    data.setLinkSitioWeb(website);
                    data.setEmail(mail);
                    data.setFechaNacimiento(fechaParssed);
                    if (avatar != null) {
                        data.setImage(avatar.toString());
                    }
                    publicador.editProfeInfo(userId, data, newPass);
                    //System.out.println("profesor editado correctamente! (no editaste password)");
                    response.sendRedirect("verPerfil");
                } else {
                    // SI modifico password
                    data.setNombre(name);
                    data.setApellido(lastname);
                    data.setNickname(nickname);
                    data.setDescripcionGeneral(description);
                    data.setBiografia(biography);
                    data.setLinkSitioWeb(website);
                    data.setEmail(mail);
                    // data.setPassword
                    data.setFechaNacimiento(fechaParssed);
                    data.setImage(avatar != null ? avatar.toString() : null);
                    publicador.editProfeInfo(userId, data, newPass);
                    response.sendRedirect("verPerfil");
                }
                ProfesorDTO profe = publicador.getProfesorById(userId);
                session.setAttribute("currentSessionUser", profe);
            } catch (Exception e) {
                System.out.println("Aca1");

                System.out.println(e);
            }
        }

        if (userType.equals("Socio")) {
            try {
                SocioEditDTO dataSocio = new SocioEditDTO();
                Part filePart = request.getPart("selected_file");
                InputStream fileContent = null;
                File avatar = null;
                if (filePart.getSize() > 0) {
                    BlobToImage blobToImg = new BlobToImage();
                    fileContent = filePart.getInputStream();
                    byte[] targetArray = ByteStreams.toByteArray(fileContent);
                    avatar = blobToImg.writeBytesToFile(nickname, targetArray);
                }

                GregorianCalendar fecha = new GregorianCalendar();
                fecha.setTime(fechaNacimientoDate);
                XMLGregorianCalendar fechaParssed;
                fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fecha);
                if (pass == null || request.getParameter("confirmPassword").equals("")) {
                    System.out.println("no Cambio password");
                    dataSocio.setNombre(name);
                    dataSocio.setApellido(lastname);
                    dataSocio.setNickname(nickname);
                    dataSocio.setEmail(mail);
                    dataSocio.setNacimiento(fechaParssed);
                    if (avatar != null) {
                        dataSocio.setImage(avatar.toString());
                    }
                    publicador.editSocioInfo(userId, dataSocio, "");
                    System.out.println("llego 6");

                    response.sendRedirect("verPerfil");
                } else {
                    System.out.println("Cambio password");
                    // SI modifico password
                    String newPass = request.getParameter("confirmPassword");
                    System.out.println(newPass);

                    dataSocio.setNombre(name);
                    dataSocio.setApellido(lastname);
                    dataSocio.setNickname(nickname);
                    dataSocio.setEmail(mail);
                    dataSocio.setNacimiento(fechaParssed);
                    if (avatar != null) {
                        dataSocio.setImage(avatar.toString());
                    }
                    //dataSocio.setPassport
                    publicador.editSocioInfo(userId, dataSocio, newPass);

                    response.sendRedirect("verPerfil");
                }
                SocioDTO socio = publicador.consultarSocio(userId);
                session.setAttribute("currentSessionUser", socio);
            } catch (Exception e) {
                System.out.println("Aca12");
                System.out.println(e);
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
