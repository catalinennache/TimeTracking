

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    request.getSession().removeAttribute("user");
    request.getSession().removeAttribute("user");
      response.sendRedirect("/TimeTracking/LoginAngajat.jsp");
%>