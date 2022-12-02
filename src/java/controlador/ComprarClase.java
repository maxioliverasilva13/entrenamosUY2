/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.Gson;
import customsDtos.ResponseServer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import ws.DtRegistro;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;

/**
 *
 * @author rodrigo
 */
public class ComprarClase extends HttpServlet {

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
            out.println("<title>Servlet ComprarClase</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ComprarClase at " + request.getContextPath() + "</h1>");
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
        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        String claseIdStr = request.getParameter("claseId");
        String precioFinalStr = request.getParameter("precioFinal");
        String cuponeraIdStr = request.getParameter("choosedCupID");
        HttpSession session = request.getSession(true);
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("currentSessionUser");

        if (claseIdStr == null || precioFinalStr == null) {
            response.sendError(400, "Datos invalidos");
            return;
        }
        int socioID = user.getID();

        float precioFinalFlt = Float.parseFloat(precioFinalStr);
        int claseId = Integer.parseInt(claseIdStr);

        List<Integer> clases = new ArrayList<Integer>();
        clases.add(claseId);

        DtRegistro registro = new DtRegistro();
        registro.setCosto(precioFinalFlt);
        GregorianCalendar fecha = new GregorianCalendar();
        fecha.setTime(new Date());
        XMLGregorianCalendar fechaParssed;
        System.out.println("llego 12");
        try {
            fechaParssed = DatatypeFactory.newInstance().newXMLGregorianCalendar(fecha);

            registro.setFecha(fechaParssed);
            registro.setSocioName(user.getNICKNAME());

            Integer cuponeraID = null;
            if (!cuponeraIdStr.equals("") && !(cuponeraIdStr == null)) {
                cuponeraID = Integer.parseInt(cuponeraIdStr);
            }

            Gson gson = new Gson();
            ResponseServer res;
            PrintWriter pw = response.getWriter();
            response.setContentType("application/json");
            String responseStr;
            try {
                if (cuponeraID != null) {
                    publicador.agregarRegistro(socioID, claseId, registro, cuponeraID);
                } else {
                    publicador.agregarRegistroSinCuponera(socioID, claseId, registro);
                }
                res = new ResponseServer(200, "Has comprado la clase correctamente!");
                responseStr = gson.toJson(res);
                pw.print(responseStr);
            } catch (Exception e) {
                System.out.println(e);
                res = new ResponseServer(500, e.getMessage());
                responseStr = gson.toJson(res);
                pw.print(responseStr);
            }

        } catch (DatatypeConfigurationException ex) {
            System.out.println("error aca");
            System.out.println(ex);
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
