<%-- 
    Document   : index.jsp
    Created on : 15/09/2022, 09:16:14 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="Usuario.dtos.UsuarioDTO"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="Institucion.DtInstitucion"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include> 
<%@ page import="util.BlobToImage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
    HashMap<Integer, DtInstitucion> instituciones = new HashMap<Integer, DtInstitucion>();
    HashMap<Integer, ActividadDTO> actividades = new HashMap<Integer, ActividadDTO>();
    int cantidadUsuarios = (int) request.getAttribute("cantidadUsuarios");
    int totalActividades = (int) request.getAttribute("totalActividades");
    int totalInstituciones = (int) request.getAttribute("totalInstituciones");
    BlobToImage btimg = new BlobToImage();
    
    
    UsuarioDTO loggedUser = null;
    loggedUser = (UsuarioDTO)session.getAttribute("currentSessionUser");
    
    // Id del user q quiero consultar
    int usrId = 4;
    
    try {
        instituciones = (HashMap<Integer, DtInstitucion>) request.getAttribute("instituciones");
        actividades = (HashMap<Integer, ActividadDTO>) request.getAttribute("actividades");
    } catch (Exception e) {
        System.out.println("Error");
    }
    String nameOfUser = "Usuario";
    UsuarioDTO userInfo = (UsuarioDTO)session.getAttribute("currentSessionUser");
    if (userInfo != null) {
        nameOfUser = userInfo.getNombre() + " " + userInfo.getApellido();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Inicio</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body class="w-screen h-screen flex items-start flex-col justify-start ">


        <a href="verPerfil?&userID=<%=usrId %>"> Ver Perfil</a>
        <div class="w-full h-full lg:flex-row  flex-col flex-grow px-8 py-6 max-h-full overflow-auto flex items-center justify-between gap-x-8">
            <aside class="lg:w-96 w-full lg:h-full h-auto min-h-[300px] border max-h-full overflow-auto lg:mb-0 mb-4 border-gray-300 rounded rounded-3xl bg-white shadow-md flex flex-col items-start justify-start">
                <span class="w-full h-auto px-4 py-2 bg-[#DEDEDE] text-[#6B7280] text-left">Instituciones</span>
                <ul class="w-full h-auto flex flex-col items-start justify-start">
                    <%-- ForEach Instituciones --%>
                    <% for (HashMap.Entry<Integer, DtInstitucion> en : instituciones.entrySet()) {
                            Integer key = en.getKey();
                            DtInstitucion val = en.getValue();

                    %>
                    <div class="w-full h-auto px-4 py-4 border-b border-gray-300 flex flex-col gap-y-2">
                        <div class="w-full h-auto flex flex-row items-center justify-start gap-x-2">
                            <img class="w-8 h-8 rounded-full" src="<%=btimg.getBase64StringImage(val.getImageBlob())%>" />
                            <p class="text-[#111827] text-base font-medium text-left w-full truncate max-w-full"> <%=val.getNombre()%> </p>
                        </div>
                        <p class="text-[#6B7280] text-sm font-normal max-w-full text-left truncate">  <%=val.getDescripcion()%> </p>
                    </div>
                    <%
                        }
                    %>

                </ul>
            </aside>

            <main class="flex-grow w-full h-full flex flex-col items-start justify-start gap-y-1">
                <div class="w-full h-auto p-2 bg-blue-50 flex flex-col items-start justify-start gap-y-1.5 rounded-md ">
                    <p class="text-[#0F225E] text-xl font-semibold">Buenas tardes <%=nameOfUser %>, esperamos que estes teniendo un buen dia! </p>
                    <p class="text-[#1E40AF] text-xl font-medium">Tenemos un monton de actividades y clases para ti !</p>
                </div>
                <p class="text-[#3A5A6E] font-medium lg:my-0 my-3 text-xl">Algunas Estadisticas Que Podrian Interesarte</p>
                <%-- Estadisticas Div Principal --%>
                <div class="w-full lg:h-28 h-auto flex lg:flex-row flex-col items-center justify-between gap-x-6 mt-1">
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Usuarios</p>
                            <p class="font-semibold text-[#4C837A] text-3xl"><%=cantidadUsuarios%></p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#4C837A] rounded-md p-3">
                            <i class="fa-solid fa-users text-white text-2xl"></i>
                        </div>
                    </div>
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Instituciones</p>
                            <p class="font-semibold text-[#3A5A6E] text-3xl"><%=totalInstituciones%></p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#3A5A6E] rounded-md p-3">
                            <i class="fa-solid fa-house text-white text-2xl"></i>
                        </div>
                    </div>
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Actividades</p>
                            <p class="font-semibold text-[#E5E2C9] text-3xl"><%=totalActividades%></p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#E5E2C9] rounded-md p-3">
                            <i class="fa-solid fa-basketball text-[#5E5E5E] text-3xl"></i>
                        </div>
                    </div>
                </div>
                <p class="text-[#3A5A6E my-2 font-medium text-2xl">Aqui tienes algunas actividades, para acceder a ellas debes iniciar seison</p>

                <%-- Recorrer actividades --%>

                <div class="w-full flex-grow h-full grid grid-cols-2 min-h-[450px] py-2 lg:grid-cols-4 md:grid-cols-3 gap-4 auto-rows-max max-h-full overflow-auto">
                    <% for (HashMap.Entry<Integer, ActividadDTO> en : actividades.entrySet()) {
                            Integer key = en.getKey();
                            ActividadDTO val = en.getValue();

                    %>
                    <jsp:include page='/components/cardActividad.jsp' >
                        <jsp:param name="nombre" value="<%=val.getNombre()%>" />
                        <jsp:param name="image" value="<%=btimg.getBase64StringImage(val.getImageBlob())%>" />
                        <jsp:param name="descripcion" value="<%=val.getDescripcion()%>" />
                        <jsp:param name="actID" value="<%=val.getId()%>" />
                    </jsp:include>
                    <%
                        }
                    %>
                </div>
            </main>
        </div>
    </body>
</html>
