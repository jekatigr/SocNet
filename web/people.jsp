<%@page import="net.soc.Profile"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.soc.People"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/blocks/auth.jspf" %>

<%
    if(!auth) {
        response.sendRedirect("index.jsp");
        throw new javax.servlet.jsp.SkipPageException();
    }
    ArrayList<Profile> list = People.loadAll();
    ArrayList<String> positions = People.loadAllPositions();
    ArrayList<String> countries = People.loadAllCountries();
    ArrayList<String> cities = People.loadAllCities();
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
        <div class="countainer">
            <div class="row col-md-8 col-md-offset-2">
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
            <div class="row col-md-6 col-md-offset-3">
                <div class="list-group all_people">
                <%
                    for(int i = 0; i < list.size(); i++) {
                        Profile p = list.get(i);
                        %>
                            <div class="list-group-item list-group-item-linkable people_container" data-link="index.jsp?p=<%= p.getId() %>">
                                <div class="people_info_container">
                                    <img class="people_user_avatar" src="pic/photos/<%= p.getPhoto() %>">
                                    <div class="people_container_name_info">
                                        <a class="people_info_name" href="index.jsp?p=<%= p.getId() %>"><b><%= p.getName() %></b></a>
                                        <br>
                                        <span class="people_info_item"><span class="glyphicon glyphicon-briefcase"></span> <%= p.getPosition() %></span>
                                        <br>
                                        <span class="people_info_item"><span class="glyphicon glyphicon-gift"></span> <%= p.getBirthday() %></span>
                                        <br>
                                        <span class="people_info_item"><span class="glyphicon glyphicon-map-marker"></span> <%= p.getLocation() %></span>
                                    </div>
                                </div>
                                <% if (session.getAttribute("id") != null && p.getId() != Integer.parseInt(session.getAttribute("id").toString())) { %>
                                    <div class="people_send_message_container pull-right">
                                        <a class="btn btn-primary" href="chat.jsp?uid=<%= p.getId() %>">Send message</a>
                                    </div>
                                <% } %>
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
                
                $(".filter_form").submit(function(event) {
                    event.preventDefault();
                });
                $(".filter_partname").on('input', updatePeopleList)
                $(".filter_position").change(updatePeopleList)
                $(".filter_country").change(updatePeopleList)
                $(".filter_city").change(updatePeopleList)
            });
            
            function updatePeopleList() {
                var data = $(".filter_form").serializeArray();
                $.getJSON("components/people_filter.jsp", data, function(resp){
                    $(".all_people").html('');
                    if (resp.ok === "true") {
                        for (var i = 0; i < resp.people.length; i++) {
                            var add = '';
                            if (resp.people[i].id !== <%= session.getAttribute("id").toString()%>) {
                                add = '            <div class="people_send_message_container pull-right">                                                              '+
                                '                <a class="btn btn-primary" href="chat.jsp?uid='+ resp.people[i].id +'">Send message</a>                                '+
                                '            </div>                                                                                                              '+
                                '                                                                                                                        ';
                            }
                            $(".all_people").append('<div class="list-group-item list-group-item-linkable people_container" data-link="index.jsp?p='+ resp.people[i].id +'">                '+ 
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
                        
                        $('.list-group-item-linkable').on('click', function() {
                            window.location.href = $(this).data('link');
                        });

                        $('.list-group-item-linkable a, .list-group-item-linkable button')
                        .on('click', function(e) {
                            e.stopPropagation();
                        });
                    } else {
                        $(".all_people").html('<br><br><h2 align="center" class="no_messages_title">Users not found...</h2>');
                    }
                });
            }
        </script> 
    </body>
</html>
