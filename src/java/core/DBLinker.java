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
            String sql = "Insert into companii values('" + user + "','" + parola + "');";

            Statement stmt = con.createStatement();
            stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
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

    static ArrayList<Invitatie> getInvitatii(int id_companie) throws SQLException {
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

}
