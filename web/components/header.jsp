
<%@page import="util.BlobToImage"%>
<%@page import="Usuario.dtos.UsuarioDTO"%>
<%@page import="Cuponera.DtCuponera"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='../imports.jsp' />
<script>
    const toggleSidebar = () => {
        var element = document.getElementById("mobile-menu");
        var desktopHeader = document.getElementById("desktopHeader");
        if (getComputedStyle(element).display === "none") {
            element.style.cssText = "display:flex";
            desktopHeader.classList.toggle("outHeader");
        } else {
            element.style.cssText = "display: none";
            desktopHeader.classList.toggle("outHeader");
        }
    }

    const toggleModalUser = (id) => {
        var element = document.getElementById(id);
        if (getComputedStyle(element).display === "none") {
            element.style.cssText = "display:flex";
            // desktopHeader.classList.toggle("outHeader");
        } else {
            element.style.cssText = "display: none";
            //desktopHeader.classList.toggle("outHeader");
        }
    }

    const toggleModalCuponera = (id) => {
        var element = document.getElementById(id);
        if (getComputedStyle(element).display === "none") {
            element.style.cssText = "display:flex";
            element.onload();
        } else {
            element.style.cssText = "display: none";
        }
    }
</script>

<%
    UsuarioDTO userInfo = (UsuarioDTO) session.getAttribute("currentSessionUser");
    String typeOfUser = (String) session.getAttribute("typeOfUser");
    boolean hasUser = userInfo != null;
    BlobToImage bltimg = new BlobToImage();

    String openModalstr = (String) request.getAttribute("open");
    Boolean arr = new Boolean(openModalstr);
    boolean openCuponeraModal = false;
    if (arr.equals(true)) {
        openCuponeraModal = true;

    }

    DtCuponera cuponeraInfo = null;
    if (request.getAttribute("cuponera") != null) {
        cuponeraInfo = (DtCuponera) request.getAttribute("cuponera");
    }
%>

<!DOCTYPE html>
<div class="z-[3000] w-screen max-w-screen relative">
    
            <% if (openCuponeraModal == true || cuponeraInfo != null) {
        %>
        <jsp:include page='./verCuponerasDisponibles.jsp'/>
        <%
            }%> 
        <%
            if (userInfo != null && typeOfUser != null && typeOfUser.equals("Socio")) {
        %>
        <jsp:include page='./listadoCuponerasDisponibles.jsp'/>
        <%
            }
        %>
    <style>
        .animationHeader {
            transition: .3s all ease;
            animation: mymove .3s ease;
        }

        .outHeader {
            transition: .3s all ease;
            animation: mymove2 .3s ease;
            opacity: 0;
        }

        .enterHeader {
            transition: .3s all ease;
            animation: mymove3 .3s ease;
        }

        @keyframes mymove {
            from {
                right: -500px;
            }
            to {
                right: 0px;
            }
        }
        @keyframes mymove2 {
            from {
                margin-top: 0px;
            }
            to {
                margin-top: -200px;
            }
        }

        @keyframes mymove3 {
            from {
                margin-top: -200px;
            }
            to {
                margin-top: 0px;
            }
        }

    </style>
    <header id="desktopHeader" class="w-screen overflow-hidden h-16 bg-[#1F2937] flex flex-row items-center justify-between overflow-y-visible md:px-6 px-2 max-w-full overflow-x-hidden enterHeader">

        <div class="w-auto h-full flex flex-row items-center justify-start gap-x-6">
            <p class="text-white font-semibold text-xl">Entrenamos<span class="bg-[#E5E2C9] py-1 px-2 rounded-xs mx-1 rounded-md">UY</span></p>
            <ul class="w-auto h-full items-center justify-start gap-x-4 md:flex hidden">
                <a href="Inicio" class="text-white cursor-pointer text-base font-normal py-2 px-4 rounded-md ${param.path == "index" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Inicio</a> 
                <a href="actividadesInfo" class=" cursor-pointer text-base font-normal py-2 px-4 rounded-md ${param.path == "actividades" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Actividades</a>
                <a class="text-[#D1D5DB] cursor-pointer text-base font-normal py-2 px-4 rounded-md">Clases</a>
                <%
                    if (userInfo != null && typeOfUser != null && typeOfUser.equals("Socio")) {
                %>
                <p onclick="toggleModalCuponera('cuponerasDisponiblesModalView')" class="text-[#D1D5DB] cursor-pointer text-base font-normal py-2 px-4 rounded-md">Cuponeras</p>
                <%
                    }
                %>
                <a href="Usuarios" class="text-[#D1D5DB] cursor-pointer text-base font-normal py-2 px-4 rounded-md ${param.path == "usuarios" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}"">Usuarios</a>

            </ul>
        </div>
        <%-- Login icon --%>
        <div class="flex flex-row items-center justify-between gap-x-32">
            <%-- Search --%>
            <%--
            <div class="w-96 h-10 lg:flex hidden bg-white rounded-md flex-row items-center overflow-hidden justify-center border border-gray-300">
                <div class="flex-grow w-full h-full bg-white px-4 py-1 flex items-center justify-start gap-x-2">
                    <i class="fa-solid mt-1 fa-magnifying-glass text-gray-400"></i>
                    <input
                        type="text"
                        class="flex-grow w-full outline-none font-normal text-[#6B7280]"
                        placeholder="Search"
                        />
                </div>
                <div class="w-auto h-full fkex px-4 py-1 bg-[#F9FAFB] border-l border-gray-300 py-2 px-4 gap-x-2 items-center justify-start">
                    <i class="fa-solid fa-arrow-down-short-wide flex items-center h-full"></i>
                    <div class="flex items-center justify-center gap-x-2">
                        <p class="text-[#374151] font-normal text-sm">
                            Sort</p>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </div>
            --%>
            <div class="w-auto h-auto flex flex-row items-center justify-start">
                <i onclick="toggleSidebar()" class="fa-solid fa-bars text-xl md:opacity-0 md:mx-2 mx-4 text-white md:hidden order-2"></i>
                <%                    if (hasUser) {
                %>
                <div class="w-auto h-full flex items-center jusitfy-start gap-x-4 md:order-2 order-1">
                    <i class="fa-regular fa-bell text-xl text-white"></i>
                    <div class="">
                        <img onclick="toggleModalUser('claseModal')" class="w-8 cursor-pointer h-8 min-w-8 min-h-8 rounded-full overflow-hidden object-cover" src="<%=bltimg.getBase64StringImage(userInfo.getBlobImage())%>" />
                        <div  id="claseModal" style="display: none" class="w-64 h-auto gap-y-2 px-4 py-4 shadow-lg bg-gray-50 absolute top-12 right-12 border rounded-2xl border-gray-300 flex-col items-center justify-cecnter">
                            <% if (userInfo != null) {
                            %>
                            <a href="verPerfil?&userID=<%=userInfo.getId()%>" class="w-full h-auto bg-gray-700 text-white px-4 py-2 font-medium cursor-pointer rounded-xl text-center">Mi Perfil</a>
                            <%
                                }
                            %>
                            <a href="logout" class="w-full h-auto bg-red-600 text-white px-4 py-2 font-medium cursor-pointer rounded-xl text-center">Logout</a>


                        </div>
                    </div>
                </div>
                <%
                } else {
                %>
                <div class="flex flex-row items-center justify-center gap-x-4"> 
                    <a href="login.jsp" class="bg-white py-1 px-3 text-base font-medium text-[#294557] rounded-md">Log In</a>
                    <a href="signup.jsp" class="bg-[#E5E2C9] py-1 px-3 text-base font-medium text-[#294557] rounded-md">Sign Up</a>
                </div>
                <%
                    }
                %>
            </div>

        </div>

    </header>
    <%-- Mobile Header --%>
    <header style="display: none" id="mobile-menu" class="w-screen h-screen absolute top-0 right-0 z-40 animationHeader flex-row items-center justify-start">
        <% if (openCuponeraModal == true || cuponeraInfo != null) {
        %>
        <jsp:include page='./verCuponerasDisponibles.jsp'/>
        <%
            }%> 
        <%
            if (userInfo != null && typeOfUser != null && typeOfUser.equals("Socio")) {
        %>
        <jsp:include page='./listadoCuponerasDisponibles.jsp'/>
        <%
            }
        %>
        <div onclick="toggleSidebar()" class="flex-grow h-full"></div>
        <div  class="w-[300px] gap-y-4 h-screen bg-[#1F2937] flex flex-col items-start justify-start">

            <div class="w-full h-16 px-2 flex flex-row items-center justify-between">
                <%
                    if (hasUser) {
                %>
                <div class="w-full h-full flex flex-row items-center justify-between">
                    <p class="text-white -mt-1 font-semibold text-xl">Entrenamos<span class="bg-[#E5E2C9] text-xs  py-1 px-2 rounded-xs mx-1 rounded-md">UY</span></p>
                    <div class="w-auto h-full flex items-center jusitfy-start gap-x-4 md:order-2 order-1">
                        <i class="fa-regular fa-bell text-xl text-white"></i>
                        <img onclick="toggleModalUser('claseModalMobile')" class="w-8 cursor-pointer h-8 min-w-8 min-h-8 rounded-full overflow-hidden object-cover" src="<%=bltimg.getBase64StringImage(userInfo.getBlobImage())%>" />
                        <div  id="claseModalMobile" style="display: none" class="w-64 h-auto px-4 py-4 shadow-lg bg-gray-50 absolute top-12 right-12 border rounded-2xl border-gray-300 items-center justify-cecnter">
                            <a href="logout" class="w-full h-auto bg-red-600 text-white px-4 py-2 font-medium cursor-pointer rounded-xl text-center">Logout</a>
                        </div>
                    </div>
                </div>
                <%
                } else {
                %>
                <div class="flex flex-row items-center justify-center gap-x-4"> 
                    <a href="login.jsp" class="bg-white py-1 px-3 text-base font-medium text-[#294557] rounded-md">Log In</a>
                    <a href="signup.jsp" class="bg-[#E5E2C9] py-1 px-3 text-base font-medium text-[#294557] rounded-md">Sign Up</a>
                </div>
                <%
                    }
                %>
            </div>

            <ul class="w-full h-auto flex flex-col items-start justify-start gap-y-2 p-2">
                <a href="Inicio" class="text-white w-full cursor-pointer text-base font-normal py-2 px-4 rounded-xl ${param.path == "index" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Inicio</a> 
                <a href="actividadesInfo" class=" cursor-pointer w-full text-base font-normal py-2 px-4 rounded-xl ${param.path == "actividades" ? "bg-[#111827] text-white" : "text-[#D1D5DB]"}">Actividades</a>
                <a class="text-[#D1D5DB] w-full cursor-pointer text-base font-normal py-2 px-4 rounded-xl">Clases</a>
                <p onclick="toggleModalCuponera('cuponerasDisponiblesModalView')" class="text-[#D1D5DB] w-full cursor-pointer text-base font-normal py-2 px-4 rounded-xl">Cuponeras</p>
            </ul>

        </div>

    </header>

</div>