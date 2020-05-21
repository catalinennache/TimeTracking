<%-- 
    Document   : Sesiuni
    Created on : May 19, 2020, 11:38:45 AM
    Author     : Ana Dima
--%>
<%@page import="core.Sesiune"%>
<%@page import="core.AngajatProiect"%>
<%@page import="core.Proiect"%>
<%@page import="core.Angajat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.Invitatie"%>
<%@page import="core.DBLinker"%>
<%@page import="core.Companie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
   
     HttpSession current_session = request.getSession();
    /*if (current_session.getAttribute("user") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }*/

 Angajat angajat=(Angajat)current_session.getAttribute("user");
 //int ap=angajat.id_ap;
     ArrayList<Sesiune> angajat_sesiune = DBLinker.getSesiuniAngajat(angajat.id_angajat);
     ArrayList<AngajatProiect> angajat_sesiuni = DBLinker.getAngajatProiecte(angajat.id_angajat);

%>
<html>

<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="text-align:center;color:purple;">Sesiunile Mele</h1>
        
         <table>
            <thead>
            <th style="text-align: center;font-size:30px; color: indigo;  padding: 20px;"> Id Sesiune </th>
            <th style="text-align: center;font-size:30px; color: indigo;  padding: 20px;"> Cod Proiect</th>
            <th style="text-align: center;font-size:30px; color: indigo;  padding: 20px;"> Ora Inceput </th>
            <th style="text-align: center;font-size:30px; color: indigo;  padding: 20px;"> Ora Sfarsit</th>

        </thead>


        
        
        
        <tbody>
            <% for (int i = 0; i < angajat_sesiune.size(); i++) {%> 
            <tr class="<%= i == angajat_sesiune.size() - 1 ? "last" : ""%>">
                <td style="text-align: center;" >
                    <%= angajat_sesiune.get(i).id_sesiune%>
                </td>
                
                 <td style="text-align: center;" >
                    <%= angajat_sesiuni.get(i).cod_proiect%>
                  
                </td>
                <td style="text-align: center;" >
                    <%= angajat_sesiune.get(i).timestamp_inceput%>
                </td>

                <td style="text-align: center;" >
                    <%= angajat_sesiune.get(i).timestamp_sfarsit%>
                </td>
               
               


            </tr>
            <% }%>



        </tbody>
    </table>
        
         <style>
       body{
         // background:#f2f2f3;
          background-image:url('9.jpg');
          background-size:1600px 1100px; 
          // background-size: cover;
                background-attachment: fixed;
      }
      .grid {
          width:50%;
          margin-top: 16%;
          margin-left: 25%;
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            grid-gap: .5rem;
            padding: .5rem;
            grid-auto-rows: minmax(100px, auto);
           // background:white;
           box-shadow:0px 10px 50px -20px black;
           text-align:center;
}

            table{
                margin:0 auto;
                margin-top:10%;
                font-size:5;
            }
            
             th{
                border-bottom:1px dashed black;
            }
            
            tbody td{
                border-left:1px dashed black;
                border-right:1px dashed black;
                padding:10px;
            }
            .last td{
                border-bottom:1px dashed black;
            }
 .blocks{
     font-family: monospace;
     text-decoration: none;;
     user-select: none;
     cursor: pointer;
    margin:10px;
   // transition:.2s ease-in-out;
    color:black;
    text-align: center;
  font-size: 18px;
}
td{
    
  
}
 
      </style>


    </body>
</html>
