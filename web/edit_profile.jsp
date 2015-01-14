<%@page import="net.soc.Profile"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<jsp:useBean id="profileBean" class="net.soc.ProfileBean" scope="application"/>
<% //определяем, какой профайл открыт и загружаем его
    Profile p = null;
    if(auth) {
        p = profileBean.load(Integer.parseInt(session.getAttribute("id").toString()));        
    } 
    if (p == null) {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing profile - SocNet</title>
        <link rel="stylesheet" type="text/css" href="css/datepicker.css"/>
        <%@include file="WEB-INF/blocks/includes.jspf" %>
        <script type="text/javascript" src="js/bootbox.min.js"></script>
        <script type="text/javascript" src="js/datepicker.js"></script>
    </head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <% if (session.getAttribute("edit_profile_error") != null) { %>
                        <div class="alert alert-danger col-md-offset-3 col-md-7 alert-dismissible fade in">
                            <span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;&nbsp;<strong>Internal error!</strong> Please, try again.
                            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                        </div>
                        <div style="clear:both;"></div>
                    <% session.removeAttribute("edit_profile_error"); } %>
                    <% if (session.getAttribute("photo_upload_error") != null) { %>
                        <div class="alert alert-danger col-md-offset-3 col-md-7 alert-dismissible fade in">
                            <span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;&nbsp;<strong><%= session.getAttribute("photo_upload_error") %></strong>
                            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                        </div>
                        <div style="clear:both;"></div>
                    <% session.removeAttribute("photo_upload_error"); } %>
                    <% if (session.getAttribute("photo_upload_success") != null) { %>
                        <div class="alert alert-success col-md-offset-3 col-md-7 alert-dismissible fade in">
                            <span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>Success!</strong> New photo is uploaded.
                            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                        </div>
                        <div style="clear:both;"></div>
                    <% session.removeAttribute("photo_upload_success"); } %>
                    
                    
                    <div class="panel panel-info">
                        <div class="panel-heading">
                                <h3 class="panel-title text-center">
                                    <span class="lead"><span class="glyphicon glyphicon-edit"></span> Profile editing</span>	
                                </h3>
                        </div>
                        <div class="panel-body">
                                <div class="row">
                                        <div class="col-md-5 col-md-offset-1">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    Photo
                                                    <a class="btn btn-default btn-xs pull-right button_delete_photo">Remove</a>
                                                </div>
                                                <div class="panel-body text-center">
                                                    <form action="PhotoUploadServlet" method="POST" enctype="multipart/form-data">
                                                        <img class="edit_profile_user_photo profile_user_avatar" src="pic/photos/<%= p.getPhoto() %>">
                                                        <input class="btn btn-default input_photo_file" type="file" name="photo" title="JPEG, PNG, BMP or GIF">
                                                        <button class="btn btn-primary col-md-4 col-md-offset-4" type="submit">Upload</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <form action="components/edit_profile_handler.jsp" method="POST">
                                                <div class="form-group">
                                                        <label for="inputFn">First name:</label>
                                                        <input type="text" class="form-control" id="inputFn" placeholder="Enter your first name..." name="first_name" value="<%= p.getFirst_name() %>">
                                                </div>
                                                <div class="form-group">
                                                        <label for="inputLn">Last name:</label>
                                                        <input type="text" class="form-control" id="inputLn" placeholder="Enter your last name..." name="last_name" value="<%= p.getLast_name() %>">
                                                </div>
                                                <div class="form-group col-md-6">
                                                        <label for="inputBirthday">Birthday:</label>
                                                        <input type="text" class="form-control" id="inputBirthday" placeholder="Enter your birthday..." name="birthday" value="<%= p.getBirthday() %>">
                                                </div>
                                                <div class="form-group col-md-6">
                                                        <label for="inputSex">Sex:</label>
                                                        <select class="form-control" id="inputSex" name="sex">
                                                            <option<% if(p.getSex() == true) { out.print(" selected"); } %> value="1">Male</option>
                                                            <option<% if(p.getSex() == false) { out.print(" selected"); } %> value="0">Female</option>
                                                        </select>
                                                </div>
                                                <div class="form-group col-md-6">
                                                        <label for="inputCountry">Country:</label>
                                                        <input type="text" class="form-control" id="inputCountry" placeholder="Enter your country..." name="country" value="<%= p.getCountry() %>">
                                                </div>
                                                <div class="form-group col-md-6">
                                                        <label for="inputCity">City:</label>
                                                        <input type="text" class="form-control" id="inputCity" placeholder="Enter your city..." name="city" value="<%= p.getCity() %>">
                                                </div>
                                                <div class="form-group">
                                                        <label for="inputAbout">About:</label>
                                                        <textarea class="form-control" id="inputAbout" rows="3" name="about" placeholder="Tell people about yourself..."><%= p.getAbout() %></textarea>
                                                </div>
                                                <button class="btn btn-primary col-md-4 col-md-offset-4" type="submit">Save</button>
                                            </form>
                                        </div>
                                </div>
                                <hr>
                                <a name="auth"></a>
                                <% if (session.getAttribute("password_changed_error") != null) { %>
                                    <div class="alert alert-danger col-md-offset-3 col-md-6 alert-dismissible fade in">
                                        <span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;&nbsp;<strong><%= session.getAttribute("password_changed_error") %></strong>
                                        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span>
                                    </div>
                                    <div style="clear:both;"></div>
                                <% session.removeAttribute("password_changed_error"); } %>
                                <div class="row">
                                        <div class="col-md-8 col-md-offset-2">
                                                <div class="panel panel-warning">
                                                        <div class="panel-heading">
                                                            <b>Change password:</b>
                                                        </div>
                                                        <div class="panel-body text-center">
                                                                <form class="form-inline" action="components/edit_password_handler.jsp" method="POST">
                                                                        <div class="form-group">
                                                                                <div>
                                                                                    <p class="form-control-static"><b><%= p.getLogin() %>&nbsp;&nbsp;&nbsp;</b></p>
                                                                                </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                                <input type="password" class="form-control" id="inputOldPass" name="oldpass" placeholder="Old password..." value="">
                                                                        </div>
                                                                        <div class="form-group">
                                                                                <input type="password" class="form-control" id="inputNewPass" name="pass" placeholder="New password..." value="">
                                                                        </div>
                                                                        <div class="form-group">
                                                                                <input type="password" class="form-control" id="inputNewPass2" name="pass2" placeholder="Confirm..." value="">
                                                                        </div>
                                                                        <button class="btn btn-warning" type="submit">Save</button>
                                                                </form>
                                                        </div>
                                                </div>
                                        </div>
                                </div>
                        </div>
                    </div>                     
                </div>
            </div>
        </div> 
        
    <script type="text/javascript">
	$(document).ready(function(){
		$(".input_photo_file").tooltip({placement:"bottom"});
		
		$(".button_delete_photo").click(function(){
			bootbox.dialog({
				message: "Are you sure?",
				title: "Removing photo...",
				onEscape: function() {},
				show: true,
				backdrop: true,
				closeButton: true,
				animate: true,
				className: "confirm-delete-photo-modal",
				buttons: {
					"Cancel": function() {},
					"Remove": {
						className: "btn-danger",
						callback: function() {
							$.post("components/delete_photo_handler.php", function(){
								$(".edit_profile_user_photo").attr("src","/pic/photos/def.jpg");
							});
						}
					},
				}
				});
		});
		
		$("#inputBirthday").datepicker({format:"dd.mm.yyyy",weekStart:1,viewMode:"years"}).on('changeDate', function(ev){
                    if (ev.viewMode === "days"){
                        $(this).datepicker('hide');
                    }
		});
		$("#inputBirthday").focus(function(){
                    $(this).datepicker('show');
		});
		$("#inputAbout").focus(function(){
                    $("#inputBirthday").datepicker('hide');
		});
	});
    </script>        
    </body>
</html>
