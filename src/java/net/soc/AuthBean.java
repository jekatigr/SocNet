/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package net.soc;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Driver;
import com.mysql.jdbc.Statement;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
public class AuthBean {
    public boolean checkAuth(Object id_o, Object hash_o) {
        if (id_o != null && hash_o != null) {
            int id = Integer.parseInt(String.valueOf(id_o));
            String hash = String.valueOf(hash_o);
            return checkAuth(id, hash);
        }
        return false;
    }
            
    public boolean checkAuth(int id, String hash) {
        if (hash != null) {
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                
            System.out.println("in checkAuth");
                DriverManager.registerDriver(new Driver());
                con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
                st = (Statement) con.createStatement();
                rs = st.executeQuery("SELECT password FROM users WHERE id='" + id + "'");
                if (rs.next()) {
                    String saved_pass_hash = rs.getString(1);
                    if (md5(saved_pass_hash).equals(hash)) {
                        return true;
                    }
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
        }
        return false;
    }
    
    public static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest((input + "this_is_incredible_salt").getBytes());
            BigInteger number = new BigInteger(1, messageDigest);
            String hashtext = number.toString(16);
            // Now we need to zero pad it if you actually want the full 32 chars.
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
