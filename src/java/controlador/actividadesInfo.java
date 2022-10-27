/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import Actividad.ActividadBO;
import Actividad.dtos.ActividadDTO;
import Categoria.CategoriaBO;
import Categoria.DtCategoria;
import Institucion.DtInstitucion;
import Institucion.InstitucionBO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Maximiliano Olivera
 */
@WebServlet(name = "actividadesInfo", urlPatterns = {"/actividadesInfo"})
public class actividadesInfo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InstitucionBO insBO = new InstitucionBO();
        CategoriaBO catBO = new CategoriaBO();
        ActividadBO actBO = new ActividadBO();

        String institucionID = (String) request.getParameter("instId");
        boolean hasFilteredCategories = request.getAttribute("filteredActividades") != null;
        
        try {
            HashMap<Integer, DtCategoria> categorias = catBO.listarCategorias();
            request.setAttribute("categorias", categorias);

            if (!hasFilteredCategories) {
                if (institucionID != null && institucionID != "") {
                    DtInstitucion ins = insBO.existeInstitucion(Integer.parseInt(institucionID));
                    if (ins == null) {
                        response.sendRedirect("NotFound.jsp");
                    } else {
                        request.setAttribute("institucionInfo", ins);
                        HashMap<Integer, ActividadDTO> actividades = actBO.listarActividades(ins.getId(), "Aceptada");
                        request.setAttribute("actividadesInstitucion", actividades);
                    }
                } else {
                    HashMap<Integer, DtInstitucion> instituciones = new HashMap<>();
                    instituciones = insBO.listarInstituciones();
                    request.setAttribute("instituciones", instituciones);
                }
            }
            request.getRequestDispatcher("/actividades.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ActividadBO actBO = new ActividadBO();

        try {
            String body = request.getReader().lines().collect(Collectors.joining());
            List<String> categoriasToFilter = new ArrayList<>();

            String[] items = body.split("&");

            for (String item : items) {
                String[] keyAndValue = item.split("=");
                if (!keyAndValue[0].equals("") && !keyAndValue[0].equals(null)) {
                    categoriasToFilter.add(keyAndValue[0]);
                }
            }

            HashMap<Integer, ActividadDTO> filteredActividades = actBO.listarActividadesByCategoria(categoriasToFilter, "Aceptada");
            request.setAttribute("filteredActividades", filteredActividades);
            if (categoriasToFilter.size() > 0) {
                request.setAttribute("listOfAppliedFilters", categoriasToFilter);
            }
            doGet(request, response);
        } catch (Exception e) {
            response.sendRedirect("NotFound.jsp");
        }
    }

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
            out.println("<title>Servlet ActividadesInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActividadesInfo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
