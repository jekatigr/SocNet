package net.soc;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Driver;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class CreateGroupChatBean {
    private int userID;

    public String createGroupChat() throws SQLException {
        Chat res = null;
        Connection con = null;
        Statement st1 = null, st2 = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            con.setAutoCommit(false);
            
            st1 = (Statement) con.createStatement();
            st2 = (Statement) con.createStatement();
            
            st1.executeUpdate("INSERT INTO chats (chat_owner, is_group) VALUES ("+userID+", 1)", Statement.RETURN_GENERATED_KEYS);
            rs = st1.getGeneratedKeys();
            if (rs.next()) {
                int newChatID = rs.getInt(1);
                Date dt = Calendar.getInstance().getTime();
                String date = DBConnect.getDateForSQL(dt);
                st2.executeUpdate("INSERT INTO users_to_chats (user_id, chat_id, add_date) VALUES ("+ userID +","+ newChatID +",'"+ date +"')");
                con.commit();
                
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
                String dtf = sdf.format(dt);
            
                return "{\"ok\": \"true\", \"id\": \""+ newChatID +"\", \"date\":\""+ dtf +"\"}";
            }
            
            con.commit();
            
            return "{\"ok\": \"false\"}";
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            if (con != null) {
                con.rollback();
            }
        } finally {
            try {
                if (rs != null) { rs.close(); }
                if (st1 != null) { st1.close(); }
                if (st2 != null) { st2.close(); }
                if (con != null) { con.close(); }
            } catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return null;
    }

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
}
