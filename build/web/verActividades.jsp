<%-- 
    Document   : verActividades
    Created on : 26/09/2022, 09:46:00 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="util.BlobToImage"%>
<%@page import="Actividad.dtos.ActividadDTO"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>

<%
    HashMap<Integer, ActividadDTO> actividades = new HashMap<Integer, ActividadDTO>();
    BlobToImage btimg = new BlobToImage();
    if (request.getAttribute("actividadesInstitucion") != null) {
        actividades = (HashMap<Integer, ActividadDTO>) request.getAttribute("actividadesInstitucion");
    }
    HashMap<Integer, ActividadDTO> filteredActividades = new HashMap<Integer, ActividadDTO>();
    if (request.getAttribute("filteredActividades") != null) {
        filteredActividades = (HashMap<Integer, ActividadDTO>) request.getAttribute("filteredActividades");
    }

    HashMap<Integer, ActividadDTO> actividadesToShow = filteredActividades.size() == 0 ? actividades : filteredActividades;
%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .error{
                color: red;
                font-style: italic;
            }
        </style>
    </head>

    <%        if (actividadesToShow.size() == 0) {
    %>
    <div class="w-full h-full flex-grow flex items-center flex-col justify-center gap-y-2">
        <img src=" https://cdni.iconscout.com/illustration/premium/thumb/folder-is-empty-4064360-3363921.png" class="select-none object-cover w-[300px]" />
        <p class="text-gray-800 font-medium text-base">No encontramos ningun resultado!</p>
    </div>
    <%
    } else {
    %> 
    <div class="w-full flex-grow h-full grid grid-cols-4 gap-4 auto-rows-max min-h-[400px]">
        <!-- Main modal --> 
        <div id="defaultModal" tabindex="-1" aria-hidden="true" class="absolute top-10 px-10 w-3/5">
            <div class="relative p-4 w-full  h-full md:h-auto px-10">
                <!-- Modal content -->
                <div class="relative bg-white rounded-lg shadow dark:bg-gray-700 px-6">
                    <!-- Modal header -->
                    <div class="flex justify-between items-start p-6 rounded-t border-b dark:border-gray-600 ">
                        <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                            Agregar Actividad Deportiva
                        </h3>
                        <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-toggle="defaultModal">
                            <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                            <span class="sr-only">Close modal</span>
                        </button>
                    </div>
                    <!-- Modal body -->
                    <form action="CrearActividad" method="post"  id="add-activity" enctype="multipart/form-data">
                        <div class="p-6 space-y-6">
                            <h4 class="text-lg font-semibold text-gray-900 dark:text-white">
                                Informacion de la actividad
                            </h4>
                            <span class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
                                This information will be displayed publicly so be careful what you share.                 </p>
                            </span><!-- comment -->
                            <div class="w-3/4">
                                <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre</label>
                                <input type="text" id="nombre" name="nombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Natacion" >
                            </div>

                            <div class="w-full" id="inputFileContainer">
                                <label class="flex justify-center w-full h-32 px-4 transition bg-white border-2 border-gray-300 border-dashed rounded-md appearance-none cursor-pointer hover:border-gray-400 focus:outline-none">
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
                                    <input type="file" class="hidden" value="" name="file_upload"  accept="image/*" onchange="loadFile(event)"/>
                                </label>

                            </div>

                            <div class="w-full flex justify-center hidden" id="imgContainer">
                                <figure class="max-w-lg">
                                    <img id="img" class="max-w-full h-auto rounded-lg" src="/docs/images/examples/image-3@2x.jpg" alt="image description">
                                        <figcaption class="mt-2 text-sm text-center text-gray-500 dark:text-gray-400">
                                            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="quitImage()">Quitar imagen</button>
                                        </figcaption>
                                </figure>

                            </div
                            <div class='flex'>


                                <div class="flex gap-5 flex-wrap">
                                    <div class="flex-1">
                                        <label for="duracion" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Duracion</label>
                                        <input type="text" id="duracion" name="duracion" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Natacion" />
                                    </div>

                                    <div  class="flex-1">
                                        <label for="costo" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Costo</label>
                                        <input type="text" id="costo" name="costo" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Natacion"/>
                                    </div>
                                </div>

                                <div>
                                    <label for="descripcion" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Descripcion</label> 
                                    <textarea id="descripcion" rows="4" name="descripcion" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Descripcion..."></textarea>
                                </div>
                            </div>


                            <div>
                                <div class="flex justify-center" >
                                    <div role="status p-10" id="loadingCategories">
                                        <svg aria-hidden="true" class="mr-2 w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                            <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                                        </svg>
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>

                                <div class='flex gap-5 flex-wrap max-h-32 overflow-y-auto mt-10 ' id="categoriasContainer">

                                </div>
                            </div>



                            <div class="flex items-center p-6 justify-end space-x-2 rounded-b border-t border-gray-200 dark:border-gray-600">
                                <button data-modal-toggle="defaultModal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-blue-300 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancel</button>
                                <button data-modal-toggle="defaultModal" type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" id="save">Save</button>

                            </div>

                        </div>  
                    </form>


                    <!-- Modal footer -->
                    ¡
                </div>
            </div>
        </div>



        <% for (HashMap.Entry<Integer, ActividadDTO> en : actividadesToShow.entrySet()) {
                Integer key = en.getKey();
                ActividadDTO val = en.getValue();
        %>
        <jsp:include page='/components/cardActividad.jsp' >
            <jsp:param name="nombre" value="<%=val.getNombre()%>" />
            <jsp:param name="image" value="<%=btimg.getBase64StringImage(val.getImageBlob())%>" />
            <jsp:param name="descripcion" value="<%=val.getDescripcion()%>" />
            <jsp:param name="actID" value="<%=val.getId()%>" />
        </jsp:include>
        <%
            }
        %>
    </div>

    <%
        }
    %>

    <script>

        var loadFile = function (event) {

            const imgContainer = document.getElementById("imgContainer");


            imgContainer.classList.remove("hidden");
            imgContainer.classList.add("flex");
            imgContainer.classList.add("justify-center");
            const inputFileContainer = document.getElementById("inputFileContainer");
            inputFileContainer.classList.add("hidden");

            var output = document.getElementById('img');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.onload = function () {
                URL.revokeObjectURL(output.src) // free memory
            }
        };

        function quitImage() {
            const imgContainer = document.getElementById("imgContainer");
            imgContainer.classList.add("hidden");
            imgContainer.classList.remove("flex");

            const inputFileContainer = document.getElementById("inputFileContainer");
            inputFileContainer.classList.add("flex");
            inputFileContainer.classList.remove("hidden");

        }


        $(function () {

            const form = $("#add-activity").validate({
                // Specify validation rules
                rules: {
                    // The key name on the left side is the name attribute
                    // of an input field. Validation rules are defined
                    // on the right side
                    nombre: {
                        required: true,

                    },
                    duracion: {
                        required: true,
                        number: true
                    },
                    costo: {
                        required: true,

                    },

                    descripcion: {
                        required: true,
                        minlength: 10

                    },

                },
                // Specify validation error messages
                messages: {
                    nombre: "nombre es requerido",
                    duracion: {
                        required: "duracion es requerido",
                        number: "duracion debe ser un numero "
                    },
                    costo: {
                        required: "costo es requerido",
                        number: "costo debe ser un numero "
                    },
                    descripcion: {
                        required: "descripcion es requerido",
                        minlength: "descripcion debe tener al menos 10 caracteres de largo "
                    },

                },
                // Make sure the form is submitted to the destination defined
                // in the "action" attribute of the form when valid
                submitHandler: function (form) {
                    console.log(form);
                    setTimeOut(() => {
                        form.submit();
                    }, 2000)

                }
            });



            const loadingCategoriesElem = $("#loadingCategories");
            const containerCategorias = $("#categoriasContainer");
            $.get('CrearActividad', function (data, status) {
                if (status !== "success") {
                    return;
                }
                const dataObj = data.categorias;
                console.log(dataObj[1].nombre);
                const keys = Object.keys(dataObj);
                keys.map(item => {
                    const nombre = dataObj[item].nombre;
                    const template = ` <div class="flex items-center mb-4">
                                           <input id="categoria-${item}" type="checkbox" class="checkbox-categoria" value="${item}" class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                           <label for="categoria-${item}" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">` + nombre + `</label>
                                       </div>`;
                    containerCategorias.append(template);

                })
                loadingCategoriesElem.addClass("hidden");


            });

        });




    </script>  
</html>
