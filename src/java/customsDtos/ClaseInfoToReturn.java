package customsDtos;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import Clase.DtClase;
import Socio.dtos.SocioDTO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author maximilianoolivera
 */
public class ClaseInfoToReturn {
    public DtClase claseInfo;
    public boolean isProfesorDeClaseAndYaPaso;
    public boolean verResultados;
    List<SocioDTO> resultados = new ArrayList<>();

    public DtClase getClaseInfo() {
        return claseInfo;
    }

    public ClaseInfoToReturn(DtClase claseInfo, boolean isProfesorDeClaseAndYaPaso, boolean verResultados, List<SocioDTO> resultados) {
        this.claseInfo = claseInfo;
        this.isProfesorDeClaseAndYaPaso = isProfesorDeClaseAndYaPaso;
        this.verResultados = verResultados;
        this.resultados = resultados;
    }

    public void setClaseInfo(DtClase claseInfo) {
        this.claseInfo = claseInfo;
    }

    public boolean isVerResultados() {
        return verResultados;
    }
    
    public boolean isIsProfesorDeClaseAndYaPaso() {
        return isProfesorDeClaseAndYaPaso;
    }

    public List<SocioDTO> getResultados() {
        return resultados;
    }

    public void setIsProfesorDeClaseAndYaPaso(boolean isProfesorDeClaseAndYaPaso) {
        this.isProfesorDeClaseAndYaPaso = isProfesorDeClaseAndYaPaso;
    }
    
    
}
