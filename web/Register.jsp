<%-- 
    Document   : Register
    Created on : May 10, 2020, 4:51:00 PM
    Author     : Enache
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
       
        
         <form method="POST" action="/TimeTracking/Register.jsp">
             <div class="row">
                <label> Cod Invitatie </label>
                <input type="text" required name="invitatie">
             </div>
             <div class="row">
                <label> Nickname </label>
                <input type="text" required name="nickname">
             </div>
               <div class="row">
                <label> Email </label>
                <input type="email" required name="email">
             </div>
             <div class="row">
                <label> Parola </label>
                <input type="password" required name="pass">
             </div>
            <input type="submit" class="send" value="Register">
        </form>
        
        <style>
            
            body{
              background-color:darkgrey ;
            }
            form{
               width: max-content;
                margin: 0 auto;
                padding: 20px;
                background:white;
                margin-top:10%;
            }
            form input, form label{
                display: block;
                margin:0 auto;
                border:1px sold black;
                
            }
            
            form input{
                padding:5px;
                
            }
            
            .send{
                border:1px solid black;
                background: white;
                margin-top:10px;
                transition: 0.2s linear;
            }
            
            .send:hover{
                background: black;
                color:white;
                cursor:pointer;
            }
            .row{
                padding:10px;
            
            }
        </style>
    </body>
</html>
