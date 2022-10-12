<%-- 
    Document   : actividadInfo
    Created on : 27 sept 2022, 23:37:11
    Author     : angel
--%>

<%@page import="java.util.Random"%>
<%@page import="util.BlobToImage"%>
<%@page import="Institucion.DtInstitucion"%>
<%@page import="CuponeraXActividad.DtCuponeraXActividad"%>
<%@page import="Clase.DtClase"%>
<%@page import="java.util.List"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Actividad.dtos.ActividadDetalleDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="Categoria.DtCategoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%
    String modalIsOpen = (String) request.getAttribute("modalIsOpen");
    String modalPagoOpen = (String) request.getAttribute("infoPagoModal");
    boolean openClaseModalInfo = modalIsOpen != null ? modalIsOpen.equals("true") : false;
    boolean openPagoModal = modalPagoOpen != null ? modalPagoOpen.equals("true") : false;

    BlobToImage btimg = new BlobToImage();
    ActividadDTO infoAct = (ActividadDTO) request.getAttribute("actInfo");
    List<DtCategoria> categoriasAct = infoAct.getCategorias();
    List<DtClase> clasesAct = infoAct.getClases();
    List<DtCuponeraXActividad> cuponerasXAct = infoAct.getCuponerasXActivdad();
    DtInstitucion instAct = infoAct.getInstitucion();

%>

<%!
    String getRandomColor() {
        Random obj = new Random();
        int rand_num = obj.nextInt(0xffffff + 1);
        // format it as hexadecimal string and print
        String colorCode = String.format("#%06x", rand_num);
        String randomColor = colorCode;
        return randomColor;
    }

%>

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

        <%            if (openClaseModalInfo) {
        %> 
        <jsp:include page='/components/infoClaseModal.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>
        <%
            }
        %>

        <%
            if (openPagoModal) {
        %> 
        <jsp:include page='/components/pagarClase.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>
        <%
            }
        %>

        <div class="w-full h-full flex-grow flex flex-col items-start justify-start px-20 my-8 gap-y-12">
            <div class="w-full h-[450px] flex flex-row items-center justify-between gap-x-20">
                <div class='w-[420px] h-full flex flex-col items-center justify-start gap-y-6'>
                    <img
                        src="<%=btimg.getBase64StringImage(infoAct.getImageBlob())%>"
                        class="w-full h-[300px] object-cover rounded-md overflow-hidden"
                        />

                    <p class="text-gray-900 text-xl font-medium pb-5 border-b w-full border-gray-300">Categorias</p>

                    <div class="w-full h-auto flex flex-row items-center justify-start gap-2 flex-wrap">

                        <% for (DtCategoria cat : categoriasAct) {
                                DtCategoria val = cat;

                        %>
                        <div class="w-auto h-6 flex items-center justify-center px-4 gap-x-2 bg-red-300 rounded-md " style="background: <%=getRandomColor()%>">
                            <span class="w-2 h-2 bg-red-600 rounded-full"></span>
                            <p class="text-sm font-medium text-white"><%=cat.getNombre()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class='w-full flex-grow h-full border border-gray-300 rounded-md shadow-md flex flex-col items-start justify-start p-6'>

                    <p class="py-5 border-b border-gray-300 w-full text-left">Nombre Actividad: <%=infoAct.getNombre()%></p>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Insttucion</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=instAct.getNombre()%></p>
                    </div>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Duracion</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=infoAct.getDuracion()%></p>
                    </div>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Fecha Alta</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=infoAct.getFechaRegistro()%></p>
                    </div>
                    <div class="flex w-full flex-row flex-grow items-start justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Descripcion</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=infoAct.getDescripcion()%></p>
                    </div>
                </div>
            </div>
            <%-- Solo si es socio --%>
            <div class="w-full h-auto flex flex-row items-center justify-end h-10 my-2">
                <p>Agregar</p>
            </div>
            <div class="w-full h-full min-h-[400px] flex-grow max-h-full overflow-auto flex flex-row items-start justify-center gap-x-16">

                <div class="w-full flex-grow h- rounded-md border border-gray-300 shadow-sm flex flex-col items-center bg-whit justify-start  overflow-hidden">
                    <div class="w-full flex flex-row items-center justify-start h-12 bg-gray-50 border-b border-gray-300 px-6">
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Cuponeras</p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Descripcion</p>
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium">Clases</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Descuento</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Status</p>
                    </div>


                    <% for (DtCuponeraXActividad cat : cuponerasXAct) {
                            DtCuponeraXActividad val = cat;
                    %>
                    <div class="w-full flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCuponera().getNombre()%></p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCuponera().getDescripcion()%></p>
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCantClases()%></p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCuponera().getDescuento()%></p>
                        <div class="w-[15%] h-auto text-sm font-medium">
                            <p class="bg-green-100 w-fit h-auto text-green-800 rounded-xl py-0.5 px-3 ">Activa</p>
                        </div>
                    </div>
                    <%
                        }
                    %>

                </div>


                <div class="w-full flex-grow h-full rounded-md border border-gray-300 shadow-sm flex flex-col items-center bg-whit justify-start overflow-hidden">
                    <div class="w-full flex flex-row items-center justify-start h-12 bg-gray-50 border-b border-gray-300 px-6">
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium">Clase</p>
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium">Profesor</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Min Socio</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Max Socio</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Inscriptos</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">Fecha</p>
                    </div>


                    <% for (DtClase clase : clasesAct) {
                    %>
                    <a href="verActividadInfo?actId=<%=infoAct.getId()%>&modalOpen=true&claseId=<%=clase.getId()%>" class="w-full flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                        <p class="w-[20%] h-auto tex%>')"t-sm text-gray-500 font-medium"><%=clase.getNombre()%></p>
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium"><%=clase.getProfesor()%></p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium"><%=clase.getCapMinima()%></p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium"><%=clase.getCapMaxima()%></p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium"><%=clase.getRegistros().size()%></p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium"><%=clase.getFecha().toLocaleString()%></p>
                    </a>
                    <%
                        }
                    %>
                </div>

            </div>
        </div>
    </body>
</html>
