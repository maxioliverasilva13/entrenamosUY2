/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import controlador.utils.ClaseInsertDTO;
import controlador.utils.ResponseUtil;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import ws.DtClase;
import ws.DtRegistro;
import ws.Publicador;
import ws.Publicador_Service;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "InsertarClase", urlPatterns = {"/insertarClase"})
public class InsertarClase extends HttpServlet {

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
            out.println("<title>Servlet InsertarClase</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertarClase at " + request.getContextPath() + "</h1>");
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

        File outputFile = null;
        byte[] data = null;
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            ClaseInsertDTO claseToInsert = new Gson().fromJson(request.getReader(), ClaseInsertDTO.class);
            String crntImage = claseToInsert.getFileToSend();

            if (crntImage != null && crntImage != "") {

                data = Base64.getDecoder().decode(crntImage);

                try ( OutputStream stream = new FileOutputStream("temp.jpg")) {
                    stream.write(data);
                } catch (Exception e) {
                    System.err.println("Couldn't write to file...");
                }

                outputFile = new File("temp.jpg");
                try ( FileOutputStream outputStream = new FileOutputStream(outputFile)) {
                    outputStream.write(data);
                }
            }

            String claseNombre = claseToInsert.getNombre();
            Date fechaClase = new Date(claseToInsert.getFechaClase());
            String profesorNombre = claseToInsert.getProfesorNombre();
            Integer profesorId = Integer.parseInt(claseToInsert.getIdProfesor());
            Integer capMinima = Integer.parseInt(claseToInsert.getSociosMin());
            Integer capMaxima = Integer.parseInt(claseToInsert.getSociosMax());
            String linkVideo = claseToInsert.getVideoClase();
            String urlAcceso = claseToInsert.getUrlAcceso();
            Date fechaRegistro = new Date();
            List<DtRegistro> registros = null;
            Integer idActividad = Integer.parseInt(claseToInsert.getIdActividad());
            Integer cantidadSorteados = 0;
            if (claseToInsert.getCantidadSorteados() != null && !claseToInsert.getCantidadSorteados().equals("")) {
                cantidadSorteados = Integer.parseInt(claseToInsert.getCantidadSorteados());
            }

            String nombrePremio = claseToInsert.getNombrePremio();

            GregorianCalendar fechaClaseData = new GregorianCalendar();
            fechaClaseData.setTime(fechaClase);
            XMLGregorianCalendar fechaParssed;
            fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fechaClaseData);

            GregorianCalendar fechaHoy = new GregorianCalendar();
            fechaHoy.setTime(fechaRegistro);
            XMLGregorianCalendar fechaParssedRegistro;
            fechaParssedRegistro = DatatypeFactory.newInstance().newXMLGregorianCalendar(fechaHoy);

            DtClase claseToInsertDt = new DtClase();
            claseToInsertDt.setId(0);
            claseToInsertDt.setNombre(claseNombre);
            claseToInsertDt.setProfesor(profesorNombre);
            claseToInsertDt.setProfesorId(profesorId);
            claseToInsertDt.setCapMaxima(capMaxima);
            claseToInsertDt.setCapMinima(capMinima);
            claseToInsertDt.setUrlAcceso(urlAcceso);
            claseToInsertDt.setFecha(fechaParssed);
            claseToInsertDt.setFechaRegistro(fechaParssedRegistro);
            claseToInsertDt.setIdActividad(idActividad);
            if (outputFile != null) {
                claseToInsertDt.setImage(outputFile.toString());
            }
            claseToInsertDt.setLinkClase(linkVideo);
            claseToInsertDt.setImageBlob(data);
            if (nombrePremio == null || nombrePremio.equals("")) {
                publicador.insertarClase(claseToInsertDt.getIdActividad(), claseToInsertDt);
            } else {
                publicador.insertarClaseAndPremio(claseToInsertDt.getIdActividad(), claseToInsertDt, nombrePremio, cantidadSorteados);
            }
            ResponseUtil respUtil = new ResponseUtil(true, "Clase insertada correctamente", claseToInsertDt);

            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            System.out.println(e);
            ResponseUtil respUtil = new ResponseUtil(false, e.getMessage(), this);

            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
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
