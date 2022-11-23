/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.ActividadDao;
import Actividad.dtos.ActividadDTO;
import Clase.DtClase;
import Cuponera.CuponeraBo;
import Cuponera.DtCuponera;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import ParseDate.ParseDate;
import Premio.PremioBO;
import Premio.dtos.PremioDTO;
import Profesor.ProfesorBO;
import Profesor.dtos.ProfesorDTO;
import Registro.DtRegistro;
import Socio.SocioBO;
import Socio.dtos.SocioDTO;
import Usuario.UsuarioBO;
import Usuario.dtos.UsuarioDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mygym.logica.usuario.dataTypes.DtActividad;

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

        ParseDate parse = new ParseDate();

        HttpSession session = request.getSession(true);
        UsuarioDTO loggedUser = (UsuarioDTO) session.getAttribute("currentSessionUser");

        int userAconsultar = 0;

        // Si voy al url /verPerfil sin especificar ID, me lleva a MI perfil (logged)
        // TO DO: Validar si no está logueado, llevarlo a not found.
        if (request.getParameter("userID") == null) {
            if (loggedUser != null) {
                userAconsultar = loggedUser.getId();
            }
        } else {
            userAconsultar = Integer.parseInt(request.getParameter("userID"));  //  A PRUEBA
        }

        InstitucionBO insBO = new InstitucionBO();
        ActividadBO actBO = new ActividadBO();
        UsuarioBO userBO = new UsuarioBO();
        ProfesorBO profBO = new ProfesorBO();
        SocioBO socBO = new SocioBO();
        CuponeraBo cupBO = new CuponeraBo();

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

        request.setAttribute("idConsultado", userAconsultar); // Para usar luego en el POST.
        request.setAttribute("userDT", userInfoToShow);

        int seguidos = (int) userBO.getSeguidos(userAconsultar);
        int seguidores = (int) userBO.getSeguidores(userAconsultar);

        request.setAttribute("cantSeguidores", seguidores);
        request.setAttribute("cantSeguidos", seguidos);

        byte[] imageBlob = null;
        imageBlob = userInfoToShow.getBlobImage();

        if (imageBlob != null) {
            request.setAttribute("imagen", imageBlob);
        }

        // Setteo atributo para saber si el loggUser actualmente sigue al usuario consultado.
        boolean loggSigueAconsultado = false;
        try {
            if (loggedUser != null) {
                loggSigueAconsultado = userBO.consultarSigueUsuario(loggedUser.getId(), userAconsultar);
                request.setAttribute("sigoAlConsultado", loggSigueAconsultado);
            } else {
                request.setAttribute("userNotLogged", true);
            }

        } catch (Exception e) {
        }

        // Validar si es profesor o socio
        if (userInfoToShow instanceof ProfesorDTO) {

            ProfesorDTO dtProfesor = (ProfesorDTO) userInfoToShow;

            List<DtInstitucion> list = dtProfesor.getInstituciones();
            DtInstitucion dtIns = list.get(0);

            HashMap<Integer, ActividadDTO> listActPropio = new HashMap<>(); // Se listan en todos los estados.
            HashMap<Integer, ActividadDTO> listActAjeno = new HashMap<>(); // Se listan solo en estado aceptada.

            try {
                listActPropio = actBO.listarActividadesByProfesor(userAconsultar);

                List<ActividadDTO> actsProfeAjeno = dtProfesor.getActividades();
                actsProfeAjeno.forEach((item) -> {
                    listActAjeno.put(item.getId(), item);
                });

            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtProfesor.getNombre());
            request.setAttribute("apellido", dtProfesor.getApellido());
            request.setAttribute("correo", dtProfesor.getEmail());
            request.setAttribute("institucion", dtIns.getNombre());
            if (dtProfesor.getNacimiento() != null) {
                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                String date = DATE_FORMAT.format(dtProfesor.getNacimiento());
                request.setAttribute("fnacimiento", date);
            }
            request.setAttribute("website", dtProfesor.getLinkSitioWeb());
            request.setAttribute("biografia", dtProfesor.getBiografia());
            request.setAttribute("descripcion", dtProfesor.getdescripcionGeneral());

            // Validar si el perfil q va a consultar es el suyo o uno ajeno.
            if (loggedUser != null) {
                if (userAconsultar == loggedUser.getId()) {
                    // Es su propio perfil
                    request.setAttribute("actividades", listActPropio);
                    request.getRequestDispatcher("Profesor/perfilProfesorPropio.jsp").forward(request, response);
                } else {
                    // Es un perfil ajeno
                    request.setAttribute("actividades", listActAjeno);
                    request.getRequestDispatcher("Profesor/perfilProfesorAjeno.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("actividades", listActAjeno);
                request.getRequestDispatcher("Profesor/perfilProfesorAjeno.jsp").forward(request, response);
            }
        }

        if (userInfoToShow instanceof SocioDTO) {
            SocioDTO dtSocio = (SocioDTO) userInfoToShow;
            ActividadDao actDao = new ActividadDao();

            HashMap<Integer, DtCuponera> listCuponeras = new HashMap<>();
            try {
                listCuponeras = cupBO.listarCuponerasAdquiridasBySocio(userAconsultar);
            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }
            List<DtClase> listClasesOfUser = new ArrayList<>();
            PremioBO premBO = new PremioBO();
            List<PremioDTO> premioOfuser = premBO.premiosOfUser(dtSocio.getId());
            
            List<ActividadDTO> actividadesOfUser = new ArrayList<>();

            dtSocio.getRegistros().forEach((DtRegistro r) -> {
                listClasesOfUser.add(r.getClase());
                int idActividad = r.getClase().getIdActividad();
                if (idActividad != 0) {
                    Actividad.Actividad act = actDao.getById(idActividad);
                    if (act != null) {
                        ActividadDTO actToAdd = act.getDtActividad();
                        if (!actividadesOfUser.contains(actToAdd)) {
                            actividadesOfUser.add(act.getDtActividad());
                        }
                    }
                }

                // actividadesOfUser.add()
            });
            request.setAttribute("listClasesOfUser", listClasesOfUser);
            request.setAttribute("premioOfuser", premioOfuser);

            request.setAttribute("actividadesOfUser", actividadesOfUser);

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtSocio.getNombre());
            request.setAttribute("apellido", dtSocio.getApellido());
            request.setAttribute("correo", dtSocio.getEmail());
            request.setAttribute("nickname", dtSocio.getNickname());
            if (dtSocio.getNacimiento() != null) {
                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                String date = DATE_FORMAT.format(dtSocio.getNacimiento());
                request.setAttribute("fnacimiento", date);
            }
            request.setAttribute("cuponeras", listCuponeras);

            // Validar si el perfil q va a consultar es el suyo o uno ajeno.
            if (loggedUser != null) {
                if (userAconsultar == loggedUser.getId()) {
                    // Es su propio perfil
                    request.getRequestDispatcher("verInfoSocioPerfil.jsp").forward(request, response);
                } else {
                    // Es un perfil ajeno
                    request.getRequestDispatcher("Socio/perfilSocioAjeno.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("Socio/perfilSocioAjeno.jsp").forward(request, response);
            }

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
