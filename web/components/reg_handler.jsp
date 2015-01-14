<jsp:useBean id="formHandler" class="net.soc.RegFormBean" scope="request">
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%
if (formHandler.validate()) {
    if (formHandler.createNewUser()) {
        session.setAttribute("reg_success", true);
        response.sendRedirect("../index.jsp");
        session.setAttribute("id", formHandler.getId());
        session.setAttribute("hash", formHandler.getHash());
    } else {
        session.setAttribute("reg_error", true);
        response.sendRedirect("../reg.jsp");
    }
}  else {
    session.setAttribute("reg_form", formHandler);
    response.sendRedirect("../reg.jsp");
}
%>