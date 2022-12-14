<%-- 
    Document   : signup
    Created on : 6 oct 2022, 21:18:58
    Author     : rodrigo
--%>

<%@page import="ws.DtInstitucion"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>


<%
    HashMap<Integer, DtInstitucion> ins = new HashMap<Integer, DtInstitucion>();
    try {
        if (request.getAttribute("instituciones") != null) {
            ins = (HashMap<Integer, DtInstitucion>) request.getAttribute("instituciones");
            request.setAttribute("instituciones", ins);
        }

    } catch (Exception e) {
    }
%>


<script>
    const handleCheckEmail = (value) => {
        const email = value;
        const url = '/entrenamosUY3/consultarSocioByEmail?email=' + email;

        window.fetch(url)
                .then((response) => response.json())
                .then((data) => {
                    const isValid = data?.data === false;
                    const errorEmailLabel = document.getElementById("errorEmail");
                    const submitButton = document.getElementById("submitButton");
                    if (errorEmailLabel) {
                        if (isValid) {
                            errorEmailLabel.style.cssText = "display: none";
                            submitButton.disabled = false;
                        } else {
                            $("#errorEmail").text("Ya existe un usuario con este email")
                            errorEmailLabel.style.cssText = "display: flex";
                            submitButton.disabled = true;
                        }
                    }

                })

    }

    const handleCheckNickname = (value) => {
        const email = value;
        const url = '/entrenamosUY3/consultarSocioByNickname?nickname=' + email;

        window.fetch(url)
                .then((response) => response.json())
                .then((data) => {
                    const isValid = data?.data === false;
                    const errorNicknameLabel = document.getElementById("errorNickname");
                    const submitButton = document.getElementById("submitButton");
                    if (errorNicknameLabel) {
                        if (isValid) {
                            errorNicknameLabel.style.cssText = "display: none";
                            submitButton.disabled = false;
                        } else {
                            $("#errorNickname").text("Ya existe un usuario con este nickname")
                            errorNicknameLabel.style.cssText = "display: flex";
                            submitButton.disabled = true;
                        }
                    }

                })

    }


    $(document).ready(() => {
        console.log("xd");
        const inputElement = document.getElementById("checkEmailInput");
        const inputNickname = document.getElementById("checkNicknameError");
        if (inputElement) {
            inputElement.addEventListener("input", (e) => {
                const value = e?.target?.value;
                handleCheckEmail(value);
            })
        }
        if (inputNickname) {
            inputNickname.addEventListener("input", (e) => {
                const value = e?.target?.value;
                handleCheckNickname(value);
            })
        }
    })
</script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

    </head>
    <body class=" w-full h-full bg-cover bg-no-repeat md:bg-[url('https://res.cloudinary.com/dwh8j7fys/image/upload/v1665238297/natacion_twsiuc.jpg')] "">
        <form action="SignUp" method="post"  id="registration" enctype="multipart/form-data">
            <div class="w-full w-h flex justify-end">
                <div class="bg-white md:basis-3/4 w-full">
                    <div class="w-full flex justify-center mt-5 " id="form" >
                        <div class="w-3/4 overflow-y-auto pb-20 min-h-[100vh] mb-5">
                            <%
                                if (request.getAttribute("invalid-signup") != null) {
                            %>
                            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                                <strong class="font-bold">Authenticacion incorrecta!</strong>
                                <span class="block sm:inline"><%= request.getAttribute("invalid-signup")%> </span>
                                <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                                    <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                                </span>
                            </div>
                            <%
                                } %>

                            <h1 class="font-['Inter'] text-3xl text-center ">Registro de nuevo usuario</h1>
                            <p class="mt-5 text-[#6B7280] m-auto">
                                <span class="font-['Inter'] font-semibold text-[#000]">Profile</span>
                                <br>
                                This information will be displayed publicy so be careful what you share
                            </p>
                            <div class="flex md:flex-row flex-col gap-5 my-5 ">
                                <div>
                                    <label class="font-['Inter']">Tipo Usuario</label>
                                    <select onchange="handleSelectChange()" id="selectTipoUsuario" name="tipoUsuario" class="form-select form-select-lg mb-3
                                            appearance-none
                                            block
                                            w-full
                                            px-4
                                            py-2

                                            text-xl
                                            font-normal
                                            text-gray-700
                                            bg-white bg-clip-padding bg-no-repeat
                                            border border-solid border-gray-300
                                            rounded
                                            transition
                                            ease-in-out
                                            m-0
                                            focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none
                                            min-w-[350px]" aria-label=".form-select-lg example">
                                        <option value="Socio">Socio</option>
                                        <option value="Profesor"
                                                >Profesor</option>

                                    </select>
                                </div>
                                <div class="flex-1">
                                    <label class="font-['Inter']" for="nickname">Nickname</label>
                                    <input id="checkNicknameError" type="text" id="nickname" name="nickname" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="John123" >
                                    <p id="errorNickname" style="display: none" class="text-red-500 font-medium texe-sm my-2"></p>
                                </div>
                            </div>
                            <div> 
                                <div class="w-full" id="inputFileContainer">
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
                                        <input type="file" id="inputFile" value="" name="file_upload" class="hidden" accept="image/*" onchange="loadFile(event)"/>
                                    </label>
                                </div>
                                <div class="hidden" id="avatarContainer">
                                    <figure class="max-w-lg">
                                        <img id="avatar" class="max-w-full h-auto rounded-lg" src="/docs/images/examples/image-3@2x.jpg" alt="image description">
                                        <figcaption class="mt-2 text-sm text-center text-gray-500 dark:text-gray-400">
                                            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="quitImage()">Quitar avatar</button>
                                        </figcaption>
                                    </figure>

                                </div>
                            </div>      

                            <div class="mt-10 ">
                                <span class="font-['Inter'] text-1xl ">Personal Information</span>
                                <p class=" text-[#6B7280]">Use a permanent address where you can receive a email</p>
                                <div class="flex md:flex-row flex-col  justify-between gap-10">
                                    <div class="flex-1">
                                        <label for="Nombre" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre</label>
                                        <input type="text" id="Nombre" name="Nombre" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="John" >
                                    </div>
                                    <div class="flex-1">
                                        <label for="Apellido" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Apellido</label>
                                        <input type="text" id="Apellido" name="Apellido" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Pedredrol" >
                                    </div>
                                </div>
                                <div class="flex md:flex-row flex-col  mt-3">
                                    <div class="flex-grow">
                                        <label for="Email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Email</label>
                                        <input id="checkEmailInput" type="email" id="Email" name="Email" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="john@gmail.com" >
                                        <p id="errorEmail" style="display: none" class="text-red-500 font-medium texe-sm my-2"></p>
                                    </div>
                                </div>

                                <div class="flex md:flex-row flex-col mt-3 gap-10 w-full">
                                    <div class="flex-grow">
                                        <label for="contrase??a" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Contrase??a</label>
                                        <input type="password" id="contrase??a" name="contrase??a" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="" >
                                    </div>
                                    <div class="flex-grow">
                                        <label for="confirmPassword" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Confirmar contrase??a</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="" >
                                    </div>
                                </div>

                                <div class='mt-5'>
                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha de nacimiento</label>

                                    <div class="relative">
                                        <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                            <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                                        </div>
                                        <input name="fechaNacimiento" id="fechaNacimiento" datepicker="" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 datepicker-input" placeholder="Select date">
                                    </div>

                                </div>


                            </div>

                            <div class="mt-10 hidden" id="profesorDataCard">
                                <span class="font-['Inter'] text-1xl ">Informacion del profesor</span>
                                <p class=" text-[#6B7280]">Algo de informacion extra debido a que eres profesor</p>
                                <div class="flex justify-between gap-10 mt-5">
                                    <div>
                                        <label for="institucion" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Institucion</label>
                                        <select id="institucion" name="institucion" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 min-w-[350px]">
                                            <option value="" disable>Seleccione una institucion</option>
                                            <% for (HashMap.Entry<Integer, DtInstitucion> in : ins.entrySet()) {
                                                    Integer key = in.getKey();
                                                    DtInstitucion val = in.getValue();
                                            %>

                                            <option value="<%=key%>" ><%= val.getNombre()%></option><!-- comment -->
                                            <%
                                                }
                                            %>



                                        </select>   
                                    </div>
                                </div>



                                <div class="flex justify-between gap-10 mt-5">
                                    <div class="flex-1">
                                        <label for="about" class="form-label inline-block mb-2 text-gray-700">About</label>
                                        <textarea
                                            class="
                                            form-control
                                            block
                                            w-full
                                            px-3
                                            py-1.5
                                            text-base
                                            font-normal
                                            text-gray-700
                                            bg-white bg-clip-padding
                                            border border-solid border-gray-300
                                            rounded
                                            transition
                                            ease-in-out
                                            m-0
                                            focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none
                                            "
                                            id="about"
                                            rows="3"
                                            placeholder=""
                                            name="about"
                                            ></textarea>
                                    </div>

                                    <div class="flex-1">
                                        <label for="description" class="form-label inline-block mb-2 text-gray-700">Descripcion</label>
                                        <textarea
                                            class="
                                            form-control
                                            block
                                            w-full
                                            px-3
                                            py-1.5
                                            text-base
                                            font-normal
                                            text-gray-700
                                            bg-white bg-clip-padding
                                            border border-solid border-gray-300
                                            rounded
                                            transition
                                            ease-in-out
                                            m-0
                                            focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none
                                            "
                                            id="description"
                                            rows="3"
                                            placeholder=""
                                            name="description"
                                            ></textarea>
                                    </div>



                                </div>
                                <div class="flex">
                                    <div class="basis-1/2">
                                        <label for="website" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Sitio web</label>
                                        <input type="text" name="website" id="website" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Website" >
                                    </div>
                                </div>
                            </div>


                            <div class="flex space-x-2 justify-end mt-10">
                                <button
                                    type="submit"
                                    id="submitButton"
                                    data-mdb-ripple="true"
                                    data-mdb-ripple-color="light"
                                    class="inline-block px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out"
                                    >Registrarse</button>
                            </div>
                        </div>

                    </div> 
                </div>
            </div>
        </form>

    </div>
</div>


</body>
<script>

    // Initialize form validation on the registration form.
    // It has the name attribute "registration"

    const SELECT_TIPO_USUARIO = document.getElementById("selectTipoUsuario");
    const PROFESOR_DATA_CARD = document.getElementById("profesorDataCard");




    function handleSelectChange(event) {
        const VALUE = SELECT_TIPO_USUARIO.value;

        if (VALUE == "Socio") {
            console.log("socio")
            PROFESOR_DATA_CARD.style.display = "none";
        } else {
            console.log("profe")
            PROFESOR_DATA_CARD.style.display = "block";
        }
    }
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


    var loadFile = function (event) {
        const avatarContainer = document.getElementById("avatarContainer");
        avatarContainer.classList.remove("hidden");
        avatarContainer.classList.add("flex");
        avatarContainer.classList.add("justify-center");

        const inputFileContainer = document.getElementById("inputFileContainer");
        inputFileContainer.classList.add("hidden");

        var output = document.getElementById('avatar');
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }
    };



    function quitImage() {
        const avatarContainer = document.getElementById("avatarContainer");
        avatarContainer.classList.add("hidden");
        avatarContainer.classList.remove("flex");
        $('#inputFile').val("");
        const inputFileContainer = document.getElementById("inputFileContainer");
        inputFileContainer.classList.add("flex");
        inputFileContainer.classList.remove("hidden");

    }
    $.validator.addMethod("fechaLessThanToday", function (value, element) {
        const today = new Date();
        const valueDate = new Date(value);
        if (valueDate >= today) {
            return false;
        }
        return true;
    }, "Please specify the correct domain for your documents");


    $(function () {

        $("#registration").validate({
            rules: {
                nickname: {
                    required: true
                },
                Nombre: {
                    required: true
                },
                Apellido: {
                    required: true
                },
                Email: {
                    required: true,
                    email: true
                },
                Contrase??a: {
                    required: true,
                    minlength: 6
                },
                confirmPassword: {
                    required: true,
                    equalTo: "#contrase??a",
                    minlength: 6
                },
                institucion: {
                    required: true,

                },
                description: {
                    required: true,

                },

                fechaNacimiento: {
                    required: true,
                    fechaLessThanToday: true
                },
            },
            messages: {

                nickname: {
                    required: "nickname es requerido"
                },
                Nombre: {
                    required: "nombre es requerido"
                },
                Apellido: {
                    required: "apellido es requerido"
                },
                Email: {
                    required: "email es requerido",
                    email: "email es invalido"
                },
                Contrase??a: {
                    required: "Contrase??a es requerido",
                    minlength: "Contrase??a debe tener minimo 6 caracteres"
                },
                confirmPassword: {
                    minlength: "Contrase??a debe tener minimo 6 caracteres",
                    required: "Confirmar password es requerido",
                    equalTo: "La confirmacion no coincide con la contrase??a"
                },
                institucion: {
                    required: "Institucion es requerida",

                },
                description: {
                    required: "Descripcion es requerida",

                },
                fechaNacimiento: {
                    required: "Fecha de nacimiento es requerido",
                    fechaLessThanToday: "No puedes haber nacido en el futuro"

                },

            },
        })
    })
</script>

<style>
    .error{
        color: red;
        font-style: italic;
    }
</style>
</html
