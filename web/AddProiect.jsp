<%-- 
    Document   : AddProiect
    Created on : May 14, 2020, 8:03:04 PM
    Author     : Ana Dima
--%>


<%@page import="core.DBLinker"%>
<%@page import="core.Proiect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
     HttpSession current_session = request.getSession();
    /*if(current_session.getAttribute("user_admin") != null){
           response.sendRedirect("/TimeTracking/AddProiect.jsp");
    }else{
         System.out.println("Niciun user momentan logat");
    }*/
    
    String metoda_de_obtinere_a_paginii = request.getMethod();
    int id_companie_gasita = -1;
    String mesaj_eroare = " nu merge";
    
    
    if(metoda_de_obtinere_a_paginii.equals("POST"))
    { String cod_proiect = request.getParameter("cod_proiect");
        String nume = request.getParameter("nume");
       // long data = request.getParameter("data");
        
        String date=request.getParameter("data");
       
         Proiect proiect = new Proiect(cod_proiect,nume,date);
            boolean scs =  DBLinker.addProiect(proiect);
	
   
    
  
      
       if(scs){
           response.sendRedirect("/TimeTracking/AddProiect.jsp");
       }else{
           mesaj_eroare = "A aparut o eroare la adaugare";
       
       }
    } 

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creaza un Proiect</title>
    </head>
    <body>


        <form method="POST" action="/TimeTracking/AddProiect.jsp">
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
         <style>

            body{
                // background-color:darkgrey ;
                //background-image:url('4.png') ;
                background-image:url(11.jpg) ;
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
                background:#6600cc;
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
