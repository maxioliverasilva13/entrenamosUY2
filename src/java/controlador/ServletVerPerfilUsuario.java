/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.dtos.ActividadDTO;
import Cuponera.CuponeraBo;
import Cuponera.DtCuponera;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import Profesor.ProfesorBO;
import Profesor.dtos.ProfesorDTO;
import Socio.SocioBO;
import Socio.dtos.SocioDTO;
import Usuario.UsuarioBO;
import Usuario.dtos.UsuarioDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mandi
 */
@WebServlet(name = "VerPerfil", urlPatterns = "/verPerfil", initParams = {
    @WebInitParam(name = "usrId", value = "Not provided")})

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

        //request.setAttribute("usrId", getRequestParameter(request, "usrId"));
        
        // ANDANDO    int userAconsultar = Integer.parseInt(getRequestParameter(request, "usrId"));
        int userAconsultar = Integer.parseInt(request.getParameter("userID"));  //  A PRUEBA
        
        InstitucionBO insBO = new InstitucionBO();
        ActividadBO actBO = new ActividadBO();
        UsuarioBO userBO = new UsuarioBO();
        ProfesorBO profBO = new ProfesorBO();
        SocioBO socBO = new SocioBO();
        CuponeraBo cupBO = new CuponeraBo();

        HttpSession session = request.getSession(true);
        UsuarioDTO userInfoToShow = null; // Guarda la info del usuario a consultar. (trae el id del url que viene de los parametros del servlet)
        String userType;
        
        // Aqui ya se valida si el user no existe (dependiendo del id)
        try {
            userType = userBO.getTipoById(userAconsultar);
        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
            return;
        }
        
        if (userType.equals("Profesor")) {
            userInfoToShow = profBO.getProfesorById(userAconsultar); // USER_ID 52: Nicolas
        } else if (userType.equals("Socio")) {
            userInfoToShow = socBO.consultarSocio(userAconsultar);  // USER_ID 2: Manuel
        }
        
        UsuarioDTO loggedUser = (UsuarioDTO)session.getAttribute("currentSessionUser");
        request.setAttribute("idConsultado", userAconsultar); // Para usar luego en el POST.
        request.setAttribute("userDT", userInfoToShow);
        
        // Setteo atributo para saber si el loggUser actualmente sigue al usuario consultado.
        boolean loggSigueAconsultado = false;
        try {
            loggSigueAconsultado = userBO.consultarSigueUsuario(loggedUser.getId(), userAconsultar);
            request.setAttribute("sigoAlConsultado", loggSigueAconsultado);
        } catch (Exception e) {
            System.out.println("ERROR CATCHED: " + e.getMessage());
        }
        
        
        // Validar si es profesor o socio
        if (userInfoToShow instanceof ProfesorDTO) {

            ProfesorDTO dtProfesor = (ProfesorDTO) userInfoToShow;

            List<DtInstitucion> list = dtProfesor.getInstituciones();
            DtInstitucion dtIns = list.get(0);

            
            
            HashMap<Integer, ActividadDTO> listAct = new HashMap<>();
            
            try {
                listAct = actBO.listarActividadesByProfesor(userAconsultar);
            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }

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
            
            if (loggedUser != null){
                if (userAconsultar == loggedUser.getId()) {
                    // Es su propio perfil
                    System.out.println("si1");
                    request.getRequestDispatcher("Profesor/perfilProfesorPropio.jsp").forward(request, response);
                } else {
                    System.out.println("si2");
                    request.getRequestDispatcher("Profesor/perfilProfesorAjeno.jsp").forward(request, response);
                }
            }else{
                request.getRequestDispatcher("Profesor/perfilProfesorAjeno.jsp").forward(request, response);
            }
        }

        if (userInfoToShow instanceof SocioDTO) {
            SocioDTO dtSocio = (SocioDTO) userInfoToShow;

            HashMap<Integer, DtCuponera> listCuponeras = new HashMap<>();
            
            try {
                listCuponeras = cupBO.listarCuponerasBySocio(userAconsultar);
            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }
            
            request.setAttribute("cantSeguidores", dtSocio.getCantSeguidores());
            request.setAttribute("cantSeguidos", dtSocio.getCantSeguidos());

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtSocio.getNombre());
            request.setAttribute("apellido", dtSocio.getApellido());
            request.setAttribute("correo", dtSocio.getEmail());
            //request.setAttribute("institucion", dtIns.getNombre());
            request.setAttribute("fnacimiento", dtSocio.getNacimiento().toString());
            //  SOCIO NO TIENE WEBSITE ???  request.setAttribute("website", dtSocio.getLinkSitioWeb());
            //request.setAttribute("biografia", dtSocio.getBiografia());
            //request.setAttribute("descripcion", dtSocio.getdescripcionGeneral());
            //request.setAttribute("actividades", listAct);
            //request.setAttribute("clases", listClases);
            request.setAttribute("cuponeras", listCuponeras);

            request.getRequestDispatcher("verInfoSocioPerfil.jsp").forward(request, response);

        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            doGet(request, response);

            UsuarioBO userBO = new UsuarioBO();
            HttpSession session = request.getSession(true);
            UsuarioDTO loggedUser = (UsuarioDTO)session.getAttribute("currentSessionUser");
            
            int idConsultado = (int)request.getAttribute("idConsultado");
            boolean sigoAconsultado = (boolean)request.getAttribute("sigoAlConsultado");
            
            if (!sigoAconsultado){
                userBO.seguirAUsuario(loggedUser.getId(), idConsultado);
                request.setAttribute("sigoAlConsultado", true);
            }else{
                try {
                    userBO.dejarSeguirUsuario(loggedUser.getId(), idConsultado);
                    System.out.println("Ya lo seguias, lo has dejado de seguir!");
                    request.setAttribute("sigoAlConsultado", false);
                } catch (Exception e) {
                    System.out.println("Error:" + e.getMessage());
                }
            }
            
            //doGet(request, response);
        } catch (Exception e) {
            System.out.println("ERROOOR:" + e.getMessage());
            response.sendRedirect("NotFound.jsp");
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
