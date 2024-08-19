
package entity;

public class Brand {
    private int brandId;
    private String brandName;
    private int brandstatus ; 

    public Brand() {
    }

    public Brand(int brandId, String brandName, int brandstatus) {
        this.brandId = brandId;
        this.brandName = brandName;
        this.brandstatus = brandstatus;
    }


    public int getBrandId() {
        return brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public int getBrandstatus() {
        return brandstatus;
    }

    public void setBrandstatus(int brandstatus) {
        this.brandstatus = brandstatus;
    }

    @Override
    public String toString() {
        return "Brand{" + "brandId=" + brandId + ", brandName=" + brandName + ", brandstatus=" + brandstatus + '}';
    }

    

}