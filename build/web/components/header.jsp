
<%@page import="Cuponera.DtCuponera"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='../imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>
<%
    String openModalstr = (String) request.getAttribute("open");
    Boolean arr = new Boolean(openModalstr);
    boolean openCuponeraModal = false;
    if (arr.equals(true)) {
        openCuponeraModal = true;
    }
    System.out.println(openModalstr + "dfdf");
    
    DtCuponera cuponeraInfo = null;
    if (request.getAttribute("cuponera")!= null) {
        cuponeraInfo=(DtCuponera)request.getAttribute("cuponera");
    }

%>
<!DOCTYPE html>
<header class="w-full h-16 bg-[#1F2937] flex flex-row items-center justify-between px-6">
    <% if (openCuponeraModal == true || cuponeraInfo != null) {
    %>
    <jsp:include page='./verCuponerasDisponibles.jsp'/>
    <%
        }%>    
    <% boolean isLogged = true; %>
    <div class="w-auto h-full flex flex-row items-center justify-start gap-x-6">
        <p class="text-white font-semibold text-xl">Entrenamos<span class="bg-[#E5E2C9] py-1 px-2 rounded-xs mx-1 rounded-md">UY</span></p>
        <ul class="w-auto h-full flex items-center justify-start gap-x-4">
            <a href="Inicio" class="text-white cursor-pointer text-base font-normal py-2 px-4 rounded-md ${param.path == "index" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Inicio</a> 
            <a href="actividades.jsp" class=" cursor-pointer text-base font-normal py-2 px-4 rounded-md ${param.path == "actividades" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Actividades</a>
            <a class="text-[#D1D5DB] cursor-pointer text-base font-normal py-2 px-4 rounded-md">Clases</a>
            <a href="listarCuponeras?openModal=true" class="text-[#D1D5DB] cursor-pointer text-base font-normal py-2 px-4 rounded-md">Cuponeras</a>       
        </ul>
    </div>
    <%-- Login icon --%>
    <div class="flex flex-row items-center justify-between gap-x-32">
        <%-- Search --%>
        <div class="w-96 h-10 bg-white rounded-md flex flex-row items-center overflow-hidden justify-center border border-gray-300">
            <div class="flex-grow w-full h-full bg-white px-4 py-1 flex items-center justify-start gap-x-2">
                <i class="fa-solid mt-1 fa-magnifying-glass text-gray-400"></i>
                <input
                    type="text"
                    class="flex-grow w-full outline-none font-normal text-[#6B7280]"
                    placeholder="Search"
                    />
            </div>
            <div class="w-auto h-full px-4 py-1 bg-[#F9FAFB] border-l border-gray-300 py-2 px-4 gap-x-2 flex items-center justify-start">
                <i class="fa-solid fa-arrow-down-short-wide flex items-center h-full"></i>
                <div class="flex items-center justify-center gap-x-2">
                    <p class="text-[#374151] font-normal text-sm">
                        Sort</p>
                    <i class="fa-solid fa-chevron-down"></i>
                </div>
            </div>
        </div>
        <%
            if (isLogged) {
        %>
        <div class="w-auto h-full flex items-center jusitfy-start gap-x-4">
            <i class="fa-regular fa-bell text-xl text-white"></i>
            <img class="w-8 h-8 rounded-full overflow-hidden object-cover" src="https://t3.ftcdn.net/jpg/01/97/11/64/360_F_197116416_hpfTtXSoJMvMqU99n6hGP4xX0ejYa4M7.jpg" />
        </div>
        <%
        } else {
        %>
        <%-- Search Filter --%>
        <div class="flex flex-row items-center justify-center gap-x-4"> 
            <button class="bg-white py-2 px-3 text-base font-medium text-[#294557] rounded-md">Log In</button>
            <button class="bg-[#E5E2C9] py-2 px-3 text-base font-medium text-[#294557] rounded-md">Sign Up</button>
        </div>
        <%
            }
        %>
    </div>
</header>
