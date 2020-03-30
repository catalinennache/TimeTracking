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
public class Proiect {
    
    public String cod_proiect;
    public String nume;
    public long data_creare;
    
    protected Proiect( String cod, String nume, long data){
        cod_proiect=cod;
        this.nume=nume;
        data_creare=data;
        
    }
    
}
