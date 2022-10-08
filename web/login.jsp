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
	       	   	   	   		<a class="text-[#709FE6]  font-['Inter'] font-medium hover:text-white hover:cursor-pointer"> Crear una cuenta gratuita</a>
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
                                                <div class="flex justify-between">
                                                        <div>
                                                                <input type="checkbox"  class="rounded-[10px]">
                                                                <label class="text-white font-['Inter'] font-normal text-xs md:text-sm">Remember password</label>
                                                        </div>
                                                        <div>
                                                                <a class="text-[#709FE6]  font-['Inter'] font-medium text-xs md:text-sm hover:text-white hover:cursor-pointer">Forgot your password?</a>
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
</html>
