<%
    session.removeAttribute("id");
    session.removeAttribute("hash");
    response.sendRedirect("index.jsp");
%>