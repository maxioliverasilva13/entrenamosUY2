/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ws.ActividadDTO;
import ws.DtClase;
import ws.DtCuponera;
import ws.ProfesorDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "VerActividadInfo", urlPatterns = {"/verActividadInfo"})
public class VerActividadInfo extends HttpServlet {

    Boolean bool = new Boolean("true");

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

        String actID = request.getParameter("actId");
        String modalOpen = request.getParameter("modalOpen");
        String claseId = request.getParameter("claseId");
        String verInfoPagoOpen = request.getParameter("verInfoPago");
        String cupId = request.getParameter("cupId");
        HttpSession session = request.getSession(true);
        ProfesorDTO loggUser = null;
        if (session.getAttribute("currentSessionUser") != null && session.getAttribute("typeOfUser") != null) {
            if (session.getAttribute("typeOfUser").equals("Profesor")) {
                loggUser = (ProfesorDTO) session.getAttribute("currentSessionUser");
            }

        }

        try {
            if (claseId != null) {
                DtClase claseInfo = publicador.consultarClase(Integer.parseInt(claseId));
                request.setAttribute("selectedClaseInfo", claseInfo);
            }

            if (cupId != null) {
                DtCuponera cupinfo = publicador.consultarCuponera(Integer.parseInt(cupId));
                request.setAttribute("selectedCuponeraInfo", cupinfo);
            }

            if (actID == null || actID.equals("")) {
                response.sendRedirect("NotFound.jsp");
            } else {
                ActividadDTO actInfo = publicador.getActividadById(Integer.parseInt(actID));
                request.setAttribute("actInfo", actInfo);
                if (loggUser != null) {
                    ProfesorDTO profe = loggUser;
                    if (profe.getInstituciones().get(0).getId() == actInfo.getInstitucion().getId()) {
                        request.setAttribute("showAddClassButton", true);
                    }
                }

                if (modalOpen != null) {
                    request.setAttribute("modalIsOpen", modalOpen.equals("true") ? "true" : "false");
                }
                if (verInfoPagoOpen != null) {
                    UsuarioDTO userLogged = (UsuarioDTO) session.getAttribute("currentSessionUser");
                    request.setAttribute("infoPagoModal", verInfoPagoOpen.equals("true") ? "true" : "false");
                    HashMap<Integer, DtCuponera> cuponerasDisp = new HashMap();
                    publicador.listarCuponerasDisponiblesBySocio(userLogged.getID(), Integer.parseInt(actID)).forEach((DtCuponera cup) -> {
                        cuponerasDisp.put(cup.getId(), cup);
                    });

                    request.setAttribute("cuponerasDisp", cuponerasDisp);
                }
                request.getRequestDispatcher("/actividadInfo.jsp").forward(request, response);
            }
        } catch (Exception e) {
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
            out.println("<title>Servlet VerActividadInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerActividadInfo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
