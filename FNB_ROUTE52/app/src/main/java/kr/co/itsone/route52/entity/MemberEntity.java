package kr.co.itsone.route52.entity;

public class MemberEntity {
    private String msNum;
    private String msName;
    private String msMemDiv;
    private String msLikelihood;

    public String getMsNum() {
        return msNum;
    }

    public void setMsNum(String msNum) {
        this.msNum = msNum;
    }

    public String getMsName() {
        return msName;
    }

    public void setMsName(String msName) {
        this.msName = msName;
    }

    public String getMsMemDiv() {
        return msMemDiv;
    }

    public void setMsMemDiv(String msMemDiv) {
        this.msMemDiv = msMemDiv;
    }

    public String getMsLikelihood() {
        return msLikelihood;
    }

    public void setMsLikelihood(String msLikelihood) {
        this.msLikelihood = msLikelihood;
    }
}
