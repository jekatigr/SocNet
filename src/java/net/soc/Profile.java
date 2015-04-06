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
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;

/**
 *
 * @author TireX
 */
public class Profile {
    private int id;
    private String login;
    private String first_name;
    private String last_name;
    private String photo;
    private boolean sex; //true-male, false-female
    private String birthday;
    private String country;
    private String city;
    private String about;
    private List<String> posts = new ArrayList<>();
    private List<Integer> id_posters = new ArrayList<>();  //person who write post (if user writes it himself, id = id_poster)
    private List<Timestamp> times = new ArrayList<>();
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
     * @return the first_name
     */
    public String getFirst_name() {
        return first_name;
    }

    /**
     * @param first_name the first_name to set
     */
    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    /**
     * @return the last_name
     */
    public String getLast_name() {
        return last_name;
    }

    /**
     * @param last_name the last_name to set
     */
    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getName() {
        String res = "";
        if (this.first_name != null && !this.first_name.equals("")) {
            res += this.first_name;
        }
        if (this.last_name != null && !this.last_name.equals("")) {
            if(!res.equals("")) {
                res += " ";
            }
            res += this.last_name;
        }
        if (res.equals("")) {
            return this.login;
        } else {
            return res;
        }
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
     * @return the sex
     */
    public boolean isSex() {
        return sex;
    }

    /**
     * @param sex the sex to set
     */
    public void setSex(boolean sex) {
        this.sex = sex;
    }

    /**
     * @return the birthday
     */
    public String getBirthday() {
        return (this.birthday != null) ? this.birthday.toString() : "undefended";
    }

    /**
     * @param birthday the birthday to set
     */
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /**
     * @return the country
     */
    public String getCountry() {
        return country;
    }

    /**
     * @param country the country to set
     */
    public void setCountry(String country) {
        this.country = country;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getLocation() {
        String res = "";
        if (this.country != null && !this.country.equals("")) {
            res += this.country;
        }
        if (this.city != null && !this.city.equals("")) {
            if(!res.equals("")) {
                res += ", ";
            }
            res += this.city;
        }
        if (res.equals("")) {
            return "undefended";
        } else {
            return res;
        }
    }

    /**
     * @return the about
     */
    public String getAbout() {
        return (about != null && !about.equals("")) ? about : "Nothing.";
    }

    /**
     * @param about the about to set
     */
    public void setAbout(String about) {
        this.about = about;
    }

    public void setLogin(String login) {
        this.login = login;
    }
    
    public String getLogin() {
        return this.login;
    } 
    
    public boolean getSex() {
        return this.sex;
    }
    
    
    public String getPost(int i) {
        return posts.get(i);
    }

    public void setPost(String post) {
        posts.add(post);
    }

    public Integer getId_poster(int i) {
        return id_posters.get(i);
    }

    public void setId_poster(Integer id_poster) {
        id_posters.add(id_poster);
    }

    public Timestamp getTime(int i) {
        return times.get(i);
    }

    public void setTime(Timestamp time) {
        times.add(time);
    }
    
    public List<String> getPosts() {
        return posts;
    }
    
    public boolean load(int id) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            rs = st.executeQuery("SELECT users.login, profiles.id, profiles.first_name, "
                    + "profiles.last_name, profiles.photo, profiles.sex, DATE_FORMAT(profiles.birthday,'%d.%m.%Y'), "
                    + "profiles.country, profiles.city, profiles.about FROM users INNER JOIN profiles ON profiles.id = users.id WHERE users.id='" + id + "'");
            if (rs.next()) {
                setId(id);
                setLogin(rs.getString(1));
                setFirst_name(rs.getString(3));
                setLast_name(rs.getString(4));
                setPhoto(rs.getString(5));
                setSex(rs.getString(6).equals("1"));
                setBirthday(rs.getString(7));
                setCountry(rs.getString(8));
                setCity(rs.getString(9));
                setAbout(rs.getString(10));
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
