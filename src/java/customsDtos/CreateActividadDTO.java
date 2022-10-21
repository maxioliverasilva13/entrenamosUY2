/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package customsDtos;

import java.util.List;

/**
 *
 * @author rodrigo
 */
public class CreateActividadDTO {
    private String nombre;
    private String descripcion;
    private float duracion;
    private float costo;
    private List<Integer> categoriasId;

    public CreateActividadDTO(String nombre,String descripcion,float duracion,float costo, List<Integer> categoriasId){
      this.nombre = nombre;
      this.descripcion = descripcion;
      this.duracion = duracion;
      this.costo = costo;
      this.categoriasId= categoriasId;
    }

    public String getNombre(){
        return this.nombre;
    }
    public String descripcion(){
        return this.descripcion;
    }
    public float getDuracion(){
        return this.duracion;
    }
    public float getCosto(){
        return this.costo;
    }
    public List<Integer> getCategoriasID(){
        return this.categoriasId;
    }
}