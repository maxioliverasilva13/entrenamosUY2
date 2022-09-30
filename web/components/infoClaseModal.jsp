<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="w-full h-full absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all">
    <div class="bg-white rounded-2xl p-12 border-gray-300 border w-3/5 h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <img src="https://static1.abc.es/media/bienestar/2019/08/02/tenis-abecedario-kgNF--620x349@abc.jpg" class="w-40 h-40 rounded-full overflow-hidden"/>
        <div class="flex flex-col items-center justify-start flex-grow gap-y-16">
            <div class='flex flex-col flex-grow w-full h-auto rounded-md border border-gray-300 shadow-sm items-start justify-start'>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300">
                <p class="text-2xl font-medium text-gray-900">Clase 1</p>
                <p class="text-gray-500 font-normal text-base">Descripcion of clase 1</p>
            </div>
            
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Fecha de inicio</p>
                <p class="text-gray-500 font-normal text-sm flex-grow">20/5/2022</p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Hora de inicio</p>
                <p class="text-gray-500 font-normal text-sm flex-grow">17:00</p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Profesor</p>
                <p class="text-gray-500 font-normal text-sm flex-grow">Augusto</p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Socios Minimos</p>
                <p class="text-gray-500 font-normal text-sm flex-grow">3</p>
            </div>
            <div class="w-full h-auto p-6 gap-y-1 border-b border-gray-300 flex flex-row items-center justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">Socios Maximos</p>
                <p class="text-gray-500 font-normal text-sm flex-grow">6</p>
            </div>
            <div class="w-full h-24 p-6 gap-y-1 border-b border-gray-300 flex flex-row items-start justify-start">
                <p class="text-sm font-medium text-gray-900 w-1/3">URL</p>
                <div class="flex-grow h-12 p-4 border-gray-300 border rounded-md flex items-center gap-x-2 justify-start">
                    <i class="fa-solid fa-link"></i>
                </div>
            </div>
        </div>
            <%-- Solo para socio que va a comprar --%>
            <button class="w-auto h-auto p-4 border text-black text-base rounded-md bg-[#E5E2C9]">
                Seleccionar medio de pago
            </button>
        </div>
    </div>
    
</div>
