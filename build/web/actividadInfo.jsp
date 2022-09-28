<%-- 
    Document   : actividadInfo
    Created on : 27 sept 2022, 23:37:11
    Author     : angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="w-screen h-screen flex items-start flex-col justify-start ">
        <jsp:include page='/components/header.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>
        <div class="w-full h-full flex-grow flex flex-col items-start justify-start px-20 my-8 gap-y-12">
            <div class="w-full h-[450px] flex flex-row items-center justify-between gap-x-20">
                <div class='w-[420px] h-full flex flex-col items-center justify-start gap-y-6'>
                    <img
                        src="https://cdn.pixabay.com/photo/2020/11/27/18/59/tennis-5782695__340.jpg"
                      class="w-full h-[300px] object-cover rounded-md overflow-hidden"
                        />
                    
                    <p class="text-gray-900 text-xl font-medium pb-5 border-b w-full border-gray-300">Categorias</p>
                    
                    <div class="w-full h-auto flex flex-row items-center justify-start gap-2 flex-wrap">
                        
                        <div class="w-auto h-6 flex items-center justify-center px-4 gap-x-2 bg-red-300 rounded-md">
                            <span class="w-2 h-2 bg-red-600 rounded-full"></span>
                            <p class="text-sm font-medium text-red-700">Badge 1</p>
                        </div>
                            
                        <div class="w-auto h-6 flex items-center justify-center px-4 gap-x-2 bg-green-300 rounded-md">
                            <span class="w-2 h-2 bg-green-600 rounded-full"></span>
                            <p class="text-sm font-medium text-green-700">Badge 2</p>
                        </div>
                        
                    </div>
                </div>
                
                    <div class='w-full flex-grow h-full border border-gray-300 rounded-md shadow-md flex flex-col items-start justify-start p-6'>
                            
                        <p class="py-5 border-b border-gray-300 w-full text-left">Tenis</p>
                        <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                            <p class="w-1/3 text-gray-500 text-sm font-medium">Insttucion</p>
                            <p class="w-2/3 text-sm font-normal text-gray-900">Lar UTEC</p>
                        </div>
                        <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                            <p class="w-1/3 text-gray-500 text-sm font-medium">Duracion</p>
                            <p class="w-2/3 text-sm font-normal text-gray-900">15</p>
                        </div>
                        <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                            <p class="w-1/3 text-gray-500 text-sm font-medium">Fecha Alta</p>
                            <p class="w-2/3 text-sm font-normal text-gray-900">12/5/2020</p>
                        </div>
                        <div class="flex w-full flex-row flex-grow items-start justify-start py-5 border-b border-gray-300">
                            <p class="w-1/3 text-gray-500 text-sm font-medium">Descripcion</p>
                            <p class="w-2/3 text-sm font-normal text-gray-900">Actividad Ejemplo testeo</p>
                        </div>
                    </div>
            </div>
            <div class="w-full h-full flex-grow max-h-full overflow-auto flex flex-row items-center justify-center gap-x-16">
                <div class="w-full flex-grow h-full rounded-md border border-gray-300 shadow-sm flex flex-col items-center bg-whit justify-start  overflow-hidden">
                    <div class="w-full flex flex-row items-center justify-start h-12 bg-gray-50 border-b border-gray-300 px-6">
                        <p class="w-2/5 h-auto text-sm text-gray-500 font-medium">Cuponeras</p>
                        <p class="w-2/5 h-auto text-sm text-gray-500 font-medium">Descripcion</p>
                        <p class="w-1/5 h-auto text-sm text-gray-500 font-medium">Status</p>
                    </div>
                    <div class="w-full flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                        <p class="w-2/5 h-auto text-sm text-gray-500 font-medium">Cuponera1</p>
                        <p class="w-2/5 h-auto text-sm text-gray-500 font-medium">Test1</p>
                        <div class="w-1/5 h-auto text-sm font-medium">
                            <p class="bg-green-100 w-fit h-auto text-green-800 rounded-xl py-0.5 px-3 ">Activa</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="w-full flex-grow h-full rounded-md border border-gray-300 shadow-sm flex flex-col items-center bg-whit justify-start overflow-hidden">
                    <div class="w-full flex flex-row items-center justify-start h-12 bg-gray-50 border-b border-gray-300 px-6">
                        <p class="w-1/2 h-auto text-sm text-gray-500 font-medium">Clase</p>
                        <p class="w-1/2 h-auto text-sm text-gray-500 font-medium">Duracion</p>
                    </div>
                    <div class="w-full flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                        <p class="w-1/2 h-auto text-sm text-gray-500 font-medium">Cuponera1</p>
                        <p class="w-1/2 h-auto text-sm text-gray-500 font-medium">Test1</p>
                    </div>
                </div>
                
            </div>
        </div>
    </body>
</html>
