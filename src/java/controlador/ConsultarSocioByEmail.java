/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Clase.ClaseBO;
import Clase.DtClase;
import Profesor.dtos.ProfesorDTO;
import Registro.DtRegistro;
import Socio.dtos.SocioDTO;
import Usuario.Usuario;
import Usuario.UsuarioDAO;
import com.google.gson.Gson;
import customsDtos.ClaseInfoToReturn;
import customsDtos.ResponseServer;
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

/**
 *
 * @author maximilianoolivera
 */
@WebServlet(name = "ConsultarSocioByEmail", urlPatterns = {"/consultarSocioByEmail"})
public class ConsultarSocioByEmail extends HttpServlet {

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
            out.println("<title>Servlet ConsultarSocioByEmail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConsultarSocioByEmail at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        String emailUser = request.getParameter("email");
        UsuarioDAO userDao = new UsuarioDAO();
        Usuario userInfoByEmail = userDao.getByEmail(emailUser);
        Boolean alreadyExists = userInfoByEmail != null;
        if (emailUser != null) {
            response.setStatus(200);
            ResponseServer resp = new ResponseServer(200, "todo ok", alreadyExists);
            String claseJSON = new Gson().toJson(resp);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(claseJSON);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(404);
            ResponseServer resp = new ResponseServer(404, "No se provee un email correcto", alreadyExists);
            String claseJSON = new Gson().toJson(resp);
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
