<%@page import="net.soc.Profile"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<jsp:useBean id="profileBean" class="net.soc.ProfileBean" scope="application"/>
<% //определяем, какой профайл открыт и загружаем его
    Profile p = null;
    if(auth) {
        if (request.getParameter("p") == null || request.getParameter("p") == session.getAttribute("id")) {
            p = profileBean.load(Integer.parseInt(session.getAttribute("id").toString()));
        } else {
            p = profileBean.load(Integer.parseInt(request.getParameter("p").toString()));
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to the SocNet!</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <div class="container">
            <div class="row">
                <div class="col-md-12">
        
                    <% if (auth) { /* если пользователь залогинен */
                        if (p != null) { %>
                            <% if (session.getAttribute("reg_success") != null) { %>
                                <div class="alert alert-success col-md-offset-3 col-md-7 alert-dismissible fade in">
                                    <span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>Congrads!</strong> Registration complete.
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                                </div>
                                <div style="clear:both;"></div>
                            <% session.removeAttribute("reg_success"); } %>
                            <% if (session.getAttribute("login_success") != null) { %>
                                <div class="alert alert-success col-md-offset-3 col-md-7 alert-dismissible fade in">
                                    <span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>You've completely logged in.</strong>
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                                </div>
                                <div style="clear:both;"></div>
                            <% session.removeAttribute("login_success"); } %>
                            <% if (session.getAttribute("edit_profile_success") != null) { %>
                                <div class="alert alert-success col-md-offset-3 col-md-7 alert-dismissible fade in">
                                    <span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>Profile was successfully saved.</strong>
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                                </div>
                                <div style="clear:both;"></div>
                            <% session.removeAttribute("edit_profile_success"); } %>
                            <% if (session.getAttribute("password_changed_success") != null) { %>
                                <div class="alert alert-success col-md-offset-3 col-md-7 alert-dismissible fade in">
                                    <span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>Password was successfully changed.</strong>
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                                </div>
                                <div style="clear:both;"></div>
                            <% session.removeAttribute("password_changed_success"); } %>
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                        <h3 class="panel-title text-center">
                                            <span class="lead"><span class="glyphicon glyphicon-user"></span> <%= p.getName() %></span>	
                                            <a class="btn btn-default pull-right button_delete_avatar" href="edit_profile.jsp">Edit profile</a>	
                                        </h3>
                                </div>
                                <div class="panel-body">
                                        <div class="row">
                                                <div class="col-md-4 col-md-offset-1">
                                                        <img class="profile_user_avatar" src="pic/photos/<%= p.getPhoto() %>">
                                                </div>
                                                <div class="col-md-5">
                                                        <table class="profile_user_info_table">
                                                                <tr><td class="profile_table_td">
                                                                        <span class="glyphicon glyphicon-gift"></span>
                                                                        <b><%=p.getBirthday() %></b>										
                                                                </td></tr>
                                                                <tr class="profile_table_tr"><td class="profile_table_td">
                                                                        <span class="glyphicon glyphicon-map-marker"></span>
                                                                        <b><%= p.getLocation() %></b>										
                                                                </td></tr>
                                                        </table>
                                                        <div class="panel panel-default">
                                                                <div class="panel-heading">
                                                                        <h3 class="panel-title">
                                                                                About
                                                                        </h3>
                                                                </div>
                                                                <div class="panel-body">
                                                                    <%= p.getAbout() %>
                                                                </div>
                                                        </div>
                                                </div>
                                        </div>
                                        <hr>
                                        <% /* =======================     тут заготовка интерфейса      ====================== */ %>
                                        <div class="add_post_button">
                                            <button class="btn btn-primary btn-lg add_comment_button_js">
                                            <span class="glyphicon glyphicon-comment"></span> 
                                            Add post
                                            </button>
                                        </div>
                                        <div>
                                            <div class="post-field">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <form accept-charset="UTF-8" action="components/add_post.jsp" method="POST">
                                                            <textarea class="form-control animated post_textarea" name="text" placeholder="Your text here..." rows="5"></textarea>
                                                            <input type="hidden" name="uid" value="16"><%/* здесь id пользователя, на чьей странице пост */%>
                                                            <div class="text-right">
                                                                <button class="btn btn-success btn-lg post_button" type="submit"><span class="glyphicon glyphicon-send"></span> Post it</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-md-12 col-md-offset-0">
                                                <div class="panel panel-info">
                                                    <div class="panel-body">
                                                            <div class="post_img pull-left">
                                                                <a href="index.jsp?p=16"><img class="post_user_avatar" src="pic/photos/def.jpg"></a>
                                                            </div>
                                                            <div class="post_body">
                                                                    <div>
                                                                        <div class="pull-left">
                                                                            <span class="glyphicon glyphicon-user"></span>
                                                                            <a href="index.jsp?p=16">Имя Фамилия</a>
                                                                        </div>
                                                                        <div class="pull-right">
                                                                            <span class="glyphicon glyphicon-time"></span> 01:22 &#x2015; 28.03.2015 
                                                                        </div>
                                                                    </div>
                                                                    <div style="clear: right;"></div>
                                                                    <div class="well well-sm post_well">
                                                                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula ultricies a non tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut gravida lorem. Ut turpis felis, pulvinar a semper sed, adipiscing id dolor. Pellentesque auctor nisi id magna consequat sagittis. Curabitur dapibus enim sit amet elit pharetra tincidunt feugiat nisl imperdiet. Ut convallis libero in urna ultrices accumsan. Donec sed odio eros. Donec viverra mi quis quam pulvinar at malesuada arcu rhoncus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In rutrum accumsan ultricies. Mauris vitae nisi at sem facilisis semper ac in est.							
                                                                    </div>
                                                                    <div class="pull-left">
                                                                        <a class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span> Delete</a>
                                                                    </div>
                                                                    <div class="pull-right">
                                                                        <a class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-share-alt"></span> Reply</a>
                                                                    </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 col-md-offset-0">
                                                <div class="panel panel-info">
                                                    <div class="panel-body">
                                                            <div class="post_img pull-left">
                                                                <a href="index.jsp?p=16"><img class="post_user_avatar" src="pic/photos/def.jpg"></a>
                                                            </div>
                                                            <div class="post_body">
                                                                    <div>
                                                                        <div class="pull-left">
                                                                            <span class="glyphicon glyphicon-user"></span>
                                                                            <a href="index.jsp?p=16">Другое Имя</a>
                                                                        </div>
                                                                        <div class="pull-right">
                                                                            <span class="glyphicon glyphicon-time"></span> 15:08 &#x2015; 06.02.2014 
                                                                        </div>
                                                                    </div>
                                                                    <div style="clear: right;"></div>
                                                                    <div class="well well-sm post_well">
                                                                            Vivamus fermentum semper porta. Nunc diam velit, adipiscing ut tristique vitae, sagittis vel odio. Maecenas convallis ullamcorper ultricies. Curabitur ornare, ligula semper consectetur sagittis, nisi diam iaculis velit, id fringilla sem nunc vel mi. Nam dictum, odio nec pretium volutpat, arcu ante placerat erat, non tristique elit urna et turpis. Quisque mi metus, ornare sit amet fermentum et, tincidunt et orci. Fusce eget orci a orci congue vestibulum. Ut dolor diam, elementum et vestibulum eu, porttitor vel elit. Curabitur venenatis pulvinar tellus gravida ornare. Sed et erat faucibus nunc euismod ultricies ut id justo. Nullam cursus suscipit nisi, et ultrices justo sodales nec. Fusce venenatis facilisis lectus ac semper. Aliquam at massa ipsum. Quisque bibendum purus convallis nulla ultrices ultricies. Nullam aliquam, mi eu aliquam tincidunt, purus velit laoreet tortor, viverra pretium nisi quam vitae mi. Fusce vel volutpat elit. Nam sagittis nisi dui.																
                                                                    </div>
                                                                    <div class="pull-left">
                                                                        <a class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span> Delete</a>
                                                                    </div>
                                                                    <div class="pull-right">
                                                                        <a class="btn btn-primary btn-xs add_comment_button_js"><span class="glyphicon glyphicon-share-alt"></span> Reply</a>
                                                                    </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
													                                 
                                </div>
                            </div>
            <% } else { %>
                 <div class="panel panel-info">
                    <div class="panel-heading">
                            <h3 class="panel-title text-center">
                                    <span class="lead"><span class="glyphicon glyphicon-user"></span> Unknown</span>		
                            </h3>
                    </div>
                    <div class="panel-body">
                            <div class="row">
                                    <div class="col-md-4 col-md-offset-1">
                                        <img class="profile_user_avatar" src="pic/photos/def.jpg">
                                    </div>
                                    <div class="col-md-5">
                                        <h3>Such user doesn't exist!</h3>
                                    </div>
                            </div>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <div class="jumbotron">
                <h1>Welcome!</h1>
                <hr>
                <p class="lead">SocNet - it is a social network, which absolutely does not differ from others!<br>Only chatting and posting available.</p>
                <br>
                <div class="btn-group col-md-8 col-md-offset-2" role="group" aria-label="...">
                    <a class="btn btn-lg btn-primary col-md-4" href="login.jsp" role="button">Log in...</a>
                    <a class="btn btn-lg btn-success col-md-8" href="reg.jsp" role="button">Or sign up today!</a>
                </div>
                <br>
            </div>
        <% } %>
                </div>
            </div>
        </div> 
        
        
    </body>
</html>
