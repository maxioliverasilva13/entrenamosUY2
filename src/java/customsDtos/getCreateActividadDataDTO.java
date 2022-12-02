/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package customsDtos;

import java.util.HashMap;
import ws.DtCategoria;

/**
 *
 * @author rodrigo
 */
public class getCreateActividadDataDTO {
    private HashMap<Integer,DtCategoria> categorias;
    
    public getCreateActividadDataDTO(HashMap<Integer,DtCategoria> categorias){
       
        this.categorias = categorias;
    }
   
    public HashMap<Integer,DtCategoria> getCategoriass(){
        return this.categorias;
    }
}
