<%
    session.removeAttribute("id");
    session.removeAttribute("login");
    session.removeAttribute("hash");
    response.sendRedirect("index.jsp");
%>