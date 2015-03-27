<jsp:useBean id="formHandler" class="net.soc.LoginFormBean" scope="request">
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%
if (formHandler.authenticate()) {
    session.setAttribute("id", formHandler.getId());
    session.setAttribute("login", formHandler.getLogin());
    session.setAttribute("hash", formHandler.getHash());
    session.setAttribute("login_success", true);
    response.sendRedirect("../index.jsp");
}  else {
    session.setAttribute("login_form", formHandler);
    response.sendRedirect("../login.jsp");
}
%>