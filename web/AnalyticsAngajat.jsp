
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
        HttpSession current_session = request.getSession();
        if (current_session.getAttribute("user") == null) {
            System.out.println("Niciun user momentan logat");
            response.sendRedirect("/TimeTracking/LoginAngajat.jsp");
        } else {

        }
        
        
        
        Angajat angajat = (Angajat) current_session.getAttribute("user");
        ArrayList<AngajatProiect> ap = DBLinker.getAngajatProiecte(angajat.id_angajat);  
        double max = 0;
        AngajatProiect mx = null;
        for(int i =0; i<ap.size(); i++){
            
            AngajatProiect temp = ap.get(i);
            if(temp.ore_lucrate > max )
                   max = temp.ore_lucrate;
        }
        
    
        for(int i =0; i<ap.size(); i++){
            AngajatProiect temp = ap.get(i);
            if(temp.ore_lucrate == max )
                  mx = temp;
        }
        
        
       
       Date data_minima = DBLinker.getMinDate(angajat.id_angajat);
       //Date data_minima = new Date(data_minima_bruta);
       System.out.println(data_minima);
       
      Calendar c = Calendar.getInstance();
      c.setTime(new Date());
      c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
      Date cap_saptamana = c.getTime();
       c.add(Calendar.DATE, -7);
       Date coada_saptamana = c.getTime();
      double max_h = 0;
      Date cap_saptamana_max = cap_saptamana;
      Date coada_saptamana_max = coada_saptamana;
      double read_h= DBLinker.getHoursOnInterval(angajat.id_angajat,cap_saptamana,coada_saptamana);
      
        if(read_h>max_h){
            System.out.println("max updated "+max_h+" >> "+read_h);
            max_h = read_h;
            cap_saptamana_max = cap_saptamana;
            coada_saptamana_max = coada_saptamana;
        }
    
      
      while(read_h != 0){
        cap_saptamana = coada_saptamana;
        c.add(Calendar.DATE, -7);
        coada_saptamana = c.getTime();
        read_h= DBLinker.getHoursOnInterval(angajat.id_angajat,cap_saptamana,coada_saptamana);
        if(read_h>max_h){
            System.out.println("max updated "+max_h+" >> "+read_h);
            max_h = read_h;
            cap_saptamana_max = cap_saptamana;
            coada_saptamana_max = coada_saptamana;
        }
    
      }
      SimpleDateFormat sdf = 
     new SimpleDateFormat("yyyy-MM-dd");

String cap = sdf.format(cap_saptamana_max);
String coada = sdf.format(coada_saptamana_max);
    
      System.out.println(max_h);
       

    %>





    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    </head>
    <body>
        <h1 style="text-align:center;color:purple;">Analytics</h1>


        <div class="stage">
            <div class="row">
                <label>
                    Cea mai productiva saptamana
                </label>

                <input type="text" class="tag" readonly value = "<%= coada+" - "+ cap%>">

            </div> 

            <div class="row">
                <label>
                    Proiectul la care ai lucrat cel mai mult
                </label>

                <input type="text" class="tag" readonly value="<%= mx.cod_proiect%>">
            </div>

        </div>




  
        <style>
            label{
                float:left;
            }
            
            .stage{
                margin:0 auto;
                margin-top:15%;
            }
            .tag{
                float:right;
                cursor:default;
                transition:0.3s ease-in-out;
                margin-left:15px;
                border:none;
                text-align:center;

            }
            .tag:hover{
                transform:scale(1.2);
            }
            .row{
                width: 500px;
                 margin: 0 auto;
                padding:25px;
                padding-left:0;
                display:block;
            }
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
