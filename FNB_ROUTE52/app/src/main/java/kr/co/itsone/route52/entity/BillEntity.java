package kr.co.itsone.route52.entity;

import android.os.Parcel;
import android.os.Parcelable;

public class BillEntity implements Parcelable {
    private boolean isSelected = false;
    private String coDiv;
    private String slShop;
    private String slDiv;
    private String slTableNo;
    private String slTableName;
    private String slDay;
    private String slCos;
    private String slCosNm;
    private String slTime;
    private String slEnName;
    private String enChkinno;
    private String slNo;
    private String slPayDiv;
    private String slTotalAmount;
    private String slTablePerson;
    private String slRound;
    private String bkName;
    private String menuList;
    private String menuNList;
    private String cartNo;
    private String orderTime;
    private String arrivalTime;
    private String orderId;
    private String sendYn;
    private String slState;

    public BillEntity() {
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

    public String getSlShop() {
        return slShop;
    }

    public void setSlShop(String slShop) {
        this.slShop = slShop;
    }

    public String getSlDiv() {
        return slDiv;
    }

    public void setSlDiv(String slDiv) {
        this.slDiv = slDiv;
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

    public String getSlDay() {
        return slDay;
    }

    public void setSlDay(String slDay) {
        this.slDay = slDay;
    }

    public String getSlCos() {
        return slCos;
    }

    public void setSlCos(String slCos) {
        this.slCos = slCos;
    }

    public String getSlCosNm() {
        return slCosNm;
    }

    public void setSlCosNm(String slCosNm) {
        this.slCosNm = slCosNm;
    }

    public String getSlTime() {
        return slTime;
    }

    public void setSlTime(String slTime) {
        this.slTime = slTime;
    }

    public String getSlEnName() {
        return slEnName;
    }

    public void setSlEnName(String slEnName) {
        this.slEnName = slEnName;
    }

    public String getEnChkinno() {
        return enChkinno;
    }

    public void setEnChkinno(String enChkinno) {
        this.enChkinno = enChkinno;
    }

    public String getSlNo() {
        return slNo;
    }

    public void setSlNo(String slNo) {
        this.slNo = slNo;
    }

    public String getSlPayDiv() {
        return slPayDiv;
    }

    public void setSlPayDiv(String slPayDiv) {
        this.slPayDiv = slPayDiv;
    }

    public String getSlTotalAmount() {
        return slTotalAmount;
    }

    public void setSlTotalAmount(String slTotalAmount) {
        this.slTotalAmount = slTotalAmount;
    }

    public String getSlTablePerson() {
        return slTablePerson;
    }

    public void setSlTablePerson(String slTablePerson) {
        this.slTablePerson = slTablePerson;
    }

    public String getSlRound() {
        return slRound;
    }

    public void setSlRound(String slRound) {
        this.slRound = slRound;
    }

    public String getBkName() {
        return bkName;
    }

    public void setBkName(String bkName) {
        this.bkName = bkName;
    }

    public String getMenuList() {
        return menuList;
    }

    public void setMenuList(String menuList) {
        this.menuList = menuList;
    }

    public String getMenuNList() {
        return menuNList;
    }

    public void setMenuNList(String menuNList) {
        this.menuNList = menuNList;
    }

    public String getCartNo() {
        return cartNo;
    }

    public void setCartNo(String cartNo) {
        this.cartNo = cartNo;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getSendYn() {
        return sendYn;
    }

    public void setSendYn(String sendYn) {
        this.sendYn = sendYn;
    }

    public String getSlState() {
        return slState;
    }

    public void setSlState(String slState) {
        this.slState = slState;
    }

    public static final Creator<BillEntity> CREATOR = new Creator<BillEntity>() {
        @Override
        public BillEntity createFromParcel(Parcel in) {
            return new BillEntity(in);
        }

        @Override
        public BillEntity[] newArray(int size) {
            return new BillEntity[size];
        }
    };

    public BillEntity(Parcel in) {
        if (in.readByte() == 1) {
            isSelected = true;
        } else {
            isSelected = false;
        }

        coDiv = in.readString();
        slShop = in.readString();
        slDiv = in.readString();
        slTableNo = in.readString();
        slTableName = in.readString();
        slDay = in.readString();
        slCos = in.readString();
        slTime = in.readString();
        slEnName = in.readString();
        enChkinno = in.readString();
        slNo = in.readString();
        slPayDiv = in.readString();
        slTotalAmount = in.readString();
        slTablePerson = in.readString();
        slRound = in.readString();
        orderId = in.readString();
        slState = in.readString();
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int i) {
        dest.writeByte((byte) (isSelected ? 1 : 0));
        dest.writeString(coDiv);
        dest.writeString(slShop);
        dest.writeString(slDiv);
        dest.writeString(slTableNo);
        dest.writeString(slTableName);
        dest.writeString(slDay);
        dest.writeString(slCos);
        dest.writeString(slTime);
        dest.writeString(slEnName);
        dest.writeString(enChkinno);
        dest.writeString(slNo);
        dest.writeString(slPayDiv);
        dest.writeString(slTotalAmount);
        dest.writeString(slTablePerson);
        dest.writeString(slRound);
        dest.writeString(orderId);
        dest.writeString(slState);
    }
}
