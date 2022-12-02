/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import controlador.utils.ParseDate;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ws.ActividadDTO;
import ws.DtCuponera;
import ws.DtInstitucion;
import ws.DtRegistro;
import ws.PremioDTO;
import ws.ProfesorDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;
import ws.UsuarioDTO;

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
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        ParseDate parse = new ParseDate();

        HttpSession session = request.getSession(true);
        UsuarioDTO loggedUser = (UsuarioDTO) session.getAttribute("currentSessionUser");

        int userAconsultar = 0;

        // Si voy al url /verPerfil sin especificar ID, me lleva a MI perfil (logged)
        // TO DO: Validar si no está logueado, llevarlo a not found.
        if (request.getParameter("userID") == null) {
            if (loggedUser != null) {
                userAconsultar = loggedUser.getID();
            }
        } else {
            userAconsultar = Integer.parseInt(request.getParameter("userID"));  //  A PRUEBA
        }

        UsuarioDTO userInfoToShow = null; // Guarda la info del usuario a consultar. (trae el id del url que viene de los parametros del servlet)
        String userType;

        // Aqui ya se valida si el user no existe (dependiendo del id)
        try {
            userType = publicador.getTipoById(userAconsultar);
        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
            return;
        }

        if (userType.equals("Profesor")) {
            userInfoToShow = publicador.getProfesorById(userAconsultar); // USER_ID 52: Nicolas
        } else if (userType.equals("Socio")) {
            userInfoToShow = publicador.consultarSocio(userAconsultar);  // USER_ID 2: Manuel
        }

        request.setAttribute("idConsultado", userAconsultar); // Para usar luego en el POST.
        request.setAttribute("userDT", userInfoToShow);

        int seguidos = (int) publicador.getSeguidosByUser(userAconsultar);
        int seguidores = (int) publicador.getSeguidoresByUser(userAconsultar);

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
                loggSigueAconsultado = publicador.consultarSigueUsuario(loggedUser.getID(), userAconsultar);
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
                publicador.listarActividadesByProfesor(userAconsultar).forEach((ActividadDTO act) -> {
                    listActPropio.put(act.getId(), act);
                });

                List<ActividadDTO> actsProfeAjeno = dtProfesor.getActividades();
                actsProfeAjeno.forEach((item) -> {
                    listActAjeno.put(item.getId(), item);
                });

            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtProfesor.getNOMBRE());
            request.setAttribute("apellido", dtProfesor.getAPELLIDO());
            request.setAttribute("correo", dtProfesor.getEMAIL());
            request.setAttribute("institucion", dtIns.getNombre());
            if (dtProfesor.getNACIMIENTO() != null) {
                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                String date = DATE_FORMAT.format(dtProfesor.getNACIMIENTO().toGregorianCalendar().getTime());
                request.setAttribute("fnacimiento", date);
            }
            request.setAttribute("website", dtProfesor.getLinkSitioWeb());
            request.setAttribute("biografia", dtProfesor.getBiografia());
            request.setAttribute("descripcion", dtProfesor.getDescripcionGeneral());

            // Validar si el perfil q va a consultar es el suyo o uno ajeno.
            if (loggedUser != null) {
                if (userAconsultar == loggedUser.getID()) {
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

            HashMap<Integer, DtCuponera> listCuponeras = new HashMap<>();
            try {
                publicador.listarCuponerasAdquiridasBySocio(userAconsultar).forEach((DtCuponera cup) -> {
                    listCuponeras.put(cup.getId(), cup);
                });
            } catch (Exception e) {
                response.sendRedirect("NotFound.jsp");
                return;
            }
            List<DtRegistro> listRegistrosOfUser = new ArrayList<>();
            List<ActividadDTO> actividadesOfUser = new ArrayList<>();
            List<PremioDTO> premioOfuser = publicador.premiosOfUser(dtSocio.getID());

            dtSocio.getRegistros().forEach((DtRegistro r) -> {
                listRegistrosOfUser.add(r);
                int idActividad = r.getClase().getIdActividad();
                if (idActividad != 0) {
                    ActividadDTO actToAdd = publicador.getActividadById(idActividad);
                    if (actToAdd != null) {
                        if (!actividadesOfUser.contains(actToAdd)) {
                            actividadesOfUser.add(actToAdd);
                        }
                    }
                }

                // actividadesOfUser.add()
            });
            request.setAttribute("premioOfuser", premioOfuser);

            request.setAttribute("listRegistrosOfUser", listRegistrosOfUser);
            request.setAttribute("actividadesOfUser", actividadesOfUser);

            request.setAttribute("userType", "Profesor");
            request.setAttribute("nombre", dtSocio.getNOMBRE());
            request.setAttribute("apellido", dtSocio.getAPELLIDO());
            request.setAttribute("correo", dtSocio.getEMAIL());
            request.setAttribute("nickname", dtSocio.getNICKNAME());
            if (dtSocio.getNACIMIENTO() != null) {
                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                String date = DATE_FORMAT.format(dtSocio.getNACIMIENTO().toGregorianCalendar().getTime());
                request.setAttribute("fnacimiento", date);
            }
            request.setAttribute("cuponeras", listCuponeras);

            // Validar si el perfil q va a consultar es el suyo o uno ajeno.
            if (loggedUser != null) {
                if (userAconsultar == loggedUser.getID()) {
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
