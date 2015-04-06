<%@page import="net.soc.Profile"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.soc.People"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<%
    ArrayList<Profile> list = People.loadAll();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>People search</title>
        <%@include file="WEB-INF/blocks/includes.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/blocks/menu.jspf" %>
        <!-- Тело документа -->
        <ul class="list-group">
        <%
            for(int i = 0; i < list.size(); i++) {
                Profile p = list.get(i);
                %>
                    <li class="list-group-item">
                        <div class="row">
                                <div class="col-md-2 col-md-offset-4">
                                    <a href="index.jsp?p=<%= p.getId() %>">
                                        <img class="people_user_avatar" src="pic/photos/<%= p.getPhoto() %>">
                                    </a>
                                </div>
                                <div class="col-md-4">
                                        <table class="people_user_info_table">
                                                <tr><td class="people_table_td">
                                                        <span class="glyphicon glyphicon-user"></span>
                                                        <b><a href="index.jsp?p=<%= p.getId() %>"><%= p.getName() %></a></b>										
                                                </td></tr>
                                                <tr><td class="people_table_td">
                                                        <span class="glyphicon glyphicon-gift"></span>
                                                        <%= p.getBirthday() %>										
                                                </td></tr>
                                                <tr class="people_table_tr"><td class="people_table_td">
                                                        <span class="glyphicon glyphicon-map-marker"></span>
                                                        <%= p.getLocation() %>										
                                                </td></tr>
                                        </table>
                                </div>
                        </div>
                    </li>
                <%
            }
        %>
        </ul>
    </body>
</html>
