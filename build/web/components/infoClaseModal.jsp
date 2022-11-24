<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="Cuponera.DtCuponera"%>
<%@page import="util.BlobToImage"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="Clase.DtClase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    /* DtClase selectedClaseInfo = (DtClase) request.getAttribute("selectedClaseInfo");
    Calendar c = Calendar.getInstance();
    c.setTime(selectedClaseInfo.getFecha());
    BlobToImage btimg = new BlobToImage();

    String formattedFechaInicio = c.get(Calendar.DAY_OF_MONTH) + "/" + c.get(Calendar.MONTH) + "/" + c.get(Calendar.YEAR);
   
    }*/

    boolean isLoggedAndSocio = false;
    String typeOfUser = (String) session.getAttribute("typeOfUser");
    if (typeOfUser != null) {
        if (typeOfUser.equalsIgnoreCase("Socio")) {
            isLoggedAndSocio = true;
        }
    }
%>

<script>
    const closeModalClase = () => {
        document.getElementById("infoClaseModal").style.cssText = "display: none";
    }
    $(document).ready(function () {
        document.getElementById("infoClaseModal").onload = (isOpen, resultados) => {
        }
    });

</script>

<jsp:include page="./crearSorteoModal.jsp" />
<jsp:include page="./resultadosSorteo.jsp" />

<!DOCTYPE html>
<div id="infoClaseModal" style="display: none;" class="w-full h-full min-h-screen z-[9999] py-6 fixed top-0 left-0 right-0 bottom-0 max-h-full overflow-auto bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white transition-all transition-opacity rounded-2xl md:p-12 p-4 border-gray-300 border m-auto md:min-w-[600px] min-w-[90%] md:w- w-auto h-auto flex flex-col gap-4 md:items-start items-center justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModalClase()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <div id="contentInfo" class="flex-col md:min-w-[550px] w-full items-center justify-start gap-y-16">
            <div class='flex flex-col flex-grow w-full h-auto rounded-md border border-gray-300 shadow-sm items-start justify-start'>
                <div class="w-full px-4 h-auto flex flex-row items-center justify-start gap-x-2  border-b border-gray-300">
                    <img id="imageClase" class="w-20 h-20 my-4 min-w-20 min-h-20 rounded-full overflow-hidden"/>
                    <div class="w-full flex-grow h-auto p-6 gap-y-1">
                        <p class="text-2xl font-medium text-gray-900">Informacion de <span id="claseNombre" class="">Inscriptos: <span id="inscriptosClase"></span></span>
                        </p>
                    </div>
                </div>


                <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                    <p class="text-sm font-medium text-gray-900 w-1/3">Fecha de inicio: </p>
                    <p id="fechaInicioClase" class="text-gray-500 font-normal text-sm flex-grow"></p>
                </div>

                <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                    <p class="text-sm flex font-medium text-gray-900 w-1/3">Profesor</p>
                    <p id="profesorClase" class="text-gray-500 font-normal text-sm flex-grow"></p>
                </div>
                <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                    <p class="text-sm font-medium text-gray-900 w-1/3">Socios Minimos</p>
                    <p id="sociosMinimosClase" class="text-gray-500 font-normal text-sm flex-grow"></p>
                </div>
                <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                    <p class="text-sm font-medium text-gray-900 w-1/3">Socios Maximos</p>
                    <span id="sociosMaximosClase" class="text-gray-500 font-normal text-sm flex-grow"></span>
                </div>
                <div class="w-full h-24 p-6 gap-y-1 border-b border-gray-300 flex flex-row items-start justify-start">
                    <p class="text-sm font-medium text-gray-900 w-1/3">Url Acceso</p>
                    <div class="flex-grow h-12 p-4 border-gray-300 border rounded-md flex items-center gap-x-2 justify-start">
                        <i class="fa-solid fa-link"></i>
                        <span id="urlClase"></span>
                    </div>
                </div>
            </div>
        </div>
        <%-- Solo para socio que va a comprar --%>
        <% if (isLoggedAndSocio) {
        %>
        <a id="seleccionarMedioPagoModal" href="" <%-- href="%>" --%> class="w-auto m-auto cursor-pointer h-auto p-4 border text-black text-base rounded-md bg-[#E5E2C9]">
            Seleccionar medio de pago
        </a>
        <%
            }
        %>
        <button id="buttonRealizarSorteo" class="hidden px-4 py-2 text-white rounded-md bg-indigo-800 hover:bg-indigo-900 transition-all transform hover:scale-105">
            Realizar sorteo
        </button>
        <div id="mostrarResultadosModal" style="display: none" class="flex flex-col items-center justify-center gap-y-2">
            <p>El sorteo de esta clase fue realizado correctamente </p>
            <button id="buttonVerResultados" class="px-4 py-2 text-white rounded-md bg-indigo-800 hover:bg-indigo-900 transition-all transform hover:scale-105">
                Mostrar Resultados
            </button>
        </div>

    </div>

</div>
