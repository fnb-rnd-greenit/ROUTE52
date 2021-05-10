package kr.co.itsone.route52.entity;

public class MenuDivisionEntity implements Cloneable {
    private boolean isSelected = false;
    private String coDiv;
    private String pdShop;
    private String midCode;
    private String midName;
    private String smallCode;
    private String smallName;

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

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

    public String getPdShop() {
        return pdShop;
    }

    public void setPdShop(String pdShop) {
        this.pdShop = pdShop;
    }

    public String getMidCode() {
        return midCode;
    }

    public void setMidCode(String midCode) {
        this.midCode = midCode;
    }

    public String getMidName() {
        return midName;
    }

    public void setMidName(String midName) {
        this.midName = midName;
    }

    public String getSmallCode() {
        return smallCode;
    }

    public void setSmallCode(String smallCode) {
        this.smallCode = smallCode;
    }

    public String getSmallName() {
        return smallName;
    }

    public void setSmallName(String smallName) {
        this.smallName = smallName;
    }
}
