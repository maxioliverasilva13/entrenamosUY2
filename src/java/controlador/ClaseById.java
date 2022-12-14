/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import customsDtos.ClaseInfoToReturn;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ws.DtClase;
import ws.DtRegistro;
import ws.ProfesorDTO;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "ClaseById", urlPatterns = {"/claseById"})
public class ClaseById extends HttpServlet {

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
            out.println("<title>Servlet ClaseById</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClaseById at " + request.getContextPath() + "</h1>");
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
        String claseId = request.getParameter("claseId");
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();
        
        
        if (claseId != null) {
            request.setAttribute("", this);
            DtClase claseInfo = publicador.consultarClase(Integer.parseInt(claseId));
            // request.setAttribute("selectedCuponeraInfo", cupinfo);
            PrintWriter out = response.getWriter();
            boolean isProfesorDeClaseAndYaPaso = false;
            boolean verResultados = false;
            HttpSession session = request.getSession(true);
            List<SocioDTO> resultados = new ArrayList<>();
            String typeofUser = (String) session.getAttribute("typeOfUser");
            if (typeofUser != null && typeofUser.equals("Profesor")) {
                ProfesorDTO profe = (ProfesorDTO) session.getAttribute("currentSessionUser");
                if (claseInfo.getProfesorId() == profe.getID()) {
                    if (claseInfo.getPremio() != null) {
                        if (claseInfo.getPremio().getRegistros().size() > 0) {
                            verResultados = true;
                            claseInfo.getPremio().getRegistros().forEach((DtRegistro reg) -> {
                                resultados.add(reg.getSocio());
                            });
                        } else {
                            Date now = new Date();
                            Date currentFecha = claseInfo.getFecha().toGregorianCalendar().getTime();
                            if (currentFecha.before(now) && claseInfo.getPremio() != null) {
                                if (claseInfo.getPremio().isFueSorteado() == false) {
                                    isProfesorDeClaseAndYaPaso = true;
                                }
                            }
                        }

                    }

                }
            }
            ClaseInfoToReturn claseToReturn = new ClaseInfoToReturn(claseInfo, isProfesorDeClaseAndYaPaso, verResultados, resultados);
            String claseJSON = new Gson().toJson(claseToReturn);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
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
