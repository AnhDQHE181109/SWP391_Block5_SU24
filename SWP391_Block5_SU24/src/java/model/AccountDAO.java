/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Account;
import java.util.ArrayList;
import java.util.List;
import Util.EncryptionHelper;

public class AccountDAO extends MyDAO {

    public List<Account> getAccounts() {
        String sql = "SELECT * FROM Accounts";
        List<Account> accountList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String hash = rs.getString("Hash");
                String phoneNumber = rs.getString("PhoneNumber");
                String email = rs.getString("Email");
                String address = rs.getString("Address");
                int role = rs.getInt("Role");
                Account account = new Account(accountID, username, hash, phoneNumber, email, address, role);
                accountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountList;
    }

    public Account getAccount(String username) {
        String sql = "SELECT * FROM Accounts WHERE Username = ?";
        Account account = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String email = rs.getString("Email");
                String hash = rs.getString("Hash");
                String phoneNumber = rs.getString("PhoneNumber");
                String address = rs.getString("Address");
                int role = rs.getInt("Role");
                account = new Account(accountID, username, hash, phoneNumber, email, address, role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }

    public int validateAccount(String username, String password, int role) {
        String query = "SELECT * FROM Accounts WHERE Username = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("Hash");
                String storedSalt = rs.getString("Salt");
                String hashedPassword = EncryptionHelper.hashPassword(password, storedSalt);
                if (hashedPassword.equals(storedHash)) {
                    int storedRole = rs.getInt("Role");
                    if (role==1 && storedRole == role) {
                        return 1; // Login successful customer
                    } else if((role==2||role==3)&&role!=1){
                        return 1; //Login successful staff and manager
                    }else{
                        return 2; // Role mismatch
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 3; // Login failed
    }

    public boolean isEmailTaken(String email) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE Email = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isUsernameTaken(String username) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE Email = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isPhoneNumberTaken(String pnum) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE PhoneNumber = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, pnum);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    

    public boolean addAccount(String username, String hash, String phoneNumber, String email, String address, int role) {
        String sql = "INSERT INTO Accounts (Username, Hash, PhoneNumber, Email, Address, Role) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hash);
            ps.setString(3, phoneNumber);
            ps.setString(4, email);
            ps.setString(5, address);
            ps.setInt(6, role);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

