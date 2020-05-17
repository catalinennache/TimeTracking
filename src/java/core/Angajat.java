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
public class Angajat {
    public int id_angajat;
    public String id_invitatie;
    public String nickname,email,parola;
    
    public Angajat(int id_angajat, String cod_invitatie ,String nick,String email, String parola){
    
            this.id_angajat = id_angajat;
            this.id_invitatie = cod_invitatie;
            this.nickname = nick;
            this.parola = parola;
            this.email = email;
    }
    
}
