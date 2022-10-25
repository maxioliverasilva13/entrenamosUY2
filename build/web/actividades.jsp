<%-- 
    Document   : index.jsp
    Created on : 15/09/2022, 09:16:14 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Categoria.DtCategoria"%>
<%@page import="util.BlobToImage"%>
<%@page import="Institucion.DtInstitucion"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%
    BlobToImage bltim = new BlobToImage();
    HashMap<Integer, DtInstitucion> instituciones = new HashMap<Integer, DtInstitucion>();
    DtInstitucion ins = (DtInstitucion) request.getAttribute("institucionInfo");
    HashMap<Integer, DtCategoria> categorias = (HashMap<Integer, DtCategoria>) request.getAttribute("categorias");
    Boolean hasInstitucionInfo = ins != null;

    Boolean hasFilteredCategories = request.getAttribute("filteredActividades") != null;

    if (!hasInstitucionInfo) {
        instituciones = (HashMap<Integer, DtInstitucion>) request.getAttribute("instituciones");
    }

    Boolean hasAppliedFilters = request.getAttribute("listOfAppliedFilters") != null;
    List<String> appliedFilters = new ArrayList();
    if (hasAppliedFilters) {
        appliedFilters = (List<String>) request.getAttribute("listOfAppliedFilters");
    }


%>

<script>
    const handleRemoveItem = (item, itemID) => {
        var itemString = item.toString();
        document.getElementById(itemString).checked = false;
        console.log(document.getElementById("id-" + itemString));
        document.getElementById("id-" + itemString).style.setProperty("display", "none");
    }
</script>

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
        <div class="w-full h-full flex-grow px-8 py-6 max-h-full overflow-auto flex flex-row items-center justify-between gap-x-32 p-10">
            <div class="w-96 h-full flex flex-col items-center justify-start gap-y-2">
                <p class="text-gray-500 w-full text-left font-medium text-md">Categorias</p>

                <form onsubmit="handleSubmit(event);" method="POST" class="w-full h-full flex-grow flex flex-col items-start justify-start gap-y-4">
                    <div class="w-full h-auto flex flex-row items-center justify-between">
                        <input type="submit" class="bg-[#E5E2C9] py-1 px-2 cursor-pointer text-sm font-medium text-[#294557] rounded-md" value="Aplicar Filtros" />
                        <%                            if (hasAppliedFilters) {
                        %>
                        <a href="actividadesInfo" class="font-medium underline text-[#E5E2C9]">Limpiar</a>
                        <%
                            }
                        %>
                    </div>
                    <div class="w-full h-auto flex flex-row items-start justify-start gap-2 flex-wrap max-w-full">
                        <%-- ForEach appliedFilters --%>
                        <%
                            if (appliedFilters.size() > 0) {
                                for (int i = 0; i < appliedFilters.size(); i++) {
                                    String item = appliedFilters.get(i);
                        %>
                        <span id="id-<%=item%>" class="px-3 py-1 rounded-md bg-gray-200 text-gray-900 font-bold relative">
                            <%=item%>
                            <span onclick="handleRemoveItem('<%=item%>')" href="actividadesInfo" class="w-5 h-5 text-2xl bg-red-100 text-red-700 flex items-center justify-center rounded-full absolute -top-1 -right-1">
                                <i class="fa-solid text-xs fa-xmark"></i>
                            </span>
                        </span>
                        <%
                                }
                            }
                        %>
                    </div>

                    <div class="w-full h-full flex-grow flex flex-col items-center justify-start gap-y-5">
                        <%-- ForEach Categorias --%>
                        <% 
                        int iterator = 0;
                        for (HashMap.Entry<Integer, DtCategoria> en
                                    : categorias.entrySet()) {
                                Integer key = en.getKey();
                                DtCategoria val = en.getValue();
                                boolean isChecked = appliedFilters.contains(val.getNombre());
                        %>
                        <jsp:include page='/components/categoriaCard.jsp' >
                            <jsp:param name="categoria" value="<%=val.getNombre()%>" />
                            <jsp:param name="totalActividades" value="<%=val.getTotalActividades()%>" />
                            <jsp:param name="categoriaId" value="<%=val.getId()%>" />
                            <jsp:param name="checked" value="<%=isChecked%>" />
                            <jsp:param name="index" value="<%=iterator%>" />
                            

                        </jsp:include>
                        <%
                            iterator ++;
                            }
                        %>
                    </div>

                </form>
            </div>


            <div class="w-full flex-grow h-full flex flex-col items-center justify-start gap-y-12">
                <p class="text-gray-900 text-2xl text-left w-full font-medium pb-5 border-b border-gray-300 w-full">
                    <%=hasInstitucionInfo == true ? "Actividades Filtradas" : "Haz click sobre una categoria o institucion para ver sus actividades y cuponeras "%>

                </p>
                <div class="w-full h-full max-h-full overflow-auto flex-grow border-gray-300 rounded-md <%=hasInstitucionInfo || hasAppliedFilters == true ? "border-0" : "border"%>">
                    <%
                        if (hasInstitucionInfo == true || hasFilteredCategories) {
                    %>
                    <div class="w-full flex-grow h-full flex items-center justify-start flex-col max-h-full overflow-auto py-2 px-2 gap-y-4">
                        <%
                            if (!hasFilteredCategories) {
                        %> 
                        <p class="text-base font-medium text-gray-900 flex flex-row items-center justify-start gap-x-2">Institucion Seleccionada: 

                            <span class="px-3 py-1 rounded-md bg-gray-200 text-gray-900 font-bold relative">
                                <%=ins.getNombre()%>
                                <a href="actividadesInfo" class="w-5 h-5 text-2xl bg-red-100 text-red-700 flex items-center justify-center rounded-full absolute -top-1 -right-1">
                                    <i class="fa-solid text-xs fa-xmark"></i>
                                </a>
                            </span>
                        </p>
                        <%
                            }
                        %>

                        <jsp:include page='/verActividades.jsp' >
                            <jsp:param name="totalActividades" value="asd" />
                        </jsp:include>

                    </div>
                    <%
                    } else {
                    %>
                    <%-- ForEach Instituciones --%>
                    <% for (HashMap.Entry<Integer, DtInstitucion> en : instituciones.entrySet()) {
                            Integer key = en.getKey();
                            DtInstitucion val = en.getValue();

                    %>
                    <div class="w-full h-20 border-b border-gray-300 px-6 py-4 flex flex-row items-center justify-start gap-x-4">
                        <img 
                            src="<%=bltim.getBase64StringImage(val.getImageBlob())%>"
                            class="w-12 h-12 rounded-full overflow-hidden"   
                            />
                        <div class="w-[30%] h-full flex flex-col items-start justify-between">
                            <p class="text-[#4F46E5] font-medium text-sm"><%=val.getNombre()%></p>
                            <div class="flex items-center justify-start gap-x-2">
                                <i class="fa-solid fa-comment text-gray-300"></i>
                                <p class="text-gray-500 font-normal text-sm "><%=val.getDescripcion()%></p>
                            </div>

                        </div>

                        <div class="flex-grow h-full flex flex-col items-start justify-between">
                            <p class="text-gray-900 font-medium text-sm">Total Actividades: <%=val.getTotalActividadesAceptadas()%> </p>
                            <div class="flex items-center justify-start gap-x-2">
                                <i class="fa-solid fa-circle-check text-sm text-green-600"></i>
                                <p class="text-gray-500 font-normal text-sm ">Applied on January 7, 2020</p>
                            </div>

                        </div>
                        <a href="actividadesInfo?instId=<%=val.getId()%>">
                            <i class="fa-solid fa-chevron-right text-gray-900 cursor-pointer px-4"></i>
                        </a>
                    </div>
                    <%                        }
                    %>
                    <%
                        }
                    %>

                </div>
            </div>
        </div>
    </body>
</html>

