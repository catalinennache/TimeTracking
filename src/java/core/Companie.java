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
    
    int id_companie;
    String user,parola;
    ArrayList<Invitatie> invitatii;
    
    
    protected Companie(int id_comp,String user,String parola){
        id_companie = id_comp;
        this.user = user;
        this.parola = parola;
    }
    
    
    public void updateInvitatii() throws SQLException{
      invitatii =  DBLinker.getInvitatii(id_companie);
    }
}
