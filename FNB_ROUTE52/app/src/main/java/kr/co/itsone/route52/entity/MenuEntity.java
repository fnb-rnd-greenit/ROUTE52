package kr.co.itsone.route52.entity;

import android.os.Parcel;
import android.os.Parcelable;

public class MenuEntity implements Cloneable, Parcelable {
    private boolean newYn = true;
    private String coDiv;
    private String pdShop;
    private String midCode;
    private String midName;
    private String smallCode;
    private String smallName;
    private String slSeq;
    private String pdCd;
    private String pdName;
    private String pdVatYn;
    private String pdVat;
    private String pdCost;
    private String slAmount;
    private String pdAmount;
    private String pdImageUrl;
    private String slDcRate;
    private String saleDiv;
    private String memo = "";
    private String printYn;
    private String slCancel = "N";
    private int slDcRateIdx = 0;
    private int saleDivIdx = 0;
    private int orderCnt = 0;
    private int orderCost = 0;

    public MenuEntity() {

    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    public boolean isNewYn() {
        return newYn;
    }

    public void setNewYn(boolean newYn) {
        this.newYn = newYn;
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

    public String getSlSeq() {
        return slSeq;
    }

    public void setSlSeq(String slSeq) {
        this.slSeq = slSeq;
    }

    public String getPdCd() {
        return pdCd;
    }

    public void setPdCd(String pdCd) {
        this.pdCd = pdCd;
    }

    public String getPdName() {
        return pdName;
    }

    public void setPdName(String pdName) {
        this.pdName = pdName;
    }

    public String getPdVatYn() {
        return pdVatYn;
    }

    public void setPdVatYn(String pdVatYn) {
        this.pdVatYn = pdVatYn;
    }

    public String getPdVat() {
        return pdVat;
    }

    public void setPdVat(String pdVat) {
        this.pdVat = pdVat;
    }

    public String getPdCost() {
        return pdCost;
    }

    public void setPdCost(String pdCost) {
        this.pdCost = pdCost;
    }

    public String getSlAmount() {
        return slAmount;
    }

    public void setSlAmount(String slAmount) {
        this.slAmount = slAmount;
    }

    public String getPdAmount() {
        return pdAmount;
    }

    public void setPdAmount(String pdAmount) {
        this.pdAmount = pdAmount;
    }

    public String getPdImageUrl() {
        return pdImageUrl;
    }

    public void setPdImageUrl(String pdImageUrl) {
        this.pdImageUrl = pdImageUrl;
    }

    public String getSlDcRate() {
        return slDcRate;
    }

    public void setSlDcRate(String slDcRate) {
        this.slDcRate = slDcRate;
    }

    public String getSaleDiv() {
        return saleDiv;
    }

    public void setSaleDiv(String saleDiv) {
        this.saleDiv = saleDiv;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getPrintYn() {
        return printYn;
    }

    public void setPrintYn(String printYn) {
        this.printYn = printYn;
    }

    public String getSlCancel() {
        return slCancel;
    }

    public void setSlCancel(String slCancel) {
        this.slCancel = slCancel;
    }

    public int getSlDcRateIdx() {
        return slDcRateIdx;
    }

    public void setSlDcRateIdx(int slDcRateIdx) {
        this.slDcRateIdx = slDcRateIdx;
    }

    public int getSaleDivIdx() {
        return saleDivIdx;
    }

    public void setSaleDivIdx(int saleDivIdx) {
        this.saleDivIdx = saleDivIdx;
    }

    public int getOrderCnt() {
        return orderCnt;
    }

    public void setOrderCnt(int orderCnt) {
        this.orderCnt = orderCnt;
    }

    public int getOrderCost() {
        return orderCost;
    }

    public void setOrderCost(int orderCost) {
        this.orderCost = orderCost;
    }

    public static final Creator<MenuEntity> CREATOR = new Creator<MenuEntity>() {
        @Override
        public MenuEntity createFromParcel(Parcel in) {
            return new MenuEntity(in);
        }

        @Override
        public MenuEntity[] newArray(int size) {
            return new MenuEntity[size];
        }
    };

    public MenuEntity(Parcel in) {
        newYn = in.readByte() == 1 ? true : false;
        coDiv = in.readString();
        pdShop = in.readString();
        midCode = in.readString();
        midName = in.readString();
        smallCode = in.readString();
        smallName = in.readString();
        pdCd = in.readString();
        pdName = in.readString();
        pdVatYn = in.readString();
        pdVat = in.readString();
        pdCost = in.readString();
        slAmount = in.readString();
        pdAmount = in.readString();
        pdImageUrl = in.readString();
        slDcRate = in.readString();
        saleDiv = in.readString();
        memo = in.readString();
        printYn = in.readString();
        slCancel = in.readString();
        slDcRateIdx = in.readInt();
        saleDivIdx = in.readInt();
        orderCnt = in.readInt();
        orderCost = in.readInt();
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int i) {
        dest.writeByte((byte) (newYn ? 1 : 0));
        dest.writeString(coDiv);
        dest.writeString(pdShop);
        dest.writeString(midCode);
        dest.writeString(midName);
        dest.writeString(smallCode);
        dest.writeString(smallName);
        dest.writeString(pdCd);
        dest.writeString(pdName);
        dest.writeString(pdVatYn);
        dest.writeString(pdVat);
        dest.writeString(pdCost);
        dest.writeString(slAmount);
        dest.writeString(pdAmount);
        dest.writeString(pdImageUrl);
        dest.writeString(slDcRate);
        dest.writeString(saleDiv);
        dest.writeString(memo);
        dest.writeString(printYn);
        dest.writeString(slCancel);
        dest.writeInt(slDcRateIdx);
        dest.writeInt(saleDivIdx);
        dest.writeInt(orderCnt);
        dest.writeInt(orderCost);
    }
}
