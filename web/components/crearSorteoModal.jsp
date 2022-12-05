<%-- 
    Document   : crearSorteoModal
    Created on : 15 nov. 2022, 21:18:14
    Author     : maximilianoolivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    const closeModalRealizarSorteo = () => {
        document.getElementById("realizarSorteoModal").style.cssText = "display: none";
    }

    const handleOpenResultadosSorteoModal = () => {
        document.getElementById("resultadosSorteoModal").style.cssText = "display: block";
        closeModalRealizarSorteo();
    }

    const handleSortearButton = (idPremio, claseId, cantidadSorteados) => {
        const url = '/entrenamosUY3/sortearPremio?premioId=' + idPremio;

        let timerInterval


        window.fetch(url, {
            method: "POST",
        }).then((response) => {
            return response.json();
        }).then((data) => {
            Swal.fire({
                title: 'Realizando sorteo...',
                html: 'Estamos realizando el sorteo, finalizara en <b></b>s.',
                timer: 2000,
                timerProgressBar: true,
                didOpen: () => {
                    Swal.showLoading()
                    const b = Swal.getHtmlContainer().querySelector('b')
                    timerInterval = setInterval(() => {
                        b.textContent = Number(Swal.getTimerLeft() / 600).toFixed(0);
                    }, 100)
                },
                willClose: () => {
                    clearInterval(timerInterval)
                }
            }).then((result) => {
                console.log(result);
                if (result.dismiss === Swal.DismissReason.timer) {
                }
                handleOpenResultadosSorteoModal();
            })
            document.getElementById("resultadosSorteoModal").onload(data, claseId, cantidadSorteados);
        }).catch((err) => {
            console.log(err);
        });
    }

    $(document).ready(function () {
        document.getElementById("realizarSorteoModal").onload = (data) => {
            const parentElement = document.getElementById("listOfSociosPorSorteo");
            const participantesCount = document.getElementById("participantesCount");
            const cantidadGanadores = document.getElementById("numeroDeGanadores");
            const sortearButton = document.getElementById("sortearButton");
            const registros = data.registros || [];
            const claseId = data.id;
            console.log(data);
            const premioInfo = data?.premio;
            if (parentElement) {
                sortearButton.onclick = () => handleSortearButton(premioInfo.id, claseId, data?.registros?.length);
                while (parentElement.firstChild) {
                    parentElement.removeChild(parentElement.lastChild);
                }
                participantesCount.textContent = registros.length;
                cantidadGanadores.textContent = premioInfo.cantidadSorteados;
                registros.forEach((registro) => {
                    const socioInfo = registro?.socio;
                    var element = document.createElement("template");
                    const socioNombre = socioInfo.NOMBRE + " " + socioInfo.APELLIDO;
                    const userId = socioInfo.ID;

                    var imgsrc = socioInfo.blobImage ? "data:image/jpg;base64," + btoa(new Uint8Array(socioInfo.blobImage).reduce(function (data, byte) {
                        return data + String.fromCharCode(byte);
                    }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"

                    element.innerHTML = `
                    <div class="w-[200px] h-auto flex flex-col px-4 py-4 items-center justify-start shadow-md border border-gray-100 rounded-lg">
                        <div class="w-[70px] h-[70px] rounded-full shadow-md mb-1">
                            <img src="` + imgsrc + `" class="w-full h-full object-cover rounded-full" />
                        </div>
                        <p class="font-medium text-sm flex-grow text-gray-900 text-left truncate max-w-full">
                            <i class="fa-solid fa-signature"></i><span>` + socioNombre + `</span>
                        </p>
                        <p class="font-medium text-sm flex-grow text-gray-900 text-left truncate max-w-full">
                            <i class="fa-solid fa-envelope mr-1"></i>
                            <span>` + socioInfo.EMAIL + `</span>
                        </p>
                        <a href="verPerfil?&userID=` + userId + `" class="font-medium transition-all cursor-pointer hover:underline text-sm mt-4 flex-grow text-indigo-800 text-center truncate max-w-full">Perfil ></a>
                    </div>`
                    parentElement.appendChild(element.content);
                })

            }
        }
    });

</script>

<div id="realizarSorteoModal" style="display: none;" class="w-full h-full min-h-screen z-[99999] py-6 fixed top-0 left-0 right-0 bottom-0 max-h-full overflow-auto bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white transition-all transition-opacity rounded-2xl md:p-12 p-4 border-gray-300 border m-auto md:max-w-[650px] max-w-[90%] w-full h-auto flex flex-col gap-4 md:items-start items-center justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModalRealizarSorteo()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <div class="flex-col flex w-full items-center justify-start gap-y-12">
            <h1 class="text-gray-800 font-semibold text-lg">Realizar sorteo</h1>

            <div class="w-full h-auto flex flex-col items-center justify-center ">
                <h2 class="text-base font-semibold text-indigo-800">Numero de ganadores: (<span id="numeroDeGanadores"></span>) </h2>
                <h2 class="text-base font-semibold text-indigo-800">Participantes: (<span id="participantesCount"></span>) </h2>

                <div id="listOfSociosPorSorteo" class="w-full py-4 h-auto max-h-[400px] overflow-auto mt-4 flex flex-row items-center justify-center gap-4 flex-wrap">
                </div>
            </div>

            <button id="sortearButton" class="px-4 py-2 text-white rounded-md bg-indigo-800 hover:bg-indigo-900 transition-all transform hover:scale-105">
                Sortear
            </button>
        </div>

    </div>
</div>