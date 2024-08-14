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
                String salt = rs.getString("Salt");
                Account account = new Account(accountID, username, hash, phoneNumber, email, address, salt, role);
                accountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountList;
    }
    
    public List<Account> getAccountsByRole(int role) {
    String sql = "SELECT * FROM Accounts WHERE Role = ?";
    List<Account> accountList = new ArrayList<>();
    try {
        ps = con.prepareStatement(sql);
        ps.setInt(1, role);
        rs = ps.executeQuery();
        while (rs.next()) {
            int accountID = rs.getInt("AccountID");
            String username = rs.getString("Username");
            String hash = rs.getString("Hash");
            String phoneNumber = rs.getString("PhoneNumber");
            String email = rs.getString("Email");
            String address = rs.getString("Address");
            String salt = rs.getString("Salt");
            Account account = new Account(accountID, username, hash, phoneNumber, email, address, salt, role);
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
                String salt = rs.getString("Salt");
                account = new Account(accountID, username, hash, phoneNumber, email, address, salt, role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }
    public Account getAccountbyEmail(String email) {
        String sql = "SELECT * FROM Accounts WHERE Email = ?";
        Account account = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String hash = rs.getString("Hash");
                String phoneNumber = rs.getString("PhoneNumber");
                String address = rs.getString("Address");
                int role = rs.getInt("Role");
                String salt = rs.getString("Salt");
                account = new Account(accountID, username, hash, phoneNumber, email, address, salt, role);
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
                    if (role == 1 && storedRole == role) {
                        return 1; // Login successful customer
                    } else if ((storedRole == 2 || storedRole == 3) && role != 1) {
                        return 1; //Login successful staff and manager
                    } else {
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

    public boolean addAccount(String username, String hash, String phoneNumber, String email, String address, int role, String salt) {
        String sql = "INSERT INTO Accounts (Username, Hash, PhoneNumber, Email, Address, Role, Salt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hash);
            ps.setString(3, phoneNumber);
            ps.setString(4, email);
            ps.setString(5, address);
            ps.setInt(6, role);
            ps.setString(7, salt);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
public boolean updateAccount(int accountId, String newEmail, String newPhoneNumber, String newAddress) {
    String sql = "UPDATE Accounts SET Email = ?, PhoneNumber = ?, Address = ? WHERE AccountID = ?";
    try {
        ps = con.prepareStatement(sql);
        ps.setString(1, newEmail);
        ps.setString(2, newPhoneNumber);
        ps.setString(3, newAddress);
        ps.setInt(4, accountId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public void changePassword(String email, String newpass, String salt) {
        String sql = "UPDATE Accounts SET Hash = ?, Salt = ? WHERE Email = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, newpass);
            ps.setString(2, salt);
            ps.setString(3, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   public String getUsernameByAccountID(int accountID) {
        String username = null;
        String sql = "SELECT username FROM Accounts WHERE accountID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                username = rs.getString("username");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return username;
    }

   // Tìm accountID theo username, có thể nhập một vài ký tự ở bất kỳ vị trí nào
    public List<Integer> findAccountIDsByUsername(String usernamePattern) throws Exception {
        List<Integer> accountIDs = new ArrayList<>();
        String query = "SELECT accountID FROM Accounts WHERE username LIKE ?";
        
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + usernamePattern + "%"); // Thêm '%' vào cả đầu và cuối
            rs = ps.executeQuery();
            
            while (rs.next()) {
                accountIDs.add(rs.getInt("accountID"));
            }
        } finally {
            // Đảm bảo đóng ResultSet, PreparedStatement
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
        
        return accountIDs;
    }
    
       public String getAdressByAccountID(int accountID) {
        String username = null;
        String sql = "SELECT [Address] FROM Accounts WHERE accountID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                username = rs.getString("Address");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return username;
    }
       
              public String getPhoneByAccountID(int accountID) {
        String username = null;
        String sql = "SELECT [PhoneNumber] FROM Accounts WHERE accountID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                username = rs.getString("PhoneNumber");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return username;
    }
    
}
