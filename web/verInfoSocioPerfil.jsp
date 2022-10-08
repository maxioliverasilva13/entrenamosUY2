<%-- 
    Document   : verInfoSocioPerfil
    Created on : 2 oct. 2022, 14:50:35
    Author     : pedri
--%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
         
         <div class="w-full h-full flex-grow flex flex-col items-stretch justify-start px-[72px] py-[32px] gap-y-9">
             <div class="w-full h-[263px] flex flex-row items-stretch justify-between flex-grow">
                 <div class="w-auto h-full flex flex-col items-start justify-start content-start ">
                    <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-[100000px] w-[187px] h-[192px] object-cover"/>
                    <div class="text-[#595E67] text-[48px] font-normal gap-y-[25px] px-[33px]">Pepe</div>
                    <div class="text-[#959EB0] text-[24px] font-normal gap-y-[14px] px-[61px]">Socio</div>
                 </div>
                 <div class="w-[1083px] h-[263px] rounded-[20px] bg-[#F4F4F4] px-[28px] shadow-md flex flex-row ">
                     <div class="w-full h-full flex flex-col items-stretch justify-start gap-y-[27px] py-[24px]">
                         <p class="text-[#6B7280] text-[14px] font-normal">Nombre y Apellido</p>
                         <p class="text-[#6B7280] text-[14px] font-normal">Correo@correo.com</p>
                         <p class="text-[#6B7280] text-[14px] font-normal">Institucion</p>
                         <p class="text-[#6B7280] text-[14px] font-normal">Fecha de Nacimiento</p>
                         <p class="text-[#6B7280] text-[14px] font-normal">www.miweb.com</p>
                     </div>
                     
                     
                     <div class="w-full h-full flex flex-col justify-center items-end gap-y-[19px] ">
                        <div class="bg-[#FFFFFF] rounded-[8px] shadow-md h-[100px] w-[344px] flex flex-col justify-center items-start px-[16px] py-[20px]">
                            <p class="text-[14px] text-[#4C837A] font-medium">Seguidores</p>
                            <p class="text-[30px] font-semibold text-gray-900">71,897</p>
                        </div>
                        <div class="bg-[#FFFFFF] rounded-[8px] shadow-md h-[100px] w-[344px] flex flex-col justify-center items-start px-[16px] py-[20px]">
                            <p class="text-[14px] text-[#4C837A] font-medium">Seguidos</p>
                            <p class="text-[30px] font-semibold text-gray-900">1,250</p>
                        </div>
                     </div>
                 </div>
                 <div class=" w-auto h-auto flex flex-col justify-between justify-start py-[28px]">
                     <button class=" h-[57px] w-[306px]  bg-[#DFD9A4] text-[20px] font-medium rounded-[6px]">Editar Informacion</button>
                     <button class="h-[57px] w-[306px]  bg-[#4F7994] text-[20px] font-medium rounded-[6px]">Cambiar Foto</button>
                     <button class="h-[57px] w-[306px]  bg-[#C56969] text-[20px] font-medium rounded-[6px]">Cerrar Sesion</button>
                 </div>
                 
                 
                 
                 
                 
                 
             </div>
             <div class="w-full h-[582px] flex flex-row items-stretch justify-center gap-x-[96px]">
                 <div class="h-full w-[400px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                     <div class="bg-[#DEDEDE] px-[24px] py-[12px]">
                        <p class="text-gray-500 text-[12px] font-medium">ACTIVIDADES</p>
                     </div>
                     <div class="h-[72px] w-[403px] border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                        <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[40px] h-[40px] object-cover"/>
                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex item-start justify-start flex-col">CLASES</div>
                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                     </div>
                 </div>
                  <div class="h-full w-[400px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                     <div class="bg-[#DEDEDE] px-[24px] py-[12px]">
                         <p class="text-gray-500 text-[12px] font-medium ">CLASES</p>
                     </div>
                       <div class="h-[72px] w-[403px] border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                        <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[40px] h-[40px] object-cover"/>
                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex item-start justify-start flex-col">CLASES</div>
                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                     </div>
                 </div>
                 
                  <div class="h-full w-[400px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                     <div class="bg-[#DEDEDE] px-[24px] py-[12px]">
                         <p class="text-gray-500 text-[12px] font-medium">CUPONERAS</p>
                     </div>
                     <div class="h-[72px] w-[403px] border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                        <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[40px] h-[40px] object-cover"/>
                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex item-start justify-start flex-col">CLASES</div>
                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                     </div>
                 </div>
             </div>
         </div>
    </body>
</html>
