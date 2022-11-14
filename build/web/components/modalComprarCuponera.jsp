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

    const getColorCat = (index) => {
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
            }).then((res) => {
                return res.json();
            }).then((data) => {
                console.log(data);
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
            $("#cuponeraDescuento").text(cuponeraInfo?.descuento + "%" + " de descuento en todas las actividades");
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
                <a href="verActividadInfo?actId=` + act?.id + `" class="cursor-pointer border-b-[1px] w-full h-max flex flex-col lg:flex-row items-center lg:justify-between py-2 lg:py-0 px-[24px]"">
                    <div class='flex gap-x-2 lg:gap-x-4 items-center'>
                        <img src="` + imageOfAct + `" class="rounded-full w-[48px] h-[48px] object-cover"/>
                        <p class="text-[#4F46E5] text-lg font-medium">` + act?.nombre + `</p>
                    </div>
                    <p class="text-gray-900 font-medium">Cantidad Clases: ` + act?.clases?.length || "0" + `</p>
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
                    <span style="background:` + getColorCat(index) + `" class="text-white text-sm font-semibold px-2 rounded-md">` + categoria + `</span>`;
                categoriasContentPrincipal.appendChild(div.content)
            })
            window.actividades = actividades;
            window.idCuponera = cuponeraInfo?.id;
        };
    })

</script>


<!DOCTYPE html>
<div style="display: none" id="cuponeraInfoSelected" class="w-full max-h-screen h-screen fixed z-[99999999] bg-[#6B7280] bg-opacity-60 top-0 left-0">
    <div class="py-6 w-full h-full justify-center items-center max-h-full overflow-auto">
        <div class="p-12 w-5/6 sm:w-4/5 md:w-3/5 xl:w-1/2 m-auto h-auto min-h-max rounded-2xl bg-white shadow-lg flex flex-col align-start justify-start relative gap-y-2 lg:gap-y-0"> <!-- TODO: HEIGHT  -->         
            <button onclick="handleGetInfoCuponera()" class="w-10 cursor-pointer h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
                <i class="fa-solid fa-xmark"></i>
            </button>
            <div class="w-full min-h-[248px] gap-x-6 flex flex-col lg:flex-row justify-between items-center">
                <div class="w-[142px] h-[142px] min-w-[142px] min-h-[142px]">
                    <img id="imageCup" alt="Cuponera Imagen" class="rounded-full w-[142px] h-[142px] object-cover absolute"/>
                </div>
                
                <div class="bg-white w-full h-max rounded-[8px] shadow-md flex flex-col border-[1px]">
                    <div class="border-b-[1px] w-full h-[64px] flex items-center justify-center lg:justify-start px-[24px]">
                        <p id="cuponeraNombre" class="font-[Inter] text-[18px] text-[#4F46E5] font-medium"></p>
                    </div>
                    <div class="border-b-[1px] w-full h-[60px] flex items-center">
                        <p class="text-[14px] text-[#6B7280] font-medium ml-4 w-16">Fecha Fin</p>
                        <p id="cuponeraFechaFin" class="text-[14px] font-normal text-[#111827] ml-3 md:ml-10"></p>
                    </div>
                    <div class="border-b-[1px] w-full h-[60px] flex items-center">
                        <p class="text-[14px] text-[#6B7280] font-medium ml-4 w-16">Descuento</p>
                        <p id="cuponeraDescuento" class="text-[14px] text-[#111827] ml-3 md:ml-10 truncate"></p>
                    </div>
                </div>    
            </div>
            <div>
                <p class="text-[18px] text-[#111827] font-medium w-24 pb-1 border-b-2">Categorias</p>
                <div id="categoriasContentPrincipal" class="w-full h-max flex items-center gap-x-0.5 py-2">
            </div>
                
            </div>
            <div class="w-full h-max flex flex-col lg:flex-row items-center justify-center gap-4">
                <div class="w-full flex flex-col items-start jusify-start gap-y-2 w-full md:w-4/5 lg:w-full">
                    <p class="font-semibold text-2xl text-gray-900">Actividades</p>
                    <div id="actividadesOfCuponera" class="bg-whiteself-center h-[322px] w-full max-h-[322px] overflow-auto rounded-[6px] shadow-md border-[1px] ">

                    </div>
                </div>
                <div class="h-max w-full md:w-4/5 lg:w-52 bg-white rounded-[6px] shadow-lg border flex flex-col p-5 gap-y-2 lg:self-end">
                    <div id="cuponeraPrecio" class="text-[#4F7994] text-[60px] font-extrabold text-center"></div>
                    <p class="text-center md:text-start text-gray-500 text-[18px]">Precio unico para esta cuponera abonando con cualquier metodo de pago</p>
                    <button onclick="handleComprarCuponera()" class="w-full h-12 bg-[#4F7994] rounded-[6px] text-[#FFFFFF] text-[16px] font-medium">Comprar</button>
                </div>
            </div>
        </div>
    </div>
</div>