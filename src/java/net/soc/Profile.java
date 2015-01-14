/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package net.soc;

import java.util.Date;

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
}
