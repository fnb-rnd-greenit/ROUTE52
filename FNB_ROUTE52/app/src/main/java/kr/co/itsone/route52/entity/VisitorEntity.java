package kr.co.itsone.route52.entity;

import android.os.Parcel;
import android.os.Parcelable;

public class VisitorEntity implements Cloneable, Parcelable {
    private boolean isSelected = false;
    private boolean isLock = false;
    private String coDiv;
    private String chkInNo;
    private String day;
    private String cos;
    private String cosNm;
    private String time;
    private String name;
    private String locker;
    private String gpNum;
    private String gpName;
    private String msNum;
    private String part;
    private String bkName;
    private String caddyNum;
    private String cyName;
    private String cartNo;
    private String seatNo = "1";

    public VisitorEntity() {
    }

    public void setVisitorEntity(VisitorEntity visitor) {
        this.isSelected = visitor.isSelected;
        this.isLock = visitor.isLock;
        this.coDiv = visitor.coDiv;
        this.chkInNo = visitor.chkInNo;
        this.day = visitor.day;
        this.cos = visitor.cos;
        this.cosNm = visitor.cosNm;
        this.time = visitor.time;
        this.name = visitor.name;
        this.locker = visitor.locker;
        this.gpNum = visitor.gpNum;
        this.gpName = visitor.gpName;
        this.msNum = visitor.msNum;
        this.part = visitor.part;
        this.bkName = visitor.bkName;
        this.caddyNum = visitor.caddyNum;
        this.cyName = visitor.cyName;
        this.cartNo = visitor.cartNo;
    }

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

    public boolean isLock() {
        return isLock;
    }

    public void setLock(boolean lock) {
        isLock = lock;
    }

    public String getCoDiv() {
        return coDiv;
    }

    public void setCoDiv(String coDiv) {
        this.coDiv = coDiv;
    }

    public String getChkInNo() {
        return chkInNo;
    }

    public void setChkInNo(String chkInNo) {
        this.chkInNo = chkInNo;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getCos() {
        return cos;
    }

    public void setCos(String cos) {
        this.cos = cos;
    }

    public String getCosNm() {
        return cosNm;
    }

    public void setCosNm(String cosNm) {
        this.cosNm = cosNm;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocker() {
        return locker;
    }

    public void setLocker(String locker) {
        this.locker = locker;
    }

    public String getGpNum() {
        return gpNum;
    }

    public void setGpNum(String gpNum) {
        this.gpNum = gpNum;
    }

    public String getGpName() {
        return gpName;
    }

    public void setGpName(String gpName) {
        this.gpName = gpName;
    }

    public String getMsNum() {
        return msNum;
    }

    public void setMsNum(String msNum) {
        this.msNum = msNum;
    }

    public String getPart() {
        return part;
    }

    public void setPart(String part) {
        this.part = part;
    }

    public String getBkName() {
        return bkName;
    }

    public void setBkName(String bkName) {
        this.bkName = bkName;
    }

    public String getCaddyNum() {
        return caddyNum;
    }

    public void setCaddyNum(String caddyNum) {
        this.caddyNum = caddyNum;
    }

    public String getCyName() {
        return cyName;
    }

    public void setCyName(String cyName) {
        this.cyName = cyName;
    }

    public String getCartNo() {
        return cartNo;
    }

    public void setCartNo(String cartNo) {
        this.cartNo = cartNo;
    }

    public String getSeatNo() {
        return seatNo;
    }

    public void setSeatNo(String seatNo) {
        this.seatNo = seatNo;
    }

    public static final Creator<VisitorEntity> CREATOR = new Creator<VisitorEntity>() {
        @Override
        public VisitorEntity createFromParcel(Parcel in) {
            return new VisitorEntity(in);
        }

        @Override
        public VisitorEntity[] newArray(int size) {
            return new VisitorEntity[size];
        }
    };

    public VisitorEntity(Parcel in) {
        isSelected = in.readByte() == 1;
        isLock = in.readByte() == 1;

        coDiv = in.readString();
        chkInNo = in.readString();
        day = in.readString();
        cos = in.readString();
        cosNm = in.readString();
        time = in.readString();
        name = in.readString();
        locker = in.readString();
        gpNum = in.readString();
        gpName = in.readString();
        msNum = in.readString();
        part = in.readString();
        bkName = in.readString();
        caddyNum = in.readString();
        cyName = in.readString();
        cartNo = in.readString();
        seatNo = in.readString();
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int i) {
        dest.writeByte((byte) (isSelected ? 1 : 0));
        dest.writeByte((byte) (isLock ? 1 : 0));
        dest.writeString(coDiv);
        dest.writeString(chkInNo);
        dest.writeString(day);
        dest.writeString(cos);
        dest.writeString(cosNm);
        dest.writeString(time);
        dest.writeString(name);
        dest.writeString(locker);
        dest.writeString(gpNum);
        dest.writeString(gpName);
        dest.writeString(msNum);
        dest.writeString(part);
        dest.writeString(bkName);
        dest.writeString(caddyNum);
        dest.writeString(cyName);
        dest.writeString(cartNo);
        dest.writeString(seatNo);
    }
}
