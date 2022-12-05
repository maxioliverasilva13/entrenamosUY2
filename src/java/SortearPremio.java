/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Clase.ClaseBO;
import Clase.DtClase;
import Premio.PremioBO;
import Profesor.dtos.ProfesorDTO;
import Socio.dtos.SocioDTO;
import com.google.gson.Gson;
import customsDtos.ClaseInfoToReturn;
import customsDtos.ResponseServer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

        try {
            String idPremio = request.getParameter("premioId");
            if (idPremio != null) {
                PremioBO premioBO = new PremioBO();
                List<SocioDTO> ganadores = premioBO.realizarSorteo(Integer.valueOf(idPremio));
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
