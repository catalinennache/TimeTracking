
<%@page import="core.Invitatie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.DBLinker"%>
<%@page import="core.Companie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% HttpSession current_session = request.getSession();
    if (current_session.getAttribute("user_admin") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }

    Companie companie = (Companie) current_session.getAttribute("user_admin");

    ArrayList<Invitatie> invitatii_companie = DBLinker.getInvitatii(companie.id_companie);


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="text-align: center;">Invitatii Existente</h1>

        <table>
            <thead>
            <th> Cod Invitatie </th>
            <th> Folosita </th>
        </thead>

        <tbody>
            <% for (int i = 0; i < invitatii_companie.size(); i++) {%> 
            <tr class="<%= i==invitatii_companie.size()-1?"last":"" %>">
                <td>
                    <%= invitatii_companie.get(i).cod_invitatie%>
                </td>
                <td>
                    <%= invitatii_companie.get(i).folosita%>
                </td>
            </tr>
            <% }%>
        </tbody>
    </table>
        
        <style>
            table{
                margin:0 auto;
                margin-top:10px;
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
