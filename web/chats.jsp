<%@page import="java.util.ArrayList"%>
<%@page import="net.soc.Chats"%>
<%@page import="net.soc.ChatDescription"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<%
    if(!auth) {
        response.sendRedirect("index.jsp");
        throw new javax.servlet.jsp.SkipPageException();
    }
    ArrayList<ChatDescription> chats = Chats.loadAll(Integer.valueOf(session.getAttribute("id").toString()));
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
                <div class="list-group">
                <%
                    for(int i = 0; i < chats.size(); i++) {
                        ChatDescription cd = chats.get(i);
                        %>
                            <div class="list-group-item list-group-item-linkable" data-link="chat.jsp?cid=<%= cd.getChatID() %>">
                                <div class="chats_info_container">
                                    <a href="index.jsp?p=<%= cd.getReceiverID() %>"><img class="chats_receiver_avatar" src="pic/photos/<%= cd.getReceiverPhoto() %>"></a>
                                    <div class="chats_info_container_name_date">
                                        <a class="chats_info_name" href="index.jsp?p=<%= cd.getReceiverID() %>"><%= cd.getReceiverName() %></a>
                                        <br>
                                        <span class="chats_info_date"><%= cd.getDate() %></span>
                                    </div>
                                </div>
                                <div class="chats_last_message_container pull-right">
                                    <img class="chats_last_message_avatar" src="pic/photos/<%= cd.getPhotoLastMessage() %>">
                                    <div class="chats_last_message_text_container"><%= cd.getLastMessage() %></div>
                                </div>
                            </div>
                                
                        <%
                    }
                %>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $('.list-group-item-linkable').on('click', function() {
                    window.location.href = $(this).data('link');
                });

                $('.list-group-item-linkable a, .list-group-item-linkable button')
                .on('click', function(e) {
                    e.stopPropagation();
                });
            });
        </script> 
    </body>
</html>
