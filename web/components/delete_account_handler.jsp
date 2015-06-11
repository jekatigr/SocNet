<jsp:useBean id="formHandler" class="net.soc.DeleteAccountBean" scope="request">
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%@include file="../WEB-INF/blocks/auth.jspf" %>

<%
if (auth) {
    formHandler.setId(Integer.parseInt(session.getAttribute("id").toString()));
    formHandler.setLogin(session.getAttribute("login").toString());
    if (formHandler.deleteAccount()) {
        session.setAttribute("account_deletion_success", true);
        response.getWriter().write("{\"ok\": \"true\"}");
    }  else {
        response.getWriter().write("{\"ok\": \"false\"}");
        session.setAttribute("account_deletion_error", formHandler.getError());
    }
}
response.getWriter().flush();
response.getWriter().close();
%>