package net.soc;


import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

public class RegFormBean {
    private int id;
    private String login;
    private String pass;
    private String pass2;
    private String hash;
    
    private HashMap<String, String> errors = new HashMap<>();
    
    public String getLogin() {
        return this.login;
    }
    
    public void setLogin(String login) {
        this.login = login.trim();
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
    
    public HashMap getErrors() {
        return this.errors;
    }
    
    private void setId(int id) {
        this.id = id;
    }
    
    public int getId() {
        return this.id;
    }
    
    public String getHash() {
        return AuthBean.md5(AuthBean.md5(this.getPass()));
    }
    
    
    public String getErrorMsg(String s) {
        String errorMsg =(String)errors.get(s.trim());
        return (errorMsg == null) ? "":errorMsg;
    }
    
    
    public boolean validate() {
        if (this.login == null || this.login.length() == 0) {
            errors.put("login", "You didn't enter the login!");
        } else {
            if (isLoginInDB(this.login)) {
                errors.put("login", "Such login already exists!");
            }
        }
        
        if (this.pass == null || this.pass.length() < 6) {
            errors.put("pass", "Password should be more than 5 chars!");
        }
        
        if (this.pass2 == null || !this.pass.equals(this.pass2)) {
            errors.put("pass2", "Passwords should be equal!");
        }
        
        return errors.isEmpty();
    }

    private static boolean isLoginInDB(String login) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT id FROM users WHERE login='" + login + "'");
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
        return true;
    }
    
    public boolean createNewUser() {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            st.executeUpdate("INSERT INTO users (login, password) VALUES ('"+ this.getLogin() +"', '"+ AuthBean.md5(this.getPass()) +"')");
            rs = st.executeQuery("SELECT id FROM users WHERE login='" + this.getLogin() + "'");
            if (rs.next()) {
                this.setId(rs.getInt(1));
                st.executeUpdate("INSERT INTO profiles (id) VALUES ('"+ this.getId() +"')");
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
}

