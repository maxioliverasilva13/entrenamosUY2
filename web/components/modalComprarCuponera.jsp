<%-- 
    Document   : modalEditarInfoSocio
    Created on : 3 oct. 2022, 17:57:24
    Author     : pedri
--%>

<%@page import="Cuponera.DtCuponera"%>
<jsp:include page='../imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%
 
    
    DtCuponera cuponeraInfo = null;
    if (request.getAttribute("cuponera")!= null) {
        cuponeraInfo=(DtCuponera)request.getAttribute("cuponera");
    }
  
   
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="w-screen h-screen flex items-start flex-col justify-start ">
        <div class="h-full w-full bg-[#6B7280] bg-opacity-60 flex justify-center items-center ">
            <div class="w-[1104px] h-[825px] rounded-[10px] bg-[#FFFFFF] shadow-lg flex flex-col align-start justify-start relative">           
                <a href="listarCuponeras?openModal=true" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
                    <i class="fa-solid fa-xmark"></i>
                </a>
                <div class="w-full h-[248px] mt-[88px] flex flex-row relative">
                    <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[142px] h-[142px] ml-[85px] object-cover absolute"/>
                    <p class="text-[18px] text-[#111827] font-medium h-[44px] w-[238px] border-b-[1px] mt-[204px] ml-[41px] absolute">Categorias</p>
                    <div class="bg-[#FFFFFF] w-[744px] h-[248px] rounded-[8px] shadow-md ml-[322px] flex flex-col absolute border-[1px]">
                        <div class="border-b-[1px] w-full h-[64px] flex items-center px-[24px]">
                            <p class="text-[18px] text-[#111827] font-medium"><%=cuponeraInfo.getNombre()%></p>
                        </div>
                        <div class="border-b-[1px] w-full h-[60px] flex flex-row items-center px-[24px]">
                            <p class="text-[14px] text-[#6B7280] font-medium w-[221px]">Fecha Inicio</p>
                            <p class="text-[14px] font-normal text-[#111827] ml-[16px]">21/10/2022</p>
                        </div>
                        <div class="border-b-[1px] w-full h-[60px] flex items-center px-[24px]">
                            <p class="text-[14px] text-[#6B7280] font-medium w-[221px]">Fecha Fin</p>
                            <p class="text-[14px] font-normal text-[#111827] ml-[16px]">21/12/2022</p>
                        </div>
                        <div class="w-full h-[60px] flex items-center px-[24px]">
                            <p class="text-[14px] text-[#6B7280] font-medium w-[221px]">Descuento</p>
                            <p class="text-[14px] font-normal text-[#111827] ml-[16px]">10%</p>
                        </div>
                    </div>    
                </div>
                <div class="w-full h-[95px] flex items-center px-[33px]">
                    <span class="bg-blue-100 text-blue-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800">Default</span>
                    <span class="bg-gray-100 text-gray-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300">Dark</span>
                    <span class="bg-red-100 text-red-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-200 dark:text-red-900">Red</span>
                    <span class="bg-green-100 text-green-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-green-200 dark:text-green-900">Green</span>
                    <span class="bg-yellow-100 text-yellow-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-200 dark:text-yellow-900">Yellow</span>
                </div>
                <div class="w-full h-[322px] flex flex-row align-center justify-center gap-x-[82px] px-[33px]">
                    <div class="bg-[#FFFFFF] w-[656px] h-[322px] rounded-[6px] shadow-md border-[1px] ">
                        <div class="border-b-[1px] w-full h-[80px] flex flex-row items-center px-[24px] ">
                            <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[48px] h-[48px] object-cover"/>
                            <p class="text-[#4F46E5] text-[14px] font-medium h-[48px] w-[246px] ml-[16px]">Actividad</p>
                            <p class="text-[#111827] text-[14px font-normal] flex-grow h-[20px] w-[246px] flex item-start justify-start flex-col ">32 clases</p>
                        </div>
                        <div class="border-b-[1px] w-full h-[80px] flex flex-row items-center px-[24px]">
                            <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[48px] h-[48px] object-cover"/>
                            <p class="text-[#4F46E5] text-[14px] font-medium h-[48px] w-[246px] ml-[16px]">Actividad</p>
                            <p class="text-[#111827] text-[14px font-normal] flex-grow h-[20px] w-[246px] flex item-start justify-start flex-col ">32 clases</p>
                        </div>
                        <div class="border-b-[1px] w-full h-[80px] flex items-center px-[24px]">
                            <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[48px] h-[48px] object-cover"/>
                            <p class="text-[#4F46E5] text-[14px] font-medium h-[48px] w-[246px] ml-[16px]">Actividad</p>
                            <p class="text-[#111827] text-[14px font-normal] flex-grow h-[20px] w-[246px] flex item-start justify-start flex-col ">32 clases</p>
                        </div>
                        <div class="border-b-[1px] w-full h-[80px] flex items-center px-[24px]">
                            <img src="https://cdn.shopify.com/s/files/1/0229/0839/files/bancos_de_imagenes_gratis.jpg?v=1630420628&width=1024" alt="Girl in a jacket" class="rounded-full w-[48px] h-[48px] object-cover"/>
                            <p class="text-[#4F46E5] text-[14px] font-medium h-[48px] w-[246px] ml-[16px]">Actividad</p>
                            <p class="text-[#111827] text-[14px font-normal] flex-grow h-[20px] w-[246px] flex item-start justify-start flex-col ">32 clases</p>
                        </div>
                    </div>
                    <div class="bg-[#FFFFFF] w-[295px] h-[322px] rounded-[6px] shadow-lg flex flex-col px-[24px]">
                        <p class="text-[#4F7994] text-[60px] font-extrabold mt-[32px]">$49</p>
                        <p class="text-gray-500 text-[18px] mt-[20px]">Lorem ipsum dolor sit amet consectetur, adipisicing elit.</p>
                        <button class="w-[247px] h-[50px] bg-[#4F7994] rounded-[6px] mt-[56px] text-[#FFFFFF] text-[16px] font-medium">Comprar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
