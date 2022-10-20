<%-- 
    Document   : editarInfoSocioModal
    Created on : 2 oct. 2022, 22:40:06
    Author     : mandi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="editarInfoSocioModal" style="display: none;" class="w-screen h-screen absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all">
    <div class="bg-white rounded-2xl py-6 px-8 border-gray-300 border flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <button onclick="closeModal()" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <form id="edit" action="EditInfo" method="post" enctype="multipart/form-data" class="flex flex-col">
            <p class="font-[Inter] font-medium text-center text-2xl mb-1">Editar Información Socio</p>
            <div class="border-gray-300 border-b mb-4 mx-16"></div>
            <div class="grid md:grid-cols-2 md:gap-6">
                <div class="relative z-0 mb-6 w-full group">
                    <input id="nickname" type="text" name="nickname" value="${param.nickname}" class="hover:cursor-not-allowed block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly />
                    <label for="nickname" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nickname</label>
                </div>
                <div class="relative z-0 mb-6 w-full group">
                    <input id="email" type="text" name="email" value="${param.email}" class="hover:cursor-not-allowed block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly />
                    <label for="email" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">E-mail</label>
                </div>
            </div>

            <div class="grid md:grid-cols-2 md:gap-6">
                <div class="relative z-0 mb-6 w-full group">
                    <input type="text" name="name" id="name" value="${param.name}" class="block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " required />
                    <label for="name" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nombre</label>
                </div>
                <div class="relative z-0 mb-6 w-full group">
                    <input  type="text" name="lastname" id="lastname" value="${param.lastname}" class="block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " required />
                    <label for="lastname" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Apellido</label>
                </div>
            </div>

            <div class="relative z-0 mb-6 w-full group">
                <input datepicker="" name="fechaNacimiento" id="fechaNacimiento" value="${param.fnacimiento}" class="hover:cursor-pointer block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer date-picker" placeholder=" " required />
                <label for="fechaNacimiento" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Fecha de Nacimiento</label>
            </div>
            <div class="flex gap-x-4 mx-4">
                <button type="button" onclick="handleEnableChangePass()" class="font-[Inter] bg-[#DFD9A4] hover:bg-[#EBE5B5] focus:ring-4 focus:outline-none focus:ring-blue-300 font-sm rounded-lg w-max px-5 py-2 text-center mb-4">Modificar Contraseña</button>
                <button type="button" onclick="handleEnableChangeImage()" class="font-[Inter] bg-[#DFD9A4] hover:bg-[#EBE5B5] focus:ring-4 focus:outline-none focus:ring-blue-300 font-sm rounded-lg w-max px-5 py-2 text-center mb-4">Modificar Foto de Perfil</button>
            </div>
            <div id="modifyPass" class="grid md:grid-cols-2 md:gap-6 mb-4 hidden">
                <div class="relative z-0 mb-6 w-full group">
                    <input id="password" type="password" name="password" minlength="6" class="block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " disabled />
                    <label for="password" class="peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Contraseña</label>
                </div>
                <div class="relative z-0 w-full group">
                    <input id="confirmPassword" type="password" name="confirmPassword" minlength="6" class="block py-2.5 px-0 w-full text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " disabled />
                    <label for="confirmPassword" class=" peer-focus:font-medium absolute text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Confirmar Contraseña</label>
                </div>
                <input hidden type="text" name="userType" value="${param.utype}"/>
                <input hidden type="text" name="userId" value="${param.usrIdConsultado}"/>
            </div>
            <div id="ifileContainer" class="flex gap-x-2 mb-4 hidden items-center justify-center">
                <div class="max-w-xs">
                    <input class="mb-2 w-full text-xs text-gray-900 bg-gray-50 rounded-lg border border-gray-300 cursor-pointer focus:outline-none" id="fileInput" name="selected_file" type="file" accept="image/*" onchange="loadFile(event)">
                </div>
                <div class="hidden" id="imageContainer">
                    <img id="selected_img" class="rounded-full shadow-xl w-[80px] h-[80px] object-cover" alt="selected image">
                </div>
            </div>
            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg w-full w-auto px-5 py-2.5 text-center ">Guardar</button>
        </form>
    </div>
</div>
<script>
    const closeModal = () => {
        document.getElementById("editarInfoSocioModal").style.cssText = "display: none";
    };

    let showPassFields = false;
    let showInputFile = false;

    const handleEnableChangePass = () => {
        if (showPassFields === false) {
            document.getElementById("modifyPass").style.cssText = "display: block";
            document.getElementById("password").removeAttribute("disabled");
            document.getElementById("confirmPassword").removeAttribute("disabled");
        } else {
            document.getElementById("modifyPass").style.cssText = "display: none";
            document.getElementById("password").value = "";
            document.getElementById("confirmPassword").value = "";
        }
        showPassFields = !showPassFields;
    };

    const handleEnableChangeImage = () => {
        if (showInputFile === false) {
            document.getElementById("ifileContainer").style.cssText = "display: flex";
        } else {
            document.getElementById("ifileContainer").style.cssText = "display: none";
            
            // Al deshabilitar, también limpio el archivo que seleccionó.
            if (document.getElementById("fileInput").value){
                document.getElementById("fileInput").value = "";
            }
        }
        showInputFile = !showInputFile;
    };

    const loadFile = (event) => {
        const imageContainer = document.getElementById("imageContainer");
        imageContainer.classList.remove("hidden");
        imageContainer.classList.add("flex");
        imageContainer.classList.add("justify-center");
        
        // Codigo rodri
        let output = document.getElementById('selected_img');
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
            URL.revokeObjectURL(output.src);
        };
    };
    
    $(function () {
        $("#edit").validate({
            rules: {
                password: {
                    required: true
                },
                confirmPassword: {
                    required: true,
                    equalTo: "#password"
                }
            },
            messages: {
                password: {
                    required: "Este campo es requerido.",
                    minlength: "La contraseña debe contener al menos 6 caracteres."
                },
                confirmPassword: {
                    required: "Este campo es requerido.",
                    minlength: "La contraseña debe contener al menos 6 caracteres.",
                    equalTo: "Las contraseñas no coinciden."
                }
            }
        });
    });
</script>            
