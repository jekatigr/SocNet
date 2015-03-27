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
public class EditPassBean {
    private int id;
    private String login;
    private String oldpass;
    private String pass;
    private String pass2;

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
    
     /**
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }
    
    public String getLogin() {
        return this.login;
    }
    
    public String getOldpass() {
        return this.oldpass;
    }

    public void setOldpass(String oldpass) {
        this.oldpass = oldpass;
    }
    
    public String getPass() {
        return this.pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
    public String getPass2() {
        return this.pass2;
    }

    public void setPass2(String pass2) {
        this.pass2 = pass2;
    }
   
    public String getError() {
        return this.error;
    }
    
    public String getHash() {
        return AuthBean.md5(AuthBean.md5(this.getLogin() + this.getPass()));
    }

    
    public boolean savePass() {
        if (new AuthBean().checkAuth(this.getId(), AuthBean.md5(AuthBean.md5(this.getLogin() + this.getOldpass())))) {
            if (this.getPass() != null && this.getPass().length() > 5) { 
                if (AuthBean.md5(this.getPass()).equals(AuthBean.md5(this.getPass2()))) {
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;

                    try {
                        DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                        con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
                        st = (Statement) con.createStatement();
                        st.executeUpdate("UPDATE users SET password='"+ AuthBean.md5(this.getLogin() + this.getPass()) +"' WHERE id='"+ this.getId() +"'");
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
                } else {
                    error = "New password should be equal with confirm!";
                }
            } else {
                error = "New password length should be more than 5 chars!";
            }
        } else {
            error = "Old password is wrong!";
        }
        return false;
    }
}
