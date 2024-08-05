package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    public Connection conn = null;
    
    public DBConnect(String url, String user, String password){
        try{
            //driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //connection
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("connected");
        }
        catch(ClassNotFoundException ex){
            ex.printStackTrace();
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
    }
    
    public DBConnect(){
        this("jdbc:sqlserver://localhost:1433;databaseName=ECommerceStore", "sa", "sa");
    }
    
    public static void main(String[] args){
        new DBConnect();
    }
}
