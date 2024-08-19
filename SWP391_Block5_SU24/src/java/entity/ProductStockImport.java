/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

public class ProductStockImport {
    private int importID;
    private int accountID;
    private Date importDate;
    private  int ImportAction ; 
    private String Actorname ; 

    public ProductStockImport() {
    }

    public ProductStockImport(int importID, int accountID, Date importDate, int ImportAction, String Actorname) {
        this.importID = importID;
        this.accountID = accountID;
        this.importDate = importDate;
        this.ImportAction = ImportAction;
        this.Actorname = Actorname;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public int getImportAction() {
        return ImportAction;
    }

    public void setImportAction(int ImportAction) {
        this.ImportAction = ImportAction;
    }

    public String getActorname() {
        return Actorname;
    }

    public void setActorname(String Actorname) {
        this.Actorname = Actorname;
    }

    @Override
    public String toString() {
        return "ProductStockImport{" + "importID=" + importID + ", accountID=" + accountID + ", importDate=" + importDate + ", ImportAction=" + ImportAction + ", Actorname=" + Actorname + '}';
    }

  

    
}