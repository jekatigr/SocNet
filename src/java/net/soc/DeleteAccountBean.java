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
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;


/**
 *
 * @author TireX
 */
public class DeleteAccountBean {
    private int id;
    private String login;
    private String pass;

    private String error;
    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }
    
    public String getPass() {
        return this.pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
  
   
    public String getError() {
        return this.error;
    }
    
    public String getHash() {
        return AuthBean.md5(AuthBean.md5(this.getLogin() + this.getPass()));
    }

    
    public boolean deleteAccount() {
        if (new AuthBean().checkAuth(this.getId(), AuthBean.md5(AuthBean.md5(this.getLogin() + this.getPass())))) {
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;

                try {
                    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                    con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
                    st = (Statement) con.createStatement();
                    st.executeUpdate("DELETE FROM users WHERE id='"+ this.getId() +"'");
                    st.executeUpdate("DELETE FROM profiles WHERE id='"+ this.getId() +"'");
                    st.executeUpdate("DELETE FROM posts WHERE author_id='"+ this.getId() +"' OR receiver_id='"+ this.getId() +"'");
                    st.executeUpdate("DELETE messages.* FROM messages WHERE messages.utc_id IN (SELECT utc.id FROM users_to_chats utc WHERE ((utc.user_id='"+ this.getId() +"') OR (utc.chat_id IN (SELECT c.id FROM chats c WHERE c.chat_owner='"+ this.getId() +"'))))");
                    st.executeUpdate("DELETE FROM users_to_chats WHERE user_id='"+ this.getId() +"' OR chat_id IN (SELECT c.id FROM chats c WHERE c.chat_owner='"+ this.getId() +"')");
                    st.executeUpdate("DELETE FROM chats WHERE chat_owner='"+ this.getId() +"'");
                    return true;
                } catch (SQLException ex) {
                    System.out.println(ex.getMessage());
                    error = "Internal error! Please, try again.";
                    return false;
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
        } else {
            error = "Password is wrong!";
        }
        return false;
    }

    /**
     * @return the login
     */
    public String getLogin() {
        return login;
    }

    /**
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }
}
