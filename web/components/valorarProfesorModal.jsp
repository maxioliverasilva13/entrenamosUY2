<%-- 
    Document   : valorarProfesorModal
    Created on : 15 nov 2022, 22:36:18
    Author     : rodrigo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



   

<div id="puntuarProfModal"  class="flex h-full z-[99999] max-h-full overflow-auto transition-all delay-150 fixed top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 items-center justify-center transition-all">
    <div class="w-auto max-w-[600px] min-w-[600px] px-4 py-6 h-auto bg-white relative flex flex-col items-center justify-start rounded-2xl shadow-lg delay-500 transition-opacity mainModal">
        <button onclick="closeModal()" id="closeAddClaseButton"  class="w-10 outline-none transition-all h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        <p class="text-lg font-medium text-gray-800">Valorar profesor</p>
        
        

        <form id="addClaseForm" method="POST" class="w-full h-auto flex flex-col items-center justify-start gap-4 mt-5">
            <div id="star-rating ">
                <i class="fa-solid fa-star" id="s1"></i><!-- comment -->
                <i class="fa-solid fa-star" id="s2"></i>
                <i class="fa-solid fa-star" id="s3"></i>
                <i class="fa-solid fa-star" id="s4"></i>
                <i class="fa-solid fa-star" id="s5"></i>
            </div>
            

            <button class="w-full h-auto py-2 px-4 text-white rounded-md bg-indigo-700 cursor-pointer hover:bg-indigo-800 transition-all"  type="button" onclick="onClickValorarProfesor()">Enviar</button>
        </form>
    </div>
</div>

<script>
    var puntuacion = 0;
    
    
    $(document).ready(function(){
        $("#s1").click(function(){
            $(".fa-star").css("color","black");
            $("#s1").css("color","yellow");
            puntuacion = 1;
        })
        $("#s2").click(function(){
             $(".fa-star").css("color","black");
            $("#s1,#s2").css("color","yellow");
             puntuacion = 2;
        })
        $("#s3").click(function(){
             $(".fa-star").css("color","black");
            $("#s1,#s2,#s3").css("color","yellow");
             puntuacion = 3;
        })
        $("#s4").click(function(){
             $(".fa-star").css("color","black");
            $("#s1,#s2,#s3,#s4").css("color","yellow");
             puntuacion = 4;
        })
        $("#s5").click(function(){
            $(".fa-star").css("color","black");
            $("#s1,#s2,#s3,#s4,#s5").css("color","yellow");
            puntuacion = 5;
        })
    })
    
    
    function closeModal(){
        $("#puntuarProfModal").parent().css("display","none");
    }
    
    function onClickValorarProfesor(){
       const registroId = $("#puntuarProfModal").parent().attr("registroId");
       const puntuacionStr  = String(puntuacion);
       const data = {
           puntuacion: puntuacionStr,
           registroId
       }
       
         $.post("puntuarProfesor", data, function (res, status) {
                  if (res.status == 200) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Profesor valorado correctamente!',
                        text: res.message,
                    })
                    $("#puntuarProfModal").parent().css("display","none")
                    onPuntuacion(puntuacionStr);
                } else if (res.status == 400) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: res.message,
                    })
                } else if (res.status == 500) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: res.message,
                    })
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: res.message,
                    })
                }
          });     
    }
 </script>
 
 
 <style>
     .fa-star{
       font-size: 40px;  
      }  
 </style>



