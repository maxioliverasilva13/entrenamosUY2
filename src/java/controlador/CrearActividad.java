/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Categoria.CategoriaBO;
import Categoria.DtCategoria;
import Categoria.ICategoriaBO;
import Institucion.DtInstitucion;
import Profesor.Profesor;
import Profesor.dtos.ProfesorDTO;
import Usuario.dtos.UsuarioDTO;
import customsDtos.getCreateActividadDataDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JSONConverter;

/**
 *
 * @author rodrigo
 */
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
        processRequest(request, response);
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
