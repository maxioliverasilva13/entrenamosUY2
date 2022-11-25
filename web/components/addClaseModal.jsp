<%-- 
    Document   : infoClaseModal
    Created on : 29/09/2022, 08:26:58 PM
    Author     : Maximiliano Olivera

    Esta pagina es solo para socios logueados
--%>


<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="Clase.DtClase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
</head>

<script>

    const onClaseAddedSuccess = (data) => {
        const listOfClasesDiv = document.getElementById("clasesListadoFromActInfo");
        if (listOfClasesDiv != null) {
            const clase = data;
            var imgsrc = data?.imageBlob ? "data:image/jpg;base64," + btoa(new Uint8Array(clase.imageBlob).reduce(function (data, byte) {
                return data + String.fromCharCode(byte);
            }, '')) : "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png";

            var div = document.createElement('template');
            div.innerHTML = `
                <a onclick="handleGetClase(` + clase?.id + `, true)" class="w-full cursor-pointer flex flex-row items-center justify-start h-16 border-b border-gray-300 px-6">
                    <div class="w-[15%] h-auto flex items-center justify-center">
                        <img
                        src="` + imgsrc + `"
                            class="w-8 h-8 object-cover rounded-full overflow-hidden"
                            />
                        </div>
                        <p class="w-[25%] h-auto tex%>')"t-sm text-gray-500 font-medium">` + clase?.nombre + `</p>
                        <p class="w-[20%] h-auto text-sm text-gray-500 font-medium">` + clase?.profesor + `</p>
                        <p class="w-[25%] h-auto text-sm text-gray-500 font-medium">0</p>
                        <p class="w-[15%] h-auto text-sm text-gray-500 font-medium">` + clase?.fecha + `</p>
            </a>
`;
            listOfClasesDiv.appendChild(div.content);
        }
    }

    function quitImage() {
        const claseImage = document.getElementById("claseImage");
        claseImage.classList.add("hidden");
        const inputFileContainer = document.getElementById("inputFileContainer");
        inputFileContainer.classList.remove("hidden");
        inputFileContainer.classList.add("flex");
        var output = document.getElementById('avatar');
        output.src = null;
    }

    const toggleItem = (id, onlyHide) => {
        const element = document.getElementById(id);
        if (onlyHide === true) {
            if (element.style.display === "block") {
                element.style.cssText = "display: none";
            }
        } else if (onlyHide === false) {
            if (element.style.display === "none" || element.style.display === "") {
                element.style.cssText = "display: block";
            }
        } else {
            if (element.style.display === "none") {
                element.style.cssText = "display: block";
            } else {
                element.style.cssText = "display: none";
            }
        }

    }

    var loadSelectedFile = function (event) {
        const claseImage = document.getElementById("claseImage");
        claseImage.classList.remove("hidden");
        claseImage.classList.add("flex");
        claseImage.classList.add("justify-center");
        const inputFileContainer = document.getElementById("inputFileContainer");
        inputFileContainer.classList.add("hidden");
        var output = document.getElementById('avatar');
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }
    };
    function getByteArray(file) {
        return new Promise(function (resolve, reject) {
            let fileReader = new FileReader();
            fileReader.readAsArrayBuffer(file);
            fileReader.onload = function (ev) {
                const array = new Uint8Array(ev.target.result);
                const fileByteArray = [];
                for (let i = 0; i < array.length; i++) {
                    fileByteArray.push(array[i]);
                }
                resolve(array); // successful
            }
            fileReader.onerror = reject; // call reject if error
        })
    }

    const urlToCreateClass = "/entrenamosUY3/insertarClase";
    const handleCreateClase = (imgSrc) => {
        const nombre = $("#nombreClase").val();
        const sociosMin = $("#sociosMinClase").val();
        const sociosMax = $("#sociosMaxClase").val();
        const urlAcceso = $("#urlAccesoClase").val();
        const fechaClase = $("#fechaClase").val();
        const cantidadSorteados = $("#cantidadSorteados").val();
        const nombrePremio = $("#nombrePremio").val();

        const needsValidation = (nombrePremio != "" && nombrePremio != null) || ((cantidadSorteados != "" && cantidadSorteados != null) || cantidadSorteados > 0)
        if (needsValidation) {
            if (nombrePremio != "" || nombrePremio != null) {
                if (cantidadSorteados == 0 || cantidadSorteados == null) {
                    $("#errorCantidadCreados").text("Debes ingresar una cantidad de sorteados");
                    toggleItem("errorCantidadCreados", false)
                    return;
                } else {
                    toggleItem("errorCantidadCreados", true)
                }
            }
            if (cantidadSorteados != 0 || cantidadSorteados != null) {
                if (nombrePremio == "" || nombrePremio == null) {
                    $("#errorNombrePremio").text("Debes ingresar un nombre de sorteo");
                    toggleItem("errorNombrePremio", false)
                    return;
                }
                toggleItem("errorNombrePremio", true)
            }

            if (!(parseInt(cantidadSorteados) <= parseInt(sociosMax) && parseInt(cantidadSorteados) >= parseInt(sociosMin))) {
                $("#errorCantidadCreados").text("Los sorteados no cumple con el rango de socios aceptados");
                toggleItem("errorCantidadCreados", false)
                return;
            }
        }

        toggleItem("errorNombrePremio", true)
        toggleItem("errorCantidadCreados", true)

        fetch(urlToCreateClass, {
            method: "POST",
            body: JSON.stringify({
                nombre,
                sociosMin,
                sociosMax,
                urlAcceso,
                fechaClase,
                idActividad,
                idProfesor,
                profesorNombre,
                fileToSend: imgSrc,
                cantidadSorteados,
                nombrePremio
            })
        })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    Swal.fire({
                        icon: data?.success ? 'success' : 'error',
                        title: data?.success ? 'Clase insertada correctamente' : "Error insertando la clase",
                        text: data.message
                    });
                    if (data?.success) {
                        onClaseAddedSuccess(data?.data)
                    }
                    toggleItem("addClaseModal");
                })
                .catch((err) => {
                    console.log(data);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error agregando la actividad',
                        text: err.message
                    });
                });
    }

    const handleSubmit = (e) => {
        e.preventDefault();
        alert("llego");
        const files = $("#inputFile").prop('files');
        const fileToSend = files[0];
        if (fileToSend != null) {
            getByteArray(fileToSend).then((byteArray) => {
                // do whatever you need
                var imgsrc = btoa(new Uint8Array(byteArray).reduce(function (data, byte) {
                    return data + String.fromCharCode(byte);
                }, ''));
                handleCreateClase(imgsrc);
            })
        } else {
            handleCreateClase(null);
        }

    }

    $(document).ready(function () {
        $("#addClaseForm").on("submit", (e) => handleSubmit(e));
    })
</script>

<!DOCTYPE html>
<jsp:include page="../imports.jsp" />
<style>
    .mainModal {
        animation: opac .2s ease;
    }

    @keyframes opac {
        from {
            margin-right: -500px;
        }
        to {
            margin-right: 0px;
        }
    }

    .messageModal {
        animation: scale .2s ease;
    }

    @keyframes scale {
        from {
            transform: scale(0.5);
        }
        to {
            transform: scale(1);
        }
    }
</style>

<div id="addClaseModal" style="display: none" class="w-full h-full z-[99999] py-4 max-h-full overflow-auto transition-all delay-150 fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 transition-all">
    <div class="w-auto mx-auto mt-12 min-h-max md:min-w-[600px] min-w-[90%] h-fit px-4 py-6 bg-white relative flex flex-col items-center justify-start rounded-2xl shadow-lg delay-500 transition-opacity mainModal">
        <button onclick="toggleItem('addClaseModal')" id="closeAddClaseButton"  class="w-10 outline-none transition-all h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <p class="text-lg font-medium text-gray-800">Agregar una nueva clase</p>

        <form id="addClaseForm" onsubmit="handleSubmit(event)" method="POST" class="w-full h-auto flex flex-col items-center justify-start gap-4">
            <div class="w-full my-4" id="inputFileContainer">
                <label
                    class="flex justify-center w-full h-32 px-4 transition bg-white border-2 border-gray-300 border-dashed rounded-md appearance-none cursor-pointer hover:border-gray-400 focus:outline-none">
                    <span class="flex items-center space-x-2">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-gray-600" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                        </svg>
                        <span class="font-medium text-gray-600">
                            Drop files to Attach, or
                            <span class="text-blue-600 underline">browse</span>
                        </span>
                    </span>
                    <input type="file" id="inputFile" value="" name="file_upload" class="hidden" accept="image/*" onchange="loadSelectedFile(event)"/>
                </label>
            </div>
            <div class="w-full h-auto hidden flex flex-col items-start justify-start overflow-hidden" id="claseImage">
                <img id="avatar" class="max-w-full object-cover max-h-[150px] rounded-lg" src="" alt="Clase Imagen">
                <figcaption class="mt-2 text-sm text-center text-gray-500 dark:text-gray-400">
                    <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="quitImage()">Quitar imagen</button>
                </figcaption>
            </div>

            <div class="flex-1 w-full ">
                <label for="nombreClase" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre</label>
                <input required="true" type="text" id="nombreClase" name="nombreClase" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Nombre:" />
            </div>

            <div class="flex-1 w-full ">
                <label for="sociosMinClase" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Socios Minimos</label>
                <input min="1" required="true" type="number" id="sociosMinClase" name="sociosMinClase" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Socios Minimos:" />
            </div>

            <div class="flex-1 w-full ">
                <label for="sociosMaxClase" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Socios Maximos</label>
                <input min="1" required="true" type="number" id="sociosMaxClase" name="sociosMaxClase" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Socios Maximos:" />
            </div>

            <div class="flex-1 w-full ">
                <label for="urlAccesoClase" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Url Acceso</label>
                <input required="true" type="text" id="urlAccesoClase" name="urlAccesoClase" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="UrlAcceso" />
            </div>

            <div class="flex-1 w-full ">
                <label for="fechaClase" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha Clase</label>
                <div class="relative">
                    <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                        <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                    </div>
                    <input required="true" datepicker datepicker-format="dd/mm/yyyy" name="fechaClase" id="fechaClase" datepicker="" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 datepicker-input" placeholder="Select date" />
                </div>
            </div>



            <div class="w-full h-auto flex flex-col items-start my-4 gap-y-6">
                <p class="text-gray-900 font-bold text-[20px]">Premios</p>


                <div class="flex-1 w-full ">
                    <label for="nombrePremio" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre premio</label>
                    <input type="text" id="nombrePremio" name="nombrePremio" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Nombre premio" />
                    <p id="errorNombrePremio" class="hidden text-red-600 font-medium text-sm my-2">Error</p>

                </div>

                <div class="flex-1 w-auto">
                    <label for="cantidadSorteados" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre premio</label>
                    <input min="1" type="number" id="cantidadSorteados" name="cantidadSorteados" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Cantidad Sorteados" />
                    <p id="errorCantidadCreados" class="hidden text-red-600 font-medium text-sm my-2">Error</p>
                </div>
            </div>

            <input class="w-full h-auto py-2 px-4 text-white rounded-md bg-indigo-700 cursor-pointer hover:bg-indigo-800 transition-all"  type="submit"/>
        </form>
    </div>
</div>
