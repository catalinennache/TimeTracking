/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package core;

/**
 *
 * @author Ana Dima
 */
public class Sesiune {
 
   
    public int id_sesiune;
    public long timestamp_inceput;
    public long timestamp_sfarsit;
    public int id_ap;
    
    protected Sesiune( int id, long inceput, long sfarsit, int id_ap){
        id_sesiune=id;
        timestamp_inceput=inceput;
        timestamp_sfarsit=sfarsit;
        this.id_ap=id_ap;
        
                
        
    }
}
