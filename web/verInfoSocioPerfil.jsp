<%-- 
    Document   : verInfoSocioPerfil
    Created on : 2 oct. 2022, 14:50:35
    Author     : pedri
--%>
<%@page import="Clase.DtClase"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Usuario.dtos.UsuarioDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="Cuponera.DtCuponera"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%@ page import="util.BlobToImage" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int cantSeguidores = (int) request.getAttribute("cantSeguidores");
    int cantSeguidos = (int) request.getAttribute("cantSeguidos");

    List<DtClase> listClasesOfUser = new ArrayList<>();
    List<ActividadDTO> actividadesOfUser = new ArrayList<>();
    UsuarioDTO userDT = (UsuarioDTO) request.getAttribute("userDT");
    String nombre = (String) request.getAttribute("nombre");
    String apellido = (String) request.getAttribute("apellido");
    String nickname = (String) request.getAttribute("nickname");
    String correo = (String) request.getAttribute("correo");
    String institucion = (String) request.getAttribute("institucion");
    String fnacimiento = (String) request.getAttribute("fnacimiento");
    String biografia = (String) request.getAttribute("biografia");
    String descripcion = (String) request.getAttribute("descripcion");

    if (request.getAttribute("listClasesOfUser") != null) {
        listClasesOfUser = (List<DtClase>) request.getAttribute("listClasesOfUser");
    }

    if (request.getAttribute("actividadesOfUser") != null) {
        actividadesOfUser = (List<ActividadDTO>) request.getAttribute("actividadesOfUser");
    }

    int idConsultado = (int) request.getAttribute("idConsultado");

    BlobToImage btimg = new BlobToImage();

    byte[] imageBlob = (byte[]) request.getAttribute("imagen");

    HashMap<Integer, DtCuponera> listCups = new HashMap<>();
    try {
        listCups = (HashMap<Integer, DtCuponera>) request.getAttribute("cuponeras");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>

<script>
    const handleGetClase = (itemId) => {
        const url = '/entrenamosUY34//claseById?claseId=' + itemId;
        const claseModal = document.getElementById("infoClaseModal");
        if (window.claseInfo !== "Loading") {
            window.claseInfo = "Loading";
            claseModal.onload();

            if (document.getElementById("seleccionarMedioPagoModal")) {
                document.getElementById("seleccionarMedioPagoModal").style.cssText = "display: none!important;"

            }

            window.fetch(url).then((response) => {
                return response.json();
            }).then((data) => {
                claseModal.style.cssText = "display: flex";
                window.claseInfo = data;

                claseModal.onload();
            }).catch((err) => {
                console.log(err);
                window.claseInfo = "Error";
            });
        }

    }
    
    const handleGetCuponera = (itemId) => {
        const url = '/entrenamosUY34//cuponeraById?cupId=' + itemId;
        const cuponeraModal = document.getElementById("cuponeraInfoModal");
        window.cuponeraInfo = "Loading";
        cuponeraModal.style.cssText = "display: flex";
        cuponeraModal.onload();
        window.fetch(url).then((response) => {
            return response.json();
        }).then((data) => {
            cuponeraModal.style.cssText = "display: flex";
            window.cuponeraInfo = data;
            cuponeraModal.onload();
        }).catch((err) => {
            console.log(err);
            window.cuponeraInfo = "Error";
        });
    }
</script>

<!DOCTYPE html>
<html>
    <jsp:include page='/components/infoClaseModal.jsp' />
    <jsp:include page='/components/selectedCuponeraInfo.jsp' />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil Propio Socio</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" rel="stylesheet">
    </head>
                        <script>
                            const handleEditInfo = () => {
                                const editarInfoModal = document.getElementById("editarInfoSocioModal");
                                editarInfoModal.style.cssText = "display: flex";
                            };
                        </script>
                        <jsp:include page='/components/header.jsp' >
                            <jsp:param name="path" value="index" />
                        </jsp:include>
                        <body class="w-screen h-full flex flex-col sm:items-start sm:justify-start">


                            <div class="flex flex-col lg:flex-row h-max p-6 md:p-8 gap-x-8 w-screen md:flex-nowrap flex-wrap">
                                <div class="flex flex-col items-center h-max">
                                    <img src="<%=btimg.getBase64StringImage(imageBlob)%>" alt="Girl in a jacket" class="rounded-full w-[180px] h-[180px] object-cover"/>
                                    <div class="font-[Inter] text-[#595E67] text-5xl font-normal gap-y-[25px] px-[33px]"><%= nombre%></div>
                                    <div class="font-[Inter] text-[#959EB0] text-2xl font-normal gap-y-[14px] px-[61px]">Socio</div>
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
                                            <svg class="mx-4" width="23" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M7 20L11 4M13 20L17 4M6 9H20M4 15H18" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <p class="font-[Inter] text-base text-gray-500"><%=nickname%></p>
                                        </div>
                                        <div class="flex py-2 items-center">
                                            <svg class="mx-4" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M6 5V1M14 5V1M5 9H15M3 19H17C18.1046 19 19 18.1046 19 17V5C19 3.89543 18.1046 3 17 3H3C1.89543 3 1 3.89543 1 5V17C1 18.1046 1.89543 19 3 19Z" stroke="#111827" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <p class="font-[Inter] text-base text-gray-500"><%=fnacimiento%></p>
                                        </div>
                                    </div>

                                    <%-- CARDS TOTAL FOLLOWS & FOLLOWING --%>
                                    <div class="flex gap-x-2 flex-row lg:flex-col py-5 px-1 w-full lg:w-52 lg:pr-4 lg:gap-y-4 self-center md:justify-between">
                                        <div class="item container shadow border rounded-xl bg-white p-3">
                                            <div class="max-w-40">
                                                <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Followers</p>
                                                <p class="font-[Inter] text-3xl font-bold"><%=cantSeguidores%></p> 
                                            </div>
                                        </div>
                                        <div class="item container shadow border rounded-xl bg-white p-3 max-h-24">
                                            <div>
                                                <p class="font-[Inter] text-sm text-gray-500 font-medium">Total Following</p>
                                                <p class="font-[Inter] text-3xl font-bold"><%=cantSeguidos%></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- MODIFY INFO SECTION --%>
                                <div class="mx-auto flex flex-col w-2/6 min-w-max h-max mt-6 lg:mt-4 gap-y-5">
                                    <button onclick="handleEditInfo()" class="font-[Inter] font-medium bg-[#DFD9A4] hover:bg-[#EBE5B5] text-black p-4 rounded-md text-center">
                                        Editar Información
                                    </button>
                                    <a href="logout" class="text-center font-[Inter] font-medium bg-[#C56969] hover:bg-[#F38282] text-white p-4 rounded-md" onclick="">
                                        Cerrar Sesión
                                    </a>
                                </div>
                            </div>
                            <div class="flex flex-col items-center lg:items-start justify-center p-6 md:p-8 gap-y-4 lg:flex-row w-screen h-max lg:gap-x-12">
                                <div class="h-max w-5/6 lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium">ACTIVIDADES</p>
                                    </div>

                                    <%-- ForEach Actividades --%>
                                    <%
                                        for (ActividadDTO en : actividadesOfUser) {
                                            ActividadDTO val = en;
                                    %>
                                    <a href="verActividadInfo?actId=<%=val.getId()%>" class="h-[72px] cursor-pointer border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                                        <img src="<%=btimg.getBase64StringImage(val.getImageBlob())%>" alt="ActividadFoto" class="rounded-full w-[40px] h-[40px] object-cover"/>
                                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex flex-col item-start justify-start flex-col">
                                            <p class="text-base"><%=val.getNombre()%></p>
                                            <p class="text-sm">Institucion: <%=val.getInstitucion().getNombre()%></p>
                                        </div>
                                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                                    </a>
                                    <%
                                        }
                                    %>


                                </div>
                                <div class="h-max w-5/6 lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium ">CLASES</p>
                                    </div>

                                    <%-- ForEach Clases --%>
                                    <%
                                        for (DtClase en : listClasesOfUser) {
                                            DtClase val = en;
                                    %>
                                    <a onclick="handleGetClase('<%=val.getId()%>')" class="h-[72px] cursor-pointer border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                                        <img src="<%=btimg.getBase64StringImage(val.getImageBlob())%>" alt="Girl in a jacket" class="rounded-full w-[40px] h-[40px] object-cover"/>
                                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex flex-col item-start justify-start flex-col">
                                            <p><%=val.getNombre()%> (<%=val.getRegistros().size()%> Inscripto/s)</p>
                                            <p class="mt-1">Fecha: <%=val.getFecha()%></p>
                                        </div>
                                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                                    </a> 
                                    <%
                                        }
                                    %>


                                </div>

                                <div class="h-max w-5/6 lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium">CUPONERAS ADQUIRIDAS</p>
                                    </div>


                                    <%-- ForEach Cuponeras --%>
                                    <%
                                        for (HashMap.Entry<Integer, DtCuponera> en : listCups.entrySet()) {
                                            Integer key = en.getKey();
                                            DtCuponera val = en.getValue();
                                    %>
                                    <a onclick="handleGetCuponera('<%=val.getId()%>')" class="h-[72px] cursor-pointer border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                                        <img src="<%=btimg.getBase64StringImage(val.getBlobImage())%>" alt="Cup Image" class="rounded-full w-[40px] h-[40px] object-cover"/>
                                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex item-start justify-start flex-col">
                                            <%=val.getNombre()%>
                                            <p class="mt-1">Precio: <%=val.getPrecio()%></p>

                                        </div>
                                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                                    </a>    
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <jsp:include page='Socio/editarInfoSocioModal.jsp' >
                                <jsp:param name="path" value="index" />
                                <jsp:param name="usrIdConsultado" value="<%= idConsultado%>" />
                                <jsp:param name="nickname" value="<%= nickname%>" />
                                <jsp:param name="email" value="<%= userDT.getEmail()%>" />
                                <jsp:param name="institucion" value="<%= institucion%>" />
                                <jsp:param name="name" value="<%= nombre%>" />
                                <jsp:param name="lastname" value="<%= apellido%>" />
                                <jsp:param name="fnacimiento" value="<%= userDT.getNacimiento()%>" />
                                <jsp:param name="biografia" value="<%= biografia%>" />
                                <jsp:param name="description" value="<%= descripcion%>" />
                                <jsp:param name="utype" value="<%= userDT.getType()%>" />
                            </jsp:include>
                        </body>
                        </html>
