package net.soc;

import java.util.Date;

/**
 *
 * @author TireX
 */
public class Post {
    private int id;
    private int authorId;
    private String authorName;
    private String authorPhoto;
    private String date;
    private String text;
    
    public Post(int id, int authorId, String authorName, String authorPhoto, String date, String text) {
        this.id = id;
        this.authorId = authorId;
        this.authorName = authorName;
        this.authorPhoto = authorPhoto;
        this.date = date;
        this.text = text;
    }

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
     * @return the authorId
     */
    public int getAuthorId() {
        return authorId;
    }

    /**
     * @param authorId the authorId to set
     */
    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    /**
     * @return the authorName
     */
    public String getAuthorName() {
        return authorName;
    }

    /**
     * @param authorName the authorName to set
     */
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    /**
     * @return the authorPhoto
     */
    public String getAuthorPhoto() {
        return (authorPhoto != null && !authorPhoto.equals("")) ? authorPhoto : "def.jpg";
    }

    /**
     * @param authorPhoto the authorPhoto to set
     */
    public void setAuthorPhoto(String authorPhoto) {
        this.authorPhoto = authorPhoto;
    }

    /**
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(String date) {
        this.date = date;
    }

    /**
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }
}
