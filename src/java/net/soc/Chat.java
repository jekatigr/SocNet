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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class Chat {
    private int chatID;
    private int chatOwner;
    private boolean isGroup;
    private HashMap<Integer, Member> members = new HashMap<>(); //Integer=user_id
    private ArrayList<Message> messages = new ArrayList<>();

    /**
     * @return the messages
     */
    public ArrayList<Message> getMessages() {
        return messages;
    }

    /**
     * @param messages the messages to set
     */
    public void setMessages(ArrayList<Message> messages) {
        this.messages = messages;
    }

    /**
     * @return the members
     */
    public HashMap<Integer, Member> getMembers() {
        return members;
    }

    /**
     * @param members the members to set
     */
    public void setMembers(HashMap<Integer, Member> members) {
        this.members = members;
    }

    /**
     * @return the isGroup
     */
    public boolean isIsGroup() {
        return isGroup;
    }

    /**
     * @param isGroup the isGroup to set
     */
    public void setIsGroup(boolean isGroup) {
        this.isGroup = isGroup;
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
     * @return the chatOwner
     */
    public int getChatOwner() {
        return chatOwner;
    }

    /**
     * @param chatOwner the chatOwner to set
     */
    public void setChatOwner(int chatOwner) {
        this.chatOwner = chatOwner;
    }
    
    public static class Member {

        public Member() {
        }
        
        private int userID;
        private String firstName;
        private String lastName;
        private String photo;

        private Member(int userID, String firstName, String lastName, String photo) {
            this.userID = userID;
            this.firstName = firstName;
            this.lastName = lastName;
            this.photo = photo;
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

        /**
         * @return the name
         */
        public String getName() {
            return firstName;
        }

        /**
         * @param name the name to set
         */
        public void setName(String name) {
            this.firstName = name;
        }

        /**
         * @return the photo
         */
        public String getPhoto() {
            return (photo != null && !photo.equals("")) ? photo : "def.jpg";
        }

        /**
         * @param photo the photo to set
         */
        public void setPhoto(String photo) {
            this.photo = photo;
        }

        /**
         * @return the lastName
         */
        public String getLastName() {
            return lastName;
        }

        /**
         * @param lastName the lastName to set
         */
        public void setLastName(String lastName) {
            this.lastName = lastName;
        }
    }

    public static class Message {

        public Message() {
        }
        
        private int messageID;
        private String date;
        private int senderID;
        private String text;

        private Message(int messageID, String date, int senderID, String text) {
            this.messageID = messageID;
            this.date = date;
            this.senderID = senderID;
            this.text = text;
        }

        /**
         * @return the messageID
         */
        public int getMessageID() {
            return messageID;
        }

        /**
         * @param messageID the messageID to set
         */
        public void setMessageID(int messageID) {
            this.messageID = messageID;
        }

        /**
         * @return the date
         */
        public String getDate() {
            return date;
        }

        /**
         * @param date the date to set
         */
        public void setDate(String date) {
            this.date = date;
        }

        /**
         * @return the senderID
         */
        public int getSenderID() {
            return senderID;
        }

        /**
         * @param senderID the senderID to set
         */
        public void setSenderID(int senderID) {
            this.senderID = senderID;
        }

        /**
         * @return the text
         */
        public String getText() {
            return text;
        }

        /**
         * @param text the text to set
         */
        public void setText(String text) {
            this.text = text;
        }
    }
    
    
    public static boolean checkMembership(int chatID, int userID) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT * FROM users_to_chats WHERE chat_id="+chatID+" AND user_id="+userID);
            if (rs.next()) {
                return true;
            }
            return false;
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
        return false;
    }
    
    public static Chat load(int chatID) {
        Chat res = new Chat();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT * FROM chats WHERE id="+chatID);
            if (rs.next()) {
                res.setChatID(rs.getInt(1));
                res.setChatOwner(rs.getInt(2));
                res.setIsGroup((rs.getInt(3) == 1) ? true : false);
            
                rs = st.executeQuery("SELECT utc.user_id, p.first_name, p.last_name, p.photo, m.id AS message_id, DATE_FORMAT(m.date, '%d.%m.%Y %H:%i:%s') AS date, m.text FROM users_to_chats utc JOIN profiles p ON p.id=utc.user_id JOIN messages m ON m.utc_id=utc.id WHERE chat_id="+chatID+" ORDER BY UNIX_TIMESTAMP(m.date)");
                while (rs.next()) {
                    if (!res.getMembers().containsKey(rs.getInt(1))) {
                        res.getMembers().put(rs.getInt(1), new Member(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
                    }
                    
                    res.getMessages().add(new Message(rs.getInt(5), rs.getString(6), rs.getInt(1), rs.getString(7)));
                }
            }
            return res;
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
        return res;
    }
    
    public static Chat createOrLoad(int userID, int receiverID) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            //проверка на существование собеседника
            rs = st.executeQuery("SELECT * FROM profiles WHERE id="+receiverID);
            if (!rs.next()) {
                return null;
            }
            //проверка существования готового чата
            rs = st.executeQuery("SELECT utc.chat_id FROM users_to_chats utc JOIN (SELECT * FROM users_to_chats WHERE user_id="+ receiverID +") utc2 ON utc.chat_id=utc2.chat_id JOIN chats c ON c.id=utc.chat_id WHERE utc.user_id="+ userID +" AND c.is_group=0");
            if (rs.next()) {
                return load(rs.getInt(1));
            }
            
            st.executeUpdate("INSERT INTO chats (chat_owner, is_group) VALUES ("+userID+", 0)");
            rs = st.executeQuery("SELECT id FROM chats WHERE chat_owner="+userID+" ORDER BY id DESC");
            if (rs.next()) {
                int newChatID = rs.getInt(1);
                String date = DBConnect.getDateForSQL(Calendar.getInstance().getTime());
                st.executeUpdate("INSERT INTO users_to_chats (user_id, chat_id, add_date) VALUES ("+ userID +","+ newChatID +",'"+ date +"')");
                st.executeUpdate("INSERT INTO users_to_chats (user_id, chat_id, add_date) VALUES ("+ receiverID +","+ newChatID +",'"+ date +"')");
            
                return load(newChatID);
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
        return null;
    }
}
