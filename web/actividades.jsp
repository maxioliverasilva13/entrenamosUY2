<%-- 
    Document   : index.jsp
    Created on : 15/09/2022, 09:16:14 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

    <% 
    List<String> categorias = new ArrayList<>();
    categorias.add("Cat 1");
    categorias.add("Cat 2");
    categorias.add("Cat 3");    
    request.setAttribute("test", categorias);
    
    List<String> instituciones = new ArrayList<>();
    instituciones.add("Institucion 1");
    instituciones.add("Institucion 2");
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    instituciones.add("Institucion 3");    
    request.setAttribute("insts", instituciones);
    
    String nombreUser = (String)request.getAttribute("nombre");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Actividades</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body class="w-screen h-screen flex items-start flex-col justify-start">

        <jsp:include page='/components/header.jsp' >
            <jsp:param name="path" value="actividades" />
        </jsp:include>
        <p><%=nombreUser%></p>
        <div class="w-full h-full flex-grow px-8 py-6 max-h-full overflow-auto flex flex-row items-center justify-between gap-x-32 p-10">
            <div class="w-96 h-full flex flex-col items-center justify-start gap-y-2">
                <p class="text-gray-500 w-full text-left font-medium text-md">Categorias</p>
                
                <div class="w-full h-full flex-grow flex flex-col items-center justify-start gap-y-5">
                    
                    <c:forEach items="${test}" var="item">
                      
                     <jsp:include page='/components/categoriaCard.jsp' >
                        <jsp:param name="categoria" value="${item}" />
                     </jsp:include>
                    </c:forEach>
                </div>
            </div>
            
            
            <div class="w-full flex-grow h-full flex flex-col items-center justify-start gap-y-12">
                <p class="text-gray-900 text-2xl text-left w-full font-medium pb-5 border-b border-gray-300 w-full">Haz click sobre una categoria o institucion para ver sus actividades y cuponeras asociadas</p>
                <div class="w-full h-full max-h-full overflow-auto flex-grow border border-gray-300 rounded-md ">
                     <c:forEach items="${insts}" var="item">
                    <div class="w-full h-20 border-b border-gray-300 px-6 py-4 flex flex-row items-center justify-start gap-x-4">
                        <img 
                        src="./assets/gym.png"
                         class="w-12 h-12 rounded-full overflow-hidden"   
                        />
                        <div class="flex-grow h-full flex flex-col items-start justify-between">
                            <p class="text-[#4F46E5] font-medium text-sm">Institucion UTEC San Jose</p>
                            <div class="flex items-center justify-start gap-x-2">
                                <i class="fa-solid fa-comment text-gray-300"></i>
                                <p class="text-gray-500 font-normal text-sm ">Description of Institucion</p>
                            </div>

                        </div>
                        
                        <div class="flex-grow h-full flex flex-col items-start justify-between">
                            <p class="text-gray-900 font-medium text-sm">Total Actividades: 5 </p>
                            <div class="flex items-center justify-start gap-x-2">
                                <i class="fa-solid fa-circle-check text-sm text-green-600"></i>
                                <p class="text-gray-500 font-normal text-sm ">Applied on January 7, 2020</p>
                            </div>

                        </div>
                        <i class="fa-solid fa-chevron-right text-gray-900 cursor-pointer px-4"></i>
                    </div>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
    </body>
</html>

