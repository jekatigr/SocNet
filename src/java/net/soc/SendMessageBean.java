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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

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
            rs = st.executeQuery("SELECT utc.id, p.first_name, p.photo FROM users_to_chats utc JOIN profiles p ON p.id=utc.user_id WHERE utc.chat_id="+this.getChatID()+" AND utc.user_id="+this.getUserID());
            if (!rs.next()) {
                return "{\"ok\": \"false\"}";
            }
            
            int utcId = rs.getInt(1);
            String name = rs.getString(2);
            String photo = rs.getString(3);
            photo = (photo != null && !photo.equals("")) ? photo : "def.jpg";
            
            Date date = Calendar.getInstance().getTime();
            String dt = DBConnect.getDateForSQL(date);
            st.executeUpdate("INSERT INTO messages (date, utc_id, text) VALUES ('"+ dt +"', "+ utcId +", '"+ this.getMessage() +"')");
            
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
            String dtf = sdf.format(date);
            return "{\"ok\": \"true\", \"datetime\": \""+ dtf +"\", \"userid\":"+this.getUserID()+", \"photo\":\""+ photo +"\", \"name\":\""+ name +"\"}";
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
