<jsp:useBean id="formHandler" class="net.soc.CreateGroupChatBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<%@include file="../WEB-INF/blocks/auth.jspf" %>
<%
if (auth) {
    formHandler.setUserID(Integer.parseInt(session.getAttribute("id").toString()));
    response.getWriter().write(formHandler.createGroupChat());
    response.getWriter().flush();
    response.getWriter().close();
}
%>


