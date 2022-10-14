<%-- 
    Document   : modalEditarInfoSocio
    Created on : 3 oct. 2022, 17:57:24
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
        <div class="h-full w-full bg-[#6B7280] opacity-60 flex justify-center items-center">
            <div class="w-[681px] h-[903px] rounded-[10px] bg-[#FFFFFF] shadow-lg">           
                <div class="flex flex-row items-center justify-center content-center  py-[16px] relative">
                    <p class="h-[24px] w-auto text-[#000000] text-[24px] font-medium px-[176px]">Editar Información</p>
                    <button class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full -top-3 -right-3 absolute">
                    <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="h-full w-full flex flex-col align-center items-start justify-start px-[153px] space-y-[1px]">
                    <p class="text-[18px] text-[#000000] font-medium">Información personal</p>
                    <p class="text-[14px] text-[#000000] font-medium py-[18px]">Nickname</p>
                    <input type="text" id="fname" name="fname" class="w-[368px] h-[42px] border-[1px] border-solid shadow-md border[#D1D5DB]"><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Nombre</p>
                    <input type="text" id="fname2" name="fname2" class="w-[368px] h-[42px] border-[1px] border-solid shadow-md border[#D1D5DB]"><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Apellido</p>
                    <input type="text" id="fname3" name="fname3" class="w-[368px] h-[42px] border-[1px] border-solid shadow-md border[#D1D5DB]"><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Email</p>
                    <input type="text" id="fname4" name="fname4" class="w-[368px] h-[42px] border-[1px] border-solid shadow-md border[#D1D5DB]"><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Biografia</p>
                    <area type='text' id='a1' name='area1' class='w-[368px] h-[66px] border-[1px] border-solid shadow-md border[#D1D5DB]'><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Descripción</p>
                    <area type='text' id='a1' name='area1' class='w-[368px] h-[66px] border-[1px] border-solid shadow-md border[#D1D5DB]'><br><br>
                    <p class="text-[14px] text-[#000000] font-medium">Sitio Web</p>
                    <input type="text" id="fname4" name="fname4" class="w-[368px] h-[42px] border-[1px] border-solid shadow-md border[#D1D5DB]"><br><br>
                    <button class="w-[306px] h-[57px] rounded-[6px] bg-[#4F7994] text-[#FFFFFF] text-[20px] font-medium m-[35px]">Guardar</button>
                </div>
            </div>
        </div>
    </body>
</html>
