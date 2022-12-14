<%-- 
    Document   : usuarios.jsp
    Created on : 9 oct 2022, 17:21:56
    Author     : rodrigo
--%>

<%@page import="ws.UsuarioDTO"%>
<%@page import="java.nio.file.Files"%>
<%@page import="util.BlobToImage"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Inicio</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body class="w-screen h-full flex items-start flex-col justify-start ">

        <jsp:include page='/components/header.jsp' >
            <jsp:param name="path" value="usuarios" />
        </jsp:include>

        <%
            BlobToImage blobToImage = new BlobToImage();
            HashMap<Integer, UsuarioDTO> usuarios = new HashMap<Integer, UsuarioDTO>();
            if (request.getAttribute("usuarios") != null) {
                usuarios = (HashMap<Integer, UsuarioDTO>) request.getAttribute("usuarios");
            }
        %>


        <div class="m-auto w-5/6 h-full my-14 flex flex-col items-center justify-start gap-y-10">
            <div class="w-full h-auto flex flex-row items-center justify-start gap-x-10">
                <p class="text-gray-900 flex-grow font-medium text-2xl pb-5 border-b border-gray-300">Usuarios:</p>

            </div>

            <div class="w-full flex-grow h-full grid grid-cols-2 max-[465px]:grid-cols-1 min-[900px]:grid-cols-4 gap-4 auto-rows-max">
                <% for (HashMap.Entry<Integer, UsuarioDTO> in : usuarios.entrySet()) {
                        Integer key = in.getKey();
                        UsuarioDTO val = in.getValue();
                %>
                <jsp:include page='/components/userCard.jsp' >
                    <jsp:param name="uid" value="<%= val.getID() %>" />
                    <jsp:param name="nombre" value="<%= val.getNOMBRE()%>" />
                    <jsp:param name="apellido" value="<%= val.getAPELLIDO()%>" />
                    <jsp:param name="image" value="<%=blobToImage.getBase64StringImage(val.getBlobImage())%>" />
                    <jsp:param name="email" value="<%= val.getEMAIL()%>" />
                </jsp:include>

                <%
                    }
                %>





            </div>
        </div>
    </body>
</html>
