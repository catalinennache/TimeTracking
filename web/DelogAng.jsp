<%-- 
    Document   : DelogAng
    Created on : May 14, 2020, 4:47:29 PM
    Author     : Ana Dima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    request.getSession().removeAttribute("user");
    request.getSession().removeAttribute("user");
      response.sendRedirect("/TimeTracking/LoginAngajat.jsp");
%>