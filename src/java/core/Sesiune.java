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
 
   
    int id_sesiune;
    long timestamp_inceput, timestamp_sfarsit;
    
    protected Sesiune( int id, long inceput, long sfarsit){
        id_sesiune=id;
        timestamp_inceput=inceput;
        timestamp_sfarsit=sfarsit;
                
        
    }
}
