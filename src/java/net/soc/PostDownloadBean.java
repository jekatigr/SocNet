/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.soc;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author Александра
 */
public class PostDownloadBean {
    private int id;
    private int uid;
    private String text;
    private Timestamp date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return uid;
    }

    public void setUid (int user_id) {
        this.uid = user_id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
    private Timestamp setDateForSQL() {
        try {
            DateFormat formatter;
            String dateAsString = date.toString();
            System.out.println("in SetDateFroSQL");
            System.out.println("Truoc:"+ date);
            formatter = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
            Date temp = (Date) formatter.parse(dateAsString);      
            java.sql.Timestamp timestampDate = new Timestamp(temp.getTime());
         //   System.out.println("Date:"+ timeStampDate);
            return timestampDate;
        } catch (ParseException e) {
            System.out.println("ParseException :" + e);
            return null;
        }
    }
    public List<Object> getAllPosts() {
        List<Object> posts = new ArrayList<>(); 
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            System.out.println("in getAllPosts");
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("Select  * from posts where"
                    + "user_id='"+ uid +"'");
            while(rs.next()) {
                 posts.add(rs.getTimestamp(3));
                 posts.add(rs.getString(2));
                 posts.add(rs.getInt(1));
            }
            return posts;
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
        return posts;
    }
    
    public boolean savePost() {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            System.out.println("in SavePost");
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            st.executeUpdate("UPDATE posts SET"
                    + "user_id='"+ uid +"', "
                    + "text= '"+ text +"', "
                    + "date='"+ this.setDateForSQL() +"'"+
                    " WHERE id='"+ id +"'");
            return true;
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
    
}
