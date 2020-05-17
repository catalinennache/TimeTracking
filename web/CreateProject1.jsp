

<%@page import="com.sun.xml.rpc.processor.modeler.j2ee.xml.string"%>
<%@page import="core.Proiect"%>
<%@page import="java.sql.Date"%>
<%@page import="core.Angajat"%>
<%@page import="core.Invitatie"%>
<%@page import="core.DBLinker"%>
<%@page import="core.DBLinker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
/*
<%
     HttpSession current_session = request.getSession();
    if(current_session.getAttribute("user_admin") != null){
           response.sendRedirect("/TimeTracking/CreateProject1.jsp");
    }else{
         System.out.println("Niciun user momentan logat");
    }
    
    String metoda_de_obtinere_a_paginii = request.getMethod();
    int id_companie_gasita = -1;
    String mesaj_eroare = " nu merge";
    
    
    if(metoda_de_obtinere_a_paginii.equals("POST")){
        String cod_proiect = request.getParameter("cod_proiect");
        String nume = request.getParameter("nume");
       // long data = request.getParameter("data");
        
        String date=request.getParameter("data");
        long date1 = Long.parseLong(date);
         Proiect proiect = new Proiect(cod_proiect,nume,date1);
            boolean scs =  DBLinker.addProiect(proiect);
	
   
    
  
      
       if(scs){
           response.sendRedirect("/TimeTracking/CreateProject1.jsp");
       }else{
           mesaj_eroare = "A aparut o eroare la adaugare";
       }
       }else{
           mesaj_eroare = "Invitatia nu mai este valabila!";
       }
    } 
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creaza un Proiect</title>
    </head>
    <body>


        <form method="POST" action="/TimeTracking/CreateProject1.jsp">
            <div class="row">
                <label> Cod Proiect </label>
                <input type="text" required name="cod_proiect">
            </div>
            <div class="row">
                <label> Nume </label>
                <input type="text" required name="nume">
            </div>
            <div class="row">
                <label> Data </label>
                <input type="date" required name="data">
            </div>
            
            <input type="submit" class="send" value="Register">
          
        </form>
