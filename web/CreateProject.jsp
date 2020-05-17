

<%@page import="core.DBLinker"%>
<%@page import="core.Proiect"%>




<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creaza un Proiect</title>
    </head>
    <body>


        <form method="POST" action="/TimeTracking/CreateProject.jsp">
            <div class="row">
                <label> Cod Proiect </label>
                <input type="text" required name="cod_proiect">
            </div>
            <div class="row">
                <label> Nume </label>
                <input type="text" required name="nume">
            </div>
            <div class="row">
                <label> Data </label>
                <input type="date" required name="data">
            </div>
            
            <input type="submit" class="send" value="Register">
          
        </form>

