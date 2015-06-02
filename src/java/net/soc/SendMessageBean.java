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
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;
import static net.soc.Chat.load;

/**
 *
 * @author TireX
 */
public class SendMessageBean {
    private int userID;
    private int chatID;
    private String message;

    /**
     * @return the userID
     */
    public int getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(int userID) {
        this.userID = userID;
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

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message.trim();
    }
    
    public String sendMessage() {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        
        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            //проверка на существование чата
            rs = st.executeQuery("SELECT * FROM users_to_chats WHERE chat_id="+this.getChatID()+" AND user_id="+this.getUserID());
            boolean chat_is_ok = rs.next();
            rs2 = st.executeQuery("SELECT * FROM chats WHERE chat_owner="+this.getUserID()+" AND id="+this.getChatID());
            if (!chat_is_ok && !rs2.next()) {
                return "{\"ok\": \"false\"}";
            }
            rs2 = st.executeQuery("SELECT p.first_name, p.photo FROM profiles p WHERE id="+this.getUserID());
            rs2.next();
            String name = rs2.getString(1);
            String photo = rs2.getString(2);
            photo = (photo != null && !photo.equals("")) ? photo : "def.jpg";
            
            String dt = DBConnect.getCurrentDateForSQL();
            st.executeUpdate("INSERT INTO messages (date, user_id, chat_id, text) VALUES ('"+ dt +"', "+ this.getUserID() +", "+ this.getChatID() +", '"+ this.getMessage() +"')");
            return "{\"ok\": \"true\", \"datetime\": \""+ dt +"\", \"userid\":"+this.getUserID()+", \"photo\":\""+ photo +"\", \"name\":\""+ name +"\"}";
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
        return "{\"ok\": \"false\"}";
    }
}
