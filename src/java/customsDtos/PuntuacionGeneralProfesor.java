/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package customsDtos;

/**
 *
 * @author rodrigo
 */
public class PuntuacionGeneralProfesor {
    private double puntuacionGeneral;
    private int cantPuntuaciones;
    
    public PuntuacionGeneralProfesor(double puntuacionGeneral,int cantPuntuaciones){
        this.puntuacionGeneral = puntuacionGeneral;
        this.cantPuntuaciones = cantPuntuaciones;
    }
    
    public double getPuntuacionGeneral(){
        return this.puntuacionGeneral;
    }
    
    public double getCantPuntuaciones(){
        return this.puntuacionGeneral;
    }
}
