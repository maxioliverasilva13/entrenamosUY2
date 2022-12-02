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
import java.util.List;
import ws.ActividadDTO;
import ws.DtInstitucion;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;

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

        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();
        List<UsuarioDTO> usuarios = publicador.listarUsuarios();

        int cantidadUsuarios = usuarios.size();

        HashMap<Integer, DtInstitucion> instituciones = new HashMap<>();
        publicador.listarInstituciones().forEach((DtInstitucion ins) -> {
            instituciones.put(ins.getId(), ins);
        });

        HashMap<Integer, ActividadDTO> actividades = new HashMap<>();
        publicador.getActividadesWithLimitAndAccepted(9).forEach((ActividadDTO act) -> {
            actividades.put(act.getId(), act);
        });

        request.setAttribute("cantidadUsuarios", cantidadUsuarios);
        request.setAttribute("instituciones", instituciones);
        request.setAttribute("actividades", actividades);
        request.setAttribute("totalActividades", publicador.getActividadesAceptadasSize());
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
