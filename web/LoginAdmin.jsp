


<%@page import="core.Companie"%>
<%@page import="core.DBLinker"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<!DOCTYPE html>


<%
     HttpSession current_session = request.getSession();
    if(current_session.getAttribute("user_admin") != null){
           response.sendRedirect("/TimeTracking/HomeAdmin.jsp");
    }else{
         System.out.println("Niciun user momentan logat");
    }
    
    String metoda_de_obtinere_a_paginii = request.getMethod();
    int id_companie_gasita = -1;
    String mesaj_eroare = "";
    
    
    if(metoda_de_obtinere_a_paginii.equals("POST")){
        String user = request.getParameter("user");
        String password = request.getParameter("pass");
        
       Companie companie = DBLinker.getCompanie(user, password);
       if(companie != null){
            id_companie_gasita = companie.id_companie;
            current_session.setAttribute("user_admin", companie);
            System.out.println(" >> inregistrat_user");
            response.sendRedirect("/TimeTracking/HomeAdmin.jsp");
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
        <div class="title">
        <h1> Log In  </h1>
        </div>
        
        <form method="POST" action="/TimeTracking/LoginAdmin.jsp">
           
              <div class="row">
              <label> User </label>
                <input type="text" required  name="user">
             </div>
             <div class="row">
                <label> Parola </label>
                <input type="password" required name="pass">
             </div>
              <input type="submit" class="send" value="Apasa-ma">

        
        </form>
        <%= mesaj_eroare  %>
        
        
        <style>
            
            body{
                
               background-image:url('3.jpg');
            background-size:1600px 1000px; 
            
            }
                
            
          form{
               width: max-content;
                margin: 0 auto;
                padding: 60px;
               // background:#4ba4d1;
                margin-top:5%;
                border: groove;
                border-top-left-radius: 40px 40px;
                 border-top-right-radius: 40px 40px;
                  border-bottom-left-radius: 40px 40px;
                  border-bottom-right-radius: 40px 40px;
                  border-color:#f7efcd; 
            }
            
            form input, form label{
                display: block;
                margin:auto;
                border:1px sold black;
                
            }
            
            form input{
                padding:10px;
                
            }
            
        .send{
                border:1px solid black;
                background:  #ffe5cc;
                margin-top:10px;
                transition: 0.2s linear;
            }
            
            .send:hover{
                background:#ff7b00;
                color:white;
                cursor:pointer;
                transform:scale(1.1);
            }
            .row{
                padding:10px;
                font-size: 20px;
                
            
            }
            .title{
                
               text-align: center;
               margin-top:5%;
                //padding: 60px;
            }
            
            
            
            
        </style>
        
        
    </body>
</html>
