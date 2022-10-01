<%-- 
    Document   : index.jsp
    Created on : 15/09/2022, 09:16:14 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="Institucion.DtInstitucion"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% 
    HashMap<Integer, DtInstitucion> instituciones = new HashMap<Integer, DtInstitucion>();
    HashMap<Integer, ActividadDTO> actividades = new HashMap<Integer, ActividadDTO>();
    
    try {
       instituciones = (HashMap<Integer, DtInstitucion>)request.getAttribute("instituciones");
       actividades = (HashMap<Integer, ActividadDTO>)request.getAttribute("actividades");
    } catch (Exception e) {
        System.out.println("Error");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Inicio</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body class="w-screen h-screen flex items-start flex-col justify-start ">

        <jsp:include page='/components/header.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>
        
        <div class="w-full h-full flex-grow px-8 py-6 max-h-full overflow-auto flex items-center justify-between gap-x-8">
            <aside class="w-96 h-full border border-gray-300 rounded rounded-3xl overflow-hidden bg-white shadow-md flex flex-col items-start justify-start">
                <span class="w-full h-auto px-4 py-2 bg-[#DEDEDE] text-[#6B7280] text-left">Instituciones</span>
                <ul class="w-full flex-grow max-h-full overflow-auto flex flex-col items-start justify-start">
                    <%-- ForEach Instituciones --%>
                    <% for (HashMap.Entry<Integer, DtInstitucion> en : instituciones.entrySet()) {
                            Integer key = en.getKey();
                            DtInstitucion val = en.getValue();
                        
                    %>
                     <div class="w-full h-auto px-4 py-4 border-b border-gray-300 flex flex-col gap-y-2">
                        <p class="text-[#111827] text-base font-medium text-left w-full truncate max-w-full"> <%=val.getNombre()%> </p>
                        <p class="text-[#6B7280] text-sm font-normal max-w-full text-left truncate">  <%=val.getDescripcion()%> </p>
                     </div>
                    <%
                    }
                    %>
                       
                </ul>
            </aside>
                
            <main class="flex-grow w-full h-full max-h-full max-h-full overflow-auto flex flex-col items-start justify-start gap-y-1">
                <div class="w-full h-auto p-2 bg-blue-50 flex flex-col items-start justify-start gap-y-1.5 rounded-md ">
                    <p class="text-[#0F225E] text-xl font-semibold">Buenas tardes Usuario, esperamos que estes teniendo un buen dia! </p>
                    <p class="text-[#1E40AF] text-xl font-medium">Tenemos un monton de actividades y clases para ti !</p>
                </div>
                <p class="text-[#3A5A6E] font-medium text-xl">Algunas Estadisticas Que Podrian Interesarte</p>
                <%-- Estadisticas Div Principal --%>
                <div class="w-full h-28 flex items-center justify-between gap-x-6 mt-1">
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Usuarios</p>
                            <p class="font-semibold text-[#4C837A] text-3xl">71,897</p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#4C837A] rounded-md p-3">
                            <i class="fa-solid fa-users text-white text-2xl"></i>
                        </div>
                    </div>
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Instituciones</p>
                            <p class="font-semibold text-[#3A5A6E] text-3xl">71,897</p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#3A5A6E] rounded-md p-3">
                            <i class="fa-solid fa-house text-white text-2xl"></i>
                        </div>
                    </div>
                    <div class="h-full p-6 flex flex-row items-center justify-start flex-grow w-full rounded-xl shadow-md border border-gray-100">
                        <div class="w-full flex-grow h-full flex flex-col items-start justify-start gap-y-1">
                            <p class="font-medium text-gray-500 text-sm">Total Actividades</p>
                            <p class="font-semibold text-[#E5E2C9] text-3xl">71,897</p>
                        </div>
                        <div class="w-20 h-full flex items-center justify-center bg-[#E5E2C9] rounded-md p-3">
                            <i class="fa-solid fa-basketball text-[#5E5E5E] text-3xl"></i>
                        </div>
                    </div>
                </div>
                <p class="text-[#3A5A6E my-2 font-medium text-2xl">Aqui tienes algunas actividades, para acceder a ellas debes iniciar seison</p>
                
                <%-- Recorrer actividades --%>
                
                <div class="w-full flex-grow h-full grid grid-cols-4 gap-4 auto-rows-max">
                    <% for (HashMap.Entry<Integer, ActividadDTO> en : actividades.entrySet()) {
                            Integer key = en.getKey();
                            ActividadDTO val = en.getValue();
                        
                    %>
                      <jsp:include page='/components/cardActividad.jsp' >
                          <jsp:param name="nombre" value="<%=val.getNombre()%>" />
                        <jsp:param name="image" value="data:image/jpeg;base64,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" />
                        <jsp:param name="descripcion" value="Lorem ipsum as dolor." />
                     </jsp:include>
                    <%
                    }
                    %>
                </div>
            </main>
        </div>
    </body>
</html>

