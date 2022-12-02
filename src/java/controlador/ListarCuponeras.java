/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import controlador.utils.ResponseUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ws.DtCuponera;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "ListarCuponeras", urlPatterns = {"/listarCuponeras"})
public class ListarCuponeras extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        String typeOfUser = (String) session.getAttribute("typeOfUser");
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        if (typeOfUser != null && typeOfUser.equals("Socio")) {
            SocioDTO userinfo = (SocioDTO) session.getAttribute("currentSessionUser");

            HashMap<Integer, DtCuponera> res = new HashMap<Integer, DtCuponera>();
            publicador.listarCuponerasBySocio(userinfo.getID()).forEach((DtCuponera cup) -> {
                res.put(cup.getId(), cup);
            });
            
            ResponseUtil respUtil = new ResponseUtil(false, "Datos obtenidos correctamente", res);

            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            ResponseUtil respUtil = new ResponseUtil(false, "Permisos insificientes", null);
            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
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
