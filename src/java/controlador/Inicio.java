/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.dtos.ActividadDTO;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Usuario.UsuarioBO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "Inicio", urlPatterns = {"/"})
public class Inicio extends HttpServlet {
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        InstitucionBO insBO = new InstitucionBO();
        ActividadBO actBO = new ActividadBO();        
        UsuarioBO userBO = new UsuarioBO();
        
        int cantidadUsuarios = userBO.listarUsuarios().size();
        
        
        // Aqui checkearemos si esta logueado , en caso de que si , lo enviaremos a el login
        request.setAttribute("Name", "Maxi");

        HashMap<Integer, DtInstitucion> instituciones = new HashMap<>();
        instituciones = insBO.listarInstituciones();
        
        HashMap<Integer, ActividadDTO> actividades = new HashMap<>();
        actividades = actBO.getActividadesWithLimitAndAccepted(9);
        
        request.setAttribute("cantidadUsuarios", cantidadUsuarios);
        request.setAttribute("instituciones", instituciones);
        request.setAttribute("actividades", actividades);
        request.setAttribute("totalActividades", actBO.getActividadesAceptadasSize());
        request.setAttribute("totalInstituciones", instituciones.size());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaginaInicio</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaginaInicio at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
