/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author Enache
 */
public abstract class DBLinker {

    private static Connection con;
    private static String error = "";

    private static void connect() throws ClassNotFoundException, SQLException, Exception {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/timetracking?useSSL=false", "root", "");
        } catch (ClassNotFoundException cnfe) {
            error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
            throw new ClassNotFoundException(error);
        } catch (SQLException cnfe) {
            error = "SQLException: Nu se poate conecta la baza de date.";
            throw new SQLException(error);
        } catch (Exception e) {
            error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
            throw new Exception(error);
        }
    }

    private static void disconnect() throws SQLException {
        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException sqle) {
            error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
            throw new SQLException(error);
        }
    }

    public static String init() {
        try {
            error = "";
            connect();
        } catch (Exception e) {
        }

        return error;
    }

    public static ArrayList<Companie> getCompanies() throws SQLException {
        init();
        ArrayList<Companie> companii = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "companii" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_companie = rezultate.getInt("id_companie");
            String user = rezultate.getString("user");
            String parola = rezultate.getString("parola");
            Companie companie_gasita = new Companie(id_companie, user, parola);
            companii.add(companie_gasita);
             // new companie
            // .add(0x326);

        }

        return companii;
    }

    public static Companie getCompanie(String user, String parola) throws SQLException {
        init();
        Companie cmp = null;
        String queryString = ("select * from `timetracking`.`" + "companii" + "`" + " where user = '" + user + "'" + "','" + parola + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        rezultate.next();
        // de revazut
        String tmp = rezultate.getString("id_companie");
        if (tmp != null) {
            int id_companie = Integer.parseInt(tmp);
            cmp = new Companie(id_companie, user, parola);
        }else{
            return null;
        }

        return cmp;
    }

    public static Companie getCompanie(int id_companie) throws SQLException {
        init();
        Companie cmp = null;
        String queryString = ("select * from `timetracking`.`" + "companii" + "`" + " where id_companie = '" + id_companie + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            //  int id_companie = rezultate.getInt("id_companie");
            String user = rezultate.getString("user");
            String parola = rezultate.getString("parola");
            cmp = new Companie(id_companie, user, parola);
        }

        return cmp;
    }

    public static boolean addCompanie(String user, String parola) {
        boolean scs = true;
        init();
        try {
            String sql = "Insert into companii (user,parola) values('" + user + "','" + parola + "')";

            Statement stmt = con.createStatement();
            stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }
        return scs;
    }

    public static Invitatie getInvitatie(String cod) throws SQLException {
        init();
        Invitatie inv = null;
        String queryString = ("select * from `timetracking`.`" + "invitatii" + "`" + " where cod = '" + cod + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            // 
            boolean folosita = rezultate.getBoolean("folosita");
            int id_companie = rezultate.getInt("id_companie");
            inv = new Invitatie(cod, folosita, id_companie);
        }

        return inv;
    }

    public static ArrayList<Invitatie> getInvitatii() throws SQLException {
        init();
        ArrayList<Invitatie> invitatii = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "invitatii" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_companie = rezultate.getInt("id_companie");
            String cod = rezultate.getString("cod");
            boolean folosita = rezultate.getBoolean("folosita");
            Invitatie inv_gasita = new Invitatie(cod, folosita, id_companie);
            invitatii.add(inv_gasita);
             // new companie
            // .add(0x326);

        }

        return invitatii;
    }

   public static ArrayList<Invitatie> getInvitatii(int id_companie) throws SQLException {
        init();
        ArrayList<Invitatie> invitatii = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "invitatii" + "`" + " where id_companie = '" + id_companie + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            // int id_companie = rezultate.getInt("id_companie");
            String cod = rezultate.getString("cod");
            boolean folosita = rezultate.getBoolean("folosita");
            Invitatie inv_gasita = new Invitatie(cod, folosita, id_companie);
            invitatii.add(inv_gasita);
             // new companie
            // .add(0x326);

        }

        return invitatii;
    }

    public static boolean addInvitatie(boolean folosita, int id_companie) {
        boolean scs = true;
        String cod_invitatie = genereazaCodInv();
        init();
        try {

            String sql = "Insert into companii values('" + cod_invitatie + "','" + (folosita ? 1 : 0) + "','" + id_companie + "');";
            Statement stmt = con.createStatement();
            stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
        }
        return scs;
    }

    private static String genereazaCodInv() {
        Random rnd = new Random();
        String cod_generat = "";
        String dictionar = "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNM";
        for (int i = 0; i < 64; i++) {
            cod_generat += dictionar.charAt(rnd.nextInt(dictionar.length()));
        }

        return cod_generat;

    }
    public static Sesiune getSesiune(int id_sesiune) throws SQLException {
        init();
        Sesiune sesi = null;
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + " where id_sesiune = '" + id_sesiune + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
          
            long tempstamp_inceput=rezultate.getLong("tempstamp_inceput");
            long tempstamp_sfarsit=rezultate.getLong("tempstamp_sfarsit");
            int id_ap=rezultate.getInt("id_ap");
           
            sesi = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit,id_ap);
        }

        return sesi;
    }
    
     public static ArrayList<Sesiune> getSesiuni() throws SQLException {
        init();
        ArrayList<Sesiune> sesiuni = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_sesiune");
            long tempstamp_inceput=rezultate.getLong("tempstamp_inceput");
            long tempstamp_sfarsit=rezultate.getLong("tempstamp_sfarsit");
            int id_ap=rezultate.getInt("id_ap");
            Sesiune sesiune_gasita = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit,id_ap);
            sesiuni.add(sesiune_gasita);
           

        }

        return sesiuni;
    }
     
      public static ArrayList<Sesiune> getSesiuni(int id_ap) throws SQLException {
        init();
        ArrayList<Sesiune> sesiuni = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + " where id_ap = '" + id_ap + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
           
            int id_sesiune = rezultate.getInt("id_sesiune");
            long tempstamp_inceput=rezultate.getLong("tempstamp_inceput");
            long tempstamp_sfarsit=rezultate.getLong("tempstamp_sfarsit");
            Sesiune sesiune_gasita = new  Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit,id_ap);
          
            sesiuni.add(sesiune_gasita);

        }

        return sesiuni;
    }
      
      
      
    
     public static ArrayList<Angajat> getAngajati() throws SQLException {
        init();
        ArrayList<Angajat> angajati = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "angajati" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_angajat");
            int id_invitatie = rezultate.getInt("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");
           
            Angajat angajat_gasit = new Angajat(id_sesiune, id_invitatie, nickname,email,parola);
            angajati.add(angajat_gasit);
           

        }

        return angajati;
    }
     
          public static ArrayList<Angajat> getAngajati(int id_companie) throws SQLException {
        init();
        ArrayList<Angajat> angajati = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "angajati" + "` where id_invitatie in (select id_invitatie from invitatii where id_companie ='"+id_companie+"')"+  ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_angajat");
            int id_invitatie = rezultate.getInt("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");
           
            Angajat angajat_gasit = new Angajat(id_sesiune, id_invitatie, nickname,email,parola);
            angajati.add(angajat_gasit);
           

        }

        return angajati;
    }
     
      public static Angajat getAngajat(int id_angajat) throws SQLException {
        init();
         Angajat ang = null;
        String queryString = ("select * from `timetracking`.`" + "angajati" + "`" + " where id_angajat = '" + id_angajat + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
           int id_sesiune = rezultate.getInt("id_angajat");
            int id_invitatie = rezultate.getInt("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");
           
          ang = new Angajat(id_sesiune, id_invitatie, nickname,email,parola);
            //angajati.add(angajat_gasit);
        }

        return ang;
    }
      
      
       public static Proiect getProiect(String cod_proiect) throws SQLException {
        init();
        Proiect proiect = null;
        String queryString = ("select * from `timetracking`.`" + "proiecte" + "`" + " where cod_proiect = '" + cod_proiect + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
          
            String nume=rezultate.getString("nume");
            long data_creare=rezultate.getLong("data_creare");
           
           
            proiect = new Proiect(cod_proiect, nume, data_creare);
        }

        return proiect;
    }
       
       public static ArrayList<Proiect> getProiect() throws SQLException {
        init();
        ArrayList<Proiect> proiecte = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "proiecte" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            String cod_proiect=rezultate.getString("cod_proiect");
            String nume=rezultate.getString("nume");
            long data_creare=rezultate.getLong("data_creare");
           Proiect proiect_gasit = new Proiect(cod_proiect, nume, data_creare);
            proiecte.add(proiect_gasit);
           


        }

        return proiecte;
    }
       
       
       //lipseste get dupa id_ap
}
