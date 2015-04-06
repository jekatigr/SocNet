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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class People {
    public static ArrayList<Profile> loadAll() {
        ArrayList<Profile> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT users.login, profiles.id, profiles.first_name, "
                    + "profiles.last_name, profiles.photo, profiles.sex, DATE_FORMAT(profiles.birthday,'%d.%m.%Y'), "
                    + "profiles.country, profiles.city, profiles.about FROM users INNER JOIN profiles ON profiles.id = users.id");
            while (rs.next()) {
                Profile p = new Profile();
                p.setId(rs.getInt(2));
                p.setLogin(rs.getString(1));
                p.setFirst_name(rs.getString(3));
                p.setLast_name(rs.getString(4));
                p.setPhoto(rs.getString(5));
                p.setSex(rs.getString(6).equals("1"));
                p.setBirthday(rs.getString(7));
                p.setCountry(rs.getString(8));
                p.setCity(rs.getString(9));
                p.setAbout(rs.getString(10));
                list.add(p);
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
        return list;
    }
}
