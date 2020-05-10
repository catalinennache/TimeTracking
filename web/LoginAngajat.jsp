<%-- 
    Document   : Login
    Created on : Apr 28, 2020, 3:36:31 PM
    Author     : Enache
--%>



<%@page import="core.Angajat"%>
<%@page import="core.Companie"%>
<%@page import="core.DBLinker"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<!DOCTYPE html>


<%
     HttpSession current_session = request.getSession();
    if(current_session.getAttribute("user") != null){
           response.sendRedirect("/TimeTracking/HomeAngajat.jsp");
    }else{
         System.out.println("Niciun user momentan logat");
    }
    
    String metoda_de_obtinere_a_paginii = request.getMethod();
    int id_companie_gasita = -1;
    String mesaj_eroare = "";
    
    
    if(metoda_de_obtinere_a_paginii.equals("POST")){
        String user = request.getParameter("user");
        String password = request.getParameter("pass");
        Angajat angajat =  DBLinker.getAngajat(user,password);
   //    Companie companie = DBLinker.getCompanie(user, password);
       if(angajat != null){
            id_companie_gasita = angajat.id_angajat;
            current_session.setAttribute("user_admin", angajat);
            System.out.println(" >> inregistrat_user");
            response.sendRedirect("/TimeTracking/HomeAngajat.jsp");
       }else{
            mesaj_eroare = "Autentificare esuata";
       }
        
    } 
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1> Log In -- Angajat </h1>
        <form method="POST" action="/TimeTracking/LoginAngajat.jsp">
            <input type="text" name="user">
            <input type="password" name="pass">
            <input type="submit" value="apasa-ma">
        </form>
        <%= mesaj_eroare  %>
        
    </body>
</html>
