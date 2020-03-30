/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package core;

/**
 *
 * @author Enache
 */
public class Invitatie {
    
    String cod_invitatie;
    boolean folosita;
    int id_companie;
    
    protected Invitatie(String cod,boolean folosita,int id){
        cod_invitatie = cod;
        this.folosita = folosita;
        this.id_companie = id;
    }
    
}
