/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.FollowData;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;

/**
 *
 * @author mandi
 */
@WebServlet(name = "SeguirUsuario", urlPatterns = {"/SeguirUsuario"})
public class SeguirUsuario extends HttpServlet {

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
            out.println("<title>Servlet SeguirUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SeguirUsuario at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession(true);

        int usrIDConsultado = Integer.parseInt(request.getParameter("idConsultado"));
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            PrintWriter out = response.getWriter();
            int seguidores = publicador.getSeguidoresByUser(usrIDConsultado);
            int seguidos = publicador.getSeguidosByUser(usrIDConsultado);
            FollowData fd = new FollowData(seguidores, seguidos);
            String JSONdata = new Gson().toJson(fd);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(JSONdata);
            response.setStatus(HttpServletResponse.SC_OK);
//            request.setAttribute("sigoAlConsultado", loggSigueAconsultado);
        } catch (Exception e) {
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
        //doGet(request, response);
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            HttpSession session = request.getSession(true);
            UsuarioDTO loggedUser = (UsuarioDTO) session.getAttribute("currentSessionUser");

            int idConsultado = Integer.parseInt(request.getParameter("idConsultado"));

            boolean loggSigueAconsultado = publicador.consultarSigueUsuario(loggedUser.getID(), idConsultado);

            if (!loggSigueAconsultado) {
                publicador.seguirUsuario(loggedUser.getID(), idConsultado);
                System.out.println("LLEGO 1");
            } else {
                try {
                    publicador.dejarSeguirUsuario(loggedUser.getID(), idConsultado);
                    System.out.println("LLEGO 2");
                } catch (Exception e) {
                }
            }
            response.sendRedirect("verPerfil?&userID=" + idConsultado);

        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
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
