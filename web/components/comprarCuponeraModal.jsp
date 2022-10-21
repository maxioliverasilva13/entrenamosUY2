<%-- 
    Document   : comprarCuponeraModal
    Created on : 6 oct. 2022, 13:07:40
    Author     : mandi
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<String> cuponeras = new ArrayList<>();
    cuponeras.add("Cuponera 1");
    cuponeras.add("Cuponera 2");
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    cuponeras.add("Cuponera 3");    
    request.setAttribute("cupos", cuponeras);
    
%>

<!DOCTYPE html>
<div class="w-screen h-screen absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex flex-grow items-center justify-center transition-all">
    <div class="bg-white rounded-2xl max-w-[95%] md:min-w-[40%] py-8 px-8 border-gray-300 border flex flex-col items-start justify-start gap-x-12 relative max-h-[80%]">
        <%-- Close Button --%>
        <button class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </button>
        
        <div class="w-full text-3xl border-b border-gray-300 pb-2 font-[Inter] font-medium text-center">
            Cuponeras Disponibles
        </div>
        
        <div class="w-full h-full max-h-full overflow-auto flex-grow border border-gray-300 rounded-md mt-4">
            <c:forEach items="${cupos}" var="item">
                <div class="w-full h-20 border-b border-gray-300 px-6 py-4 flex flex-row items-center justify-start gap-x-4">
                    <%-- <img 
                    src="https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg"
                     class="w-12 h-12 rounded-full overflow-hidden"   
                    /> --%>
                    <div class="flex-grow h-full flex flex-col items-start justify-between">
                        <a href="#" class="text-[#4F46E5] font-medium text-sm">Cuponera Ejemplo</a>
                        <div class="flex items-center justify-start gap-x-2">
                            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M4 0C3.44772 0 3 0.447715 3 1V2H2C0.895431 2 0 2.89543 0 4V14C0 15.1046 0.895431 16 2 16H14C15.1046 16 16 15.1046 16 14V4C16 2.89543 15.1046 2 14 2H13V1C13 0.447715 12.5523 0 12 0C11.4477 0 11 0.447715 11 1V2H5V1C5 0.447715 4.55228 0 4 0ZM4 5C3.44772 5 3 5.44772 3 6C3 6.55228 3.44772 7 4 7H12C12.5523 7 13 6.55228 13 6C13 5.44772 12.5523 5 12 5H4Z" fill="#9CA3AF"/>
                            </svg>
                            <p class="text-gray-500 font-normal text-sm ">Vence 06/12/2022</p>
                        </div>

                    </div>

                    <div class="flex-grow h-full flex flex-col items-start justify-between">
                        <span class="bg-green-100 text-green-800 text-sm font-semibold mr-2 px-2.5 py-0.5 rounded-xl  dark:bg-green-200 dark:text-green-900 self-end">
                                    Dto. 50%
                        </span>
                    </div>
                    <i class="fa-solid fa-chevron-right text-gray-900 cursor-pointer"></i>

                </div>
           </c:forEach>
       </div>
    </div>
</div>