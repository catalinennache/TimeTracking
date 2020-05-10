<%-- 
    Document   : HomeAdmin
    Created on : Apr 28, 2020, 4:21:00 PM
    Author     : Enache
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  HttpSession current_session = request.getSession();
    if (current_session.getAttribute("user_admin") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <h1 style="text-align: center; margin-bottom: 100px;">Time Tracking -- Admin</h1>
      


    <div class="grid">
        <a href="Invitatii.jsp" class="blocks"> Invitatii</a>
        <a href="GenInv.jsp" class="blocks"> Genereaza invitatie </a>
        <a href="Proiecte.jsp" class="blocks"> Proiecte </a>
        <a href="CreateProiesct.jsp" class="blocks"> Creaza Proiect </a>
        <a href="Angajati.jsp" class="blocks"> Angajati </a>
        <a href="Analytics.jsp" class="blocks"> Analytics </a>
       
        <a href="/TimeTracking/Delog.jsp" class="blocks"> Delogheaza-ma! </a>
    </div>
     
      <style>
      .body{
          background:#f2f2f3;
      }
      
          .blocks{
              background:#7B68EE;
          }
      .grid {
          width:50%;
          margin:0 auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: .5rem;
            padding: .5rem;
            grid-auto-rows: minmax(100px, auto);
            background:white;
            box-shadow:0px 10px 50px -20px black;
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
    padding:50px 0;
}
 .blocks:hover{
         transform:scale(1.1);
    }
      </style>


   
</body>
</html>