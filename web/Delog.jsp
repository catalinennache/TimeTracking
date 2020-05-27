
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.getSession().removeAttribute("user_admin");
    request.getSession().removeAttribute("user");
      response.sendRedirect("/TimeTracking/LoginAdmin.jsp");
%>
