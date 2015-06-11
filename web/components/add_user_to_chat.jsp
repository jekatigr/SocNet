<jsp:useBean id="formHandler" class="net.soc.AddUserToChatBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<%@include file="../WEB-INF/blocks/auth.jspf" %>
<%
if (auth) {
    if (formHandler.addUserToChat()) {
        response.getWriter().write("{\"ok\": \"true\"}");
    } else {
        response.getWriter().write("{\"ok\": \"false\"}");
    }
    response.getWriter().flush();
    response.getWriter().close();
}
%>


