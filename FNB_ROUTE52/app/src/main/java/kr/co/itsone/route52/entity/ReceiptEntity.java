package kr.co.itsone.route52.entity;

import java.util.ArrayList;
import java.util.List;

public class ReceiptEntity {
    private boolean isSelected = false;
    private boolean isChecked = false;
    private String date;
    private String seq;
    private String slNo;
    private String table;
    private String staff;
    private String time;
    private String printYn;
    private List<MenuEntity> menus = new ArrayList<>();

    public boolean isSelected() {
        return isSelected;
    }

    public void setSelected(boolean selected) {
        isSelected = selected;
    }

    public boolean isChecked() {
        return isChecked;
    }

    public void setChecked(boolean checked) {
        isChecked = checked;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getSlNo() {
        return slNo;
    }

    public void setSlNo(String slNo) {
        this.slNo = slNo;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPrintYn() {
        return printYn;
    }

    public void setPrintYn(String printYn) {
        this.printYn = printYn;
    }

    public List<MenuEntity> getMenus() {
        return menus;
    }

    public void setMenus(List<MenuEntity> menus) {
        this.menus = menus;
    }
}
