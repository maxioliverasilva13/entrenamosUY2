window.addEventListener("load",function(){
   const SELECT_TIPO_USUARIO = document.getElementById("selectTipoUsuario");
   const PROFESOR_DATA_CARD = document.getElementById("profesorDataCard");
   SELECT_TIPO_USUARIO.addEventListener("change", ()=>{
       const VALUE = SELECT_TIPO_USUARIO.value;
       
       if(VALUE == "Socio"){
           PROFESOR_DATA_CARD.setAttribute("display","none");
       }else{
           PROFESOR_DATA_CARD.setAttribute("display","block");
       }
   }); 
   
   
   function handleSelectChange(event){
       console.log("Holaaa");
   }

});

