<%-- 
    Document   : GenInv
    Created on : May 10, 2020, 3:51:00 PM
    Author     : Enache
--%>

<%@page import="core.Companie"%>
<%@page import="core.DBLinker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% HttpSession current_session = request.getSession();
    if (current_session.getAttribute("user_admin") == null) {
        response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
    }
    
    Companie companie = (Companie) current_session.getAttribute("user_admin");

    
    String code = DBLinker.addInvitatie(false, companie.id_companie);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="text-align:center;">Generator invitatii</h1>
        
        <div class="grid">
            <input class="blocks" value="<%= code %>">
                
         
        </div>
        
         <style>
      .body{
          background:#f2f2f3;
      }
      
        
      .grid {
          width:50%;
          margin:0 auto;
            display: grid;
            grid-template-columns: repeat(1, 1fr);
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
    color:black;
    text-align: center;
  font-size: 18px;
}
 
      </style>


    </body>
</html>
