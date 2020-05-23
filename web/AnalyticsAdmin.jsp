
<%@page import="core.Companie"%>
<%@page import="java.util.HashMap"%>
<%@page import="core.AngajatProiect"%>
<%@page import="core.Angajat"%>
<%@page import="core.Proiect"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.DBLinker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
                

  ArrayList<Angajat> angajati_intarziati =  DBLinker.getLateUsers();
      System.out.println("ang int "+angajati_intarziati.size());
        
        
         HttpSession current_session = request.getSession();
  /*  if(current_session.getAttribute("user_admin") == null){
           System.out.println("Niciun user momentan logat");
           response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }else{
      
    }*/
    Companie cmp = (Companie)current_session.getAttribute("user_admin");
        
        ArrayList<Proiect> proiecte = DBLinker.getProiects(cmp.id_companie);
        ArrayList<Angajat> angajati = DBLinker.getAngajati(cmp.id_companie);
        ArrayList<AngajatProiect> ap = new ArrayList();
          for(int i =0;i<angajati.size();i++){
           Angajat angajat = angajati.get(i);
                try{  
               ap.addAll(DBLinker.getAngajatProiecte(angajat.id_angajat));
            }
            catch(Exception e){}
          }
       
        
        HashMap<Proiect,String> proiect_numar_ore = new HashMap();
        HashMap<Angajat,String> angajat_numar_ore = new HashMap();
        
        for(int i =0;i<proiecte.size();i++){
            Proiect proiect = proiecte.get(i);
            String rezultat =  DBLinker.getOreProiect(proiect.cod_proiect);
            proiect_numar_ore.put(proiect, rezultat);
        }
      
        for(int i =0;i<angajati.size();i++){
            Angajat angajat = angajati.get(i);
            String rezultat =  DBLinker.getOreAngajat(angajat.id_angajat);
            angajat_numar_ore.put(angajat, rezultat);
        }

   
        
  
        
    %>





<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
    <h1 style="text-align:center;color:purple;">Analytics</h1>

    <table>
        <thead>
        <th style="text-align: center;font-size:30px; color: indigo;"> Cod Proiect </th>
        <th style="text-align: center;font-size:30px; color: indigo;">  Ore Lucrate </th>
      

    </thead>





    <tbody>
        <% for (int i = 0; i < proiecte.size(); i++) {
        
     
        %>
        <tr class="<%= i == proiecte.size() - 1 ? "last" : ""%>">
            <td style="text-align: center;" >
                <%= proiecte.get(i).cod_proiect%>
            </td>
          
            <td style="text-align: center;" >
                <%= proiect_numar_ore.get(proiecte.get(i)) %>
                <!--suma dupa orele lucrate in toate sesiunile acestui proiect-->
            </td>
           


        </tr>
        <% }%>



    </tbody>
</table>
          <table>
        <thead>
        <th style="text-align: center;font-size:30px; color: indigo;"> Cod Proiect </th>
        <th style="text-align: center;font-size:30px; color: indigo;">  Ore Lucrate </th>
      

    </thead>





    <tbody>
        <% for (int i = 0; i < proiecte.size(); i++) {
        
     
        %>
        <tr class="<%= i == proiecte.size() - 1 ? "last" : ""%>">
            <td style="text-align: center;" >
                <%= proiecte.get(i).cod_proiect%>
            </td>
          
            <td style="text-align: center;" >
                <%= proiect_numar_ore.get(proiecte.get(i)) %>
                <!--suma dupa orele lucrate in toate sesiunile acestui proiect-->
            </td>
           


        </tr>
        <% }%>



    </tbody>
</table>
        
        
          <table>
        <thead>
        <th style="text-align: center;font-size:30px; color: indigo;">Proiect </th>
        <th style="text-align: center;font-size:30px; color: indigo;">Angajat </th>
        <th style="text-align: center;font-size:30px; color: indigo;">  Ore Lucrate </th>
      

    </thead>





    <tbody>
        <% for (int i = 0; i < ap.size(); i++) {
        
     
        %>
        <tr class="<%= i == ap.size() - 1 ? "last" : ""%>">
            <td style="text-align: center;">
                <%= ap.get(i).cod_proiect %>
            </td>
            <td style="text-align: center;" >
                <%= ap.get(i).id_angajat %>
            </td>
          
            <td style="text-align: center;" >
                <%= ap.get(i).ore_lucrate %>
                <!--suma dupa orele lucrate in toate sesiunile acestui proiect-->
            </td>
           


        </tr>
        <% }%>



    </tbody>
</table>
        
        </table>
        
        
          <table>
        <thead>
        <th style="text-align: center;font-size:30px; color: indigo;">Nickname </th>
        <th style="text-align: center;font-size:30px; color: indigo;">Email </th>
        <th style="text-align: center;font-size:30px; color: indigo;"> Controls </th>
      

    </thead>





    <tbody>
        <% for (int i = 0; i < angajati_intarziati.size(); i++) {
        
     
        %>
        <tr class="<%= i == angajati_intarziati.size() - 1 ? "last" : ""%>">
            <td style="text-align: center;">
                <%= angajati_intarziati.get(i).nickname %>
            </td>
            <td style="text-align: center;" >
                <%= angajati_intarziati.get(i).email %>
            </td>
          
            <td style="text-align: center;" >
                <span class="send-mail" ref="<%= angajati_intarziati.get(i).email %>"> Trimite Email </span>
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
            
            $('.send-mail').on('click',function(ev){
                
                var email = $(ev.target).attr("ref");
                
                $.ajax({
                    url:'/TimeTracking/SendEmail',
                    type:'POST',
                    data:{email:email},
                    success:function(data){
                    
                        if(data.indexOf("true")>=0)
                            alert("Email trimis!")
                        else
                            alert("A aparut o problema :/");
                    }
                })
                
            })
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

</html>
