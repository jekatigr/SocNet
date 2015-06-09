<jsp:useBean id="formHandler" class="net.soc.AddPostBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>

<%@include file="../WEB-INF/blocks/auth.jspf" %>

<%
if (auth) {
    out.println(formHandler.getText());
    if (formHandler.getText() != null && !formHandler.getText().equals(""))
    formHandler.setAuthorId(Integer.parseInt(session.getAttribute("id").toString()));
    formHandler.savePost();
    
    //response.sendRedirect("../index.jsp?p=" + formHandler.getReceiverId() + "#posts");
}
%>


