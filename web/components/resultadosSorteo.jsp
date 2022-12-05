<%-- 
    Document   : crearSorteoModal
    Created on : 15 nov. 2022, 21:18:14
    Author     : maximilianoolivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    const closeModalResultadosSorteo = () => {
        document.getElementById("resultadosSorteoModal").style.cssText = "display: none";
    }

    $(document).ready(function () {
        document.getElementById("resultadosSorteoModal").onload = (data, claseId, cantidadSorteados) => {
            const countSorteados = cantidadSorteados ? cantidadSorteados : 0;
            const ganadores = data.data;
            const parentElement = document.getElementById("listadoGanadores");
            handleGetClase(claseId, false);
            while (parentElement.firstChild) {
                parentElement.removeChild(parentElement.lastChild);
            }
            if (parentElement) {
                ganadores.forEach((usuarioGanador) => {
                    const socioInfo = usuarioGanador;
                    var element = document.createElement("template");
                    const socioNombre = socioInfo.nombre + " " + socioInfo.nombre;
                    const userId = socioInfo.id;
                    const totalParticipantesText = $("#totalParticipantes");
                    const totalGanadoresText = $("#totalGanadores");

                    totalGanadoresText.text(ganadores?.length);
                    totalParticipantesText.text(cantidadSorteados);

                    var imgsrc = socioInfo.blobImage ? "data:image/jpg;base64," + btoa(new Uint8Array(socioInfo.blobImage).reduce(function (data, byte) {
                        return data + String.fromCharCode(byte);
                    }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png"

                    element.innerHTML = `
                    <div class="w-[200px] h-auto flex flex-col px-4 py-4 items-center justify-start shadow-md border border-gray-100 rounded-lg">
                        <div class="w-[70px] h-[70px] rounded-full bg-red-500 shadow-md mb-1">
                            <img src="` + imgsrc + `" class="w-full h-full object-cover rounded-full" />
                        </div>
                        <p class="font-medium text-sm flex-grow text-gray-900 text-left truncate max-w-full">
                            <i class="fa-solid fa-signature"></i><span>` + socioNombre + `</span>
                        </p>
                        <p class="font-medium text-sm flex-grow text-gray-900 text-left truncate max-w-full">
                            <i class="fa-solid fa-envelope mr-1"></i>
                            <span>` + socioInfo.email + `</span>
                        </p>
                        <a href="verPerfil?&userID=` + userId + `" class="font-medium transition-all cursor-pointer hover:underline text-sm mt-4 flex-grow text-indigo-800 text-center truncate max-w-full">Perfil ></a>
                    </div>`
                    parentElement.appendChild(element.content);
                })

            }
        }
    });

</script>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .birthday-gift {
        position: relative;
        z-index: 999999999999;
        margin-top: 90px;
    }

    .birthday-gift:before {
        content:"";
        position: absolute;
        width: 170px;
        height:20px;
        border-radius:50%;
        background-color: rgba(0,0,0,0.4);
        top:90px;
        left:-10px;
    }

    input#click {
        display: none;
    }

    .gift {
        position: relative;
        width: 150px;
        height: 100px;
        background-color: #e9c46a;
    }

    .gift:before {
        content:"";
        position: absolute;
        width: 25px;
        height: 100px;
        background-color: #e76f51;
        left:62px;
    }

    .gift:after {
        content:"";
        position: absolute;
        box-shadow: inset 0 10px rgba(0,0,0,0.3);
        width: 150px;
        height: 100px;
    }

    .click {
        position: absolute;
        background-color: #e9c46a;
        width: 170px;
        height: 40px;
        top:-40px;
        left:-10px;
        transform-origin: bottom left;
        transition: .3s;
        cursor: pointer;
    }

    .click:before {
        content:"";
        position: absolute;
        width: 25px;
        height: 40px;
        background-color: #e76f51;
        left:69px;
    }

    .click:after {
        content:"";
        position: absolute;
        width: 5px;
        height: 0;
        border-bottom: 30px solid #e76f51;
        border-top: 30px solid #e76f51;
        border-left: 0px solid transparent;
        border-right: 30px solid transparent;
        transform: rotate(-90deg);
        left:65px;
        top:-47px;
    }

    #click:checked + .click {
        transform: rotate(-110deg) scaleX(0.85);
    }

    .wishes {
        position: absolute;
        transition: .5s;
        color: #333;
        font-size: 28px;
        text-align: center;
        z-index:-1;
        left:-20px;
        z-index: 999999999999999999;
    }

    #click:checked ~ .wishes {
        transform: translateY(-100px);
    }

    #click:checked ~ .sparkles {
        display: block;
    }



    .sparkles {
        position: absolute;
        display: none;
        top:-15px;
        z-index:-2;
        left:40px;
    }

    .spark1, .spark2, .spark3, .spark4, .spark5, .spark6 {
        position: absolute;
        background-color: #fee440;
        border-radius:50%;
        top:-9px;
        z-index:-1;
    }

    .spark1 {
        width: 8px;
        height:8px;
        left:30px;
        top:-9px;
        animation: fire 0.9s ease-in-out infinite, color 0.4s linear infinite;
    }

    .spark1:before {
        content:"";
        position: absolute;
        width:5px;
        height:5px;
        top:8px;
        left:11px;
        background-color: #fee440;
        border-radius:50%;
    }

    .spark2 {
        width: 9px;
        height:9px;
        left:33px;
        top:-5px;
        animation: fire2 0.28s ease-in-out infinite, color 0.4s linear infinite;
    }

    .spark2:before {
        content:"";
        position: absolute;
        width:5px;
        height:5px;
        top:12px;
        left:3px;
        background-color: #fee440;
        border-radius:50%;
    }

    .spark3 {
        width: 8.5px;
        height:8.5px;
        left:33px;
        top:-5px;
        animation: fire3 0.36s ease-in-out infinite, color2 0.4s linear infinite;
    }

    .spark3:before {
        content:"";
        position: absolute;
        width:5px;
        height:5px;
        top:12px;
        left:-1px;
        background-color: #fee440;
        border-radius:50%;
    }

    .spark4 {
        width: 7px;
        height:7px;
        left:27px;
        top:-5px;
        animation: fire2 0.24s ease-in-out infinite, color2 0.2s linear infinite;
    }

    .spark5 {
        width: 7px;
        height:7px;
        left:29px;
        top:-5px;
        animation: fire3 0.45s ease-in-out infinite, color 0.2s linear infinite;
    }

    .spark6 {
        width: 6px;
        height:6px;
        left:29px;
        top:-5px;
        animation: fire 0.35s ease-in-out infinite, color2 0.2s linear infinite;
    }

    @keyframes fire3 {
        100% {
            transform:translateX(20px) translateY(-93px);
            opacity: 0.3;
        }
    }

    @keyframes fire2 {
        100% {
            transform:translateX(-5px) translateY(-90px);
            opacity: 0.3;
        }
    }

    @keyframes fire {
        100% {
            transform:translateX(-25px) translateY(-95px);
            opacity: 0.3;
        }
    }

    @keyframes color {
        from {
            background-color: #d00000;
        }
        to {
            background-color: #0081a7;
        }
    }

    @keyframes color2 {
        from {
            background-color: #8cff00;
        }
        to {
            background-color: #1d2d44;
        }
    }




</style>
<div id="resultadosSorteoModal" style="display: none;" class="w-full h-full min-h-screen z-[999999] py-6 fixed top-0 left-0 right-0 bottom-0 max-h-full overflow-auto bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="bg-white mt-16 transition-all transition-opacity rounded-2xl md:p-12 p-4 py-6 border-gray-300 border m-auto md:max-w-[650px] max-w-[90%] w-full h-auto flex flex-col gap-4 md:items-start items-center justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModalResultadosSorteo()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <div class="flex-col flex w-full items-center justify-start gap-y-12">
            <h1 class="text-gray-800 text-center font-semibold text-lg">Ganadores:</h1>

            <p class="text-base font-medium text-gray-900 mt-6">De los <span id="totalParticipantes" class="font-bold text-black text-base"></span> participantes del sorteo , solo  <span id="totalGanadores" class="font-bold text-black text-base"></span>  se llevaron el premio de <span class="text-black font-bold text-base" id="premioNombre">Tele 32</span></p>
            <div class="birthday-gift transform md:scale-[0.9] scale-[0.7]">
                <div class="gift">
                    <input checked id='click' type='checkbox'>
                    <label class='click' for='click'></label>
                    <div class="wishes">Felicitaciones!</div>
                    <div class="sparkles">
                        <div class="spark1"></div>
                        <div class="spark2"></div>
                        <div class="spark3"></div>
                        <div class="spark4"></div>
                        <div class="spark5"></div>
                        <div class="spark6"></div>
                    </div>
                </div>
            </div>

            <div class="w-full h-auto flex flex-col items-start justify-start ">
                <div id="listadoGanadores" class="w-full md:pt-8 mt-2 h-auto max-h-[400px] overflow-auto mt-4 flex flex-row items-center justify-center gap-4 flex-wrap">
                </div>
            </div>

        </div>

    </div>
</div>