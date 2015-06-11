<%@page import="net.soc.People"%>
<%@page import="net.soc.Chat.Member"%>
<%@page import="net.soc.Chat.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.soc.Chats"%>
<%@page import="net.soc.Chat"%>
<%@page import="net.soc.ChatDescription"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<%
    Chat chat = null;
    
    if (auth && request.getParameter("uid") != null) {
        chat = Chat.createOrLoad(Integer.valueOf(session.getAttribute("id").toString()), Integer.valueOf(request.getParameter("uid")));
    }
    
    if(auth && request.getParameter("cid") != null && Chat.checkMembership(Integer.valueOf(request.getParameter("cid")), Integer.valueOf(session.getAttribute("id").toString()))) {
        chat = Chat.load(Integer.valueOf(request.getParameter("cid")), Integer.valueOf(session.getAttribute("id").toString()));
    }
    
    if (chat == null) {
        response.sendRedirect("index.jsp");
        throw new javax.servlet.jsp.SkipPageException();
    }
    
    ArrayList<String> positions = People.loadAllPositions();
    ArrayList<String> countries = People.loadAllCountries();
    ArrayList<String> cities = People.loadAllCities();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chats</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %></head>
        <script type="text/javascript" src="js/bootbox.min.js"></script>
    </head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <div class="countainer">
            <div class="row col-md-6 col-md-offset-3">
                <div class="panel panel-default messages_panel">
                    <table class="table messages_table">
                        <%
                            if (chat.getMessages().isEmpty()) {
                        %>
                            <h2 align="center" class="no_messages_title">No messages yet...</h2>
                        <%
                            }
                            for (Message m : chat.getMessages()) {
                        %>
                            <tr>
                                <td>
                                    <div class="message_container">
                                        <div class="message_avatar">
                                            <a href="index.jsp?p=<%= m.getSenderID() %>"><img class="chats_receiver_avatar" src="pic/photos/<%= chat.getMembers().get(m.getSenderID()).getPhoto() %>"></a>
                                        </div>
                                        <div class="message_name_date">
                                            <div class="message_name">
                                                <a href="index.jsp?p=<%= m.getSenderID() %>"><%= chat.getMembers().get(m.getSenderID()).getName() %></a>
                                            </div>
                                            <div class="message_date">
                                                <%= m.getDate() %>
                                            </div>
                                        </div>
                                        <div class="message_text">
                                            <%= m.getText() %>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
        <div class="navbar-fixed-bottom row-fluid message_send_form_container">
            <div class="navbar-inner">
                <div class="container col-md-6 col-md-offset-3">
                    <div class="form-group">
                        <textarea class="form-control message_textarea" rows="3" name="message" placeholder="Type message here..."></textarea>
                    </div>
                    <div class="member_container">
                        <%
                            if (!chat.isGroup()) {
                                for (Member m : chat.getMembers().values()) {
                                    if (m.getUserID() != Integer.valueOf(session.getAttribute("id").toString())) {
                        %>
                                    <a href="index.jsp?p=<%= m.getUserID() %>"><img class="chat_member_avatar" src="pic/photos/<%= m.getPhoto() %>"></a>
                                    <b><a class="chat_member_name" href="index.jsp?p=<%= m.getUserID() %>"><%= m.getFullName() %></a></b>
                        <%
                                    }
                                }
                            } else {
                        %>
                                <button class="btn btn-primary show_members_button">Members: <%= chat.getMembers().values().size() %></button>  
                        <%
                            }
                        %>
                    </div>
                    <button class="btn btn-default add_members_button" title="<%= (chat.isGroup()) ? "Add users into chat" : "Add users into chat. Will make this chat group." %>"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
                    <button class="btn btn-primary col-md-4 pull-right message_send_button" type="submit">Send</button>   
                </div>
            </div>
        </div>
        <div class="template_container" style="display: none;">
            <div class="countainer members_popup_data">
                <div class="row col-md-10 col-md-offset-1">
                    <div class="list-group all_members">
                    <%
                        for(Member m : chat.getMembers().values()) {
                            %>
                                <div class="list-group-item members_container member-<%= m.getUserID() %>">
                                    <div class="members_info_container">
                                        <a class="members_user_avatar_link" href="index.jsp?p=<%= m.getUserID() %>">
                                            <img class="members_user_avatar" src="pic/photos/<%= m.getPhoto() %>">
                                        </a>
                                        <div class="members_container_name_info">
                                            <a class="members_info_name" href="index.jsp?p=<%= m.getUserID() %>"><b><%= m.getFullName() %></b></a>
                                        </div>
                                    </div>
                                    <% if (chat.getChatOwner() == Integer.parseInt(session.getAttribute("id").toString()) && m.getUserID() != chat.getChatOwner()) { %>
                                        <button class="btn btn-danger pull-right delete_user_from_chat_button" data-user_id=<%= m.getUserID() %>>Delete from chat</button>
                                    <% } %>
                                </div>

                            <%
                        }
                    %>
                    </div>
                </div>
            </div>
            <div class="add_members_popup">
                <div class="countainer">
                    <div class="row col-md-12 col-md-offset-0">
                        <form class="filter_form">
                            <div class="form-group col-md-3">
                                <label for="partname">Name:</label>
                                <input type="text" class="form-control filter_partname" id="partname" name="partname" placeholder="Start type name here...">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="position">Position:</label>
                                <select class="form-control filter_position" id="position" name="position">
                                    <option>-</option>
                                    <% for (String pos : positions) { %>
                                        <option><%= pos %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group col-md-3">
                                <label for="country">Country:</label>
                                <select class="form-control filter_country" id="country" name="country">
                                    <option>-</option>
                                    <% for (String cont : countries) { %>
                                        <option><%= cont %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group col-md-3">
                                <label for="city">City:</label>
                                <select class="form-control filter_city" id="city" name="city">
                                    <option>-</option>
                                    <% for (String city : cities) { %>
                                        <option><%= city %></option>
                                    <% } %>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="countainer">
                    <div class="row col-md-12 col-md-offset-0">
                        <div class="list-group all_people">
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var membersIdArray = <%= chat.getMembersIdForJS() %>;
            
            $(document).ready(function() {
                window.scrollTo(0,document.body.scrollHeight);
                $(".form-control").focus();
                $(".add_members_button").tooltip({placement:"right"});
            });
            
            $(".show_members_button").click(showMembersPopup);
            
            function showMembersPopup() {
                var box = bootbox.dialog({
                    message: "<div class=\"popup\">" + $(".members_popup_data").html() + "</div><div style=\"clear: both;\"></div>",
                    title: "Members:",
                    buttons: {
                        main: {
                            label: "Close",
                            className: "btn-primary",
                            callback: function() {
                                bootbox.hideAll();
                            }
                        }
                    }
                });  
                
                box.on("shown.bs.modal", function() {
                    $(".delete_user_from_chat_button").click(deleteUserFromChat);
                });
            }
            
            function deleteUserFromChat() {
                var user_id = $(this).data('user_id');
                var button = $(this);
                $.post("components/delete_user_from_chat.jsp", {chatID: <%= chat.getChatID() %>, userID: user_id}, function(resp) {
                    var o = $.parseJSON(resp);
                    if (o.ok === "true") {
                        $(".popup .member-"+user_id).remove();
                        $(".template_container .member-"+user_id).remove();
                        membersIdArray.splice(membersIdArray.indexOf(user_id), 1);
                        $(".member_container").html('<button class="btn btn-primary show_members_button">Members: '+ membersIdArray.length +'</button>  ');
                        $(".show_members_button").click(showMembersPopup);
                    } else {
                        button.text("Error! Try again.");
                        button.addClass("disabled");
                    }
                });
            }
            
            $(".message_send_button").click(function(){
                var text = $(".message_textarea").val().trim();
                if (text.length > 0) {
                        $.post("components/send_message.jsp", {chatID: <%= chat.getChatID() %>, message: text}, function(resp) {
                            var o = $.parseJSON(resp);
                            if (o.ok === "true") {
                                $(".no_messages_title").hide();
                                $(".messages_table").append('<tr><td><div class="message_container"><div class="message_avatar"><a href="index.jsp?p='+ o.userid +'"><img class="chats_receiver_avatar" src="pic/photos/'+ o.photo +'"></a></div><div class="message_name_date"><div class="message_name"><a href="index.jsp?p='+ o.userid +'">'+ o.name +'</a></div><div class="message_date">'+ o.datetime +'</div></div><div class="message_text">'+ text +'</div></div></td></tr>');
                                window.scrollTo(0,document.body.scrollHeight);
                                $(".message_textarea").val("");
                                $(".form-control").focus();
                            }
                        });
                }
            });
            
            $(".add_members_button").click(function(){
                var box = bootbox.dialog({
                    message: "<div class=\"popup\">" + $(".add_members_popup").html() + "</div><div style=\"clear: both;\"></div>",
                    title: "Add members to chat:",
                    buttons: {
                        main: {
                            label: "Close",
                            className: "btn-primary",
                            callback: function() {
                                bootbox.hideAll();
                            }
                        }
                    }
                });  

                box.on("shown.bs.modal", function() {
                    updatePeopleList();
                    $(".filter_form").submit(function(event) {
                        event.preventDefault();
                    });
                    $(".filter_partname").on('input', updatePeopleList)
                    $(".filter_position").change(updatePeopleList)
                    $(".filter_country").change(updatePeopleList)
                    $(".filter_city").change(updatePeopleList)
                });
            });
            
            function updatePeopleList() {
                var data = $(".popup .filter_form").serializeArray();
                $.getJSON("components/people_filter.jsp", data, function(resp){
                    $(".all_people").html('');
                    if (resp.ok === "true") {
                        for (var i = 0; i < resp.people.length; i++) {
                            var add = '';
                            if ($.inArray(resp.people[i].id, membersIdArray) == -1) {
                                add = '            <div class="col-md-4 people_send_message_container pull-right">                                                              '+
                                '                <a class="col-md-12 btn btn-primary add_user_to_chat_button" data-user_id='+ resp.people[i].id +' data-user_name="'+ resp.people[i].name +'" data-user_photo="'+ resp.people[i].photo +'">Add</a>                                '+
                                '            </div>                                                                                                              '+
                                '                                                                                                                        ';
                            } else {
                                add = '            <div class="col-md-4 people_send_message_container pull-right">                                                              '+
                                '                <a class="col-md-12 btn btn-warning disabled already_in_chat_button">Already in chat</a>                                '+
                                '            </div>                                                                                                              '+
                                '                                                                                                                        ';
                            }
                            $(".all_people").append('<div class="list-group-item">                '+ 
                        '        <div class="people_info_container">                                                                                     '+
                        '            <img class="people_user_avatar" src="pic/photos/'+ resp.people[i].photo +'">                                               '+
                        '            <div class="people_container_name_info">                                                                            '+
                        '                <a class="people_info_name" href="index.jsp?p='+ resp.people[i].id +'"><b>'+ resp.people[i].name +'</b></a>                   '+
                        '                <br>                                                                                                            '+
                        '                <span class="people_info_item"><span class="glyphicon glyphicon-briefcase"></span> '+ resp.people[i].position +'</span> '+
                        '                <br>                                                                                                            '+
                        '                <span class="people_info_item"><span class="glyphicon glyphicon-gift"></span> '+ resp.people[i].birthday +'</span>      '+
                        '                <br>                                                                                                            '+
                        '                <span class="people_info_item"><span class="glyphicon glyphicon-map-marker"></span> '+ resp.people[i].location +'</span>'+
                        '            </div>                                                                                                              '+
                        '         </div>                                                                                                                 '+ add+
                        '   </div>');
                        }
                    } else {
                        $(".all_people").html('<br><br><h2 align="center" class="no_messages_title">Users not found...</h2>');
                    }
                    
                    $(".add_user_to_chat_button").click(function(){
                        var user_id = $(this).data('user_id');
                        var user_name = $(this).data('user_name');
                        var user_photo = $(this).data('user_photo');
                        var button = $(this);
                        $.post("components/add_user_to_chat.jsp", {chatID: <%= chat.getChatID() %>, userToAddID: user_id}, function(resp) {
                            var o = $.parseJSON(resp);
                            if (o.ok === "true") {
                                button.removeClass("btn-primary add_user_to_chat_button").addClass("btn-warning disabled already_in_chat_button");
                                button.text("Already in chat");
                                membersIdArray.push(user_id);
                                $(".member_container").html('<button class="btn btn-primary show_members_button">Members: '+ membersIdArray.length +'</button>  ');
                                $(".show_members_button").click(showMembersPopup);
                                $(".all_members").append(	'<div class="list-group-item members_container">																									'+
                                                                '	<div class="members_info_container">                                                                                                            '+
                                                                '		<a class="members_user_avatar_link" href="index.jsp?p='+ user_id +'">                                                                '+
                                                                '			<img class="members_user_avatar" src="pic/photos/'+ user_photo +'">                                                                  '+
                                                                '		</a>                                                                                                                                        '+
                                                                '		<div class="members_container_name_info">                                                                                                   '+
                                                                '			<a class="members_info_name" href="index.jsp?p='+ user_id +'"><b>'+ user_name +'</b></a>                                  '+
                                                                '		</div>                                                                                                                                      '+
                                                                '	</div>                                                                                                                                          '+
                                                                '	          '+
                                                                '		<button class="btn btn-danger pull-right delete_user_from_chat_button" href="cha.jsp?uid='+ user_id +'">Delete from chat</button>    '+
                                                                '	                                                                                                                                       '+
                                                                '</div>');
                                $(".delete_user_from_chat_button").click(deleteUserFromChat);                                
                            } else {
                                button.text("Error! Try again.");
                                button.addClass("disabled");
                            }
                        })
                    });
                });
            }
        </script> 
    </body>
</html>
