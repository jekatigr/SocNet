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
        chat = Chat.load(Integer.valueOf(request.getParameter("cid")));
    }
    
    if (chat == null) {
        response.sendRedirect("index.jsp");
        throw new javax.servlet.jsp.SkipPageException();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chats</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %></head>
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
                    <button class="btn btn-primary col-md-4 col-md-offset-4 pull-right message_send_button" type="submit">Send</button>   
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                window.scrollTo(0,document.body.scrollHeight);
                $(".form-control").focus();
            });
            
            $(".message_send_button").click(function(){
                var text = $(".message_textarea").val().trim();
                if (text.length > 0) {
                        $.post("components/send_message.jsp", {chatID: <%= chat.getChatID() %>, message: text}, function(resp) {
                            var o = $.parseJSON(resp);
                            if (o.ok === "true") {
                                $(".no_messages_title").hide();
                                $(".messages_table").append('<tr><td><div class="message_container"><div class="message_avatar"><a href="index.jsp?p='+ o.userid +'"><img class="chats_receiver_avatar" src="pic/photos/'+ o.photo +'"></a></div><div class="message_name_date"><div class="message_name"><a href="index.jsp?p='+ o.userid +'">'+ o.name +'</a></div><div class="message_date">'+ o.datetime +'</div></div><div class="message_text">'+ text +'</div></div></td></tr>');
                                window.scrollTo(0,document.body.scrollHeight);
                            }
                        })
                }
            })
        </script> 
    </body>
</html>
