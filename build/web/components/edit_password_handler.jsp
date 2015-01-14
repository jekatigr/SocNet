<jsp:useBean id="formHandler" class="net.soc.EditPassBean" scope="request">
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%@include file="../WEB-INF/blocks/auth.jspf" %>

<%
if (auth) {
    formHandler.setId(Integer.parseInt(session.getAttribute("id").toString()));
    if (formHandler.savePass()) {
        session.setAttribute("password_changed_success", true);
        session.setAttribute("hash", formHandler.getHash());
        response.sendRedirect("../index.jsp");
    }  else {
        session.setAttribute("password_changed_error", formHandler.getError());
        response.sendRedirect("../edit_profile.jsp#auth");
    }
} else {
    response.sendRedirect("../index.jsp");
}
%>