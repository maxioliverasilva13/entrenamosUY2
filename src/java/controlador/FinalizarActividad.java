/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ws.Publicador;
import ws.Publicador_Service;

/**
 *
 * @author mandi
 */
@WebServlet(name = "FinalizarActividad", urlPatterns = {"/finalizarActividad"})
public class FinalizarActividad extends HttpServlet {

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
            out.println("<title>Servlet FinalizarActividad</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FinalizarActividad at " + request.getContextPath() + "</h1>");
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
        String actId = request.getParameter("actId");
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        if (actId != null) {
            try {
                System.out.println("Intentando finalizar...");
                publicador.cambiarEstadoActividad(Integer.parseInt(actId), "Finalizada");
                System.out.println("Actividad " + actId + " finalizada con exito!");
                request.setAttribute("exito", "true");
                response.setStatus(HttpServletResponse.SC_OK, "Actividad finalizada con exito!");
            } catch (Exception e) {
                System.out.println("Error al finalizar!");
                System.out.println(e.getMessage());
                response.sendError(400, "La actividad ya fue finalizada");
            }
//            DtClase claseInfo = claseBO.consultarClase(Integer.parseInt(claseId));
//            // request.setAttribute("selectedCuponeraInfo", cupinfo);
//            PrintWriter out = response.getWriter();
//            String claseJSON = new Gson().toJson(claseInfo);
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            out.print(claseJSON);
//            response.setStatus(HttpServletResponse.SC_OK);
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
