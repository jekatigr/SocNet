<jsp:useBean id="formHandler" class="net.soc.DeleteUserFromChatBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<%@include file="../WEB-INF/blocks/auth.jspf" %>
<%
if (auth) {
    if (formHandler.deleteUserFromChat(Integer.parseInt(session.getAttribute("id").toString()))) {
        response.getWriter().write("{\"ok\": \"true\"}");
    } else {
        response.getWriter().write("{\"ok\": \"false\"}");
    }
    response.getWriter().flush();
    response.getWriter().close();
}
%>


