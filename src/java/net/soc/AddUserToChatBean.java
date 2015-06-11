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
import java.util.Calendar;

/**
 *
 * @author TireX
 */
public class AddUserToChatBean {
    private int userToAddID;
    private int chatID;
    
    public boolean addUserToChat() {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            
            st.executeUpdate("INSERT INTO users_to_chats (user_id, chat_id, add_date) "
                    + "VALUES ("+ this.getUserToAddID() +
                    ", "+ this.getChatID() +
                    ", '"+ DBConnect.getDateForSQL(Calendar.getInstance().getTime()) +"')");
            
            st.executeUpdate("UPDATE chats SET is_group='1' WHERE id="+ chatID);
            
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                if (rs != null) { rs.close(); }
                if (st != null) { st.close(); }
                if (con != null) { con.close(); }
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return false;
    }

    /**
     * @return the userToAddID
     */
    public int getUserToAddID() {
        return userToAddID;
    }

    /**
     * @param userToAddID the userToAddID to set
     */
    public void setUserToAddID(int userToAddID) {
        this.userToAddID = userToAddID;
    }

    /**
     * @return the chatID
     */
    public int getChatID() {
        return chatID;
    }

    /**
     * @param chatID the chatID to set
     */
    public void setChatID(int chatID) {
        this.chatID = chatID;
    }
}
