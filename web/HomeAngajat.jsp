<%-- 
    Document   : HomeAdmin
    Created on : Apr 28, 2020, 4:21:00 PM
    Author     : Enache
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  HttpSession current_session = request.getSession(); 
    if(current_session.getAttribute("user") == null){
           response.sendRedirect("/TimeTracking/LoginAngajat.jsp");
    }
    
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
              <h1 style="text-align: center;color:purple;margin-bottom: 100px;">Time Tracking -- Angajat</h1>
         <div class="gridMaster">
    <div class="grid">
        
        
        <a href="ProiecteleUnuiAngajat.jsp" class="blocks"> Proiecte </a>
        <a href="Sesiuni.jsp" class="blocks"> Sesiuni </a>
        <a href="StartS.jsp" class="blocks"> Start </a>
    </div>
       
         <div class="grid2">
        <a href="/TimeTracking/DelogAng.jsp" class="block"> Delogheaza-ma! </a>
    </div>
                 </div>

        
 <style>
        body{
        // background:#f2f2f3;
        background-image:url('6.jpg');
        background-size:1600px 1100px; 
        // background-size: cover;
        background-attachment: fixed;
        }

        .blocks{
        background:#7B68EE;
        }
        .block{
        background:#7B68EE;
        }
        .grid {
      // width:100%;
        margin:0 auto;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: .5rem;
        padding: .5rem;
        grid-auto-rows: minmax(100px, auto);
        // background:white;
        //box-shadow:0px 10px 50px 0px black;
       // margin-top: 10%;
        }
        .grid2 {
       //width:100%;
        margin:0 auto;
        display: grid;
        grid-template-columns: repeat(1, 1fr);
       grid-gap: .5rem;
       padding: .5rem;
        grid-auto-rows: minmax(100px, auto);
        //  background:white;
        //box-shadow:0px 10px 50px 0px black;
        }
        
        .gridMaster{
             width:40%;
      // margin:0 auto;
    margin-left: 450px;
        margin-top: 120px;
    //  margin-right:  300px;
     //  display: grid;
         grid-gap: .5rem;
       padding: .7rem;
        //grid-auto-rows: minmax(100px, auto);
            box-shadow:0px 10px 50px 0px black;
            
        }
        .blocks{
        font-family: monospace;
        text-decoration: none;;
        user-select: none;
        cursor: pointer;
        margin:10px;
        transition:.2s ease-in-out;
        color:white;
        text-align: center;
        padding:50px;
        }
        .blocks:hover{
        transform:scale(1.1);
        }



        .block{
        font-family: monospace;
        text-decoration: none;;
        user-select: none;
        cursor: pointer;
        margin:10px;
        transition:.2s ease-in-out;
        color:white;
        text-align: center;
        padding:50px ;
        }
        .block:hover{
        transform:scale(1.1);
        }
    </style>




    </body>
</html>
