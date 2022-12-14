<%-- 
    Document   : verInfoSocioPerfil
    Created on : 2 oct. 2022, 14:50:35
    Author     : pedri
--%>
<%@page import="ws.DtClase"%>
<%@page import="ws.DtCuponera"%>
<%@page import="ws.UsuarioDTO"%>
<%@page import="ws.ActividadDTO"%>
<%@page import="ws.DtRegistro"%>
<%@page import="ws.PremioDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
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

    List<PremioDTO> listadoPremiosUsuario = new ArrayList<>();
    List<DtRegistro> listRegistrosOfUser = new ArrayList<>();
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

    if (request.getAttribute("listRegistrosOfUserPropio") != null) {
        listRegistrosOfUser = (List<DtRegistro>) request.getAttribute("listRegistrosOfUserPropio");
    }

    if (request.getAttribute("premioOfuser") != null) {
        listadoPremiosUsuario = (List<PremioDTO>) request.getAttribute("premioOfuser");
    }

    System.out.println(listadoPremiosUsuario);

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
    }
%>

<script>
    const handleOpenPremioInfo = (premioId) => {
       const modalElement = document.getElementById("infoSorteoModal");
        if (modalElement != null) {
            const url = '/entrenamosUY3/premioById?premioId=' + premioId;
            window.fetch(url).then((response) => {
                return response.json();
            }).then((data) => {
                modalElement.style.cssText = "display: flex";
                modalElement.onload(data);
            }).catch((err) => {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Error al cargar el premio',
                    textContent: err?.message,
                    showConfirmButton: false,
                });
                window.cuponeraInfo = "Error";
            });
        }

    }
    const handleGetClase = (itemId, isOpen) => {
        const url = '/entrenamosUY3//RegistroById?registroId=' + itemId;
        const claseModal = document.getElementById("infoClaseModal");
        console.log("xd")
        if (window.registroInfo !== "Loading") {
            window.registroInfo = "Loading";
            window.claseInfo = "Loading";
            claseModal.onload();
            if (document.getElementById("seleccionarMedioPagoModal")) {
                document.getElementById("seleccionarMedioPagoModal").style.cssText = "display: none!important;"
            }
            
            window.fetch(url).then((response) => {
                return response.json();
            }).then((data) => {
                console.log(data);
                claseModal.style.cssText = "display: flex";
                
                window.claseInfo = data.clase;
                window.registroInfo = data;
                window.isProfesorDeClaseAndYaPaso = data.isProfesorDeClaseAndYaPaso;
                window.registroInfo = data;
                claseModal.onload(isOpen, data?.resultados || []);
            }).catch((err) => {
                console.log(err);
                window.registroInfo = "Error";
            });
        }

    }

    const handleGetCuponera = (itemId) => {
        const url = '/entrenamosUY3//cuponeraById?cupId=' + itemId;
        const cuponeraModal = document.getElementById("cuponeraInfoModal");
        window.cuponeraInfo = "Loading";
        cuponeraModal.style.cssText = "display: flex";
        console.log("event is ", cuponeraModal.onload)
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
    <jsp:include page='/components/premioInfo.jsp' />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Perfil Propio Socio</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" rel="stylesheet">
                        <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
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
                                        Editar Informaci??n
                                    </button>
                                    <a href="logout" class="text-center font-[Inter] font-medium bg-[#C56969] hover:bg-[#F38282] text-white p-4 rounded-md" onclick="">
                                        Cerrar Sesi??n
                                    </a>
                                </div>
                            </div>
                            <div class="gap-6 grid md:grid-cols-2 grid-cols-1 items-start lg:items-start justify-center p-6 md:p-8 gap-y-4 lg:flex-row w-screen h-max lg:gap-x-12">
                                <div class="h-max m-auto flex-grow lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium">ACTIVIDADES</p>
                                    </div>

                                    <%
                                        if (actividadesOfUser.size() == 0) {
                                    %>
                                    <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                                        <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                                        <p class="text-gray-800 font-medium text-base">??No encontramos ninguna Actividad!</p>
                                    </div>
                                    <%
                                    } else {
                                    %>


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
                                        }
                                    %>


                                </div>
                                <div class="h-max m-auto flex-grow lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium ">REGISTROS A CLASES (ACT. DEPORTIVA FINALIZADA)</p>
                                    </div>
                                    <%
                                        if (listRegistrosOfUser.size() == 0) {
                                    %>
                                    <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                                        <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                                        <p class="text-gray-800 font-medium text-base">??No encontramos ning??n Registro a Clase, con Actividad finalizada!</p>
                                    </div>
                                    <%
                                    } else {
                                    %>
                                    <%-- ForEach Clases --%>
                                    <%
                                        for (DtRegistro en : listRegistrosOfUser) {
                                            DtClase val = en.getClase();
                                            
                                            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
                                            String dateRegistro = DATE_FORMAT.format(val.getFecha().toGregorianCalendar().getTime());
                                    %>
                                    <a onclick="handleGetClase('<%= en.getId()%>', true)" class="h-[72px] cursor-pointer border-b-[1px] flex flex-row items-center justify-start py-[16px] px-[24px] gap-x-[16px]">
                                        <img src="<%=btimg.getBase64StringImage(val.getImageBlob())%>" alt="Girl in a jacket" class="rounded-full w-[40px] h-[40px] object-cover"/>
                                        <div class="text-gray-500 text-[12px] font-medium flex-grow h-full flex flex-col item-start justify-start flex-col">
                                            <p><%=val.getNombre()%> (<%=val.getRegistros().size()%> Inscripto/s)</p>
                                            <p class="mt-1">Fecha: <%=dateRegistro%></p>
                                        </div>
                                        <button class="border border-gray-300 py-[1px] px-[10px] rounded-[14px] font-medium text-[14px] text-gray-700 shadow-sm">View</button>
                                    </a> 
                                    <%
                                            }
                                        }
                                    %>


                                </div>

                                <div class="h-max m-auto flex-grow lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium">CUPONERAS ADQUIRIDAS</p>
                                    </div>

                                    <%
                                        if (listCups.size() == 0) {
                                    %>
                                    <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                                        <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                                        <p class="text-gray-800 font-medium text-base">??No encontramos ninguna Cuponera!</p>
                                    </div>
                                    <%
                                    } else {
                                    %>
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
                                        }
                                    %>
                                </div>


                                <div class="h-max m-auto flex-grow lg:w-[500px] rounded-[28px] shadow-md flex flex-col items-stretch justify-start overflow-hidden">
                                    <div class="bg-gray-200 px-[24px] py-[12px]">
                                        <p class="text-gray-500 text-[12px] font-medium">Premios Ganados</p>
                                    </div>

                                    <%
                                        if (listadoPremiosUsuario.size() == 0) {
                                    %>
                                    <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                                        <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                                        <p class="text-gray-800 font-medium text-base">??No encontramos ningun premio!</p>
                                    </div>
                                    <%
                                    } else {
                                    %>
                                    <%-- ForEach Premios --%>
                                    <%
                                        for (PremioDTO en : listadoPremiosUsuario) {
                                    %>
                                    <div class="w-full px-4 py-4 gap-y-2 border-b pb-2 shadow h-auto flex flex-row items-center justify-start">
                                        <img src="https://st2.depositphotos.com/4320929/12352/v/600/depositphotos_123521904-stock-illustration-man-holding-trophy-cup.jpg" class="w-16 h-16 min-w-[64px] min-h-[64px] rounded-full overflow-hidden" />
                                        <div class="flex flex-grow flex-col gap-y-1 w-full h-auto items-start justify-center pl-6">
                                            <p class="text-black font-medium text-sm">Premio: <%=en.getDescripcion()%></p>
                                            <p class="text-black font-medium text-sm">Sorteado: <%=en.getFechaCreacion()%></p>
                                            <p class="text-black font-medium text-sm">Clase: <%=en.getClase().getNombre()%></p>

                                            <p onclick="handleOpenPremioInfo('<%=en.getId()%>')" id="verMasAboutPremio" class="text-indigo-900 cursor-pointer mt-2 underline text-sm font-medium">Ver mas</p>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            <jsp:include page='Socio/editarInfoSocioModal.jsp' >
                                <jsp:param name="path" value="index" />
                                <jsp:param name="usrIdConsultado" value="<%= idConsultado%>" />
                                <jsp:param name="nickname" value="<%= nickname%>" />
                                <jsp:param name="email" value="<%= userDT.getEMAIL()%>" />
                                <jsp:param name="institucion" value="<%= institucion%>" />
                                <jsp:param name="name" value="<%= nombre%>" />
                                <jsp:param name="lastname" value="<%= apellido%>" />
                                <jsp:param name="fnacimiento" value="<%= fnacimiento%>" />
                                <jsp:param name="biografia" value="<%= biografia%>" />
                                <jsp:param name="description" value="<%= descripcion%>" />
                                <jsp:param name="utype" value="<%=typeofUser %>" />
                            </jsp:include>
                        </body>
                        </html>
