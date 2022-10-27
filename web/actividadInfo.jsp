<%-- 
    Document   : actividadInfo
    Created on : 27 sept 2022, 23:37:11
    Author     : angel
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Cuponera.DtCuponera"%>
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
    boolean showAddClassButton = false;

    if (request.getAttribute("showAddClassButton") != null) {
        showAddClassButton = (boolean) request.getAttribute("showAddClassButton");
    }

    BlobToImage btimg = new BlobToImage();
    ActividadDTO infoAct = (ActividadDTO) request.getAttribute("actInfo");
    List<DtCategoria> categoriasAct = infoAct.getCategorias();
    List<DtClase> clasesAct = infoAct.getClases();
    List<DtCuponeraXActividad> cuponerasXAct = infoAct.getCuponerasXActivdad();
    DtInstitucion instAct = infoAct.getInstitucion();
    DtCuponera cupInfo = (DtCuponera) request.getAttribute("selectedCuponeraInfo");
    

%>

<%!
    String[] listOfColors = {"#468990", "#299D91", "#FFF4B8", "#F98F37", "#DE3C31"};

    public String formatName(Object x) {
        String val = (String) x;
        String[] myName = val.split(" ");
        String acronym = "";
        for (int i = 0; i < myName.length; i++) {
            String s = myName[i];
            acronym += s.charAt(0);
        }
        return acronym;
    }

    public String formatDate(Object x) {
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
            String date;
        try {
            date = DATE_FORMAT.format(x);
        } catch (Exception e) {
            System.out.println("Error catcheado en: actividadInfo.jsp formatDate()");
            return "error";
        }
        return date;
    }

    public String getColor(int index) {
        return listOfColors[index % 4];
    }
%>

<script>
    var idActividad;
    var idProfesor;
    var profesorNombre;
    
    const handleGetItem = (itemId) => {
        const url = '/entrenamosUY3/cuponeraById?cupId=' + itemId;
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

    const handleGetClase = (itemId) => {
        const url = '/entrenamosUY3/claseById?claseId=' + itemId;
        const claseModal = document.getElementById("infoClaseModal");
        if (window.claseInfo !== "Loading") {
            window.claseInfo = "Loading";
            claseModal.onload();

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

    const toggleOpenAddClaseModal = (idA, idP, nombreProfesor) => {
        idActividad = idA;
        idProfesor = idP;
        profesorNombre = nombreProfesor;

        const addClaseModal = document.getElementById("addClaseModal");
        if (addClaseModal.style.display === "none") {
            addClaseModal.style.cssText = "display: flex";
        } else {
            addClaseModal.style.cssText = "display: none";
        }

    }
</script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actividad <%=infoAct.getNombre()%></title>
    </head>
    <body class="w-screen h-full flex items-start flex-col justify-start ">
        <jsp:include page='/components/header.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>

        <%            if (openPagoModal) {
        %> 
        <jsp:include page='/components/pagarClase.jsp' >
            <jsp:param name="path" value="index" />
        </jsp:include>
        <%
            }
        %>

        <jsp:include page='/components/selectedCuponeraInfo.jsp' />
        <jsp:include page='/components/infoClaseModal.jsp' />

        <%
            if (showAddClassButton == true) {
        %>
        <jsp:include page='/components/addClaseModal.jsp' />
        <%
            }
        %>


        <div class="w-full h-full flex-grow flex flex-col items-start justify-start md:px-20 px-4 gap-y-4 my-6">
            <div class="w-full flex flex-col items-center md:flex-row md:items-start md:justify-between gap-x-20 gap-y-4">
                <div class='w-[420px] h-full flex flex-col items-center justify-start gap-y-6'>
                    <img
                        src="<%=btimg.getBase64StringImage(infoAct.getImageBlob())%>"
                        class="w-full h-[300px] object-cover rounded-md overflow-hidden"
                        />

                    <p class="text-gray-900 text-lg font-medium pb-5 border-b w-full border-gray-300">Categorias</p>

                    <div class="w-full h-auto flex flex-row items-center justify-start gap-2 flex-wrap">
                        <% int indexCat = 0; %>
                        <% for (DtCategoria cat : categoriasAct) {
                                DtCategoria val = cat;

                        %>
                        <div class="w-auto h-6 flex items-center justify-center px-4 gap-x-2 bg-red-300 rounded-md " style="background: <%=getColor(indexCat)%>">
                            <span class="w-2 h-2 bg-red-600 rounded-full"></span>
                            <p class="text-sm font-medium text-white"><%=cat.getNombre()%></p>
                        </div>
                        <%
                                indexCat++;
                            }
                        %>
                    </div>
                </div>

                <div class='w-full flex-grow h-auto border border-gray-300 rounded-md shadow-md flex flex-col items-start justify-start p-6'>

                    <p class="py-5 border-b border-gray-300 w-full text-left">Nombre Actividad: <%=infoAct.getNombre()%></p>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Institución</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=instAct.getNombre()%></p>
                    </div>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Duración</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=infoAct.getDuracion()%></p>
                    </div>
                    <div class="flex w-full flex-row items-center justify-start py-5 border-b border-gray-300">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Fecha Alta</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=formatDate(infoAct.getFechaRegistro())%></p>
                    </div>
                    <div class="flex w-full flex-row items-start justify-start py-5 h-auto">
                        <p class="w-1/3 text-gray-500 text-sm font-medium">Descripcion</p>
                        <p class="w-2/3 text-sm font-normal text-gray-900"><%=infoAct.getDescripcion()%></p>
                    </div>
                </div>
            </div>
            <%-- Solo si es Profesor --%>
            <%
                if (showAddClassButton == true) {
            %>
            <div class="w-full h-auto flex flex-row items-center justify-end h-auto my-0">
                <button onclick="toggleOpenAddClaseModal('<%=infoAct.getId()%>', '<%=infoAct.getProfesor().getId()%>', '<%=infoAct.getProfesor().getNombre()%>')" class="w-auto h-auto px-2 py-1 rounded-md text-white shadow border border-gray-300 bg-[#294557]">Agregar</button>
            </div>
            <%
                }
            %>

            <div class="w-full h-auto flex-grow flex flex-col lg:flex-row items-start justify-center gap-x-16 gap-y-4">
                <p class="md:hidden text-gray-900 text-lg font-medium pb-2 border-b w-max border-gray-300 self-center">
                    Cuponeras
                </p>
                <div class="w-full flex-grow h-auto min-h-[350px] overflow-auto rounded-md border border-gray-300 shadow-md flex flex-col items-center bg-whit justify-start  overflow-hidden">
                    <div class="w-full flex flex-row items-center justify-between h-12 bg-gray-50 border-b border-gray-300 px-6 2xl:px-20">
                        <p class="w-max h-auto text-sm text-gray-500 font-medium">Nombre</p>
                        <p class="w-max h-auto text-sm text-gray-500 font-medium">Descripcion</p>
                        <p class="w-max h-auto text-sm text-gray-500 font-medium">Clases</p>
                        <p class="w-max h-auto text-sm text-gray-500 font-medium">Descuento</p>
                        <p class="w-max h-auto text-sm text-gray-500 font-medium">Status</p>
                    </div>


                    <% for (DtCuponeraXActividad cat : cuponerasXAct) {
                            DtCuponeraXActividad val = cat;
                    %>
                    <a onclick="handleGetItem('<%=cat.getCuponera().getId()%>')" class="w-full cursor-pointer flex flex-row items-center justify-start h-16 border-b border-gray-300 gap-x-2 px-4">
                        <p class="truncate w-[25%] max-w-[25%] h-auto text-center text-sm text-gray-500 font-medium"><%=cat.getCuponera().getNombre()%></p>
                        <p class="break-words w-[25%] max-w-[25%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCuponera().getDescripcion()%></p>
                        <p class="w-[20%] max-w-[20%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCantClases()%></p>
                        <p class="w-[15%] max-w-[15%] h-auto text-sm text-gray-500 font-medium"><%=cat.getCuponera().getDescuento()%> %</p>
                        <div class="w-[15%] max-w-[15%] h-auto text-sm font-medium">
                            <p class="bg-green-100 w-fit h-auto text-green-800 rounded-xl py-0.5 px-3 ">Activa</p>
                        </div>
                    </a>
                    <%
                        }
                    %>

                </div>

                <p class="md:hidden text-gray-900 text-lg font-medium pb-2 border-b w-max border-gray-300 self-center">
                    Clases
                </p>
                <div id="clasesListadoFromActInfo" class="w-full flex-grow min-h-[350px] overflow-auto h-auto rounded-md border border-gray-300 shadow-md flex flex-col items-center bg-whit justify-start overflow-hidden">
                    <div class="w-full flex flex-row items-center text-center justify-between h-12 bg-gray-50 border-b border-gray-300 px-6">
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Clase</p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Profesor</p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Inscriptos</p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">Fecha</p>
                    </div>


                    <% for (DtClase clase : clasesAct) {
                    %>
                    <a onclick="handleGetClase('<%=clase.getId()%>')" class="w-full cursor-pointer flex flex-row items-center justify-start h-16 border-b border-gray-300 px-4 text-center">
                        <div class="w-[25%] gap-x-2 h-auto flex items-center justify-center">
                            <img
                            src="<%=btimg.getBase64StringImage(clase.getImageBlob())%>"
                            class="w-8 h-8 object-cover rounded-full overflow-hidden"
                            />
                        <p class="w-[10%]4 h-auto "t-sm text-gray-500 font-medium"><%=clase.getNombre()%></p>
                        </div>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium"><%=clase.getProfesor()%></p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium"><%=clase.getRegistros().size()%></p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium"><%=formatDate(clase.getFecha())%></p>
                    </a>
                    <%
                        }
                    %>
                </div>

            </div>
        </div>
    </body>
</html>
