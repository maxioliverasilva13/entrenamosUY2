/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author mandi
 */
public class FollowData {
    public int seguidores;
    public int seguidos;

    public FollowData(int seguidores, int seguidos) {
        this.seguidores = seguidores;
        this.seguidos = seguidos;
    }

    public int getSeguidores() {
        return seguidores;
    }

    public int getSeguidos() {
        return seguidos;
    }
}
