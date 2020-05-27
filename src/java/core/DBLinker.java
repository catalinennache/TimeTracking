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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
        String queryString = ("select * from `timetracking`.`" + "companii" + "`" + " where user = '" + user + "'" + " and parola = '" + parola + "';");
        Statement stmt = con.createStatement();
        System.out.println(queryString);
        ResultSet rezultate = stmt.executeQuery(queryString);
        rezultate.next();
        // de revazut
        try {
            String tmp = rezultate.getString("id_companie");
            if (tmp != null) {
                int id_companie = Integer.parseInt(tmp);
                cmp = new Companie(id_companie, user, parola);
            } else {
                return null;
            }
        } catch (Exception e) {
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

    public static boolean addAngajatProiect(String cod_proiect, int id_angajat) {
        boolean scs = true;
        init();

        try {

            String sql = "Insert into angajat_proiect values(NULL,'" + id_angajat + "','" + cod_proiect + "',sysdate(),NULL)";

            Statement stmt = con.createStatement();
            stmt.execute(sql);

            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }

        return scs;
    }

    public static boolean addAngajat(Angajat ang, Invitatie inv) {
        boolean scs = true;
        init();

        try {
            String sql = "Insert into angajati values(NULL,'" + inv.cod_invitatie + "','" + ang.nickname + "','" + ang.email + "','" + ang.parola + "')";

            Statement stmt = con.createStatement();
            stmt.execute(sql);

            sql = "update invitatii set invitatie_folosita = true where id_invitatie = '" + inv.cod_invitatie + "'";
            stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }
        return scs;
    }

    public static boolean addProiect(Proiect pr) {
        boolean scs = true;
        init();

        try {
            String sql = "Insert into proiecte values('" + pr.cod_proiect + "','" + pr.id_companie + "','" + pr.nume + "','" + pr.data_creare + "')";

            Statement stmt = con.createStatement();
            stmt.execute(sql);

            // sql = "update invitatii set invitatie_folosita = true where id_invitatie = '"+inv.cod_invitatie+"'";
            // stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }
        return scs;
    }

    public static boolean addSesiune(int id_ap) {
        boolean scs = true;
        init();
        java.util.Date dt = new java.util.Date();

        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String currentTime = sdf.format(dt);
        try {
            String sql = "Insert into sesiuni values(NULL,'" + currentTime + "',NULL,'" + id_ap + "',NULL)";

            Statement stmt = con.createStatement();
            stmt.execute(sql);

            // sql = "update invitatii set invitatie_folosita = true where id_invitatie = '"+inv.cod_invitatie+"'";
            // stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }
        return scs;
    }

    public static boolean removeCompanie(int id_comp) {
        boolean scs = false;
        try {
            Statement stmt;
            stmt = con.createStatement();
            stmt.executeUpdate("delete from " + "companii" + " where " + "id_companie" + " = '" + id_comp + "';");
            scs = true;
        } catch (Exception e) {

        }

        return scs;
    }

    public static Invitatie getInvitatie(String cod) throws SQLException {
        init();
        Invitatie inv = null;
        String queryString = ("select * from `timetracking`.`" + "invitatii" + "`" + " where id_invitatie = '" + cod + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            // 
            boolean folosita = rezultate.getBoolean("invitatie_folosita");
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
            boolean folosita = rezultate.getBoolean("invitatie_folosita");
            Invitatie inv_gasita = new Invitatie(cod, folosita, id_companie);
            invitatii.add(inv_gasita);
            // new companie
            // .add(0x326);

        }

        return invitatii;
    }

    public static ArrayList<Invitatie> getInvitatii(int id_companie) throws SQLException {
        init();
        System.out.println(">> entering getInvitatii");
        ArrayList<Invitatie> invitatii = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "invitatii" + "`" + " where id_companie = '" + id_companie + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            // int id_companie = rezultate.getInt("id_companie");
            String cod = rezultate.getString("id_invitatie");
            boolean folosita = rezultate.getBoolean("invitatie_folosita");
            Invitatie inv_gasita = new Invitatie(cod, folosita, id_companie);
            invitatii.add(inv_gasita);

            // new companie
            // .add(0x326);
        }
        System.out.println("Returning " + invitatii.size() + " invitatii ");

        return invitatii;
    }

    public static String addInvitatie(boolean folosita, int id_companie) {
        boolean scs = true;
        String cod_invitatie = genereazaCodInv();
        init();
        try {

            String sql = "Insert into invitatii values('" + cod_invitatie + "','" + (folosita ? 1 : 0) + "','" + id_companie + "');";
            Statement stmt = con.createStatement();
            stmt.execute(sql);
            disconnect();

        } catch (Exception e) {
            e.printStackTrace();
            scs = false;
        }
        return cod_invitatie;
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
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + " join" + "`" + "angajat_proiect" + "`" + "  using (id_ap)" + " where id_sesiune = '" + id_sesiune + "'" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {

            String tempstamp_inceput = rezultate.getString("tempstamp_inceput");
            String tempstamp_sfarsit = rezultate.getString("tempstamp_sfarsit");
            int id_ap = rezultate.getInt("id_ap");
            String cod_proiect = rezultate.getString("cod_proiect");
            String descriere = rezultate.getString("descriere_munca");
            sesi = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit, id_ap, cod_proiect, descriere);
        }

        return sesi;
    }

    public static ArrayList<Sesiune> getSesiuni() throws SQLException {
        init();
        ArrayList<Sesiune> sesiuni = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + " join" + "`" + "angajat_proiect" + "`" + "  using (id_ap)" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_sesiune");
            String tempstamp_inceput = rezultate.getString("tempstamp_inceput");
            String tempstamp_sfarsit = rezultate.getString("tempstamp_sfarsit");
            int id_ap = rezultate.getInt("id_ap");
            String cod_proiect = rezultate.getString("cod_proiect");
            String descriere = rezultate.getString("descriere_munca");
            Sesiune sesiune_gasita = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit, id_ap, cod_proiect, descriere);
            sesiuni.add(sesiune_gasita);

        }

        return sesiuni;
    }

    public static ArrayList<Sesiune> getSesiuni(int id_ap) throws SQLException {
        init();
        ArrayList<Sesiune> sesiuni = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + " join" + "`" + "angajat_proiect" + "`" + "  using (id_ap)" + " where id_ap = '" + id_ap + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {

            int id_sesiune = rezultate.getInt("id_sesiune");
            String tempstamp_inceput = rezultate.getString("timestamp_inceput");
            String tempstamp_sfarsit = rezultate.getString("timestamp_sfarsit");
            String cod_proiect = rezultate.getString("cod_proiect");
            String descriere = rezultate.getString("descriere_munca");

            Sesiune sesiune_gasita = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit, id_ap, cod_proiect, descriere);

            sesiuni.add(sesiune_gasita);

        }

        return sesiuni;
    }

    public static ArrayList<Sesiune> getSesiuniAngajat(int id_angajat) throws SQLException {
        init();
        ArrayList<Sesiune> sesiuni = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" + " join" + "`" + "angajat_proiect" + "`" + "  using (id_ap)" + " where id_angajat = '" + id_angajat + "' ;");
        // String queryString = ("select * from `timetracking`.`" + "sesiuni" + "`" +" join" + "`"+"angajat_proiect" + "`" +"  using (id_ap)"  +" join" + "`"+"proiecte" + "`" +"  using (cod_proiect)"  +" where id_angajat = '" + id_angajat + "' ;");

        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {

            int id_sesiune = rezultate.getInt("id_sesiune");
            String tempstamp_inceput = rezultate.getString("timestamp_inceput");
            String tempstamp_sfarsit = rezultate.getString("timestamp_final");

            int id_ap = rezultate.getInt("id_ap");
            String cod_proiect = rezultate.getString("cod_proiect");
            String descriere = rezultate.getString("descriere_munca");
            Sesiune sesiune_gasita = new Sesiune(id_sesiune, tempstamp_inceput, tempstamp_sfarsit, id_ap, cod_proiect, descriere);

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
            String id_invitatie = rezultate.getString("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");

            Angajat angajat_gasit = new Angajat(id_sesiune, id_invitatie, nickname, email, parola);
            angajati.add(angajat_gasit);

        }

        return angajati;
    }

    public static ArrayList<Angajat> getAngajati(int id_companie) throws SQLException {
        init();
        ArrayList<Angajat> angajati = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "angajati" + "` where id_invitatie in (select id_invitatie from invitatii where id_companie ='" + id_companie + "')" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_angajat");
            String id_invitatie = rezultate.getString("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");

            Angajat angajat_gasit = new Angajat(id_sesiune, id_invitatie, nickname, email, parola);
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
            String id_invitatie = rezultate.getString("id_invitatie");
            String nickname = rezultate.getString("nickname");
            String email = rezultate.getString("email");
            String parola = rezultate.getString("parola");

            ang = new Angajat(id_sesiune, id_invitatie, nickname, email, parola);
            //angajati.add(angajat_gasit);
        }

        return ang;
    }

    public static Angajat getAngajat(String porecla, String password) throws SQLException {
        init();
        Angajat ang = null;
        String queryString = ("select * from `timetracking`.`" + "angajati" + "`" + " where nickname = '" + porecla + "'" + " and parola = '" + password + "';");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int id_sesiune = rezultate.getInt("id_angajat");
            String id_invitatie = rezultate.getString("id_invitatie");
            String email = rezultate.getString("email");

            String parola = rezultate.getString("parola");

            ang = new Angajat(id_sesiune, id_invitatie, porecla, email, parola);
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

            String nume = rezultate.getString("nume");
            String data_creare = rezultate.getString("data_creare");

            proiect = new Proiect(cod_proiect, nume, data_creare, rezultate.getInt("id_companie"));
        }

        return proiect;
    }

    public static ArrayList<Proiect> getProiects() throws SQLException {
        init();
        ArrayList<Proiect> proiecte = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "proiect" + "`" + ";");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            String cod_proiect = rezultate.getString("cod_proiect");
            String nume = rezultate.getString("nume");
            String data_creare = rezultate.getString("data_creare");
            Proiect proiect_gasit = new Proiect(cod_proiect, nume, data_creare, rezultate.getInt("id_companie"));
            proiecte.add(proiect_gasit);

        }

        return proiecte;
    }

    public static ArrayList<Proiect> getProiects(int id_companie) throws SQLException {
        init();
        ArrayList<Proiect> proiecte = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "proiecte" + "`" + " where id_companie = '" + id_companie + "';");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            String cod_proiect = rezultate.getString("cod_proiect");
            String nume = rezultate.getString("nume");
            String data_creare = rezultate.getString("data_creare");
            Proiect proiect_gasit = new Proiect(cod_proiect, nume, data_creare, rezultate.getInt("id_companie"));
            proiecte.add(proiect_gasit);

        }

        return proiecte;
    }

    public static AngajatProiect getAngajatProiect(int ap) throws SQLException {
        init();

        String queryString = ("select * from `timetracking`.`" + "angajat_proiect" + "` where id_ap = '" + ap + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        rezultate.next();
        //AngajatProiect( int ap, int angajat, String cod, long in, long out)
        int ang = rezultate.getInt("id_angajat");
        String cod_p = rezultate.getString("cod_proiect");
        String in = rezultate.getString("data_inrolarii");
        String out = rezultate.getString("data_parasire");
        double ore_lucrate = rezultate.getDouble("ore_lucrate");

        return new AngajatProiect(ap, ang, cod_p, in, out);
    }

    public static ArrayList<AngajatProiect> getAngajatProiecte(int id_angajat, String id_proiect) throws SQLException {
        init();
        ArrayList<AngajatProiect> angajat_proiect = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "angajat_proiect" + "` where id_angajat = '" + id_angajat + "' and cod_proiect = '" + id_proiect + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int ap = rezultate.getInt("id_ap");
            int ang = rezultate.getInt("id_angajat");
            String cod_p = rezultate.getString("cod_proiect");
            String in = rezultate.getString("data_inrolarii");
            String out = rezultate.getString("data_parasire");
            //   double ore_lucrate = rezultate.getDouble("ore_lucrate");
            angajat_proiect.add(new AngajatProiect(ap, ang, cod_p, in, out));
        }

        return angajat_proiect;
    }

    public static ArrayList<AngajatProiect> getAngajatProiecte(int id_angajat) throws SQLException {
        init();
        ArrayList<AngajatProiect> angajat_proiect = new ArrayList<>();
        String queryString = ("select ap.*,(select sum(TIMESTAMPDIFF(HOUR,timestamp_inceput,timestamp_final)) from sesiuni where sesiuni.id_ap = ap.id_ap) as ore_lucrate  from " + "angajat_proiect ap" + " where id_angajat = '" + id_angajat + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int ap = rezultate.getInt("id_ap");
            int ang = rezultate.getInt("id_angajat");
            String cod_p = rezultate.getString("cod_proiect");
            String in = rezultate.getString("data_inrolarii");
            String out = rezultate.getString("data_parasire");
            double ore_lucrate = rezultate.getDouble("ore_lucrate");
            angajat_proiect.add(new AngajatProiect(ap, ang, cod_p, in, out, ore_lucrate));
        }

        DBLinker.disconnect();
        System.out.println("fetched " + angajat_proiect.size() + " rows");
        return angajat_proiect;
    }

    public static ArrayList<AngajatProiect> getAngajatiProiect(String cod_proiect) throws SQLException {
        init();
        ArrayList<AngajatProiect> angajat_proiect = new ArrayList<>();
        String queryString = ("select ap.*,(select sum(TIMESTAMPDIFF(HOUR,timestamp_inceput,timestamp_final)) from sesiuni where sesiuni.id_ap = ap.id_ap) as ore_lucrate  from " + "angajat_proiect ap" + " where cod_proiect = '" + cod_proiect + "' ;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int ap = rezultate.getInt("id_ap");
            int ang = rezultate.getInt("id_angajat");
            String cod_p = rezultate.getString("cod_proiect");
            String in = rezultate.getString("data_inrolarii");
            String out = rezultate.getString("data_parasire");
            double ore_lucrate = rezultate.getDouble("ore_lucrate");
            angajat_proiect.add(new AngajatProiect(ap, ang, cod_p, in, out, ore_lucrate));
        }

        return angajat_proiect;
    }

    public static ArrayList<AngajatProiect> getAngajatiProiecte() throws SQLException {
        init();
        ArrayList<AngajatProiect> angajat_proiect = new ArrayList<>();
        String queryString = ("select * from `timetracking`.`" + "angajat_proiect" + "`;");
        Statement stmt = con.createStatement();
        ResultSet rezultate = stmt.executeQuery(queryString);
        while (rezultate.next()) {
            int ap = rezultate.getInt("id_ap");
            int ang = rezultate.getInt("id_angajat");
            String cod_p = rezultate.getString("cod_proiect");
            String in = rezultate.getString("data_inrolarii");
            String out = rezultate.getString("data_parasire");
            //double ore_lucrate = rezultate.getDouble("ore_lucrate");
            angajat_proiect.add(new AngajatProiect(ap, ang, cod_p, in, out));
        }

        return angajat_proiect;
    }

    //lipseste get dupa id_ap
    public static boolean endSesiune(int id_ap, String descriere) {

        boolean scs = true;
        init();

        try {

            Statement stmt = con.createStatement();
            String sql1 = "select id_sesiune from sesiuni where id_ap = '" + id_ap + "' order by timestamp_inceput desc";
            ResultSet rezultate = stmt.executeQuery(sql1);
            rezultate.next();
            int id_sesiune = rezultate.getInt(1);
            java.util.Date dt = new java.util.Date();

            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            String currentTime = sdf.format(dt);
            String sq2 = "update sesiuni set timestamp_final = '" + currentTime + "', descriere_munca = '" + descriere + "' where id_sesiune = '" + id_sesiune + "'";
            System.out.println(sq2);
            stmt.execute(sq2);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }

        return scs;

    }

    public static int numaraSesiuni(int id_ap) {

        boolean scs = true;
        init();
        int count = -1;
        try {

            Statement stmt = con.createStatement();
            String sql1 = "select count(*) from sesiuni where id_ap = '" + id_ap + "'";
            ResultSet rezultate = stmt.executeQuery(sql1);
            rezultate.next();
            count = rezultate.getInt(1);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }

        return count;
    }

    public static int numaraSesiuniTerminate(int id_ap) {
        boolean scs = true;
        init();
        int count = -1;
        try {

            Statement stmt = con.createStatement();
            String sql1 = "select count(*) from sesiuni where id_ap = '" + id_ap + "' and timestamp_final is not null";
            ResultSet rezultate = stmt.executeQuery(sql1);
            rezultate.next();
            count = rezultate.getInt(1);
            disconnect();

        } catch (Exception e) {
            scs = false;
            e.printStackTrace();
        }

        return count;

    }

    public static String getOreProiect(String cod_proiect) {
        init();
        String rezultat = "0";

        try {
            String queryString = ("select ap.*,(select sum(TIMESTAMPDIFF(HOUR,timestamp_inceput,timestamp_final)) from sesiuni where sesiuni.id_ap = ap.id_ap) as ore_lucrate  from " + "angajat_proiect ap" + " where cod_proiect = '" + cod_proiect + "' ;");
            Statement stmt = con.createStatement();
            ResultSet rezultate = stmt.executeQuery(queryString);
            rezultate.next();
            rezultat = rezultate.getString("ore_lucrate");
        } catch (Exception e) {
            e.printStackTrace();

        }
        try {
            disconnect();
        } catch (Exception e) {
        }
        return rezultat;
    }

    public static String getOreAngajat(int id_angajat) {
        init();
        String rezultat = "-1";

        try {
            String queryString = ("select ap.*,(select sum(TIMESTAMPDIFF(HOUR,timestamp_inceput,timestamp_final)) from sesiuni where sesiuni.id_ap = ap.id_ap) as ore_lucrate  from " + "angajat_proiect ap" + " where id_angajat = '" + id_angajat + "' ;");
            Statement stmt = con.createStatement();
            ResultSet rezultate = stmt.executeQuery(queryString);
            rezultate.next();
            rezultat = rezultate.getString("ore_lucrate");
        } catch (Exception e) {
            e.printStackTrace();

        }
        try {
            disconnect();
        } catch (Exception e) {
        }
        return rezultat;
    }

    public static Date getMinDate(int id_angajat) {
        Date date = null;
        try {
            init();

            try {
                String queryString = ("select min(timestamp_inceput) from sesiuni where id_ap in (select id_ap from angajat_proiect where id_angajat = '" + id_angajat + "');");
                Statement stmt = con.createStatement();
                ResultSet rezultate = stmt.executeQuery(queryString);
                rezultate.next();
                date = rezultate.getDate(1);
            } catch (Exception e) {
                e.printStackTrace();

            }

        } catch (Exception e) {
        }
        return date;
    }
    
    public static double getHoursOnInterval(int id_angajat, Date cap_saptamana, Date coada_saptamana){
        double rezultat = 0;
     try {
       

SimpleDateFormat sdf = 
     new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String cap = sdf.format(cap_saptamana);
String coada = sdf.format(coada_saptamana);
            String queryString = ("select ap.*,(select sum(TIMESTAMPDIFF(HOUR,timestamp_inceput,timestamp_final)) from sesiuni where timestamp_inceput < '"+cap+"' and timestamp_final > '"+coada+"') as ore_lucrate  from " + "angajat_proiect ap" + " where id_angajat = '" + id_angajat + "' ;");
            System.out.println(queryString);
            Statement stmt = con.createStatement();
            ResultSet rezultate = stmt.executeQuery(queryString);
            rezultate.next();
            rezultat = rezultate.getDouble("ore_lucrate");
            System.out.println("got "+rezultat);
        } catch (Exception e) {
            e.printStackTrace();

        }
        try {
          //  disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rezultat;
    }

    public static ArrayList<Angajat> getLateUsers() {

        ArrayList<Angajat> angajati = new ArrayList<>();
        try {
            init();

            try {
                String queryString = ("select distinct id_angajat from sesiuni ss join angajat_proiect ap on(ap.id_ap = ss.id_ap) where timestamp_final is NULL and  TIMESTAMPDIFF(SECOND, sysdate(), timestamp_inceput)/3600<8;");
                Statement stmt = con.createStatement();
                ResultSet rezultate = stmt.executeQuery(queryString);
              
                while (rezultate.next()) {
                    
                    int id_ang = rezultate.getInt(1);
                     System.out.println("gasit angajat intarziat "+id_ang);
                    angajati.add(DBLinker.getAngajat(id_ang));
                   
                }
            } catch (Exception e) {
                e.printStackTrace();

            }

        } catch (Exception e) {
        }

        return angajati;
    }
}
