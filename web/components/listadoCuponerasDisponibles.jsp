<%-- 
    Document   : listadoCuponerasDisponibles
    Created on : 22 oct 2022, 7:51:55
    Author     : angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<script>
    const handleGetInfoCuponera = (cuponeraInfo) => {
        window.cuponeraSelectedInfo = cuponeraInfo;
        //console.log(cuponeraInfo);
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
                    if (listOfCuponerasDisponiblesKeys?.length == 0){
                        var div = document.createElement('template');
                        div.innerHTML = `
                        <div class="w-full h-full flex-grow flex items-center flex-col justify-center py-4">
                            <img src="https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
                            <p class="text-gray-800 font-medium text-base">¡No encontramos ninguna Cuponera!</p>
                        </div>
                        `;
                        elementCuponeraList.appendChild(div.content);
                    }
                    listOfCuponerasDisponiblesKeys?.forEach((item) => {
                        var itemInfo = listOfCuponerasDisponibles[item];
                        var totalClasesCuponera = 0;
                        itemInfo?.cuponerasXActividad?.forEach((item) => {
                            totalClasesCuponera += item?.cantClases;
                        })
                        var div = document.createElement('template');
                        const onClickEvent = () => handleGetInfoCuponera(itemInfo);
                        div.innerHTML = `
            <button id="itemInfo-` + item + `" class="w-full h-max min-h-[108px] p-4 gap-y-2 sm:gap-y-0.5 flex flex-col items-center justify-start border-b border-gray-300 cursor-pointer" >
                    <div class="flex-grow w-full h-auto flex flex-row items-center justify-between">
                        <p class="text-[#4F46E5] font-medium">` + itemInfo?.nombre + `</p>
                        <div class="w-auto h-auto px-[10px] py-[2px] rounded-2xl bg-[#D1FAE5] flex items-center justify-center">
                            <p class="text-[#065F46] font-medium text-xs">` + itemInfo?.descuento + `%</p>
                        </div>
                    </div>
                    <p class="text-left font-medium text-gray-700 w-full ">Total Actividades: ` + itemInfo?.cuponerasXActividad?.length + ` (` + totalClasesCuponera + ` Clases Incluídas con esta cuponera) </p>
                    <div class="flex-grow w-full flex items-center justify-start gap-x-2">
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

<div id="cuponerasDisponiblesModalView" style="display: none" class="w-full z-[99999] transition-all max-h-screen h-screen fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 transition-all items-center justify-center">
    <div class="w-5/6 sm:w-4/5 md:max-w-[800px] relative bg-white rounded-2xl p-6 md:p-12 border-gray-300 transition-all border flex flex-row gap-x-12 justify-center items-center min-h-max h-max">
        <%-- Close Button --%>
        <a onclick="toggleModalCuponera('cuponerasDisponiblesModalView')" class="cursor-pointer w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>
        <jsp:include page="./modalComprarCuponera.jsp" />
        <div class="flex transition-all flex-col w-full items-center max-w-[720px] h-auto justify-start flex-grow px-2 md:px-12 gap-y-4 w-full h-full">
            <p class="text-center text-3xl w-full text-gray-900 font-medium pb-2">Cuponeras Disponibles</p>

            <div id="cuponerasList" class="w-full h-auto rounded-md border border-gray-300 shadow-md flex flex-col items-center justify-start max-h-[700px] overflow-auto">

                <%-- CONTENT... --%>

                
            </div>
        </div>
    </div>
</div>
