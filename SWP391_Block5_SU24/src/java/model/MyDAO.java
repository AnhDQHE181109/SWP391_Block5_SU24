/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author xeban
 */
public class MyDAO extends DBConnect {
  public Connection con = null;
  public PreparedStatement ps = null;
  public ResultSet rs = null;
  public String xSql = null;

  public MyDAO() {
     con = conn;
  }
  
  
  public void finalize() {
     try {
        if(con != null) con.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
  }
  
  

}
