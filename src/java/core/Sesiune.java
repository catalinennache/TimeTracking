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
    public String timestamp_inceput;
    public String timestamp_sfarsit;
    public int id_ap;
    public String cod_proiect;
    public String descriere_munca;
    
    protected Sesiune( int id, String inceput, String sfarsit, int id_ap,String proiect,String descriere_munca){
        id_sesiune=id;
        timestamp_inceput=inceput;
        timestamp_sfarsit=sfarsit;
        this.id_ap=id_ap;
        this.cod_proiect = proiect;
        this.descriere_munca = descriere_munca;
    }
}
