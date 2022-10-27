<%-- 
    Document   : categoriaCard
    Created on : 25/09/2022, 08:08:19 PM
    Author     : Maximiliano Olivera
--%>

<%@page import="java.awt.Color"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String categoriaName = request.getParameter("categoria");
    String paramIndex = request.getParameter("index");
    int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));
%>

<%! 
  String[] listOfColors = {"#468990", "#299D91", "#FFF4B8", "#F98F37", "#DE3C31"};
  public String formatName(Object x ) {
    String val = (String)x;
    String[] myName = val.split(" ");
    String acronym = "";
    for (int i = 0; i < myName.length; i++) {
        String s = myName[i];
        acronym += s.charAt(0);
    }
    return acronym;
  }

  public String getColor(String index) {
    int indexInt = Integer.parseInt(index);
    return listOfColors[indexInt%4];
  }

%>
   
<div class="h-16 w-max flex flex-row items-center justify-start rounded-xl border border-gray-300 shadow overflow-hidden">
    <div class="w-16 h-full flex items-center justify-center text-white"
         style="background: <%=getColor(paramIndex)%>"
    >
        <%=formatName(categoriaName) %>
    </div>
    <div class="px-4 py-2 h-max flex-grow flex flex-col items-start justify-start">
        <p class="text-gray-900 font-medium text-xs ">${param.categoria}</p>
        <p class="font-normal text-gray-400 text-sm">Total de actividades: ${param.totalActividades}</p>
    </div>
    <div class="w-8 h-full flex items-center justify-center">
        <input type="checkbox" id="<%=categoriaName %>" name="<%=categoriaName %>" ${param.checked == true ? 'checked' : ''} value="<%=categoriaId %>" />
    </div>
</div>