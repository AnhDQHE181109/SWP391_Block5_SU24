/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Long
 */
public class Account {
    private int accountID;
    private String username;
    private String hash;
    private String phoneNumber;
    private String email;
    private String address;
    private String salt;
    private int role;
    private boolean status;
    private String fullname;
    private String name;

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Account(int accountID, String username, String hash, String phoneNumber, String email, String address, String salt, int role, boolean status, String fullname) {
        this.accountID = accountID;
        this.username = username;
        this.hash = hash;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.salt = salt;
        this.role = role;
        this.status = status;
        this.fullname = fullname;
    }
    
    public Account(int accountID, String username, String hash, String phoneNumber, String email, String address, String salt, int role) {
        this.accountID = accountID;
        this.username = username;
        this.hash = hash;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.salt = salt;
        this.role = role;
    }

    public Account(int accountID, String username, String hash, String phoneNumber, String email, String address, String salt, int role, boolean status) {
        this.accountID = accountID;
        this.username = username;
        this.hash = hash;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.salt = salt;
        this.role = role;
        this.status = status;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Account() {
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    
    public void setStatus(Boolean status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "Account{" + "accountID=" + accountID + ", username=" + username + ", hash=" + hash + ", phoneNumber=" + phoneNumber + ", email=" + email + ", address=" + address + ", salt=" + salt + ", role=" + role + ", status=" + status + ", fullname=" + fullname + '}';
    }
    public String displayPnum(){
    int length = this.phoneNumber.length();
    String maskedNumber = "*".repeat(length - 2) + this.phoneNumber.substring(length - 2);
    return maskedNumber;
    }
}