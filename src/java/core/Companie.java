/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package core;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Enache
 */
public class Companie {
    
   public int id_companie;
   public String user,parola;
   public  ArrayList<Invitatie> invitatii;
    
    
    protected Companie(int id_comp,String user,String parola){
        id_companie = id_comp;
        this.user = user;
        this.parola = parola;
    }
    
    
    public void updateInvitatii() throws SQLException{
      invitatii =  DBLinker.getInvitatii(id_companie);
    }
}
