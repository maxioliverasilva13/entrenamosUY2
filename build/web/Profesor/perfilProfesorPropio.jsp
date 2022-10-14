<%-- 
    Document   : perfilProfesorPropio
    Created on : 30 set. 2022, 12:14:57
    Author     : mandi
--%>

<<<<<<< HEAD
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
=======
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
<jsp:include page='../imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD

<% 
    int cantSeguidores = (int)request.getAttribute("cantSeguidores");
    int cantSeguidos = (int)request.getAttribute("cantSeguidos");

    String userType = (String)request.getAttribute("userType");
    String nombre = (String)request.getAttribute("nombre");
    String apellido = (String)request.getAttribute("apellido");
    String correo = (String)request.getAttribute("correo");
    String institucion = (String)request.getAttribute("institucion");
    String fnacimiento = (String)request.getAttribute("fnacimiento");
    String website = (String)request.getAttribute("website");
    String biografia = (String)request.getAttribute("biografia");
    String descripcion = (String)request.getAttribute("descripcion");
    
    List<ActividadDTO> listAct = new ArrayList<>();
    try {
        listAct = (List<ActividadDTO>)request.getAttribute("actividades");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>

=======
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
<!DOCTYPE html>
<html class="h-full">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil Profesor Propio</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" rel="stylesheet">
    </head>
    <body class="w-screen h-full flex flex-col sm:items-start sm:justify-start">
        <%--  COMENTADO PORQUE EL HEADER AÚN NO ES RESPONSIVE.
        <jsp:include page='../components/header.jsp' >
            <jsp:param name="path" value="perfilProfesor" />
        </jsp:include>
        --%>
        
        <div class="flex flex-col lg:flex-row h-max p-6 md:p-8 gap-x-8 w-screen md:flex-nowrap flex-wrap">
            <div class="flex flex-col items-center h-max">
                <img class="rounded-full" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="Imagen Profesor"/>
<<<<<<< HEAD
                <p class="text-[#595E67] text-5xl"><%=nombre%></p>
=======
                <p class="text-[#595E67] text-5xl">Pepe</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                <p class="text-[#959EB0] text-2xl">Profesor</p>
            </div>

            <div class="flex flex-col sm:justify-between border container h-max shadow sm:overflow-hidden rounded-2xl lg:flex-row bg-gray-50 flex-wrap mx-auto">
                <div class="flex flex-col w-auto px-6 py-4 h-max">
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 5C12 7.20914 10.2091 9 8 9C5.79086 9 4 7.20914 4 5C4 2.79086 5.79086 1 8 1C10.2091 1 12 2.79086 12 5Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M8 12C4.13401 12 1 15.134 1 19H15C15 15.134 11.866 12 8 12Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
<<<<<<< HEAD
                        <p class="font-[Inter] text-base text-gray-500"><%=nombre + " " +  apellido%></p>
=======
                        <p class="font-[Inter] text-base text-gray-500">Manuel Diu</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 4L8.8906 9.2604C9.5624 9.70827 10.4376 9.70827 11.1094 9.2604L19 4M3 15H17C18.1046 15 19 14.1046 19 13V3C19 1.89543 18.1046 1 17 1H3C1.89543 1 1 1.89543 1 3V13C1 14.1046 1.89543 15 3 15Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
<<<<<<< HEAD
                        <p class="font-[Inter] text-base text-gray-500"><%=correo%></p>
=======
                        <p class="font-[Inter] text-base text-gray-500">ricardo.cooper@example.com</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17 19V3C17 1.89543 16.1046 1 15 1H5C3.89543 1 3 1.89543 3 3V19M17 19L19 19M17 19H12M3 19L1 19M3 19H8M7 4.99998H8M7 8.99998H8M12 4.99998H13M12 8.99998H13M8 19V14C8 13.4477 8.44772 13 9 13H11C11.5523 13 12 13.4477 12 14V19M8 19H12" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
<<<<<<< HEAD
                        <p class="font-[Inter] text-base text-gray-500"><%=institucion%></p>
=======
                        <p class="font-[Inter] text-base text-gray-500">Institucion</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 5V1M14 5V1M5 9H15M3 19H17C18.1046 19 19 18.1046 19 17V5C19 3.89543 18.1046 3 17 3H3C1.89543 3 1 3.89543 1 5V17C1 18.1046 1.89543 19 3 19Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
<<<<<<< HEAD
                        <p class="font-[Inter] text-base text-gray-500"><%=fnacimiento%></p>
=======
                        <p class="font-[Inter] text-base text-gray-500">Fecha de nacimiento</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15.1716 7L8.58579 13.5858C7.80474 14.3668 7.80474 15.6332 8.58579 16.4142C9.36684 17.1953 10.6332 17.1953 11.4142 16.4142L17.8284 9.82843C19.3905 8.26633 19.3905 5.73367 17.8284 4.17157C16.2663 2.60948 13.7337 2.60948 12.1716 4.17157L5.75736 10.7574C3.41421 13.1005 3.41421 16.8995 5.75736 19.2426C8.1005 21.5858 11.8995 21.5858 14.2426 19.2426L20.5 13" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
<<<<<<< HEAD
                        <p class="font-[Inter] text-base text-gray-500"><%=website%></p>
=======
                        <p class="font-[Inter] text-base text-gray-500">www.miweb.com</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                    </div>
                </div>

                <%-- CARDS TOTAL FOLLOWS & FOLLOWING --%>
                <div class="flex gap-x-2 flex-row lg:flex-col pb-5 px-1 w-full lg:w-52 lg:pr-4 lg:gap-y-4 self-center md:justify-between">   <%-- ANTES: class="flex gap-x-2 sm:flex-col px-5 py-5 mx-10 sm:w-80 justify-between" --%>
                    <div class="item container shadow border rounded-xl bg-white p-3">
                        <div class="max-w-40">
                            <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Followers</p>
<<<<<<< HEAD
                            <p class="font-[Inter] text-3xl font-bold"><%=cantSeguidores%></p> 
=======
                            <p class="font-[Inter] text-3xl font-bold">71,897</p> 
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                        </div>
                    </div>
                    <div class="item container shadow border rounded-xl bg-white p-3 max-h-24">
                        <div>
                            <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Following</p>
<<<<<<< HEAD
                            <p class="font-[Inter] text-3xl font-bold"><%=cantSeguidos%></p>
=======
                            <p class="font-[Inter] text-3xl font-bold">1,250</p>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                        </div>
                    </div>
                </div>
            </div>


            <%-- MODIFY INFO SECTION --%>
            <div class="mx-auto flex flex-col w-2/6 min-w-max h-max mt-2 lg:mt-0 gap-y-5">
                    <button class="font-[Inter] font-medium bg-[#DFD9A4] hover:bg-[#EBE5B5] text-black p-4 rounded-md">
                    Editar Información
                </button>
                <button class="font-[Inter] font-medium bg-[#3A5A6E] hover:bg-[#50758C] text-white p-4 rounded-md">
                    Cambiar Foto de Perfil
                </button>
                <button class="font-[Inter] font-medium bg-[#C56969] hover:bg-[#F38282] text-white p-4 rounded-md" onclick="">
                    Cerrar Sesión
                </button>

            </div>


        </div>

        <div class="flex flex-col lg:flex-row gap-8 p-6 md:p-8 w-full">
            <div class="flex lg:flex-col gap-8 mx-auto flex-wrap justify-center">
<<<<<<< HEAD
                <textarea id="biografia" rows="8" class="block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="No tengo biografía!"><%=biografia%></textarea>
                <textarea id="descripcion" rows="12" class="block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="No tengo descripcion!"><%=descripcion%></textarea>
=======
                <textarea id="biografia" rows="8" class="block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="Biografía."></textarea>
                <textarea id="descripcion" rows="12" class="block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="Descripcion."></textarea>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
            </div>

            <div class="overflow-x-auto relative shadow-md sm:rounded-lg h-max w-full">
                <table class="w-full text-sm text-left text-gray-500 ">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 ">
                        <tr>
                            <th scope="col" class="py-3 px-6">
                                Actividad
                            </th>
                            <th scope="col" class="py-3 px-6">
                                Fecha Alta
                            </th>
                            <th scope="col" class="py-3 px-6">
                                Duración (mins)
                            </th>
                            <th scope="col" class="py-3 px-6">
                                Estado
                            </th>
                        </tr>
                    </thead>
                    <tbody>
<<<<<<< HEAD
                        
                    <%-- ForEach Actividades --%>
                    <%
                        for (ActividadDTO item : listAct) {
                        System.out.println(listAct.size());
                    %>
                        <tr class="bg-white border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                <%=item.getNombre()%>
                            </th>
                            <td class="py-4 px-6">
                                <%=item.getFechaRegistro()%>
                            </td>
                            <td class="py-4 px-6">
                                <%=item.getDuracion()%>
                            </td>
                            <td class="py-4 px-6">
                                <%-- Badge Aceptada --%>
                                <%
                                        if( item.getEstado().equals("Aceptada") ){
                                %>
                                        <span class="bg-green-100 text-green-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-green-200 dark:text-green-900">
                                            Aceptada
                                        </span>
                                <%
                                        }
                                %>

                                <%-- Badge Ingresada --%>
                                <%
                                        if( item.getEstado().equals("Ingresada") ){
                                %>
                                        <span class="bg-yellow-100 text-yellow-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-yellow-200 dark:text-yellow-900">
                                            Ingresada
                                        </span>
                                <%
                                        }
                                %>

                                <%-- Badge Rechazada --%>
                                <%
                                        if( item.getEstado().equals("Rechazada") ){
                                %>
                                        <span class="bg-red-100 text-red-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-red-200 dark:text-red-900">
                                            Rechazada
                                        </span>
                                <%
                                        }
                                %>            
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>  
=======
                        <tr class="bg-white border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                Natación
                            </th>
                            <td class="py-4 px-6">
                                10/09/2022
                            </td>
                            <td class="py-4 px-6">
                                240
                            </td>
                            <td class="py-4 px-6">
                                <span class="bg-red-100 text-red-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-red-200 dark:text-red-900">
                                    Rechazada
                                </span>
                            </td>
                        </tr>
                        <tr class="bg-gray-50 border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                Boxeo
                            </th>
                            <td class="py-4 px-6">
                                10/09/2022
                            </td>
                            <td class="py-4 px-6">
                                320
                            </td>
                            <td class="py-4 px-6">
                                <span class="bg-yellow-100 text-yellow-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-yellow-200 dark:text-yellow-900">
                                    Ingresada
                                </span>
                            </td>
                        </tr>
                        <tr class="bg-white border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap ">
                                Atletismo
                            </th>
                            <td class="py-4 px-6">
                                10/09/2022
                            </td>
                            <td class="py-4 px-6">
                                120
                            </td>
                            <td class="py-4 px-6">
                                <span class="bg-green-100 text-green-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-green-200 dark:text-green-900">
                                    Aceptada
                                </span>
                            </td>
                        </tr>
                        <tr class="bg-gray-50 border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                Pesas
                            </th>
                            <td class="py-4 px-6">
                                10/09/2022
                            </td>
                            <td class="py-4 px-6">
                                60
                            </td>
                            <td class="py-4 px-6">
                                <span class="bg-green-100 text-green-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-green-200 dark:text-green-900">
                                    Aceptada
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                Ciclismo
                            </th>
                            <td class="py-4 px-6">
                                10/09/2022
                            </td>
                            <td class="py-4 px-6">
                                240
                            </td>
                            <td class="py-4 px-6">
                                <span class="bg-yellow-100 text-yellow-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-yellow-200 dark:text-yellow-900">
                                    Ingresada
                                </span>
                            </td>
                        </tr>
                    </tbody>
>>>>>>> a529be1330cca3d5a4e583064cff8b28e12ba0dd
                </table>
            </div>
        </div>
        
        <%-- 
        <jsp:include page='../components/comprarCuponeraModal.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>       
        --%>
             
        <%-- 
            <jsp:include page='../components/editarInfoProfesorModal.jsp' >
                <jsp:param name="path" value="index" />
            </jsp:include>       
        --%>
    </body>
</html>
