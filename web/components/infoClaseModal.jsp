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

    $(document).ready(function () {
        document.getElementById("infoClaseModal").onload = () => {

            const claseInfo = window?.claseInfo;
            let parentNode = document.getElementById("tablaContent");
            if (claseInfo === "Loading") {
                $("#contentInfo").css("display", "none");
                // document.getElementById("imageCup").setAttribute("src", "")
            } else {
                $("#contentInfo").css("display", "flex");
                $("#claseNombre").text(claseInfo?.nombre);
                $("#fechaInicioClase").text(claseInfo?.fecha);
                $("#profesorClase").text(claseInfo?.profesor);
                $("#sociosMinimosClase").text(claseInfo?.capMinima);
                $("#sociosMaximosClase").text(claseInfo?.capMaxima);
                $("#urlClase").text(claseInfo?.urlAcceso);
                $("#inscriptosClase").text(claseInfo?.registros?.length || 0);
                var imgsrc = claseInfo.imageBlob ? "data:image/jpg;base64," + btoa(new Uint8Array(claseInfo.imageBlob).reduce(function (data, byte) {
                    return data + String.fromCharCode(byte);
                }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"
                $("#imageClase").attr("src", imgsrc);
                var actividadId = claseInfo?.idActividad;
                var claseId = claseInfo?.id;
                $("#seleccionarMedioPagoModal").attr("href", "verActividadInfo?actId="+ actividadId+ "&verInfoPago=true&claseId=" + claseId + "");
                window.claseInfo = null;
                this.onload = null;
            }
        }
    });

    const closeModalClase = () => {
        document.getElementById("infoClaseModal").style.cssText = "display: none";
    }

</script>


<!DOCTYPE html>
<div id="infoClaseModal" style="display: none;" class="w-full h-full min-h-screen z-[9999] py-6 fixed top-0 left-0 right-0 bottom-0 max-h-full overflow-auto bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white transition-all transition-opacity rounded-2xl p-12 border-gray-300 border m-auto lg:w-3/5 w-auto h-auto min-w-4/5 flex md:flex-row flex-col md:items-start items-center justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModalClase()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <img id="imageClase" class="w-40 h-40 my-4 min-w-40 min-h-40 rounded-full overflow-hidden"/>
        <div id="contentInfo" class="flex-col items-center justify-start md:w-auto xs:w-[300px] flex-grow w-[400] gap-y-16">
            <div class='flex flex-col flex-grow w-full h-auto rounded-md border border-gray-300 shadow-sm items-start justify-start'>
                <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300">
                    <p class="text-2xl font-medium text-gray-900">Informacion de</p>
                    <p id="claseNombre" class="text-gray-500 font-normal text-base">Inscriptos: <span id="inscriptosClase"></span></p>
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
                    <p class="text-sm font-medium text-gray-900 w-1/3">Socios Maximos <span id="sociosMaximosClase"></span></p>
                    <p class="text-gray-500 font-normal text-sm flex-grow"></p>
                </div>
                <div class="w-full h-24 p-6 gap-y-1 border-b border-gray-300 flex flex-row items-start justify-start">
                    <p class="text-sm font-medium text-gray-900 w-1/3">Url Acceso</p>
                    <div class="flex-grow h-12 p-4 border-gray-300 border rounded-md flex items-center gap-x-2 justify-start">
                        <i class="fa-solid fa-link"></i>
                        <span id="urlClase"></span>
                    </div>
                </div>
            </div>
            <%-- Solo para socio que va a comprar --%>
            <% if (isLoggedAndSocio) {
            %>
            <a id="seleccionarMedioPagoModal" href="" <%-- href="%>" --%> class="w-auto cursor-pointer h-auto p-4 border text-black text-base rounded-md bg-[#E5E2C9]">
                Seleccionar medio de pago
            </a>
            <%
            }
            %>

        </div>
    </div>

</div>
