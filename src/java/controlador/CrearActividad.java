/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import customsDtos.getCreateActividadDataDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
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
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import spals.shaded.com.google.common.io.ByteStreams;
import util.BlobToImage;

import util.JSONConverter;
import ws.ActividadCreateDTO;
import ws.DtCategoria;
import ws.DtCategoriaArray;
import ws.ProfesorDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;

/**
 *
 * @author rodrigo
 */
@MultipartConfig(maxFileSize = 160177215)
@WebServlet(name = "CrearActividad", urlPatterns = {"/crearActividad"})
public class CrearActividad extends HttpServlet {

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
            out.println("<title>Servlet CrearActividad</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CrearActividad at " + request.getContextPath() + "</h1>");
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

        /*Âsumo que el usuario que le pega a este endpoint es un profesor */
        UsuarioDTO user = (UsuarioDTO) request.getSession().getAttribute("currentSessionUser");
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();
        if (user == null) {
            response.sendError(401);
            return;
        }

        HashMap<Integer, DtCategoria> categorias = new HashMap();
        publicador.listarCategorias().forEach((DtCategoria cat) -> {
            categorias.put(cat.getId(), cat);
        });

        getCreateActividadDataDTO data = new getCreateActividadDataDTO(categorias);

        PrintWriter pw = response.getWriter();
        String jsonData = JSONConverter.convert(data);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        pw.write(jsonData);

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
        Gson gson = new Gson();
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            HttpSession session = request.getSession(true);
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            float duracion = Float.parseFloat(request.getParameter("duracion"));
            float costo = Float.parseFloat(request.getParameter("costo"));
            String categoriasIdStr = request.getParameter("categoriasId");

            if (categoriasIdStr.contains(",")) {
                System.out.println("It does!");
            }
            String[] categoriasIdArrStr = categoriasIdStr.split(",");
            //System.out.println("splitted 1: " + categoriasIdArrStr[0]);
            //System.out.println("splitted 2: " + categoriasIdArrStr[1]);
            ProfesorDTO prof = (ProfesorDTO) session.getAttribute("currentSessionUser");

            Part filePart = request.getPart("image");
            InputStream fileContent = null;
            File image = null;
            if (filePart != null) {
                String fileName = filePart.getName();
                BlobToImage blobToImg = new BlobToImage();
                fileContent = filePart.getInputStream();
                byte[] targetArray = ByteStreams.toByteArray(fileContent);
                image = blobToImg.writeBytesToFile(fileName, targetArray);
            } else {
            }

            // int institucion_id,int profesor_id, float costo, String nombre, String descripcion, Date fecha_registro, int duracion, File file, List<DtCategoria> catsInThisActividad, String estado
            List<DtCategoria> categorias = new ArrayList<DtCategoria>();
            for (int i = 0; i < categoriasIdArrStr.length; i++) {
                Integer categoriaID = Integer.parseInt(categoriasIdArrStr[i]);
                DtCategoria cat = new DtCategoria();
                cat.setId(categoriaID);
                categorias.add(cat);
            }
            int institucion_id = prof.getInstituciones().get(0).getId();
            int profesor_id = prof.getID();
            // public ActividadCreateDTO(int institucion_id,int profesor_id, float costo, String nombre, String descripcion, Date fecha_registro, int duracion, File file, List<DtCategoria> catsInThisActividad, String estado){
            ActividadCreateDTO act = new ActividadCreateDTO();
            GregorianCalendar fecha = new GregorianCalendar();
            fecha.setTime(new Date());
            XMLGregorianCalendar fechaParssed;
            fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fecha);

            act.setEstado("Ingresada");
            act.setDuracion((int) duracion);
            act.setInstitucionId(institucion_id);
            act.setProfesorId(profesor_id);
            act.setCosto(costo);
            act.setNombre(nombre);
            act.setDescripcion(descripcion);
            act.setFechaRegistro(fechaParssed);
            act.setImage(image.toString());
            //act.setCategorias
            String categoriasString = new Gson().toJson(categorias);
            publicador.createWithCategorias(act, institucion_id, profesor_id, categoriasString);
        } catch (Exception a) {
            System.out.println(a);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST); // status 400, lo controlamos en el front para ver qué mensaje de error mostrar.
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
