<%-- 
    Document   : categoriaCard
    Created on : 25/09/2022, 08:08:19 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="java.awt.Color"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Random obj = new Random();
    int rand_num = obj.nextInt(0xffffff + 1);
    // format it as hexadecimal string and print
    String colorCode = String.format("#%06x", rand_num);
    String randomColor = colorCode;
    String categoriaName = request.getParameter("categoria");
%>

<%! 
  public String formatName(Object x ) {
    String val = (String)x;
    String[] myName = val.split(" ");
    String acronym = "";
    for (int i = 0; i < myName.length; i++) {
        String s = myName[i];
        System.out.println();
        acronym += s.charAt(0);
    }
    return acronym;
  }

%>
   
<div class="h-14 w-full flex flex-row items-center justify-start rounded-xl border border-gray-300 shadow overflow-hidden">
    <div class="w-16 h-full flex items-center justify-center text-white"
         style="background: <%=randomColor%>"
    >
        <%
            String newName = formatName(categoriaName);
            out.print(newName);
        %>
    </div>
    <div class="px-4 py-2 h-full flex-grow flex flex-col items-start justify-start">
        <p class="text-gray-900 font-medium text-xs ">${param.categoria}</p>
        <p class="font-normal text-gray-400 text-sm">16 Actividades</p>
    </div>
</div>