<jsp:useBean id="formHandler" class="net.soc.EditProfileBean" scope="request">
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%@include file="../WEB-INF/blocks/auth.jspf" %>

<%
if (auth) {
    formHandler.setId(Integer.parseInt(session.getAttribute("id").toString()));
    if (formHandler.saveProfile()) {
        session.setAttribute("edit_profile_success", true);
        response.sendRedirect("../index.jsp");
    }  else {
        session.setAttribute("edit_profile_error", true);
        response.sendRedirect("../edit_profile.jsp");
    }
} else {
    response.sendRedirect("../index.jsp");
}
%>