<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="util.BlobToImage"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="Clase.DtClase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    DtClase selectedClaseInfo = (DtClase)request.getAttribute("selectedClaseInfo");
    Calendar c = Calendar.getInstance();
    c.setTime(selectedClaseInfo.getFecha());
    BlobToImage btimg = new BlobToImage();

    String formattedFechaInicio = c.get(Calendar.DAY_OF_MONTH) + "/" + c.get(Calendar.MONTH) + "/" + c.get(Calendar.YEAR);
    boolean isLoggedAndSocio = true;
    
%>
<!DOCTYPE html>
<div class="w-screen h-screen min-h-screen  absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all">
    <div class="bg-white transition-all transition-opacity rounded-2xl p-12 border-gray-300 border w-3/5 h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <a href="verActividadInfo?actId=<%=selectedClaseInfo.getIdActividad() %>" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>
        <img  src="<%=btimg.getBase64StringImage(selectedClaseInfo.getImageBlob()) %>" class="w-40 h-40 rounded-full overflow-hidden"/>
        <div class="flex flex-col items-center justify-start flex-grow gap-y-16">
            <div class='flex flex-col flex-grow w-full h-auto rounded-md border border-gray-300 shadow-sm items-start justify-start'>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300">
                <p class="text-2xl font-medium text-gray-900">Informacion de <%=selectedClaseInfo.getNombre() %></p>
                <p class="text-gray-500 font-normal text-base">Inscriptos: <%=selectedClaseInfo.getRegistros().size() %></p>
            </div>
            
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Fecha de inicio</p>
                <p class="text-gray-500 font-normal text-sm flex-grow"><%=formattedFechaInicio %></p>
            </div>
            
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Profesor</p>
                <p class="text-gray-500 font-normal text-sm flex-grow"><%=selectedClaseInfo.getProfesor() %></p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Socios Minimos</p>
                <p class="text-gray-500 font-normal text-sm flex-grow"><%=selectedClaseInfo.getCapMinima()%></p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Socios Maximos</p>
                <p class="text-gray-500 font-normal text-sm flex-grow"><%=selectedClaseInfo.getCapMaxima()%></p>
            </div>
            <div class="w-full h-24 p-6 gap-y-1 border-b border-gray-300 flex flex-row items-start justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">URL<%=selectedClaseInfo.getUrlAcceso() %></p>
                <div class="flex-grow h-12 p-4 border-gray-300 border rounded-md flex items-center gap-x-2 justify-start">
                    <i class="fa-solid fa-link"></i>
                </div>
            </div>
        </div>
            <%-- Solo para socio que va a comprar --%>
            <% if (isLoggedAndSocio) {
            %>
            <a href="verActividadInfo?actId=<%=selectedClaseInfo.getIdActividad()%>&verInfoPago=true&claseId=<%=selectedClaseInfo.getId()%>" class="w-auto cursor-pointer h-auto p-4 border text-black text-base rounded-md bg-[#E5E2C9]">
              Seleccionar medio de pago
            </a>
            <%
            }
            %>
          
        </div>
    </div>
    
</div>
