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
public class Profile {
    private int id;
    private String login;
    private String first_name;
    private String last_name;
    private String photo;
    private String birthday;
    private String country;
    private String city;
    private String about;
    private String position;
    private ArrayList<Post> posts = new ArrayList<>();
    
    
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
    
    public Post getPost(int i) {
        return posts.get(i);
    }

    public void setPosts(ArrayList<Post> posts) {
        this.posts = posts;
    }
    
    public ArrayList<Post> getPosts() {
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
                    + "profiles.last_name, profiles.photo, DATE_FORMAT(profiles.birthday,'%d.%m.%Y'), "
                    + "profiles.country, profiles.city, profiles.about, profiles.position FROM users INNER JOIN profiles ON profiles.id = users.id WHERE users.id='" + id + "'");
            if (rs.next()) {
                setId(id);
                setLogin(rs.getString(1));
                setFirst_name(rs.getString(3));
                setLast_name(rs.getString(4));
                setPhoto(rs.getString(5));
                setBirthday(rs.getString(6));
                setCountry(rs.getString(7));
                setCity(rs.getString(8));
                setAbout(rs.getString(9));
                setPosition(rs.getString(10));
                
                //загружаем посты:
                rs = st.executeQuery("SELECT ps.id, pr.id AS author_id, CONCAT(pr.first_name, \" \", pr.last_name) AS author_name, pr.photo AS author_photo, DATE_FORMAT(ps.date,'%d.%m.%Y %H:%i') AS date, ps.text FROM posts ps JOIN profiles pr ON ps.author_id=pr.id WHERE receiver_id=" + id + " ORDER BY ps.date DESC");
                while(rs.next()) {
                    posts.add(new Post(
                            rs.getInt(1),
                            rs.getInt(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getString(6)
                    ));
                }
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

    /**
     * @return the position
     */
    public String getPosition() {
        return position;
    }

    /**
     * @param position the position to set
     */
    public void setPosition(String position) {
        this.position = position;
    }

}
