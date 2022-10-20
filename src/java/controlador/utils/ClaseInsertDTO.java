/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador.utils;

import java.io.File;

/**
 *
 * @author Maximiliano Olivera
 */
public class ClaseInsertDTO {

    String nombre;
    String sociosMin;
    String sociosMax;
    String urlAcceso;
    String fechaClase;
    String idActividad;
    String idProfesor;
    String profesorNombre;
    String fileToSend;

    public String getFileToSend() {
        return fileToSend;
    }

    public ClaseInsertDTO(String nombre, String sociosMin, String sociosMax, String urlAcceso, String fechaClase, String idActividad, String idProfesor, String profesorNombre, String fileToSend) {
        this.nombre = nombre;
        this.sociosMin = sociosMin;
        this.sociosMax = sociosMax;
        this.urlAcceso = urlAcceso;
        this.fechaClase = fechaClase;
        this.idActividad = idActividad;
        this.idProfesor = idProfesor;
        this.profesorNombre = profesorNombre;
        this.fileToSend = fileToSend;
    }

    public void setFileToSend(String fileToSend) {
        this.fileToSend = fileToSend;
    }

    public String getIdActividad() {
        return idActividad;
    }

    public void setIdActividad(String idActividad) {
        this.idActividad = idActividad;
    }

    public String getIdProfesor() {
        return idProfesor;
    }

    public void setIdProfesor(String idProfesor) {
        this.idProfesor = idProfesor;
    }

    public String getProfesorNombre() {
        return profesorNombre;
    }

    public void setProfesorNombre(String profesorNombre) {
        this.profesorNombre = profesorNombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSociosMin() {
        return sociosMin;
    }

    public void setSociosMin(String sociosMin) {
        this.sociosMin = sociosMin;
    }

    public String getSociosMax() {
        return sociosMax;
    }

    public void setSociosMax(String sociosMax) {
        this.sociosMax = sociosMax;
    }

    public String getUrlAcceso() {
        return urlAcceso;
    }

    public void setUrlAcceso(String urlAcceso) {
        this.urlAcceso = urlAcceso;
    }

    public String getFechaClase() {
        return fechaClase;
    }

    public void setFechaClase(String fechaClase) {
        this.fechaClase = fechaClase;
    }

}
