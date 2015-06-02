/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package net.soc;

/**
 *
 * @author TireX
 */
public class ChatDescription {
    private int chatID;
    private String date;
    private int membersCount = 2;
    private int receiverID;
    private String receiverName;
    private String receiverPhoto;
    private String lastMessage;
    private String photoLastMessage;

    /**
     * @return the receiverName
     */
    public String getReceiverName() {
        return receiverName;
    }

    /**
     * @param receiverName the receiverName to set
     */
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    /**
     * @return the receiverPhoto
     */
    public String getReceiverPhoto() {
        return (membersCount > 2) ? "group.png" : (receiverPhoto != null && !receiverPhoto.equals("")) ? receiverPhoto : "def.jpg";
    }

    /**
     * @param receiverPhoto the receiverPhoto to set
     */
    public void setReceiverPhoto(String receiverPhoto) {
        this.receiverPhoto = receiverPhoto;
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
     * @return the membersCount
     */
    public int getMembersCount() {
        return membersCount;
    }

    /**
     * @param membersCount the membersCount to set
     */
    public void setMembersCount(int membersCount) {
        this.membersCount = membersCount;
    }

    /**
     * @return the lastMessage
     */
    public String getLastMessage() {
        return lastMessage;
    }

    /**
     * @param lastMessage the lastMessage to set
     */
    public void setLastMessage(String lastMessage) {
        this.lastMessage = lastMessage;
    }

    /**
     * @return the photoLastMessage
     */
    public String getPhotoLastMessage() {
        return (photoLastMessage != null && !photoLastMessage.equals("")) ? photoLastMessage : "def.jpg";
    }

    /**
     * @param photoLastMessage the photoLastMessage to set
     */
    public void setPhotoLastMessage(String photoLastMessage) {
        this.photoLastMessage = photoLastMessage;
    }

    /**
     * @return the chatID
     */
    public int getChatID() {
        return chatID;
    }

    /**
     * @param chatID the chatID to set
     */
    public void setChatID(int chatID) {
        this.chatID = chatID;
    }

    /**
     * @return the receiverID
     */
    public int getReceiverID() {
        return receiverID;
    }

    /**
     * @param receiverID the receiverID to set
     */
    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }
    
    
}
