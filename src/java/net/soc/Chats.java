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
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class Chats {
    
    public static ArrayList<ChatDescription> loadAll(int userId) {
        ArrayList<ChatDescription> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT utc.chat_id FROM users_to_chats utc WHERE utc.user_id="+userId);
            ArrayList<Integer> chats_id = new ArrayList<>();
            while (rs.next()) {
                chats_id.add(rs.getInt(1));
            }
            //for (int i = 0; i < chats_id.size(); i++) {
                //rs = st.executeQuery("SELECT utc.chat_id FROM users_to_chats utc WHERE utc.user_id="+userId);
                //while (rs.next()) {
                {{  ChatDescription cd = new ChatDescription();
                    cd.setChatID(1);
                    cd.setDate("21.03.2011 22:17:09");
                    cd.setLastMessage("bla bla bla");
                    cd.setMembersCount(2);
                    cd.setReceiverID(4);
                    cd.setReceiverName("Nuka nuka");
                    cd.setReceiverPhoto("");
                    cd.setPhotoLastMessage("");
                    list.add(cd);
                    
                    cd = new ChatDescription();
                    cd.setChatID(2);
                    cd.setDate("11.12.2013 8:37:13");
                    cd.setLastMessage("bla2bla2bla2bla2bla2bla2bla2bla2bla2bla2bla2bl");
                    cd.setMembersCount(4);
                    cd.setReceiverID(10);
                    cd.setReceiverName("ne tolko");
                    cd.setReceiverPhoto("");
                    cd.setPhotoLastMessage("");
                    list.add(cd);
                }
            }
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
