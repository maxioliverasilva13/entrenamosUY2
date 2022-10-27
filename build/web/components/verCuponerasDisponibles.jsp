<%-- 
    Document   : verCuponerasDisponibles
    Created on : 01/10/2022, 07:58:03 AM
    Author     : Maximiliano Olivera
--%>
<%@page import="Cuponera.DtCuponera"%>
<%@page import="java.util.HashMap"%>
<%
    int id;
    HashMap<Integer, DtCuponera> cuponera = new HashMap<Integer, DtCuponera>();
    
    try {
       cuponera = (HashMap<Integer, DtCuponera>)request.getAttribute("cuponerasDisp");
    } catch (Exception e) {
    }
    
    DtCuponera cuponeraInfo = null;
    if (request.getAttribute("cuponera")!= null) {
        cuponeraInfo=(DtCuponera)request.getAttribute("cuponera");
    }
    
    
    String openModalstr = (String) request.getAttribute("open");
    Boolean arr = new Boolean(openModalstr);
    boolean openCuponeraModal = false;
    if (arr.equals(true)) {
        openCuponeraModal = true;
    }
   
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="w-full h-full absolute top-0 left-0 right-0 bottom-0 bg-[#6B7280] bg-opacity-60 flex items-center justify-center transition-all">
    <% if (cuponeraInfo != null) {
    %>
    <jsp:include page='./modalComprarCuponera.jsp'/>
    <%
    } else {
     %>
     <div class="bg-white rounded-2xl p-12 px-24 border-gray-300 border auto h-auto flex flex-row items-start justify-start gap-x-12 relative">
        <%-- Close Button --%>
        <a href="listarCuponeras?openModal=false" class="w-10 h-10 text-2xl bg-pink-100 text-red-700 flex items-center justify-center rounded-full absolute -top-3 -right-3">
            <i class="fa-solid fa-xmark"></i>
        </a>
        
        <div class="flex flex-col items-center min-w-[720px] h-auto justify-start flex-grow px-12 gap-y-4 w-full h-full">
            <p class="text-3xl w-full text-gray-900 font-medium border-b border-gray-300 pb-6">Cuponeras Disponibles</p>
            <%-- Sort --%>
            <div class="w-full h-auto flex items-center justify-end">
                <div class="w-auto h-full px-4 border rounded-md border-gray-300 py-1 bg-[#F9FAFB] py-2 px-4 gap-x-2 flex items-center justify-end">
                    <i class="fa-solid fa-arrow-down-short-wide flex items-center h-full"></i>
                    <div class="flex items-center justify-center gap-x-2">
                        <p class="text-[#374151] font-normal text-sm">Sort</p>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </div>
            
            <div class="w-full h-auto rounded-md border border-gray-300 shadow-md flex flex-col items-center justify-start max-h-[700px] overflow-auto">
                
                <%-- item --%>
                
                <% for (HashMap.Entry<Integer, DtCuponera> en : cuponera.entrySet()) {
                            Integer key = en.getKey();
                            DtCuponera val = en.getValue();
                    %> 
                <a href="listarCuponeras?openModal=true&id=<%=val.getId()%>" class="w-full h-[108px] min-h-[108px] p-4 flex flex-col items-center justify-start border-b border-gray-300 cursor-pointer" >
                    <div class="flex-grow w-full h-auto flex flex-row items-center justify-between">
                        <p class="text-[##4F46E5] text-sm font-medium"><%=val.getNombre()%></p>
                        <div class="w-auto h-auto px-[10px] py-[2px] rounded-2xl bg-[#D1FAE5] flex items-center justify-center">
                            <p class="text-[#065F46] font-medium text-xs"><%=val.getDescuento()%>%</p>
                        </div>
                    </div>
                    <div class="flex-grow w-full flex items-end justify-start gap-x-2">
                        <i class="fa-solid fa-calendar text-gray-500"></i>
                        <p class="text-gry-500 font-normal text-sm">Valido hasta el <%=val.getPeriodoVigencia()%></p>
                    </div>
                </a>
                <%
                }
                %>
            
                
                
            </div>
        </div>
    </div>
     <%
}
    %>
    
    
</div>
