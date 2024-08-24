/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Long
 */
import java.util.Date;

public class NotificationAlert {

    private int notiID;
    private int accountID;
    private Date notiDate;
    private String notiMessage;
    private boolean notiStatus;
    private String notiPath;

    // Constructor
    public NotificationAlert(int notiID, int accountID, Date notiDate, String notiMessage, boolean notiStatus, String notiPath) {
        this.notiID = notiID;
        this.accountID = accountID;
        this.notiDate = notiDate;
        this.notiMessage = notiMessage;
        this.notiStatus = notiStatus;
        this.notiPath = notiPath;
    }

    // Getters and Setters
    public int getNotiID() {
        return notiID;
    }

    public void setNotiID(int notiID) {
        this.notiID = notiID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public Date getNotiDate() {
        return notiDate;
    }

    public void setNotiDate(Date notiDate) {
        this.notiDate = notiDate;
    }

    public String getNotiMessage() {
        return notiMessage;
    }

    public void setNotiMessage(String notiMessage) {
        this.notiMessage = notiMessage;
    }

    public boolean isNotiStatus() {
        return notiStatus;
    }

    public void setNotiStatus(boolean notiStatus) {
        this.notiStatus = notiStatus;
    }

    public String getNotiPath() {
        return notiPath;
    }

    public void setNotiPath(String notiPath) {
        this.notiPath = notiPath;
    }

    @Override
    public String toString() {
        return "NotificationAlert{"
                + "notiID=" + notiID
                + ", accountID=" + accountID
                + ", notiDate=" + notiDate
                + ", notiMessage='" + notiMessage + '\''
                + ", notiStatus=" + notiStatus
                + ", notiPath='" + notiPath + '\''
                + '}';
    }
}
