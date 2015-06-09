<jsp:useBean id="formHandler" class="net.soc.PeopleFilterBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<%@include file="../WEB-INF/blocks/auth.jspf" %>
<%
    response.getWriter().write(formHandler.getFilteredPeople());
    response.getWriter().flush();
    response.getWriter().close();
%>