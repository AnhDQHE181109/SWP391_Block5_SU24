/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author asus
 */
public class Size {
    private int sizeId;
    private int size_int;

    public Size() {
    }

    public Size(int sizeId, int size_int) {
        this.sizeId = sizeId;
        this.size_int = size_int;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getSize_int() {
        return size_int;
    }

    public void setSize_int(int size_int) {
        this.size_int = size_int;
    }
    
    
    
}
