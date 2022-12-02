/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import controlador.utils.ResponseUtil;
import customsDtos.ComprarCuponeraInput;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;

/**
 *
 * @author angel
 */
@WebServlet(name = "ComprarCuponera", urlPatterns = {"/comprarCuponera"})
public class ComprarCuponera extends HttpServlet {

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
            out.println("<title>Servlet ComprarCuponera</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ComprarCuponera at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession(true);
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            SocioDTO socio = (SocioDTO) session.getAttribute("currentSessionUser");
            PrintWriter out = response.getWriter();

            ComprarCuponeraInput cuponerasProps = new Gson().fromJson(request.getReader(), ComprarCuponeraInput.class);

            cuponerasProps.getActividadesIds().forEach(((Integer actId) -> {
                try {
                    publicador.comprarCuponera(socio.getID(), cuponerasProps.getCuponeraId(), actId.intValue());
                } catch (Exception ex) {
                    System.out.println(ex);
                    ResponseUtil respUtil = new ResponseUtil(false, ex.getMessage(), this);
                    String claseJSON = new Gson().toJson(respUtil);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    out.print(claseJSON);
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }));

            ResponseUtil respUtil = new ResponseUtil(true, "Se compro la clase correctamente", this);

            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            System.out.println("Error");
            System.out.println("error2 " + e);
            ResponseUtil respUtil = new ResponseUtil(false, e.getMessage(), this);
            PrintWriter out = response.getWriter();
            String claseJSON = new Gson().toJson(respUtil);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);

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
