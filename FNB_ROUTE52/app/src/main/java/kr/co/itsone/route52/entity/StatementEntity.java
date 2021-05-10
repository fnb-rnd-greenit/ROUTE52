package kr.co.itsone.route52.entity;

public class StatementEntity {
    private boolean isSelected;
    private String coDiv;
    private String slShop;
    private String slNo;
    private String slTableNo;
    private String slTableName;
    private String gpName;
    private String slTime;
    private String slTotalAmount;
    private String slState;

    public boolean isSelected() {
        return isSelected;
    }

    public void setSelected(boolean selected) {
        isSelected = selected;
    }

    public String getCoDiv() {
        return coDiv;
    }

    public void setCoDiv(String coDiv) {
        this.coDiv = coDiv;
    }

    public String getSlShop() {
        return slShop;
    }

    public void setSlShop(String slShop) {
        this.slShop = slShop;
    }

    public String getSlNo() {
        return slNo;
    }

    public void setSlNo(String slNo) {
        this.slNo = slNo;
    }

    public String getSlTableNo() {
        return slTableNo;
    }

    public void setSlTableNo(String slTableNo) {
        this.slTableNo = slTableNo;
    }

    public String getSlTableName() {
        return slTableName;
    }

    public void setSlTableName(String slTableName) {
        this.slTableName = slTableName;
    }

    public String getGpName() {
        return gpName;
    }

    public void setGpName(String gpName) {
        this.gpName = gpName;
    }

    public String getSlTime() {
        return slTime;
    }

    public void setSlTime(String slTime) {
        this.slTime = slTime;
    }

    public String getSlTotalAmount() {
        return slTotalAmount;
    }

    public void setSlTotalAmount(String slTotalAmount) {
        this.slTotalAmount = slTotalAmount;
    }

    public String getSlState() {
        return slState;
    }

    public void setSlState(String slState) {
        this.slState = slState;
    }
}
