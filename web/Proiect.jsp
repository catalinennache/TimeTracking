

<%@page import="core.AngajatProiect"%>
<%@page import="core.Proiect"%>
<%@page import="core.Angajat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.Invitatie"%>
<%@page import="core.DBLinker"%>
<%@page import="core.Companie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% HttpSession current_session = request.getSession();
    if (current_session.getAttribute("user_admin") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }

   Companie companie = (Companie) current_session.getAttribute("user_admin");
   String cod_proiect = request.getParameter("id");
   ArrayList<AngajatProiect> angajati_companie = DBLinker.getAngajatiProiect(cod_proiect);

 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="text-align: center;font-size:45px;color: cyan;margin-top: 2%;">Angajati per proiect</h1>

        <table>
            <thead>
            <th style="text-align: center;font-size:30px; color: crimson;"> Cod Proiect </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Id Angajat </th>
             <th style="text-align: center;font-size:30px; color: crimson;"> Nickname </th>
              <th style="text-align: center;font-size:30px; color: crimson;"> Mail </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Ore Lucrate </th>
           
         


        
        </thead>

        <tbody>
            <% for (int i = 0; i < angajati_companie.size(); i++) {
            
                 Angajat angajat = DBLinker.getAngajat(angajati_companie.get(i).id_angajat);
                 
            %> 
            <tr class="<%= i==angajati_companie.size()-1?"last":"" %>">
                 <td style="text-align: center;" >
                   <%=angajati_companie.get(i).cod_proiect %> 
                </td>
                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).id_angajat %>
                </td>
              
                <td style="text-align: center;" >
                             <%= angajat.nickname %>
                </td>
                <td  style="text-align: center;" >
                     <%= angajat.email %>
                </td>
                
                <td  style="text-align: center;" >
                    <%= angajati_companie.get(i).ore_lucrate%>
                </td>
         
                
            </tr>
            <% }%>
        </tbody>
    </table>
        
               
        <style>
            
            
             body{
         // background:#f2f2f3;
          background-image:url('10.jpg');
          background-size:1600px 1100px; 
          // background-size: cover;
                background-attachment: fixed;
      }
            table{
                margin:0 auto;
                margin-top:20%;
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
            
            a{
                
                text-decoration: none;
                color:white;
            }
            a:hover{
                color:red;
            }
        </style>
</body>
</html>
        