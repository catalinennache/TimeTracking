
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
        
        
       
       String data_minima_bruta = DBLinker.getMinDate(angajat.id_angajat);
       Date data_minima = new Date(data_minima_bruta);
       Date cap_saptamana = new Date();
       

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

                <input type="text" class="tag" readonly>

            </div> 

            <div class="row">
                <label>
                    Proiectul la care ai lucrat cel mai mult
                </label>

                <input type="text" class="tag" readonly value="<%= mx.cod_proiect%>">
            </div>

        </div>




        <script>
            $('.control').on('click', function (ev) {
                var id_ap = $(ev.target).attr("id_ap");
                var is_start = $(ev.target).hasClass("start");
                var payload = {id_ap: id_ap, is_start: is_start};
                if (!is_start) {
                    var comentariu = prompt("Introduceti o descriere a muncii depuse :)");
                    payload.descriere = comentariu;
                }

                $.ajax({
                    url: "/TimeTracking/StartStop",
                    type: "POST",
                    data: payload,
                    success: function (data) {
                        window.location.reload();
                    },
                    error: function (err) {

                    }
                })
            });
        </script>
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
