/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Institucion.InterfaceInstitucionBO;
import Socio.dtos.SocioCreateDTO;
import Usuario.IUsuarioBO;
import Usuario.UsuarioBO;
import Usuario.dtos.UsuarioCreateDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author rodrigo
 */
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
        response.sendRedirect("signup.jsp");
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
        
        
        String tipoUsuario = request.getParameter("tipoUsuario");
        String  nickname = request.getParameter("nickname");
        String Nombre = request.getParameter("Nombre");
        String Apellido = request.getParameter("Apellido");
        String Email = request.getParameter("Email");
        String Contraseña = request.getParameter("Contraseña");
        String institucion = request.getParameter("Nombre");
        String description = request.getParameter("Nombre");
        String fechaNacimiento = request.getParameter("Nombre");
        Date fechaNacimientoDate;
        IUsuarioBO usuarioBo = new UsuarioBO();
        try{
            fechaNacimientoDate =new SimpleDateFormat("dd/MM/yyyy").parse(fechaNacimiento); 
            
        }catch(Exception e){
            response.sendError(500,"Ha ocurrido un error inesperado");
        }
       
        
        if(tipoUsuario.equals("Socio")){
         /* UsuarioCreateDTO userData = new SocioCreateDTO(
             Nombre,
             Nickname,
             Contraseña,
             email,
             fechaNacimiento,
             
                  
          );*/
        }else{ //es un profesor
              
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
