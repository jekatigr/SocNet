<jsp:useBean id="formHandler" class="net.soc.SendMessageBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<%@include file="../WEB-INF/blocks/auth.jspf" %>
<%
if (auth) {
    if (formHandler.getMessage() != null && !formHandler.getMessage().equals("")) {
        formHandler.setUserID(Integer.parseInt(session.getAttribute("id").toString()));
        response.getWriter().write(formHandler.sendMessage());
    } else {
        response.getWriter().write("{\"ok\": \"false\", \"error\":\"message is empty\"}");
    }
    response.getWriter().flush();
    response.getWriter().close();
}
%>


