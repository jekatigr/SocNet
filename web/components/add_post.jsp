<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="jdk.nashorn.internal.runtime.Version"%>
<jsp:useBean id="formHandler" class="net.soc.PostDownloadBean" scope="request">    
<jsp:setProperty name="formHandler" property="*"/>
</jsp:useBean>
<jsp:useBean id="profile" class="net.soc.Profile" scope="request">    
<jsp:setProperty name="profile" property="*"/>
</jsp:useBean>

<%@include file="../WEB-INF/blocks/auth.jspf" %>

<%
if (auth) {
//    Logger lgr = Logger.getLogger(Version.class.getName());
//    lgr.log(Level.ALL, "?????, ?? id");
//    formHandler.setId((Integer)session.getAttribute("id"));
//    lgr.log(Level.ALL, "in addpost.jsp id");
//    formHandler.setText(session.getAttribute("text").toString());
//    lgr.log(Level.ALL, "in addpost.jsp id");
//    System.out.println("in addpost.jsp text");
//    formHandler.setUser_id((Integer)session.getAttribute("user_id"));
//    System.out.println("in addpost.jsp user_id");
//    formHandler.setDate((Timestamp)session.getAttribute("date"));
//    System.out.println("in addpost.jsp date");
//    formHandler.savePost();
   // session.setAttribute(name, value);
    formHandler.savePost();
    List<Object> posts = formHandler.getAllPosts();
    for (Object o : posts) {
        if (o instanceof Integer)
           profile.setId_poster((Integer)o);
        if (o instanceof Timestamp)
            profile.setTime((Timestamp)o);
        if (o instanceof String)
            profile.setPost((String)o);    
    }
    
    response.sendRedirect("../index.jsp");
}
%>


