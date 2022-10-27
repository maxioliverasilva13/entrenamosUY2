/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package customsDtos;

import java.util.List;

/**
 *
 * @author angel
 */
public class ComprarCuponeraInput {
    public Integer idCuponera;
    public List<Integer> actividadesIds;

    public ComprarCuponeraInput(int cuponeraId, List<Integer> actividadesIds) {
        this.idCuponera = cuponeraId;
        this.actividadesIds = actividadesIds;
    }

    public int getCuponeraId() {
        return idCuponera;
    }

    public void setCuponeraId(int cuponeraId) {
        this.idCuponera = cuponeraId;
    }

    public List<Integer> getActividadesIds() {
        return actividadesIds;
    }

    public void setActividadesIds(List<Integer> actividadesIds) {
        this.actividadesIds = actividadesIds;
    }
}
