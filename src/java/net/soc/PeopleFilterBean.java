package net.soc;

import java.util.ArrayList;

/**
 *
 * @author TireX
 */
public class PeopleFilterBean {
    private String partname;
    private String position;
    private String country;
    private String city;

    public String getFilteredPeople() {
        ArrayList<Profile> list = People.loadFilteredPeople(partname, position, country, city);
        if (list != null && !list.isEmpty()) {
            String res = "";
            for (Profile p : list) {
                res += ", " + profileToJSONObject(p);
            }
            return "{\"ok\": \"true\", \"people\":["+ res.substring(1, res.length()) +"]}";
        } else {
            return "{\"ok\": \"false\"}";
        }
    }

    private String profileToJSONObject(Profile p) {
        return "{\"id\":"+ p.getId() +", \"name\":\""+ p.getName() +"\", \"photo\":\""+ p.getPhoto() +"\", \"position\":\""+ p.getPosition() +"\", \"birthday\":\""+ p.getBirthday() +"\", \"location\":\""+ p.getLocation() +"\"}";
    }
    
    /**
     * @return the partname
     */
    public String getPartname() {
        return partname;
    }

    /**
     * @param partname the partname to set
     */
    public void setPartname(String partname) {
        this.partname = partname;
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
}
