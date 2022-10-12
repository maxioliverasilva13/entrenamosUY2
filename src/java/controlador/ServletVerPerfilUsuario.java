/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.dtos.ActividadDTO;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Profesor.ProfesorBO;
import Profesor.dtos.ProfesorDTO;
import Socio.SocioBO;
import Socio.dtos.SocioDTO;
import Usuario.UsuarioBO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author mandi
 */


@WebServlet(name = "VerPerfil", urlPatterns = "/verPerfil", initParams={
@WebInitParam(name="usrId", value="Not provided")})

public class ServletVerPerfilUsuario extends HttpServlet {
    
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

        request.setAttribute("usrId", getRequestParameter(request, "usrId"));
        int userId = Integer.parseInt(getRequestParameter(request, "usrId"));
        
        InstitucionBO insBO = new InstitucionBO();
        ActividadBO actBO = new ActividadBO();        
        UsuarioBO userBO = new UsuarioBO();
        ProfesorBO profBO = new ProfesorBO();
        SocioBO socBO = new SocioBO();
        
        String userType = "";
        
        // Aqui ya se valida si el user no existe (dependiendo del id)
        try {
            userType = userBO.getTipoById(userId);
        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
            return;
        }

        Object loggedUser = null;
        if (userType.equals("Profesor")){
            loggedUser = profBO.getProfesorById(userId); // USER_ID 52: Nicolas
        }else if (userType.equals("Socio")){
            loggedUser = socBO.consultarSocio(userId);  // USER_ID 2: Manuel
        }
        
        // Validar si es profesor o socio
        if (loggedUser instanceof ProfesorDTO){
            
                ProfesorDTO dtProfesor = (ProfesorDTO) loggedUser;

                List<DtInstitucion> list = dtProfesor.getInstituciones();
                DtInstitucion dtIns = list.get(0);

                List<ActividadDTO> listAct = dtProfesor.getActividades();

                request.setAttribute("cantSeguidores", dtProfesor.getCantSeguidores());
                request.setAttribute("cantSeguidos", dtProfesor.getCantSeguidos());

                request.setAttribute("userType", "Profesor");
                request.setAttribute("nombre", dtProfesor.getNombre());
                request.setAttribute("apellido", dtProfesor.getApellido());
                request.setAttribute("correo", dtProfesor.getEmail());
                request.setAttribute("institucion", dtIns.getNombre());
                request.setAttribute("fnacimiento", dtProfesor.getNacimiento().toString());
                request.setAttribute("website", dtProfesor.getLinkSitioWeb());
                request.setAttribute("biografia", dtProfesor.getBiografia());
                request.setAttribute("descripcion", dtProfesor.getdescripcionGeneral());
                request.setAttribute("actividades", listAct);
                
                // Validar si el perfil q va a consultar es el suyo o uno ajeno.
                if (userId == ((ProfesorDTO) loggedUser).getId()){
                    // Es su propio perfil
                    request.getRequestDispatcher("Profesor/perfilProfesorPropio.jsp").forward(request, response);
                }else{
                    request.getRequestDispatcher("Profesor/perfilProfesorAjeno.jsp").forward(request, response);
                }
        }
        
        if (loggedUser instanceof SocioDTO){
            SocioDTO dtSocio = (SocioDTO) loggedUser;
            
            int cantSeguidores = dtSocio.getCantSeguidores();
            int cantSeguidos = dtSocio.getCantSeguidos();
            String tipoUsuario = "Socio";

            //List<ActividadDTO> listAct = dtSocio.getActividades();
            
            request.setAttribute("cantSeguidores", dtSocio.getCantSeguidores());
            request.setAttribute("cantSeguidos", dtSocio.getCantSeguidos());

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtSocio.getNombre());
            request.setAttribute("apellido", dtSocio.getApellido());
            request.setAttribute("correo", dtSocio.getEmail());
            //request.setAttribute("institucion", dtIns.getNombre());
            request.setAttribute("fnacimiento", dtSocio.getNacimiento().toString());
            //request.setAttribute("website", dtSocio.getLinkSitioWeb());
            //request.setAttribute("biografia", dtSocio.getBiografia());
            //request.setAttribute("descripcion", dtSocio.getdescripcionGeneral());
            //request.setAttribute("actividades", listAct);
            
            
            
            
            
            
            
            
            request.getRequestDispatcher("verInfoSocioPerfil.jsp").forward(request, response);

        }
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
    
    protected void forwardRequest(
      HttpServletRequest request, 
      HttpServletResponse response, 
      String path)
      throws ServletException, IOException { 
        request.getRequestDispatcher(path).forward(request, response); 
    }
    
    
    protected String getRequestParameter(HttpServletRequest request, String name) {
        String param = request.getParameter(name);
        return !param.isEmpty() ? param : getInitParameter(name);
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
