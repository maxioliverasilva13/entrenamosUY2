/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.IActividadBO;
import Actividad.dtos.ActividadCreateDTO;
import Categoria.CategoriaBO;
import Categoria.DtCategoria;
import Categoria.ICategoriaBO;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Profesor.Profesor;
import Profesor.dtos.ProfesorDTO;
import Usuario.dtos.UsuarioDTO;
import com.google.gson.Gson;
import customsDtos.CreateActividadDTO;
import customsDtos.getCreateActividadDataDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import util.BlobToImage;

import util.JSONConverter;

/**
 *
 * @author rodrigo
 */
@MultipartConfig(maxFileSize = 160177215) 
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
        UsuarioDTO user = (UsuarioDTO)request.getSession().getAttribute("currentSessionUser");
        
        if(user == null){
            response.sendError(401);
            return;
        }
        
          
        ICategoriaBO catBo = new CategoriaBO();
        HashMap<Integer,DtCategoria> categorias = catBo.listarCategorias();
        
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
         boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        response.setContentType("text/html");
       Gson gson = new Gson();
       try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            float duracion =   Float.parseFloat(request.getParameter("duracion"));
            float costo =   Float.parseFloat(request.getParameter("costo"));
            String[] categoriasIdArrStr = request.getParameterValues("categoriasId");
             
           
            Part filePart = request.getPart("image");
            InputStream fileContent = null;
            File image = null;
            if(filePart != null){
                String fileName = filePart.getName();
                BlobToImage blobToImg = new BlobToImage();
                fileContent = filePart.getInputStream();
                byte[] targetArray = new byte[fileContent.available()];
                image = blobToImg.writeBytesToFile(fileName, targetArray);
            }else{
                System.out.println("No se envio imagen");
            }
            
           // int institucion_id,int profesor_id, float costo, String nombre, String descripcion, Date fecha_registro, int duracion, File file, List<DtCategoria> catsInThisActividad, String estado
            List<DtCategoria> categorias  = new ArrayList<DtCategoria>();
            for(int i=0; i< categoriasIdArrStr.length; i++){
                Integer categoriaID = Integer.parseInt(categoriasIdArrStr[i]);
                categorias.add(new DtCategoria(categoriaID,null));
            }
            int institucion_id = 2;
            int profesor_id = 2;
                    // public ActividadCreateDTO(int institucion_id,int profesor_id, float costo, String nombre, String descripcion, Date fecha_registro, int duracion, File file, List<DtCategoria> catsInThisActividad, String estado){
            ActividadCreateDTO act = new ActividadCreateDTO(institucion_id,profesor_id,costo,nombre,descripcion,new Date(),(int)duracion,image,categorias,"Ingresada");
            IActividadBO actBo = new ActividadBO();
           
           actBo.crear(act, institucion_id, profesor_id);
            
     
           
       }catch(Exception e){
           System.out.println(e.getMessage());
           response.sendError(500,e.getMessage());
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
