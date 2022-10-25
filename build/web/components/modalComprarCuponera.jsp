<%-- 
    Document   : modalEditarInfoSocio
    Created on : 3 oct. 2022, 17:57:24
    Author     : pedri
--%>

<jsp:include page='../imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>

    var listOfColors = ["#468990", "#299D91", "#FFF4B8", "#F98F37", "#DE3C31"];

    const getColor = (index) => {
        return listOfColors[index % 4];
    }

    const handleComprarCuponera = () => {
        Swal.fire({
            title: 'Comprando su cuponera...😊',
            timer: 2000,
            textContent: "Comprando su cuponera...😊",
            timerProgressBar: true,
            didOpen: () => {
                Swal.showLoading()
            },
            willClose: () => {
                // clearInterval(timerInterval)
            }
        }).then((result) => {
            /* Read more about handling dismissals below */
            var actividadesIds = window?.actividades?.map((item) => item?.id);
            var idCuponera = window?.idCuponera;

            window?.fetch("/entrenamosUY3/comprarCuponera", {
                method: "POST",
                body: JSON.stringify({
                    idCuponera,
                    actividadesIds,
                })
            }).then((data) => {
                if (data?.success) {
                    Swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Compraste la cuponera correctamente!',
                        showConfirmButton: false,
                    });
                    document.getElementById("cuponeraInfoSelected").style.cssText = "display: none;";
                    const parentElement = document.getElementById("cuponerasDisponiblesModalView");
                    if (parentElement) {
                        parentElement.style.cssText = "display: none;";
                    }
                } else {
                    Swal.fire({
                        position: 'center',
                        icon: 'error',
                        title: 'Error al comprar la cuponera',
                        textContent: data?.message,
                        showConfirmButton: false,
                    });
                }
            })
                    .catch((e) => {
                        Swal.fire({
                            position: 'center',
                            icon: 'error',
                            title: 'Error al comprar la cuponera',
                            textContent: e?.getMessage(),
                            showConfirmButton: false,
                        });
                    })


        })
    }

    $(document).ready(function () {
        document.getElementById("cuponeraInfoSelected").onload = () => {
            const cuponeraInfo = window?.cuponeraSelectedInfo;
            $("#cuponeraNombre").text(cuponeraInfo?.nombre);
            $("#cuponeraFechaFin").text(cuponeraInfo?.periodoVigencia);
            //const precioFinal = cuponeraInfo?.precio - ((cuponeraInfo?.precio * cuponeraInfo?.descuento)/ 100);
            $("#cuponeraDescuento").text("%" + cuponeraInfo?.descuento + " de descuento en todas las actividades");
            $("#cuponeraPrecio").text("$" + cuponeraInfo?.precio);
            var imgsrc = cuponeraInfo.blobImage ? "data:image/jpg;base64," + btoa(new Uint8Array(cuponeraInfo.blobImage).reduce(function (data, byte) {
                return data + String.fromCharCode(byte);
            }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"
            document.getElementById("imageCup").setAttribute("src", imgsrc);

            //fill categorias
            const listOfCupXActividades = cuponeraInfo?.cuponerasXActividad || {};
            var categorias = [];
            var actividades = [];

            Object.keys(listOfCupXActividades).forEach((idCupXA) => {
                const actInfo = listOfCupXActividades[idCupXA]?.actividad;
                actividades?.push(actInfo);
                const categoriasOfAct = actInfo?.categorias || {};
                Object.keys(categoriasOfAct).forEach((cat) => {
                    const catInfo = categoriasOfAct[cat];
                    if (!categorias.includes(catInfo?.nombre)) {
                        categorias.push(catInfo?.nombre);
                    }
                })
                actInfo?.categorias?.forEach((cat) => {

                })
            })

            const actividadesOfCuponeraList = document.getElementById("actividadesOfCuponera");
            while (actividadesOfCuponeraList.hasChildNodes()) {
                actividadesOfCuponeraList.removeChild(actividadesOfCuponeraList.lastChild);
            }
            actividades.forEach((act) => {
                var element = document.createElement("template");

                var imageOfAct = act.imageBlob ? "data:image/jpg;base64," + btoa(new Uint8Array(act.imageBlob).reduce(function (data, byte) {
                    return data + String.fromCharCode(byte);
                }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"

                element.innerHTML = `
                <a href="verActividadInfo?actId=` + act?.id + `" class="cursor-pointer border-b-[1px] w-full h-[80px] flex flex-row items-center justify-between px-[24px]"">
                    <img src="` + imageOfAct + `" class="rounded-full w-[48px] h-[48px] object-cover"/>
                    <p class="text-[#4F46E5] text-[14px] font-medium ml-[16px]">` + act?.nombre + `</p>
                    <p class="text-lg text-gray-900 font-medium">Cantidad Clases:` + act?.clases?.length || "0" + `</p>
                </a>
                `;
                actividadesOfCuponeraList.appendChild(element.content);
            });

            const categoriasContentPrincipal = document.getElementById("categoriasContentPrincipal");
            while (categoriasContentPrincipal.hasChildNodes()) {
                categoriasContentPrincipal.removeChild(categoriasContentPrincipal.lastChild);
            }
            categorias.map((categoria, index) => {
                var div = document.createElement('template');
                div.innerHTML = `
                    <span style="background:` + getColor(index) + `" class="text-white text-xs font-semibold mr-2 px-2.5 py-0.5 rounded">` + categoria + `</span>`;
                categoriasContentPrincipal.appendChild(div.content)
            })
            window.actividades = actividades;
            window.idCuponera = cuponeraInfo?.id;
        };
    })

</script>


<!DOCTYPE html>
<div style="display: none" id="cuponeraInfoSelected" class="w-screen h-screen fixed z-[99999999] bg-[#6B7280] bg-opacity-60 max-h-screen overflow-auto top-0 left-0">
    <div class="h-full w-full my-16 flex justify-center items-center">
        <div class="w-[1104px] h-[825px]  rounded-[10px] bg-[#FFFFFF] shadow-lg flex flex-col align-start justify-start relative">           
            <button onclick="handleGetInfoCuponera()" class="w-10 cursor-pointer h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
                <i class="fa-solid fa-xmark"></i>
            </button>
            <div class="w-full h-[248px] mt-[88px] flex flex-row relative">
                <img id="imageCup" alt="Cuponera Imagen" class="rounded-full w-[142px] h-[142px] ml-[85px] object-cover absolute"/>
                <p class="text-[18px] text-[#111827] font-medium h-[44px] w-[238px] border-b-[1px] mt-[204px] ml-[41px] absolute">Categorias</p>
                <div class="bg-[#FFFFFF] w-[744px] h-[248px] rounded-[8px] shadow-md ml-[322px] flex flex-col absolute border-[1px]">
                    <div class="border-b-[1px] w-full h-[64px] flex items-center px-[24px]">
                        <p id="cuponeraNombre" class="text-[18px] text-[#111827] font-medium"></p>
                    </div>
                    <div class="border-b-[1px] w-full h-[60px] flex items-center px-[24px]">
                        <p class="text-[14px] text-[#6B7280] font-medium w-[221px]">Fecha Fin</p>
                        <p id="cuponeraFechaFin" class="text-[14px] font-normal text-[#111827] ml-[16px]"></p>
                    </div>
                    <div class="w-full h-[60px] flex items-center px-[24px]">
                        <p class="text-[14px] text-[#6B7280] font-medium w-[221px]">Descuento</p>
                        <p id="cuponeraDescuento" class="text-[20] font-medium text-[#111827] ml-[16px]"></p>
                    </div>
                </div>    
            </div>
            <div id="categoriasContentPrincipal" class="w-full h-[95px] flex items-center px-[33px]">

            </div>
            <div class="w-full h-[322px] flex flex-row align-center justify-center gap-x-[82px] px-[33px]">
                <div class="flex flex-col items-start jusify-start gap-y-2">
                    <p class="font-semibold text-2xl text-gray-900">Actividades</p>
                    <div id="actividadesOfCuponera" class="bg-[#FFFFFF] w-[656px] h-[322px] max-h-[322px] overflow-auto rounded-[6px] shadow-md border-[1px] ">

                    </div>
                </div>
                <div class="bg-[#FFFFFF] flex-grow h-auto rounded-[6px] shadow-lg flex flex-col px-[24px]">
                    <div id="cuponeraPrecio" class="text-[#4F7994] text-[60px] font-extrabold mt-[32px]"></div>
                    <p class="text-gray-500 text-[18px] mt-[20px]">Precio unico para esta cuponera abonando con cualquier metodo de pago</p>
                    <button onclick="handleComprarCuponera()" class="w-full h-[50px] bg-[#4F7994] rounded-[6px] mt-[16px] text-[#FFFFFF] text-[16px] font-medium">Comprar</button>
                </div>
            </div>
        </div>
    </div>
</div>