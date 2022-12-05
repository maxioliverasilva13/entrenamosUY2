/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import ws.Publicador;
import ws.Publicador_Service;
import ws.UsuarioDTO;
import ws.ProfesorDTO;
import ws.SocioDTO;
import ws.UnauthorizedException_Exception;

/**
 *
 * @author rodrigo
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
        String email = (String) request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        if (email == null || password == null) {
            response.sendError(400, "Email o password invalida");
        }
        try {
            Publicador_Service pucService = new Publicador_Service();
            Publicador publicador = pucService.getPublicadorPort();

            UsuarioDTO user = publicador.login(email, password);
            String typeofUser = publicador.getTipoById(user.getID());
            System.out.println("Type of user is: ");
            System.out.println(typeofUser);
            HttpSession session = request.getSession(true);
            session.setAttribute("typeOfUser", typeofUser);
            if (typeofUser.equals("Profesor")) {
                if(request.getHeader("User-Agent").indexOf("Mobile") != -1){   
                    request.setAttribute("status", "Correo o Contraseña incorrectos");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                    return;  
                }
                ProfesorDTO profe = publicador.getProfesorById(user.getID());
                session.setAttribute("currentSessionUser", profe);
            } else if (typeofUser.equals("Socio")) {
                SocioDTO socio = publicador.consultarSocio(user.getID());
                session.setAttribute("currentSessionUser", socio);
            }

            if (remember != null) {
                session.setMaxInactiveInterval(999999999 * 600); // sesion "infinita" si el checkbox esta ON
            }
            session.setMaxInactiveInterval(120 * 60); // sesion de 2 horas si el checkbox esta OFF
            response.sendRedirect("Inicio");
        } catch (UnauthorizedException_Exception e) {
            request.setAttribute("status", "Correo o Contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(500, "Ha ocurrido un error inesperado");
            response.sendRedirect("login.jsp");
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
