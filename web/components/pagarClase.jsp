<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera

    Esta pagina es solo para socios logueados
--%>


<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Clase.DtClase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
  DtClase selectedClaseInfo = (DtClase)request.getAttribute("selectedClaseInfo");
  ActividadDTO infoAct = (ActividadDTO) request.getAttribute("actInfo");

%>
<!DOCTYPE html>
<div class="w-full h-full absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all">
    <div class="bg-white w-auto rounded-2xl p-12 px-24 border-gray-300 border  h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <a href="verActividadInfo?actId=<%=selectedClaseInfo.getIdActividad() %>" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>
        
        <div class="flex flex-col items-center justify-start flex-grow gap-y-4 w-full h-full">
            <p class="text-2xl text-gray-900 font-medium">Elije como deseas pagar la clase</p>
            
            <hr class="w-full" />
            
            <div class="w-full h-full flex-grow flex flex-row items-center justify-start gap-x-12">
                
                <%-- Cuponeras List --%>
                <div class="flex-grow h-full flex flex-col items-start justify-start gap-y-5">
                    <p class="text-gray-900 font-medium text-xl">Elija una cuponera</p>
                    <div class="w-full h-full flex-grow border border-gray-200 rounded-2xl overflow-hidden shadow-md max-h-full overflow-auto">
                        <%-- Cols --%>
                        <div class="w-full h-10 bg-gray-50 flex flex-row items-center justify-start border-b border-gray-300 px-4">
                            <p class="text-sm w-[35%] font-medium text-gray-500 truncate">Cuponera</p>
                            <p class="text-sm w-[30%] font-medium text-gray-500 truncate">Descripcion</p>
                            <p class="text-sm w-[20%] font-medium text-gray-500 truncate">Precio</p>
                            <p class="text-sm w-[15%] font-medium text-gray-500 truncate"></p>
                        </div>
                        
                          <%-- Cols --%>
                        <div class="w-full h-12 bg-white flex flex-row items-center justify-start border-b border-gray-300 px-4">
                            <p class="text-sm w-[35%] font-medium text-gray-500 truncate">Cuponera 1</p>
                            <p class="text-sm w-[30%] font-medium text-gray-500 truncate">Esto es una descripcion</p>
                            <p class="text-sm w-[20%] font-medium text-gray-500 truncate">$51 (25% descuento)</p>
                            <div class="text-sm w-[15%] font-medium text-gray-500 flex items-center justify-center">
                                <button class="bg-[#4F7994] text-white w-auto h-auto rounded-md flex items-center justify-center px-2 py-1">
                                    Elejir
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <%-- Payment Card --%>
                <div class="w-auto h-auto flex flex-col items-center justify-start gap-y-5">
                    <p class="text-gray-900 font-medium text-xl">Con un pago unico</p>
                    <div class="w-72 h-auto flex flex-col items-start justify-start shadow-md border border-gray-100 rounded-2xl">
                    <div class="w-full h-auto p-6 flex flex-col items-start justify-start gap-y-5">
                        <p class="text-[#4F7994] text-[60px] font-bold">$<%=infoAct.getCosto() %></p>
                        <p class="text-gray-500 text-xl font-normal">Este precio es el de cada clase para esta actividad</p>
                    </div>
                    <div class="p-6 w-full h-auto bg-gray-50 border-t border-gray-100">
                        <button class="h-auto bg-[#4F7994] w-full flex-grow py-4 px-6 text-white">
                            Comprar
                        </button>
                    </div>
                </div>
                </div>
                
            </div>
        </div>
    </div>
    
</div>
