/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 *//*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 *//*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 *//*
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
 * @author Александра
 */
public class AddPostBean {
    private int authorId;
    private int receiverId;
    private String text;

    /**
     * @return the authorId
     */
    public int getAuthorId() {
        return authorId;
    }

    /**
     * @param authorId the authorId to set
     */
    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    /**
     * @return the receiverId
     */
    public int getReceiverId() {
        return receiverId;
    }

    /**
     * @param receiverId the receiverId to set
     */
    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
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
    
    public boolean savePost() {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            
            st.executeUpdate("INSERT INTO posts (author_id, receiver_id, date, text) "
                    + "VALUES ("+ this.getAuthorId() +
                    ", "+ this.getReceiverId() +
                    ", '"+ DBConnect.getDateForSQL(Calendar.getInstance().getTime()) +
                    "', '"+ this.getText() +" ')");
            
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
}
