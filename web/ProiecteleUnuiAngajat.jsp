<%-- 
    Document   : Angajati
    Created on : May 14, 2020, 5:50:15 PM
    Author     : Ana Dima
--%>

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
    if (current_session.getAttribute("user") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }

    //Companie companie = (Companie) current_session.getAttribute("user_admin");
    Angajat angajat = (Angajat) current_session.getAttribute("user");
    ArrayList<AngajatProiect> angajati_companie = DBLinker.getAngajatProiecte(angajat.id_angajat);

%>


<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
    <h1 style="text-align:center;color:purple;">Proiectele Mele</h1>

    <table>
        <thead>
        <th style="text-align: center;font-size:30px; color: indigo;"> Id Proiect </th>
        <th style="text-align: center;font-size:30px; color: indigo;"> Data In </th>
        <th style="text-align: center;font-size:30px; color: indigo;"> Data Out </th>
        <th style="text-align: center;font-size:30px; color: indigo;">  Ore Lucrate </th>
        <th style="text-align: center;font-size:30px; color: indigo;">  Munceste </th>

    </thead>





    <tbody>
        <% for (int i = 0; i < angajati_companie.size(); i++) {
        
        boolean toate_sesiunile_terminate = false; //din cadrul proiectului
        boolean nicio_sesiune = false; //din cadrul proiectului
        int sesiuni = DBLinker.numaraSesiuni(angajati_companie.get(i).id_ap);
        nicio_sesiune = ( sesiuni == 0);
        
        toate_sesiunile_terminate = (sesiuni == DBLinker.numaraSesiuniTerminate(angajati_companie.get(i).id_ap));
        
        
        %>
        <tr class="<%= i == angajati_companie.size() - 1 ? "last" : ""%>">
            <td style="text-align: center;" >
                <%= angajati_companie.get(i).cod_proiect%>
            </td>
            <td style="text-align: center;" >
                <%= angajati_companie.get(i).data_in%>
            </td>

            <td style="text-align: center;" >
                <%= angajati_companie.get(i).data_out%>
            </td>
            <td style="text-align: center;" >
                <%= angajati_companie.get(i).ore_lucrate%>
                <!--suma dupa orele lucrate in sesiunile acestui proiect-->
            </td>
            <td style="text-align: center;">
                <% if (nicio_sesiune || toate_sesiunile_terminate ) { %>
                    <a  id_ap="<%= angajati_companie.get(i).id_ap%>"  class="blocks start control btn"> Start </a>
          
                <%} else {%>
                  
                    <a  id_ap="<%= angajati_companie.get(i).id_ap%>"  class="blocks stop control btn"> Stop </a>
                <%}%>
            </td>



        </tr>
        <% }%>



    </tbody>
</table>
        <script>
            $('.control').on('click',function(ev){
                var id_ap  = $(ev.target).attr("id_ap");
                var is_start = $(ev.target).hasClass("start");
                var payload = {id_ap:id_ap,is_start: is_start};
                if(!is_start){
                    var comentariu = prompt("Introduceti o descriere a muncii depuse :)");
                    payload.descriere = comentariu;
                }
               
                $.ajax({
                    url:"/TimeTracking/StartStop",
                    type:"POST",
                    data:payload,
                    success:function(data){
                        window.location.reload();
                    },
                    error:function(err){
                        
                    }
                })
            });
        </script>
<style>
    .btn:hover{
        color:red;
    }
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
    th{
        padding:0 20px;
    }

</style>


</body>
</html>
