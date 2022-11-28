<%-- 
    Document   : verActividades
    Created on : 26/09/2022, 09:46:00 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="Socio.dtos.SocioDTO"%>
<%@page import="javafx.beans.property.SimpleBooleanProperty"%>
<%@page import="util.BlobToImage"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%
    HashMap<Integer, ActividadDTO> actividades = new HashMap<Integer, ActividadDTO>();
    BlobToImage btimg = new BlobToImage();
    if (request.getAttribute("actividadesInstitucion") != null) {
        actividades = (HashMap<Integer, ActividadDTO>) request.getAttribute("actividadesInstitucion");
    }
    HashMap<Integer, ActividadDTO> filteredActividades = new HashMap<Integer, ActividadDTO>();
    if (request.getAttribute("filteredActividades") != null) {
        filteredActividades = (HashMap<Integer, ActividadDTO>) request.getAttribute("filteredActividades");
    }

    HashMap<Integer, ActividadDTO> actividadesToShow = filteredActividades.size() == 0 ? actividades : filteredActividades;
%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .error{
                color: red;
                font-style: italic;
            }
        </style>
    </head>

    <%        if (actividadesToShow.size() == 0) {
    %>
    <div class="w-full h-full flex-grow flex items-center flex-col justify-center gap-y-2">
        <img src=" https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
        <p class="text-gray-800 font-medium text-base">No encontramos ningun resultado!</p>
    </div>
    <%
    } else {
    %> 
    <div class="w-full flex-grow h-full grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 auto-rows-max min-h-[400px]">
        <% for (HashMap.Entry<Integer, ActividadDTO> en : actividadesToShow.entrySet()) {
                Integer key = en.getKey();
                ActividadDTO val = en.getValue();

                SimpleBooleanProperty isFavoriteOfUser = new SimpleBooleanProperty(false);
                if (session.getAttribute("currentSessionUser") != null && session.getAttribute("typeOfUser").equals("Socio")) {
                    SocioDTO socio = (SocioDTO) session.getAttribute("currentSessionUser");
                    val.getFavoritos().forEach((
                              
                        favorito) -> {
                    if (favorito.getActid() == key && favorito.getUserId() == socio.getId()) {
                            isFavoriteOfUser.set(true);
                        }
                    });
                }
        %>
        <jsp:include page='/components/cardActividad.jsp' >
            <jsp:param name="nombre" value="<%=val.getNombre()%>" />
            <jsp:param name="image" value="<%=btimg.getBase64StringImage(val.getImageBlob())%>" />
            <jsp:param name="descripcion" value="<%=val.getDescripcion()%>" />
            <jsp:param name="actID" value="<%=val.getId()%>" />
            <jsp:param name="isFavorita" value="<%=isFavoriteOfUser.get()%>" />
            <jsp:param name="cantFavs" value="<%=val.getCantFavoritos()%>" />
        </jsp:include>
        <%
            }
        %>
    </div>

    <%
        }
    %>
</html>
