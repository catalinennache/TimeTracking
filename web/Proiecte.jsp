<%-- 
    Document   : Angajati
    Created on : May 14, 2020, 5:50:15 PM
    Author     : Ana Dima
--%>

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

    ArrayList<Proiect> angajati_companie = DBLinker.getProiects(companie.id_companie);

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    </head>
    <body>
        <h1 style="text-align: center;font-size:45px;color: cyan;margin-top: 2%;">Proiectele Companiei</h1>

        <table>
            <thead>
            <th style="text-align: center;font-size:30px; color: crimson;"> Id Proiect </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Data Creare </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Nume </th>
            <th style="text-align: center;font-size:30px; color: crimson;"> Control </th>
        </thead>

        <tbody>
            <% for (int i = 0; i < angajati_companie.size(); i++) {%> 
            <tr class="<%= i == angajati_companie.size() - 1 ? "last" : ""%>">
                <td style="text-align: center;" >
                    <a href="/TimeTracking/Proiect.jsp?id=<%=angajati_companie.get(i).cod_proiect%>"> <%=angajati_companie.get(i).cod_proiect%> </a>
                </td>
                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).data_creare%>
                </td>

                <td style="text-align: center;" >
                    <%= angajati_companie.get(i).nume%>
                </td>
                <td style="text-align: center;">
                  
                    <span ref="<%=angajati_companie.get(i).cod_proiect%>" class="open-add-modal">
                        Adauga Angajat
                    </span>
                    |
                    <span>
                        Sterge Proiect
                    </span>

                </td>


            </tr>
            <% }%>



        </tbody>
    </table>

    <div class="modal-wrapper hidden">
        <div class="modal ">
            <div class="row">
                <label for="tp"> Proiect </label>
                <input type="text" id="tp" name="tp" readonly value="test" class="target_proj">
            </div>
            <div class="row">
                <label> Angajat </label>
                <select id="sel_angajat">
                    <option value="-1">Selectati angajatul</option>
                    <%
                            ArrayList<Angajat> angajati = DBLinker.getAngajati(companie.id_companie);

                            for (int i = 0; i < angajati.size(); i++) {%>
                    <option value="<%=angajati.get(i).id_angajat%>"> <%=  angajati.get(i).email%> </option>
                    <% }%>
                </select>
            </div>

            <div class="row">
                <button class="add">Adauga</button>
                <button class="cancel">Anuleaza</button>
            </div>
        </div>
    </div>
                <script>
                    function ascundeModal(){
                        $('.modal-wrapper').addClass('hidden');
                    }
                    
                    function arataModal(proiect){
                        $('#tp').val(proiect);
                       $('.modal-wrapper').removeClass("hidden")
                    }
                    
                    $('.open-add-modal').on('click',function(eveniment){
                        var proiect = $(this).attr("ref");
                        arataModal(proiect);
                    })
                    
                    $('.cancel').on('click',function(ev){
                           ascundeModal();
                    })
                    
                    $(".add").on('click',function(ev){
                        
                        var proiect = $('#tp').val();
                        var angajat = $('#sel_angajat').val();
                        var date = {};
                        
                        date.proiect = proiect;
                        date.angajat = angajat;
                        
                        $.ajax({ // API -> access point integration
                            url:"/TimeTracking/addAP",
                            type:"POST",
                            data:date,
                            success:function(raspuns){  
                                console.log(raspuns);
                               var raspuns_procesa = JSON.parse(raspuns);
                                if(raspuns_procesa.scs){
                                    ascundeModal();
                                }else{
                                    alert("A aparut o eroare :(");
                                }
                            },
                            error:function(erroare){
                                
                            }
                        })                     
                    })
                  </script>

    <style>
        
        .hidden{display:none;}
        .modal-wrapper{
            top:0;
            left:0;
            width:100%;
            height:100%;
            position:fixed;

            background: rgba(0,0,0,0.5);
        }
        .modal{
            background:white;
            margin:0 auto;
            margin-top:15%;
            height:300px;
            width:300px;
            padding:30px;
        }
        .row{
            display:block;
            margin:0 auto;
            margin-bottom:20px;

        }
        .row *{
            display:block;
        }
        button{
            margin-top:170px;
        }
        button:first-child{
            float:left;
        }
        button:nth-child(2){
            float:right;
        }
        
    </style>
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
            padding:0px 20px;
        }

        tbody td{
            border-left:1px dashed black;
            border-right:1px dashed black;
            padding:10px;
        }
        .last td{
            border-bottom:1px dashed black;
        }

        a,span{

            text-decoration: none;
            color:white;
        }
        a:hover,span:hover{
            color:red;
            cursor:pointer;
        }
    </style>
</body>
</html>
