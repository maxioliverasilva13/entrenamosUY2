
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<div class="w-full relative h-80 max-h-80 border border-gray-200 shadow-md rounded-xl flex flex-col items-start justify-start">
    <div class="flex-grow h-full w-full flex flex-col items-center justify-center gap-y-6">
        <img 
            class="rounded-full w-32 h-32 overflow-hidden object-cover"
            src="${param.image}"
            />
        <div class="w-full h-auto flex flex-col items-center text-center justify-center gap-y-1">
            <p class="text-gray-900 font-medium text-sm">${param.nombre}</p>
            <p class="text-gray-500 font-normal text-sm">${param.descripcion}</p>
        </div>
    </div>
    <a href="verActividadInfo?actId=${param.actID}" class="w-full h-auto py-4 flex items-center justify-center border-t border-gray-300">
        <p class="text-sm decoration-none font-medium text-gray-700">Ver Mas</p>
    </a>
    <button id="favoriteButton" class="right-6 top-10 cursor-pointer absolute"" >
        <%
            if (request.getParameter("isFavorita").equals("true")) {
        %> 
        <i class="fa-sharp text-red-700 fa-solid text-[20px] fa-heart"></i>
        <%
            }
        %>
    </button>
</div>

