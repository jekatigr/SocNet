<%@include file="WEB-INF/blocks/auth.jspf" %>
<%@page import="net.soc.LoginFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    LoginFormBean formHandler = (LoginFormBean)session.getAttribute("login_form");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log in</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %></head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <div class="container">
            <div class="row">
                    <div class="page-header">
                        <h1>Authentication</h1>
                    </div>
                    <% if (!auth) { %>
                        <div class="col-md-6 col-md-offset-3">
                            <div class="btn-group btn-group-justified">
                                <a class="btn btn-primary" href="login.jsp" role="button">Log in</a>
                                <a class="btn btn-default" href="reg.jsp" role="button">Sign up</a>
                            </div>
                        </div>

                        <div style="margin:50px;">&nbsp;</div>

                        <% if (formHandler != null) { %>
                            <div class="alert alert-danger alert-dismissible col-md-6 col-md-offset-3 fade in" role="alert">
                                <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>
                                <strong>Error!</strong> Incorrect login/password.
                            </div>
                        <% } %>
                        
                        <form class="form-horizontal" role="form" action="components/login_handler.jsp" method="POST">
                            <div class="form-group">
                                <label for="inputLogin" class="col-md-4 control-label">Login:</label>
                                <div class="col-md-5">
                                    <input type="text" class="form-control" id="inputLogin" placeholder="Enter login..." name="login" value="<% if (formHandler != null && formHandler.getLogin() != null) out.print(formHandler.getLogin()); %>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword" class="col-md-4 control-label">Password:</label>
                                <div class="col-md-5">
                                    <input type="password" class="form-control" id="inputPassword" placeholder="Enter password..." name="pass" value="<% if (formHandler != null && formHandler.getPass() != null) out.print(formHandler.getPass()); %>">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-5 col-md-3">
                                    <button type="submit" class="btn btn-success btn-lg btn-block"><span class="glyphicon glyphicon-log-in"></span> Enter</button>
                                </div>
                            </div>
                        </form>	
                    <% } else { %>
                        <div class="alert alert-info col-md-6 col-md-offset-3" role="alert">
                            <strong>You've already logged in.</strong>.
                        </div>
                    <% } %>
            </div>
        </div>
    </body>
</html>

<%
    session.removeAttribute("login_form");
%>