<%@page import="net.soc.Profile"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<% //определяем, какой профайл открыт и загружаем его
    Profile p = new Profile();
    boolean load = false;
    boolean myprofile = false;
    if(auth) {
        if (request.getParameter("p") == null || request.getParameter("p") == session.getAttribute("id")) {
            load = p.load(Integer.parseInt(session.getAttribute("id").toString()));
            myprofile = true;
        } else {
            load = p.load(Integer.parseInt(request.getParameter("p").toString()));
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to the SocNet!</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %>
        <script type="text/javascript" src="js/bootbox.min.js"></script>
    </head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <div class="container">
            <div class="row">
                <div class="col-md-12">
        
                    <% if (auth) { /* если пользователь залогинен */
                        if (load) { %>
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
                                            <% if (myprofile) { %>
                                                <a class="btn btn-default pull-right button_delete_avatar" href="edit_profile.jsp">Edit profile</a>	
                                            <% } %>
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
                                        <a name="add_post_form"></a>
                                        <div>
                                            <div class="post-field">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <form accept-charset="UTF-8" action="components/add_post.jsp" method="POST">
                                                            <textarea class="form-control animated post_textarea" name="text" placeholder="Your text here..." rows="5"></textarea>
                                                            <input type="hidden" name="receiverId" value="<%= p.getId() %>">
                                                            
                                                            <div class="text-right">
                                                                <button class="btn btn-success btn-lg post_button" type="submit"><span class="glyphicon glyphicon-send"></span> Post it</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <a name="posts"></a>
                                        <% for (int i = 0; i < p.getPosts().size(); i++) { %>
                                        <div class="post-<%= p.getPosts().get(i).getId() %>">
                                            <hr>
                                            <div class="row">
                                                <div class="col-md-10 col-md-offset-1">
                                                    <div class="panel panel-info">
                                                        <div class="panel-body">
                                                               
                                                                <div class="post_img pull-left">
                                                                    <a href="index.jsp?p=<%= p.getPosts().get(i).getAuthorId() %>">
                                                                        <img class="post_user_avatar" src="pic/photos/<%= p.getPosts().get(i).getAuthorPhoto() %>">
                                                                    </a>
                                                                </div>
                                                                <div class="post_body">
                                                                        <div>
                                                                            <div class="pull-left">
                                                                                <a href="index.jsp?p=<%= p.getPosts().get(i).getAuthorId() %>">
                                                                                    <span class="glyphicon glyphicon-user">  <%= p.getPosts().get(i).getAuthorName() %></span>
                                                                                </a>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <span class="glyphicon glyphicon-time"> <%= p.getPosts().get(i).getDate() %> </span>
                                                                            </div>
                                                                        </div>
                                                                        <div style="clear: right;"></div>
                                                                        <div class="well well-sm post_well">
                                                                            <%= p.getPosts().get(i).getText() %>							
                                                                        </div>
                                                                        <% if (p.getPosts().get(i).getAuthorId() == Integer.parseInt(session.getAttribute("id").toString())) { %>
                                                                            <div class="pull-right">
                                                                                <a class="btn btn-danger btn-xs button_delete_post" data-id="<%= p.getPosts().get(i).getId() %>"><span class="glyphicon glyphicon-trash"></span> Delete</a>
                                                                            </div>
                                                                        <% } else { %>
                                                                            <div class="pull-right">
                                                                                <a class="btn btn-primary btn-xs" href="index.jsp?p=<%= p.getPosts().get(i).getAuthorId() %>#add_post_form"><span class="glyphicon glyphicon-share-alt"></span> Reply</a>
                                                                            </div>
                                                                        <% } %>
                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                        
                                        <% }
                                        %>
                                     </div>
                                    </div>
                                </div>
                            </div>
            <% } else { /* пользователя не существует */ %>
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
        <% } else { /* пользователь не залогинен */ %>
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
                
    <script type="text/javascript">
	$(document).ready(function(){
		$(".button_delete_post").click(function(){
                    var post_id = $(this).data("id");
			bootbox.dialog({
				message: "Are you sure?",
				title: "Removing post...",
				onEscape: function() {},
				show: true,
				backdrop: true,
				closeButton: true,
				animate: true,
				className: "confirm-delete-post-modal",
				buttons: {
					"Cancel": function() {},
					"Remove": {
						className: "btn-danger",
						callback: function() {
                                                        $.post( "PostDeleteServlet", { post_id: post_id})
                                                        .done(function() {
                                                            $("div.post-"+post_id).fadeOut("fast");
                                                        });
						}
					},
				}
				});
		});
	});
    </script> 
    </body>
</html>
