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
                    + "profiles.country, profiles.city, profiles.about, profiles.position FROM users INNER JOIN profiles ON profiles.id = users.id ORDER BY profiles.id");
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
                p.setPosition(rs.getString(11));
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
    
    public static ArrayList<String> loadAllPositions() {
        ArrayList<String> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT DISTINCT position FROM profiles ORDER BY position");
            while (rs.next()) {
                list.add(rs.getString(1));
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
    
    public static ArrayList<String> loadAllCountries() {
        ArrayList<String> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT DISTINCT country FROM profiles ORDER BY country");
            while (rs.next()) {
                list.add(rs.getString(1));
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
    
    public static ArrayList<String> loadAllCities() {
        ArrayList<String> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT DISTINCT city FROM profiles ORDER BY city");
            while (rs.next()) {
                list.add(rs.getString(1));
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
    
    public static ArrayList<Profile> loadFilteredPeople(String namepart, String position, String country, String city) 
    {
        ArrayList<Profile> list = new ArrayList<>();
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
 
        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            String sql = "SELECT u.login, p.id, p.first_name, "
                    + "p.last_name, p.photo, p.sex, DATE_FORMAT(p.birthday,'%d.%m.%Y'), "
                    + "p.country, p.city, p.about, p.position FROM users u INNER JOIN profiles p ON p.id = u.id ";
            if (namepart != null && !namepart.equals("")) {
                sql += "WHERE (p.first_name LIKE CONCAT('" + namepart + "', '%') OR p.last_name LIKE CONCAT('" + namepart + "', '%'))";
            }
            if (city != null && !city.equals("-")) {
                if (sql.contains("WHERE")) {
                    sql += " AND ";
                } else {
                    sql += " WHERE ";
                }
                sql += "p.city='" + city + "'";
            }
            if (country != null && !country.equals("-")) {
                if (sql.contains("WHERE")) {
                    sql += " AND ";
                } else {
                    sql += " WHERE ";
                }
                sql += "p.country='" + country + "'";
            }
            if (position != null && !position.equals("-")) {
                if (sql.contains("WHERE")) {
                sql += " AND ";
                } else {
                    sql += " WHERE ";
                }
                sql += "p.position='" + position + "'";
            }
            sql += " ORDER BY p.id";
            rs = st.executeQuery(sql);
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
                p.setPosition(rs.getString(11));
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
