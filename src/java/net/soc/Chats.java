

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package net.soc;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Driver;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class Chats {
    public static void main(String[] args) {
        ArrayList<ChatDescription> chats = Chats.loadAll(1);
    } 
    public static ArrayList<ChatDescription> loadAll(int userID) {
        ArrayList<ChatDescription> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver()); //"+ userID +"
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT chat, is_group, DATE_FORMAT(date,'%d.%m.%Y %H:%i:%s') AS date, concat(p.first_name, \" \", p.last_name) AS name, p.photo, user, text FROM (\n" +
"SELECT u.user_id as user, u.chat_id as chat, COALESCE(m.date, u.add_date) as date, m.text, c.is_group as is_group FROM users_to_chats u\n" +
"LEFT JOIN messages m ON m.utc_id = u.id\n" +
"INNER JOIN chats c ON c.id = u.chat_id\n" +
"WHERE u.chat_id IN (SELECT chat_id FROM users_to_chats WHERE user_id = "+ userID +")\n" +
"ORDER BY date DESC\n" +
")\n" +
"as a\n" +
"INNER JOIN profiles p ON p.id = a.user\n" +
"GROUP BY chat, user\n" +
"ORDER BY UNIX_TIMESTAMP(date) DESC");
            LinkedHashMap<Integer, ChatDescription> chats = new LinkedHashMap<>();
            while (rs.next()) {
				if (!chats.containsKey(rs.getInt(1))) { //этого чата еще не встречали
                    ChatDescription cd = new ChatDescription();
                    cd.setChatID(rs.getInt(1));
                    cd.setIsGroup(rs.getInt(2) == 1);
                    cd.setDate(rs.getString(3));
                    rs.getString(7)
                    if (!rs.wasNull()) {
                        cd.setLastMessage(rs.getString(7));
                        cd.setPhotoLastMessage(rs.getString(5));
                        cd.setAdded(true);
                    }
                    else {
                        if (rs.getInt(6) == userID) {
                            cd.setAdded(true);
                        }
                    }
                    if (rs.getInt(6) != userID) {
                        cd.setReceiverID(rs.getInt(6));
                        cd.setReceiverName(rs.getString(4));
                        cd.setReceiverPhoto(rs.getString(5));
                    }
                    cd.setMembersCount(1);
                    
                    chats.put(rs.getInt(1), cd);
                } else { //такой чат уже был
                    ChatDescription cd = chats.get(rs.getInt(1));
                    cd.setIsGroup(rs.getInt(2) == 1);
                    if (!cd.isAdded()) {
                        cd.setLastMessage(rs.getString(7));
                        cd.setPhotoLastMessage(rs.getString(5));
                        cd.setAdded(true);
                    }
                    if (rs.getInt(6) != userID) {
                        cd.setReceiverID(rs.getInt(6));
                        cd.setReceiverName(rs.getString(4));
                        cd.setReceiverPhoto(rs.getString(5));
                    }
                    cd.increaseMembersCount();
                }
				
            }
            list.addAll(chats.values());
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                if (rs != null) { rs.close(); }
                if (st != null) { st.close(); }
                if (con != null) { con.close(); }
            } catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return list;
    }
}

