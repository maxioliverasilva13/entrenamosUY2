<%-- 
    Document   : signup
    Created on : 6 oct 2022, 21:18:58
    Author     : rodrigo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page='imports.jsp'>
    <jsp:param name="" value=""/>
</jsp:include>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class=" w-full h-full bg-cover bg-no-repeat " style="background-image: url('https://res.cloudinary.com/dwh8j7fys/image/upload/v1665238297/natacion_twsiuc.jpg');">
        <div class="w-full w-h flex justify-end">
            <div class="bg-white basis-3/4 h-[100vh]">
                <div class="w-full flex justify-center mt-5" id="form" >
                    <div class="basis-3/4">
                        <h1 class="font-['Inter'] text-3xl text-center">Registro de nuevo usuario</h1>
                        <p class="mt-5 text-[#6B7280] m-auto">
                            <span class="font-['Inter'] font-semibold text-[#000]">Profile</span>
                            <br>
                            This information will be displayed publicy so be careful what you share
                        </p>
                        <div class="flex gap-5 mt-5 ">
                            <div>
                                <label class="font-['Inter']">Tipo Usuario</label>
                                <select class="form-select form-select-lg mb-3
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
                                    <option selected>Open this select menu</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                               </select>
                            </div>
                            <div>
                                <label class="font-['Inter']">Tipo Usuario</label>
                                <select class="form-select form-select-lg mb-3
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
                                    min-w-[500px]" aria-label=".form-select-lg example">
                                    <option selected>Open this select menu</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                               </select>
                            </div>
                        </div>
                        <div>
                             <div class="w-full">
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
                                        <input type="file" name="file_upload" class="hidden">
                                    </label>
                                </div>
                            
                        </div>      
                        
                        <div class="mt-10 ">
                            <span class="font-['Inter'] text-1xl ">Personal Information</span>
                            <p class=" text-[#6B7280]">Use a permanent address where you can receive a email</p>
                            <div class="flex justify-between">
                                 <div>
                                    <label for="first_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">First name</label>
                                    <input type="text" id="first_name" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="John" required>
                                </div>
                                 <div>
                                    <label for="first_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">First name</label>
                                    <input type="text" id="first_name" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="John" required>
                                </div>
                             </div>
                        </div>
 
  

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
