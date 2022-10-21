<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera

    Esta pagina es solo para socios logueados
--%>

<%@page import="Cuponera.DtCuponera"%>
<%@page import="java.util.HashMap"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Clase.DtClase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DtClase selectedClaseInfo = (DtClase) request.getAttribute("selectedClaseInfo");
    ActividadDTO infoAct = (ActividadDTO) request.getAttribute("actInfo");
    HashMap<Integer, DtCuponera> cuponerasDisp = (HashMap<Integer, DtCuponera>) request.getAttribute("cuponerasDisp");

    cuponerasDisp.forEach(( key,  
          
          
          
          
          
          
        item) ->{
     System.out.println("cuponera con id: " + key);
    });

%>
<!DOCTYPE html>
<div class="w-full h-full fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all" id="modalComponent" >
    <div class="bg-white w-auto rounded-2xl p-12 px-24 border-gray-300 border  h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <a href="verActividadInfo?actId=<%=selectedClaseInfo.getIdActividad()%>" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>

        <div class="flex flex-col items-center justify-start flex-grow gap-y-4 w-full h-full">
            <p class="text-2xl text-gray-900 font-medium">Elije como deseas pagar la clase</p>

            <hr class="w-full" />

            <div class="w-full h-full flex-grow flex flex-row items-center justify-start gap-x-12">

                <% if (cuponerasDisp.size() <= 0) {

                %> <div class="flex items-center bg-blue-500 text-white text-sm font-bold px-4 py-3" role="alert">
                    <svg class="fill-current w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M12.432 0c1.34 0 2.01.912 2.01 1.957 0 1.305-1.164 2.512-2.679 2.512-1.269 0-2.009-.75-1.974-1.99C9.789 1.436 10.67 0 12.432 0zM8.309 20c-1.058 0-1.833-.652-1.093-3.524l1.214-5.092c.211-.814.246-1.141 0-1.141-.317 0-1.689.562-2.502 1.117l-.528-.88c2.572-2.186 5.531-3.467 6.801-3.467 1.057 0 1.233 1.273.705 3.23l-1.391 5.352c-.246.945-.141 1.271.106 1.271.317 0 1.357-.392 2.379-1.207l.6.814C12.098 19.02 9.365 20 8.309 20z"/></svg>
                    <p>No tienes cuponeras disponibles.</p>
                </div>

                <%                    } else {
                %>
                <div class="flex-grow h-full flex flex-col items-start justify-start gap-y-5">
                    <p class="text-gray-900 font-medium text-xl">Elija una cuponera</p>
                    <div class="w-full h-full flex-grow border border-gray-200 rounded-2xl overflow-hidden shadow-md max-h-full overflow-auto">
                        <%-- Cols --%>
                        <div class="w-full h-10 bg-gray-50 flex flex-row items-center justify-start border-b border-gray-300 px-4">
                            <p class="text-sm w-[35%] font-medium text-gray-500 truncate">Cuponera</p>
                            <p class="text-sm w-[30%] font-medium text-gray-500 truncate">Descripcion</p>
                            <p class="text-sm w-[20%] font-medium text-gray-500 truncate">Descuento</p>
                            <p class="text-sm w-[15%] font-medium text-gray-500 truncate"></p>
                        </div>

                        <%-- Rows --%>

                        <%
                            for (HashMap.Entry<Integer, DtCuponera> in : cuponerasDisp.entrySet()) {
                                Integer key = in.getKey();
                                DtCuponera val = in.getValue();
                        %>
                        <div class="w-full h-12 bg-white flex flex-row items-center justify-start border-b border-gray-300 px-4">
                            <p class="text-sm w-[35%] font-medium text-gray-500 truncate"><%= val.getNombre()%></p>
                            <p class="text-sm w-[30%] font-medium text-gray-500 truncate"><%= val.getDescripcion()%></p>
                            <p class="text-sm w-[20%] font-medium text-gray-500 truncate"><%= val.getDescuento()%> %</p>
                            <div class="text-sm w-[15%] font-medium text-gray-500 flex items-center justify-center">
                                <button id="btn-cup-<%=val.getId()%>"  class="bg-[#4F7994] text-white w-auto h-auto rounded-md flex items-center justify-center px-2 py-1" onclick="onSelectCup(<%=val.getId()%>,<%=infoAct.getCosto()%>, <%= val.getDescuento()%>)">
                                    Elejir
                                </button>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                    <%-- Payment Card --%>
                    <div class="w-auto h-auto flex flex-col items-center justify-start gap-y-5">
                        <p class="text-gray-900 font-medium text-xl">Con un pago unico</p>
                        <div class="w-72 h-auto flex flex-col items-start justify-start shadow-md border border-gray-100 rounded-2xl">
                            <div class="w-full h-auto p-6 flex flex-col items-start justify-start gap-y-5">
                                <p class="text-[#4F7994] text-[60px] font-bold">$<%=infoAct.getCosto()%></p>
                                <p class="text-gray-500 text-xl font-normal">Este precio es el de cada clase para esta actividad</p>
                            </div>
                            <div class="p-6 w-full h-auto bg-gray-50 border-t border-gray-100">
                                <button class="h-auto bg-[#4F7994] w-full flex-grow py-4 px-6 text-white" onclick="buyCuponera(<%=selectedClaseInfo.getId()%>, <%= infoAct.getCosto()%>)">
                                    Comprar
                                </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>

    <script>


        var choosedCup = false;
        var choosedCupID = null;
        var finalPriceDesc = null;
        function onSelectCup(id, priceClass, descuento) {
            const btnCup = $("#btn-cup-" + id);
            const finalPriceElem = $("#finalPrice");
            if (!choosedCup) {
                changeBtnStyleToCancel(btnCup);
                const descuentoMonto = (priceClass / 100) * descuento;
                const newPriceFinal = Math.round(priceClass - descuentoMonto);
                finalPriceElem.text("$" + newPriceFinal);
                finalPriceDesc = newPriceFinal;
                choosedCupID = id;

            } else {
                changeBtnStyleToChoose(btnCup);
                const price = parseInt(finalPriceElem.text());
                const descuentoMonto = (priceClass / 100) * descuento;
                const newPriceFinal = Math.round(price + descuentoMonto);
                finalPriceElem.text("$" + priceClass);
                finalPriceDes = null;
                choosedCupID = null;
            }
            choosedCup = !choosedCup;
        }

        function changeBtnStyleToCancel(btn) {
            btn.removeClass("bg-[#4F7994]");
            btn.removeClass("text-white");


            btn.addClass("text-gray-700");
            btn.addClass("bg-gray-200");

            btn.text("Quitar");

        }

        function changeBtnStyleToChoose(btn) {

            btn.removeClass("text-gray-700");
            btn.removeClass("bg-gray-200");
            btn.addClass("bg-[#4F7994]");
            btn.addClass("text-white");
            btn.text("Elejir");


        }


        function  buyCuponera(claseId, costoClase) {
            let precioFinal;
            if (finalPriceDesc) {
                precioFinal = finalPriceDesc;
            } else {
                precioFinal = costoClase;
            }

            const data = {
                claseId: claseId,
                precioFinal: costoClase,
                choosedCupID: choosedCupID
            }

            var req = $.post("ComprarClase", data, function (data, status) {
                if (data.status == 200) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Felicidades!',
                        text: data.message,

                    })
                    $("#modalComponent").css("display", "none");
                } else if (data.status == 400) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: data.message,
                        footer: '<a href="">Why do I have this issue?</a>'
                    })

                } else if (data.status == 500) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: "Ha ocurrido un error inesperado",
                        footer: '<a href="">Why do I have this issue?</a>'
                    })
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: "Ha ocurrido un error inesperado",
                        footer: '<a href="">Why do I have this issue?</a>'
                    })

                }

            })


        }

    </script>