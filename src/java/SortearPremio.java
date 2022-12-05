/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.google.gson.Gson;
import customsDtos.ResponseServer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ws.Publicador;
import ws.Publicador_Service;
import ws.SocioDTO;

/**
 *
 * @author maximilianoolivera
 */
@WebServlet(urlPatterns = {"/sortearPremio"})
public class SortearPremio extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        try {
            String idPremio = request.getParameter("premioId");
            if (idPremio != null) {
                List<SocioDTO> ganadores = new ArrayList<>();
                publicador.realizarSorteo(Integer.valueOf(idPremio)).forEach((SocioDTO socio) -> {
                    ganadores.add(socio);
                });
                ResponseServer reponseServer = new ResponseServer(200, "La clase se sorteo correctamente", ganadores);
                String claseJSON = new Gson().toJson(reponseServer);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                out.print(claseJSON);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                ResponseServer reponseServer = new ResponseServer(404, "La clase que intentas sortear no es valida");
                String claseJSON = new Gson().toJson(reponseServer);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                out.print(claseJSON);
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            }
        } catch (Exception e) {
            ResponseServer reponseServer = new ResponseServer(500, e.getMessage());
            String claseJSON = new Gson().toJson(reponseServer);
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
