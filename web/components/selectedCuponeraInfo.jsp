<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="util.BlobToImage"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    console.log("hola xd")
    const removeChilds = (parent) => {
        while (parent.lastChild) {
            parent.removeChild(parent.lastChild);
        }
    };

    var listOfColors = ["#468990", "#299D91", "#FFF4B8", "#F98F37", "#DE3C31"];

    const getColor = (index) => {
        return listOfColors[index % 4];
    }

    console.log("asd")

    $(document).ready(function () {
        document.getElementById("cuponeraInfoModal").onload = () => {
            const categoriasContent = document.getElementById("categoriasContent");
            while (categoriasContent.hasChildNodes()) {
                categoriasContent.removeChild(categoriasContent.lastChild);
            }

            const cuponeraInfo = window?.cuponeraInfo;
            let parentNode = document.getElementById("tablaContent");
            if (cuponeraInfo === "Loading") {
                $("#closeButton").attr("disabled", true);
                $("#cupTitle").text("Cargando...");

                removeChilds(parentNode);
                document.getElementById("imageCup").setAttribute("src", "")
            } else {
                let allCategorias = [];
                console.log(cuponeraInfo);
                $("#closeButton").attr("disabled", false);
                $("#cupTitle").text("Cuponera: " + cuponeraInfo?.nombre);
                var imgsrc = cuponeraInfo.blobImage ? "data:image/jpg;base64," + btoa(new Uint8Array(cuponeraInfo.blobImage).reduce(function (data, byte) {
                    return data + String.fromCharCode(byte);
                }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"
                document.getElementById("imageCup").setAttribute("src", imgsrc)

                cuponeraInfo.cuponerasXActividad?.map((item) => {
                    let actividadId = item?.actividad?.id;
                    var actividadNombre = item?.actividad?.nombre;
                    var actividadInstitucion = item?.actividad?.institucion?.nombre;
                    var actividadDuracion = item?.actividad?.duracion;
                    var actividadCantClass = item?.cantClases;
                    var actividadDescuento = item?.cuponera?.descuento;

                    item?.actividad?.categorias?.forEach((categoria) => {
                        if (!allCategorias.includes(categoria?.nombre)) {
                            allCategorias.push(categoria.nombre);
                        }
                    });

                    var div = document.createElement('template');
                    div.innerHTML = `
            <a href="verActividadInfo?actId=` + actividadId + `" class="w-full transition-all flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                <p class="w-[30%] h-auto tex%>')"t-sm text-gray-500 font-medium">` + actividadNombre + `</p>
                <p class="w-[30%] h-auto text-sm text-gray-500 font-medium">` + actividadInstitucion + `</p>
                <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">` + actividadDuracion + `</p>
                <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">` + actividadCantClass + `</p>
                <p class="w-[10%] h-auto text-sm text-gray-500 font-medium">` + actividadDescuento + `</p>
            </a>
`;
                    parentNode.appendChild(div.content)
                })
                allCategorias.map((categoria, index) => {
                    var div = document.createElement('template');
                    div.innerHTML = `
                        <div class="w-auto h-6 flex items-center justify-center px-4 gap-x-2 bg-red-300 rounded-md " style="background:` + getColor(index) + `">
                            <span class="w-2 h-2 bg-red-600 rounded-full"></span>
                            <p class="text-sm font-medium text-white">` + categoria + `</p>
                        </div>            
`;
                    categoriasContent.appendChild(div.content)
                })
                window.cuponeraInfo = null;
                this.onload = null;
            }
        }
    });

    const closeModalCupInfo = () => {
        console.log("xd")
        document.getElementById("cuponeraInfoModal").style.cssText = "display: none";
    }

</script>

<!DOCTYPE html>
<div id="cuponeraInfoModal" style="display: none;" class="w-screen z-[99999] transition-all h-screen min-h-screen md:p-0 p-4  fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 items-center justify-center transition-all">
    <div class="bg-white transition-all transition-opacity transition-all rounded-2xl md:p-12 p-4 border-gray-300 border md:w-3/5 w-full h-auto flex flex-col items-start justify-start gap-x-12 gap-y-6 relative">
        <%-- Close Button --%>
        <button id="closeButton" onclick="closeModalCupInfo()" class="w-10 transition-all h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <div class="w-full h-auto flex flex-row items-center justify-start gap-x-4">
            <img id="imageCup" class="overflow-hidden rounded-full object-cover w-10 h-10" src="" />
            <p id="cupTitle" class="text-gray-700 font-medium text-xl">Cuponera : </p>
        </div>

        <div id="categoriasContent" class="w-full min-w-full h-auto my-4 flex flex-row items-center justify-start flex-wrap gap-2">
            <p class="w-fit h-auto text-gray-700 font-semibold text-base">Categorias:</p>
        </div>
        
        <p id="cupTitle" class="text-gray-700 font-medium text-xl">Actividades: </p>

        <div  class="w-full max-w-full transition-all flex-grow h-full rounded-md border border-gray-300 shadow-sm flex flex-col max-h-[550px] items-center bg-whit justify-start overflow-auto">
            <div class="w-full flex flex-row  max-w-full items-center justify-start min-h-12 h-12 bg-gray-50 border-b border-gray-300 px-6">
                <p class="min-w-[30%] w-[30%] truncate h-auto text-sm text-gray-500 font-medium">Nombre</p>
                <p class="min-w-[30%] w-[30%] truncate h-auto text-sm text-gray-500 font-medium">Institucion</p>
                <p class="min-w-[15%] w-[15%] truncate h-auto text-sm text-gray-500 font-medium">Duracion</p>
                <p class="min-w-[15%] w-[15%] truncate h-auto text-sm text-gray-500 font-medium">Cant.Clases</p>
                <p class="min-w-[10%] w-[10%] truncate h-auto text-sm text-gray-500 font-medium">Descuento</p>
            </div>
            <div id="tablaContent" class="w-full max-w-full transition-all h-auto flex flex-col items-start justify-start">

            </div>

        </div>

    </div>

</div>



