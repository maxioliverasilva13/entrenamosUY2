/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.File;
import java.io.FileInputStream;
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
 * @author maximilianoolivera
 */
@WebServlet(name = "ImprimirComprobantePremio", urlPatterns = {"/imprimirComprobantePremio"})
public class ImprimirComprobantePremio extends HttpServlet {

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
            out.println("<title>Servlet ImprimirComprobantePremio</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImprimirComprobantePremio at " + request.getContextPath() + "</h1>");
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
    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        String premioId = request.getParameter("premioId");
        String userId = request.getParameter("userID");

        Publicador_Service pucService = new Publicador_Service();
        Publicador publicador = pucService.getPublicadorPort();

        if (userId != null && premioId != null) {
            File pdfComprobante = new File(publicador.imprimirPremio(Integer.parseInt(premioId), Integer.parseInt(userId)));
            // Get PrintWriter object
            PrintWriter out = response.getWriter();

            // Set the content type and header of the response.
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",
                    "attachment; filename=\""
                    + pdfComprobante + "\"");

            // Get FileInputStream object to identify the path
            FileInputStream inputStream
                    = new FileInputStream(pdfComprobante);

            // Loop through the document and write into the
            // output.
            int in;
            while ((in = inputStream.read()) != -1) {
                out.write(in);
            }

            // Close FileInputStream and PrintWriter object
            inputStream.close();
            out.close();
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
