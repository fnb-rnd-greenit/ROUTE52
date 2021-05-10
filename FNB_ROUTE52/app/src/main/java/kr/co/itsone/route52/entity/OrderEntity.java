package kr.co.itsone.route52.entity;

import java.util.ArrayList;

public class OrderEntity {
    private VisitorEntity visitor = new VisitorEntity();
    private ArrayList<MenuEntity> menues = new ArrayList<>();

    public VisitorEntity getVisitor() {
        return visitor;
    }

    public void setVisitor(VisitorEntity visitor) {
        String seat = this.visitor.getSeatNo();
        this.visitor = visitor;
        this.visitor.setSeatNo(seat);
    }

    public ArrayList<MenuEntity> getMenues() {
        return menues;
    }

    public void setMenues(ArrayList<MenuEntity> menus) {
        this.menues.addAll(menus);
    }
}
