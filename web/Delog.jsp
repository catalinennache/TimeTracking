<%-- 
    Document   : Delog
    Created on : Apr 28, 2020, 5:30:20 PM
    Author     : Enache
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.getSession().removeAttribute("user_admin");
    request.getSession().removeAttribute("user");
      response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
%>
