
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
   
   
    ArrayList<Angajat> angajati_companie = DBLinker. getAngajati(companie.id_companie);
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="text-align: center;font-size:45px;color: cyan;margin-top: 2%;">Angajatii Companiei</h1>

        <table>
            <thead>
            <th style="text-align: center;font-size:30px; color: crimson;"> Id Angajat </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Id Invitatie </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Nickname </th>
             <th style="text-align: center;font-size:30px; color: crimson;"> Email </th>


        
        </thead>

        <tbody>
            <% for (int i = 0; i < angajati_companie.size(); i++) {%> 
            <tr class="<%= i==angajati_companie.size()-1?"last":"" %>">
                 <td style="text-align: center;" >
                    <%=angajati_companie.get(i).id_angajat %>
                </td>
                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).id_invitatie%>
                </td>
                 </td>
                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).nickname%>
                </td>
                 </td>
                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).email%>
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
        </style>
</body>
</html>
        