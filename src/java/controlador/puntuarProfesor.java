/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Exceptions.RegistroNotFoundException;
import Exceptions.SocioNotFoundException;
import Profesor.IProfesorBO;
import Profesor.ProfesorBO;
import PuntuacionProfesor.IPuntuacionProfesorBO;
import PuntuacionProfesor.PuntuacionProfesor;
import PuntuacionProfesor.PuntuacionProfesorBO;
import Usuario.dtos.UsuarioDTO;
import com.google.gson.Gson;
import customsDtos.ResponseServer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mygym.logica.usuario.dataTypes.DtPuntuacionProfesor;

/**
 *
 * @author rodrigo
 */
public class puntuarProfesor extends HttpServlet {

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
            out.println("<title>Servlet puntuarProfesor</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet puntuarProfesor at " + request.getContextPath() + "</h1>");
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
        String puntuacion = request.getParameter("puntuacion");
        String registroId = request.getParameter("registroId");
        
        HttpSession session = request.getSession(true);	    
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("currentSessionUser");
        
        
        int socioID = user.getId();
        int puntuacionInt = Integer.parseInt(puntuacion);
        int registroIdInt = Integer.parseInt(registroId);
    
       
        Gson gson = new Gson();
        PrintWriter pw = response.getWriter();
        response.setContentType("application/json");
        
        
        String responseStr;
        ResponseServer res;
        try {
            IPuntuacionProfesorBO puntuacionProfBO = new PuntuacionProfesorBO();
            DtPuntuacionProfesor puntuacionProfes = puntuacionProfBO.create(puntuacionInt, socioID, registroIdInt);
            res = new ResponseServer(200,"Profesor valorado correctamente!");
            responseStr = gson.toJson(res);
            pw.print(responseStr);
        }catch(SocioNotFoundException e){
           res = new ResponseServer(400,"No existe el socio");
           responseStr = gson.toJson(res);
           pw.print(responseStr);
        }catch(RegistroNotFoundException e){
            res = new ResponseServer(400,"No existe un registro de clase en este socio");
            responseStr = gson.toJson(res);
            pw.print(responseStr);
        }catch(Exception e){
            System.out.println(e.getMessage());
            res = new ResponseServer(400,e.getMessage());
            responseStr = gson.toJson(res);
            pw.print(responseStr);
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
