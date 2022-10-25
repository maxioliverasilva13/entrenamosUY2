<%-- 
    Document   : listadoCuponerasDisponibles
    Created on : 22 oct 2022, 7:51:55
    Author     : angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<script>
    const handleGetInfoCuponera = (cuponeraInfo) => {
        window.cuponeraSelectedInfo = cuponeraInfo;
        console.log(cuponeraInfo);
        const verInfoCuponeraModal = document.getElementById("cuponeraInfoSelected");
        if (verInfoCuponeraModal.style.display === "none") {
            verInfoCuponeraModal.style.cssText = "display: flex";
            verInfoCuponeraModal.onload();
        } else {
            verInfoCuponeraModal.style.cssText = "display: none";
        }
    }

    const clickItem = (data) => {
        console.log(data)
    }


    $(document).ready(function () {
        document.getElementById("cuponerasDisponiblesModalView").onload = () => {
            const elementCuponeraList = document.getElementById("cuponerasList");
            while (elementCuponeraList.hasChildNodes()) {
                elementCuponeraList.removeChild(elementCuponeraList.lastChild);
            }
            const listadoCuponerasModal = document.getElementById("cuponerasDisponiblesModalView");
            window.fetch('/entrenamosUY3/listarCuponeras').then((response) => {
                return response.json();
            }).then((data) => {
                const listOfCuponerasDisponibles = data?.data;
                const listOfCuponerasDisponiblesKeys = Object.keys(listOfCuponerasDisponibles);
                if (elementCuponeraList) {
                    listOfCuponerasDisponiblesKeys?.forEach((item) => {
                        var itemInfo = listOfCuponerasDisponibles[item];
                        var totalClasesCuponera = 0;
                        itemInfo?.cuponerasXActividad?.forEach((item) => {
                            totalClasesCuponera += item?.cantClases;
                        })
                        var div = document.createElement('template');
                        const onClickEvent = () => handleGetInfoCuponera(itemInfo);
                        div.innerHTML = `
            <button id="itemInfo-` + item + `" class="w-full h-[108px] min-h-[108px] p-4 flex flex-col items-center justify-start border-b border-gray-300 cursor-pointer" >
                    <div class="flex-grow w-full h-auto flex flex-row items-center justify-between">
                        <p class="text-[##4F46E5] text-sm font-medium">` + itemInfo?.nombre + `</p>
                        <div class="w-auto h-auto px-[10px] py-[2px] rounded-2xl bg-[#D1FAE5] flex items-center justify-center">
                            <p class="text-[#065F46] font-medium text-xs">` + itemInfo?.descuento + `%</p>
                        </div>
                    </div>
                    <p class="text-left font-medium text-gray-700 w-full ">Total Actividades: ` + itemInfo?.cuponerasXActividad?.length + ` (` + totalClasesCuponera + ` Clases Incluidas con esta cuponera) </p>
                    <div class="flex-grow w-full flex items-end justify-start gap-x-2">
                        <i class="fa-solid fa-calendar text-gray-500"></i>
                        <p class="text-gry-500 font-normal text-sm">Valido hasta el ` + itemInfo?.periodoVigencia + `</p>
                    </div>
                </button>
`;
                        elementCuponeraList.appendChild(div.content);
                        $(document).on("click", "#itemInfo-" + item, onClickEvent)
                    })



                }


            }).catch((err) => {
                console.log(err);
            });
        }
    });
</script>

<div id="cuponerasDisponiblesModalView" style="display: none" class="w-full transition-all h-full fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white mx-auto my-12 rounded-2xl p-12 px-24 border-gray-300 transition-all border auto h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <a onclick="toggleModalCuponera('cuponerasDisponiblesModalView')" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>
        <jsp:include page="./modalComprarCuponera.jsp" />
        <div class="flex transition-all flex-col max-w-[550px] items-center min-w-[720px] h-auto justify-start flex-grow px-12 gap-y-4 w-full h-full">
            <p class="text-3xl w-full text-gray-900 font-medium border-b border-gray-300 pb-6">Cuponeras Disponibles</p>
            <%-- Sort --%>
            <div class="w-full h-auto flex items-center justify-end">
                <div class="w-auto h-full px-4 border rounded-md border-gray-300 py-1 bg-[#F9FAFB] py-2 px-4 gap-x-2 flex items-center justify-end">
                    <i class="fa-solid fa-arrow-down-short-wide flex items-center h-full"></i>
                    <div class="flex items-center justify-center gap-x-2">
                        <p class="text-[#374151] font-normal text-sm">Sort</p>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </div>

            <div id="cuponerasList" class="w-full h-auto rounded-md border border-gray-300 shadow-md flex flex-col items-center justify-start max-h-[700px] overflow-auto">

                <%-- item --%>

                <%--
                <% for (HashMap.Entry<Integer, DtCuponera> en : cuponera.entrySet()) {
                            Integer key = en.getKey();
                            DtCuponera val = en.getValue();
                    %> 
                <a href="listarCuponeras?openModal=true&id=<%=val.getId()%>" class="w-full h-[108px] min-h-[108px] p-4 flex flex-col items-center justify-start border-b border-gray-300 cursor-pointer" >
                    <div class="flex-grow w-full h-auto flex flex-row items-center justify-between">
                        <p class="text-[##4F46E5] text-sm font-medium"><%=val.getNombre()%></p>
                        <div class="w-auto h-auto px-[10px] py-[2px] rounded-2xl bg-[#D1FAE5] flex items-center justify-center">
                            <p class="text-[#065F46] font-medium text-xs"><%=val.getDescuento()%>%</p>
                        </div>
                    </div>
                    <div class="flex-grow w-full flex items-end justify-start gap-x-2">
                        <i class="fa-solid fa-calendar text-gray-500"></i>
                        <p class="text-gry-500 font-normal text-sm">Valido hasta el <%=val.getPeriodoVigencia()%></p>
                    </div>
                </a>
                <%
                }
                %>
                --%>



            </div>
        </div>
    </div>
</div>