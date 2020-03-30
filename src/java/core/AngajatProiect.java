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
public class AngajatProiect {
    
        public int id_ap, id_angajat;
        public String cod_proiect;
        public long data_in;
        public long data_out;
   
   
   protected AngajatProiect( int ap, int angajat, String cod, long in, long out){
       
       id_ap=ap;
       id_angajat=angajat;
       cod_proiect=cod;
       data_in=in;
       data_out=out;
   }
   
}
