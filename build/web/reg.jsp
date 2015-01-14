<%@include file="WEB-INF/blocks/auth.jspf" %>
<%@page import="net.soc.RegFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    RegFormBean formHandler = (RegFormBean)session.getAttribute("reg_form");
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
                            <a class="btn btn-default" href="login.jsp" role="button">Log in</a>
                            <a class="btn btn-primary" href="reg.jsp" role="button">Sign up</a>
                        </div>
                    </div>

                    <div style="margin:50px;">&nbsp;</div>

                    <% if (session.getAttribute("reg_error") != null) { %>
                        <div class="alert alert-danger alert-dismissible col-md-6 col-md-offset-3 fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>
                            <strong>Internal error!</strong> Please, try again later.
                        </div>
                    <% }
                    session.removeAttribute("reg_error");
                    %>

                    <form class="form-horizontal" role="form" action="components/reg_handler.jsp" method="POST">
                        <!-- Login -->
                        <% if (formHandler != null && formHandler.getErrors() != null && !formHandler.getErrorMsg("login").equals("")) { %>
                        <!-- Были ошибки при регистрации -->
                            <div class="form-group has-error has-feedback">
                                <label for="inputLogin" class="col-md-4 control-label">Login:</label>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" id="inputLogin" placeholder="Enter login..." name="login" value="<% if (formHandler.getLogin() != null) out.print(formHandler.getLogin()); %>" title="for&nbsp;login&nbsp;to&nbsp;the&nbsp;site">                       
                                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                                </div>
                                <label for="inputLogin" class="control-label help-inline"><%= formHandler.getErrorMsg("login") %></label>
                            </div>
                        <% } else {%>
                        <!-- Ошибок не было-->
                            <div class="form-group">
                                <label for="inputLogin" class="col-md-4 control-label">Login:</label>
                                <div class="col-md-5">
                                        <input type="text" class="form-control" id="inputLogin" placeholder="Enter login..." name="login" value="<% if (formHandler != null && formHandler.getLogin() != null) out.print(formHandler.getLogin()); %>" title="for&nbsp;login&nbsp;to&nbsp;the&nbsp;site">                       
                                </div>
                            </div>
                        <% } %>

                        <!-- Pass -->
                        <% if (formHandler != null && formHandler.getErrors() != null && !formHandler.getErrorMsg("pass").equals("")) { %>
                        <!-- Были ошибки при регистрации -->
                            <div class="form-group has-error has-feedback">
                                <label for="inputPassword" class="col-md-4 control-label">Password:</label>
                                <div class="col-md-3">
                                    <input type="password" class="form-control" id="inputPassword" placeholder="Enter password..." name="pass" value="<% if (formHandler.getPass() != null) out.print(formHandler.getPass()); %>" title="more&nbsp;than&nbsp;6&nbsp;characters">
                                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                                </div>
                                <label for="inputPassword" class="control-label help-inline"><%= formHandler.getErrorMsg("pass") %></label>
                            </div>
                        <% } else {%>
                        <!-- Ошибок не было -->
                            <div class="form-group">
                                <label for="inputPassword" class="col-md-4 control-label">Password:</label>
                                <div class="col-md-5">
                                    <input type="password" class="form-control" id="inputPassword" placeholder="Enter password..." name="pass" value="<% if (formHandler != null && formHandler.getPass() != null) out.print(formHandler.getPass()); %>" title="more&nbsp;than&nbsp;6&nbsp;characters">
                                </div>
                            </div>
                        <% } %>

                        <!-- Pass2 -->
                        <% if (formHandler != null && formHandler.getErrors() != null && !formHandler.getErrorMsg("pass2").equals("")) { %>
                        <!-- Были ошибки при регистрации -->
                            <div class="form-group has-error has-feedback">
                                <label for="inputPassword2" class="col-md-4 control-label">Confirm:</label>
                                <div class="col-md-3">
                                    <input type="password" class="form-control" id="inputPassword2" placeholder="Confirm password..." name="pass2" value="<% if (formHandler.getPass2() != null) out.print(formHandler.getPass2()); %>">
                                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                                </div>
                                <label for="inputPassword2" class="control-label help-inline"><%= formHandler.getErrorMsg("pass2") %></label>
                            </div>                        
                        <% } else {%>
                        <!-- Ошибок не было -->
                            <div class="form-group">
                                <label for="inputPassword2" class="col-md-4 control-label">Confirm:</label>
                                <div class="col-md-5">
                                    <input type="password" class="form-control" id="inputPassword2" placeholder="Confirm password..." name="pass2" value="<% if (formHandler != null && formHandler.getPass2() != null) out.print(formHandler.getPass2()); %>">
                                </div>
                            </div>
                        <% } %>
                        <div class="form-group">
                            <div class="col-md-offset-5 col-md-3">
                                <button type="submit" class="btn btn-success btn-lg btn-block"><span class="glyphicon glyphicon-ok"></span> Sign up</button>
                            </div>
                        </div>
                    </form>	

                    <script type="text/javascript">
                    $(document).ready(function(){
                            $("#inputLogin").tooltip({placement:"right"});
                            $("#inputPassword").tooltip({placement:"right"});
                    });
                    </script>
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
    session.removeAttribute("reg_form");
%>