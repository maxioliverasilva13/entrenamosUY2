<%-- 
    Document   : perfilProfesorAjeno
    Created on : 30 set. 2022, 12:14:44
    Author     : mandi
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.BlobToImage"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<jsp:include page='../imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //int cantSeguidores = (int) request.getAttribute("cantSeguidores");
    //int cantSeguidos = (int) request.getAttribute("cantSeguidos");

    String userType = (String) request.getAttribute("userType");
    String nombre = (String) request.getAttribute("nombre");
    String apellido = (String) request.getAttribute("apellido");
    String correo = (String) request.getAttribute("correo");
    String institucion = (String) request.getAttribute("institucion");
    String fnacimiento = (String) request.getAttribute("fnacimiento");
    String website = (String) request.getAttribute("website");
    String biografia = (String) request.getAttribute("biografia");
    String descripcion = (String) request.getAttribute("descripcion");

    int idConsultado = (int) request.getAttribute("idConsultado");

    
    BlobToImage btimg = new BlobToImage();
    
    byte[] imageBlob = (byte[])request.getAttribute("imagen");
    
    boolean sigoAlConsultado = false;
    boolean userNotLogged = false;
    if (request.getAttribute("sigoAlConsultado") != null){
        sigoAlConsultado = (boolean)request.getAttribute("sigoAlConsultado");
    }
    
    if (request.getAttribute("userNotLogged") != null){
        userNotLogged = (boolean)request.getAttribute("userNotLogged");
    }
    
    HashMap<Integer, ActividadDTO> listAct = new HashMap<>();
    try {
        listAct = (HashMap<Integer, ActividadDTO>) request.getAttribute("actividades");
    } catch (Exception e) {
    }
%>

<script>
    window.addEventListener('load',()=>{
        const urlParams = new URLSearchParams(window.location.search);
        const userId = urlParams.get('userID');
        const url = '/entrenamosUY3//getPuntuacionesByProfesor?profId=' + userId;
        
     
        fetch(url).then(response =>response.json()).then(data =>{
            $("#meanPuntuacion").text(data.meanPuntuacion );
            printMeanStars(data.meanPuntuacion);
            
            console.log(data);
            
            printStarsForPercentage(
                    data.percentageOne,
                    data.percentageTwo,
                    data.percentageThree,
                    data.percentageFour,
                    data.percentageFive)
            
            
            $("#containerScores").removeClass("hidden");
            $("#loadingScores").addClass("hidden");
            
   
        })
        
        
       
        function printMeanStars(cantStars){
            const roundedCantStars = Math.round(cantStars);
            for(let i = 0; i < roundedCantStars; i++){
                
                $("#star"+(i+1)).addClass("text-yellow-400");
            }
        }
        
        function printStarsForPercentage(percentageOne,percentageTwo,percentageThree,percentageFour,percentageFive){
            $("#oneStarPercentage").css("width",percentageOne+"%")
            $("#twoStarPercentage").css("width",percentageTwo+"%")
            $("#threeStarPercentage").css("width",percentageThree+"%")
            $("#fourStarPercentage").css("width",percentageFour+"%")
            $("#fiveStarPercentage").css("width",percentageFive+"%")
            
            $("#oneStarText").text(percentageOne+"%");
            $("#twoStarText").text(percentageTwo+"%");
            $("#threeStarText").text(percentageThree+"%");
            $("#fourStarText").text(percentageFour+"%");
            $("#fiveStarText").text(percentageFive+"%");
            
            
        }

        
        
        
    })
 </script>


<!DOCTYPE html>
<html class="h-full">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil Profesor Ajeno</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" rel="stylesheet">
    </head>
    <jsp:include page='../components/header.jsp' >
        <jsp:param name="path" value="perfilProfesor" />
    </jsp:include>
    <body class="w-screen h-full flex flex-col sm:items-start sm:justify-start">

        <div class="flex flex-col lg:flex-row h-max p-6 md:p-8 gap-x-8 w-screen md:flex-nowrap flex-wrap">
            <div class="flex flex-col items-center h-max">
                <img class="rounded-full w-[180px] h-[180px] max-w-[180px] max-h-[180px] object-cover" src="<%=btimg.getBase64StringImage(imageBlob)%>" alt="Imagen Profesor"/>
                <p class="text-[#595E67] text-5xl"><%=nombre%></p>
                <p class="text-[#959EB0] text-2xl">Profesor</p>
            </div>

            <div class="flex flex-col sm:justify-between border container h-max shadow sm:overflow-hidden rounded-2xl lg:flex-row bg-gray-50 flex-wrap mx-auto">
                <div class="flex flex-col w-auto px-6 py-4 h-max">
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 5C12 7.20914 10.2091 9 8 9C5.79086 9 4 7.20914 4 5C4 2.79086 5.79086 1 8 1C10.2091 1 12 2.79086 12 5Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M8 12C4.13401 12 1 15.134 1 19H15C15 15.134 11.866 12 8 12Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p class="font-[Inter] text-base text-gray-500"><%=nombre + " " + apellido%></p>
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 4L8.8906 9.2604C9.5624 9.70827 10.4376 9.70827 11.1094 9.2604L19 4M3 15H17C18.1046 15 19 14.1046 19 13V3C19 1.89543 18.1046 1 17 1H3C1.89543 1 1 1.89543 1 3V13C1 14.1046 1.89543 15 3 15Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p class="font-[Inter] text-base text-gray-500"><%=correo%></p>
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17 19V3C17 1.89543 16.1046 1 15 1H5C3.89543 1 3 1.89543 3 3V19M17 19L19 19M17 19H12M3 19L1 19M3 19H8M7 4.99998H8M7 8.99998H8M12 4.99998H13M12 8.99998H13M8 19V14C8 13.4477 8.44772 13 9 13H11C11.5523 13 12 13.4477 12 14V19M8 19H12" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p class="font-[Inter] text-base text-gray-500"><%=institucion%></p>
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 5V1M14 5V1M5 9H15M3 19H17C18.1046 19 19 18.1046 19 17V5C19 3.89543 18.1046 3 17 3H3C1.89543 3 1 3.89543 1 5V17C1 18.1046 1.89543 19 3 19Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p class="font-[Inter] text-base text-gray-500"><%=fnacimiento%></p>
                    </div>
                    <div class="flex py-2 items-center">
                        <svg class="mx-4" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15.1716 7L8.58579 13.5858C7.80474 14.3668 7.80474 15.6332 8.58579 16.4142C9.36684 17.1953 10.6332 17.1953 11.4142 16.4142L17.8284 9.82843C19.3905 8.26633 19.3905 5.73367 17.8284 4.17157C16.2663 2.60948 13.7337 2.60948 12.1716 4.17157L5.75736 10.7574C3.41421 13.1005 3.41421 16.8995 5.75736 19.2426C8.1005 21.5858 11.8995 21.5858 14.2426 19.2426L20.5 13" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p class="font-[Inter] text-base text-gray-500"><%=website%></p>
                    </div>
                </div>

                <%-- CARDS TOTAL FOLLOWS & FOLLOWING --%>
                <div class="flex gap-x-2 flex-row lg:flex-col pb-5 px-1 w-full lg:w-52 lg:pr-4 lg:gap-y-4 self-center md:justify-between">   <%-- ANTES: class="flex gap-x-2 sm:flex-col px-5 py-5 mx-10 sm:w-80 justify-between" --%>
                    <div class="item container shadow border rounded-xl bg-white p-3">
                        <div class="max-w-40">
                            <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Followers</p>
                            <p id="followers" class="font-[Inter] text-3xl font-bold">0</p> 
                        </div>
                    </div>
                    <div class="item container shadow border rounded-xl bg-white p-3 max-h-24">
                        <div>
                            <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Following</p>
                            <p id="following" class="font-[Inter] text-3xl font-bold">0</p>
                        </div>
                    </div>
                </div>
            </div>
                        
            <%-- LAST ONLINE & FOLLOW BUTTON --%>
            <div class="mx-auto flex flex-col w-2/6 min-w-max h-max mt-2 lg:mt-0">
                <div class="flex flex-col container pt-2 pb-5 h-max text-center shadow border rounded-xl">
                    <p class="text-[#6B7280] text-4xl font-[Inter] font-medium">Last Online</p>
                    <p class="text-7xl text-[#3A5A6F] font-[Inter] font-extrabold">24/7</p>
                </div>
                    <%
                    //Si no hay sesion (loggedUser), no le muestro el boton de follow. (Otra opción seria si mostrarlo, pero redirigirlo al login).
                    if (!userNotLogged){
                    %>
                    <button hidden="true" onclick="followUser('<%= idConsultado %>')" id="btnUnfollow" class="font-[Inter] font-medium bg-red-500 hover:bg-red-400 text-white mt-8 p-4 rounded-md w-full">
                        Unfollow
                    </button>
                    <button hidden="true" onclick="followUser('<%= idConsultado %>')" id="btnFollow" class="font-[Inter] font-medium bg-[#3A5A6E] hover:bg-[#50758C] text-white mt-8 p-4 rounded-md w-full">
                        Follow
                    </button>
                    <%
                        }
                    %>
            </div>


        </div>

        <div class="flex flex-col lg:flex-row gap-8 p-6 pt-0 lg:p-8 lg:py-0 w-full">
            <div class="flex lg:flex-col gap-4 mx-auto flex-wrap justify-center">
                <div>
                    <p class="font-[Inter] text-lg">Biografia</p>
                    <textarea readonly id="biografia" rows="8"  class="max-h-[200px] block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="No tengo biografía!"><%=biografia%></textarea>
                </div>
                <div>
                    <p class="font-[Inter] text-lg">Descripción</p>
                    <textarea readonly id="descripcion" rows="12" class="max-h-[260px] block p-2.5 w-64 md:w-80 text-sm text-gray-900 bg-white rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500" placeholder="No tengo descripcion!"><%=descripcion%></textarea>
                </div>
            </div>

            <div class="overflow-x-auto relative shadow-md sm:rounded-lg h-max w-full">
            <%
                if (listAct.size() == 0){
                %>
                    <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                        <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                        <p class="text-gray-800 font-medium text-base">¡No encontramos ninguna Actividad!</p>
                    </div>
                <%
                }else{
            %>
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
                        <%-- ForEach Actividades --%>
                        <%
                            for (HashMap.Entry<Integer, ActividadDTO> en : listAct.entrySet()) {
                                Integer key = en.getKey();
                                ActividadDTO val = en.getValue();
                                
                                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                                String dateRegistro = DATE_FORMAT.format(val.getFechaRegistro());
                        %>
                        <tr class="bg-white border-b ">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                <%=val.getNombre()%>
                            </th>
                            <td class="py-4 px-6">
                                <%=dateRegistro%>
                            </td>
                            <td class="py-4 px-6">
                                <%=val.getDuracion()%>
                            </td>
                            <td class="py-4 px-6 space-x-5 space-y-6">
                                <%-- Badge Aceptada --%>
                                <%
                                    if (val.getEstado().equals("Aceptada")) {
                                %>
                                <span class="bg-green-100 text-green-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl dark:bg-green-200 dark:text-green-900">
                                    Aceptada
                                </span>
                                <a href="verActividadInfo?actId=<%= val.getId() %>">
                                    <i class="fa-solid fa-chevron-right text-gray-900 cursor-pointer px-4"></i>
                                </a>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
                    <div class="flex w-full  mt-10 p-6">
                        <div class="w-full flex justify-center" id="loadingScores">
                            <div role="status">
                            <svg aria-hidden="true" class="mr-2 w-12 h-12 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                            </svg>
                            <span class="sr-only">Loading...</span>
                          </div>
                        </div>
                         
                         <div class="w-full hidden" id="containerScores">
                            <div class="flex items-center mb-3">
                                <svg id="star1" aria-hidden="true" class="w-5 h-5 " fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>First star</title><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg id="star2" aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Second star</title><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg id="star3" aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Third star</title><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg id="star4" aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Fourth star</title><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg id="star5" aria-hidden="true" class="w-5 h-5 " fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Fifth star</title><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <p class="ml-2 text-sm font-medium text-gray-900 dark:text-white" id="meanPuntuacion"></p>
                            </div>
                            
                            <div class="flex items-center mt-4">
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500">5 star</span>
                                <div class="w-2/4 h-5 mx-4 bg-gray-200 rounded dark:bg-gray-700">
                                    <div class="h-5  bg-yellow-400 rounded"  id="fiveStarPercentage"></div>
                                </div>
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500" id="fiveStarText">70%</span>
                            </div>
                            <div class="flex items-center mt-4">
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500">4 star</span>
                                <div class="w-2/4 h-5 mx-4 bg-gray-200 rounded dark:bg-gray-700">
                                    <div class="h-5 bg-yellow-400 rounded"  id="fourStarPercentage"></div>
                                </div>
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500" id="fourStarText">17%</span>
                            </div>
                            <div class="flex items-center mt-4">
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500">3 star</span>
                                <div class="w-2/4 h-5 mx-4 bg-gray-200 rounded dark:bg-gray-700">
                                    <div class="h-5 bg-yellow-400 rounded"  id="threeStarPercentage"></div>
                                </div>
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500" id="threeStarText">8%</span>
                            </div>
                            <div class="flex items-center mt-4">
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500">2 star</span>
                                <div class="w-2/4 h-5 mx-4 bg-gray-200 rounded dark:bg-gray-700">
                                    <div class="h-5 bg-yellow-400 rounded"  id="twoStarPercentage"></div>
                                </div>
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500" id="twoStarText">4%</span>
                            </div>
                            <div class="flex items-center mt-4">
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500">1 star</span>
                                <div class="w-2/4 h-5 mx-4 bg-gray-200 rounded dark:bg-gray-700">
                                    <div class="h-5 bg-yellow-400 rounded"  id="oneStarPercentage"></div>
                                </div>
                                <span class="text-sm font-medium text-blue-600 dark:text-blue-500" id="oneStarText">1%</span>
                            </div>   
                            </div>  
                    </div>
        
     </body>
    
</html>
