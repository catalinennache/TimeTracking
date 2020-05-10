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
        <h1>Te-ai logat ca angajat, bravo!</h1>
        <a href="/TimeTracking/Delog.jsp"> Delogheaza-ma! </a>
    </body>
</html>
