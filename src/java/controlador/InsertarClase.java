/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Clase.ClaseBO;
import Clase.DtClase;
import Registro.DtRegistro;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            String urlAcceso = claseToInsert.getUrlAcceso();
            Date fechaRegistro = new Date();
            List<DtRegistro> registros = null;
            Integer idActividad = Integer.parseInt(claseToInsert.getIdActividad());
            Integer idInstitucion = null;

            ClaseBO claseBo = new ClaseBO();

            DtClase claseToInsertDt = new DtClase(0, claseNombre, fechaClase, profesorNombre, profesorId, capMinima, capMaxima, urlAcceso, fechaRegistro, registros, idActividad, null, idInstitucion, outputFile, data);
            claseBo.insertarClase(claseToInsertDt.getIdActividad(), claseToInsertDt);
            ResponseUtil respUtil = new ResponseUtil(true, "Clase insertada correctamente", claseToInsertDt);

            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
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
