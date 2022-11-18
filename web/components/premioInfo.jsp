<%-- 
    Document   : crearSorteoModal
    Created on : 15 nov. 2022, 21:18:14
    Author     : maximilianoolivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    const closeModalPremioInfo = () => {
        document.getElementById("infoSorteoModal").style.cssText = "display: none";
    }

    $(document).ready(function () {
        document.getElementById("realizarSorteoModal").onload = (data) => {
            console.log(data);
        }
    });

</script>

<div id="infoSorteoModal" style="display: none;transition: all .3s ease;" class="w-full opacity-1 transition-opacity delay-300 duration-300 h-full min-h-screen z-[99999] py-6 fixed top-0 left-0 right-0 bottom-0 max-h-full overflow-auto bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white rounded-2xl md:p-12 p-4 border-gray-300 border m-auto md:max-w-[650px] max-w-[90%] w-full h-auto flex flex-col gap-4 md:items-start items-center justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModalPremioInfo()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <div class="flex-col flex w-full items-center justify-start gap-y-6">
            <h1 class="text-gray-800 font-semibold text-lg">Informacion del sorteo</h1>

            <div class="w-full h-auto flex flex-col gap-y-2 items-center justify-start mt-4">
                <img src="https://st2.depositphotos.com/4320929/12352/v/600/depositphotos_123521904-stock-illustration-man-holding-trophy-cup.jpg" class="w-[92px] h-[92px] min-w-[92px] min-h-[92px] rounded-full overflow-hidden" />
                <p class="text-gray-800 font-semibold text-base">Descripcion: <span id="descripcionPremio"></span></p>
                <p class="text-gray-800 font-semibold text-base">Participantes: <span id="cantParticipantes"></span></p>
                <p class="text-gray-800 font-semibold text-base">Ganadores: <span id="cantGanadores"></span></p>
                <p class="text-gray-800 font-semibold text-base">Validez: <span id="descripcionPremio"></span></p>

                <button id="imprimirComprobante" class="px-4 mt-4 gap-x-2 py-2 text-white rounded-md bg-indigo-800 hover:bg-indigo-900 flex items-center transition-all transform hover:scale-105">
                    <i class="fa-solid fa-print"></i>
                    Imprimir comprobante
                </button>
            </div>
        </div>

    </div>
</div>