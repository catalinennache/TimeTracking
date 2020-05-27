

<%@page import="core.DBLinker"%>
<%@page import="core.Invitatie"%>
<%@page import="core.Angajat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        String user = request.getParameter("nickname");
        String password = request.getParameter("pass");
        String email = request.getParameter("email");
        String invitatie = request.getParameter("invitatie");
       Invitatie inv =  DBLinker.getInvitatie(invitatie);
       if(!inv.folosita){
       Angajat ang = new Angajat(-1,invitatie,user,email,password);
      boolean scs =  DBLinker.addAngajat(ang, inv);
       
       if(scs){
           response.sendRedirect("/TimeTracking/LoginAngajat.jsp");
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
        <title>Register</title>
    </head>
    <body>


        <form method="POST" action="/TimeTracking/Register.jsp">
            <div class="row">
                <label> Cod Invitatie </label>
                <input type="text" required name="invitatie">
            </div>
            <div class="row">
                <label> Nickname </label>
                <input type="text" required name="nickname">
            </div>
            <div class="row">
                <label> Email </label>
                <input type="email" required name="email">
            </div>
            <div class="row">
                <label> Parola </label>
                <input type="password" required name="pass">
            </div>
            <input type="submit" class="send" value="Register">
            <span>  <%= mesaj_eroare %> </span>
        </form>

        <style>

            body{
                // background-color:darkgrey ;
                //background-image:url('4.png') ;
                background-image:url(backg.jpeg) ;
               background-size: cover;
                background-attachment: fixed;
            }
            form{
                width: max-content;
                margin: 0 auto;
                padding: 60px;
                //background:#4ba4d1;
                margin-top:10%;
                  margin-bottom: 10%;
               //  border: groove;
                 border-top-left-radius: 40px 40px;
                  border-top-right-radius: 40px 40px;
                   border-bottom-left-radius: 40px 40px;
                   border-bottom-right-radius: 40px 40px;
                   //border-color:#f7efcd;
                 border: thick double #32a1ce;
                
                
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
                background: #87CEEB;
                margin-top:10px;
                transition: 0.2s linear;
                padding:  20px;
            }

            .send:hover{
                background: blue;
                color:white;
                cursor:pointer;
            }
            .row{
                padding:10px;
                font-size: 20px;


            }
         </style>
    </body>
</html>
