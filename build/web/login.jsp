<%-- 
    Document   : login
    Created on : 29 sept 2022, 23:32:43
    Author     : rodrigo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>
<html>
<head>
    
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login page</title>
	  
	
</head>
<body>
     
	<div class="flex">
       <div  class=" w-full h-full bg-cover bg-no-repeat flex-1 bg-center hidden md:block " style="background-image: url('https://res.cloudinary.com/dwh8j7fys/image/upload/v1665238283/gym_j5mokj.png'); width: 100%; height: 100vh;">
       </div>
            
           
       <div class="flex-1 flex flex-col justify-center items-center mt-5">
       	<!--code !-->
             <% if(request.getAttribute("signUpSucces") != null){
             %>
              <div class="w-3/5 bg-teal-100 border-t-4 border-teal-500 rounded-b text-teal-900 px-4 py-3 shadow-md mb-5" role="alert">
                <div class="flex">
                  <div class="py-1"><svg class="fill-current h-6 w-6 text-teal-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/></svg></div>
                  <div>
                    <p class="font-bold">Ya puedes logearte</p>
                    <p class="text-sm">Cuenta creado con exito!!</p>
                  </div>
                </div>
                </div>
              <%
            }%>
          
       	   <div class="">
       	   	  <span class="font-['Inika'] text-2xl md:text-3xl">Entrenamos <span class="bg-[#709FE6] rounded-[15px] p-1 text-white">UY</span></span>
       	   </div>

       	   <div class="bg-[#4A4747] py-7 px-5 md:py-12 md:px-8 mt-5 rounded-[20px]">
               
                    <div class="flex flex-col  items-center w-full md:min-w-[500px]">
       	   	   	   <img src="https://res.cloudinary.com/dwh8j7fys/image/upload/v1665238292/icon_hoakjb.png" class="w-10 h-10 bg-cover bg-no-repeat" style="background-image: url('./assets/icon.png');"/>
       	   	   	   	<p class="mt-4">
	       	   	   	   	<span class="font-['Inter'] font-extrabold text-2xl md:text-3xl text-white">Iniciar Sesion</span> 
	       	   	   	   	<br>
	       	   	   	   	<div class="mt-1">
	       	   	   	   		<span class="text-white"></span>
	       	   	   	   		<a class="text-[#709FE6]  font-['Inter'] font-medium hover:text-white hover:cursor-pointer" onclick="onClickCrearUnaCuenta()"> Crear una cuenta gratuita</a>
	       	   	   	   	</div>      	   	   	   
                                   </p>
                                   
                                      <form action="Login" method="post" class="w-full">
                                                     
                                        <div class="flex w-full flex-col gap-10 mt-10">
                                                <input name="email"   type="email"   class="bg-gray-50 outline-none  text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5  "  placeholder="Correo" />
                                                <input name="password" type="password"    class="bg-gray-50 outline-none  text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5  " placeholder="Contraseña"/>
                                                <%
                                                        if(request.getAttribute("status") != null){
                                                          %>
                                                          <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                                                                <strong class="font-bold">Authenticacion incorrecta!</strong>
                                                                <span class="block sm:inline">${status}</span>
                                                                <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                                                                </span>
                                                            </div>
                                                    
                                                          <%
                                                        }
                                                      %>
                                                <div class="flex justify-end">
                                                        <div>
                                                                <input type="checkbox"  class="rounded-[10px]">
                                                                <label class="text-white font-['Inter'] font-normal text-xs md:text-sm">Remember password</label>
                                                        </div>
                                                       
                                                </div>

                                                    <div class="">
                                                         <input type="submit" class="w-full  p-3 bg-[#709FE6] text-white font-medium text-xs leading-tight  rounded-[10px] shadow-md hover:bg-white  hover:text-[#709FE6]  transition duration-150 " value="Iniciar sesion"/>
                                                    </div>
                                                   
                                               
                                        </div>	
                                       
                                      </form>
                             


       	   

       </div>
    </div>
</body>

<script>
    function onClickCrearUnaCuenta(){
        window.location.href = 'SignUp';

    }
 </script>
</html>
