<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<div class="w-full h-80 border border-gray-200 shadow-md rounded-xl flex flex-col items-start justify-start">
    <div class="flex-grow h-full w-full flex flex-col items-center justify-center gap-y-6">
        <img 
          class="rounded-full w-32 h-32 overflow-hidden object-cover"
          src="${param.image}"
        />
        <div class="w-full h-auto flex flex-col items-center justify-center gap-y-1">
            <p class="text-gray-900 font-medium text-sm">
                <strong>Nombre:</strong>  ${param.nombre}  ${param.apellido}<br>
                <strong>Email:</strong>  ${param.email}  <br>
            </p>
           
        </div>
    </div>
    <a href="verActividadInfo?actId=${param.actID}" class="w-full h-auto py-4 flex items-center justify-center border-t border-gray-300">
        <p class="text-sm decoration-none font-medium text-gray-700">Ver Perfil</p>
    </a>
</div>

