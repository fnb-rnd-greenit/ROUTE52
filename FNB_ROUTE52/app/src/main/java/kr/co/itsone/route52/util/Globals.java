package kr.co.itsone.route52.util;

import java.util.ArrayList;
import java.util.List;

import kr.co.itsone.route52.entity.CompanyEntity;
import kr.co.itsone.route52.entity.CosEntity;
import kr.co.itsone.route52.entity.DiscountEntity;
import kr.co.itsone.route52.entity.MenuDivisionEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.SaleDivEntity;
import kr.co.itsone.route52.entity.ShopEntity;

public class Globals {
    public static final String PORT_TYPE = "portType";
    public static final String PRODUCT_NAME = "device";
    public static final String IP = "ip";
    public static final String COMPANY_NM = "COMPANY_NM";
    public static final String ADDRESS = "address";
    public static final String TEL_NO = "telNo";
    public static final String HOMEPAGE = "homepage";
    public static final String PRINT_YN = "printYn";
    public static final String RELAY_YN = "relayYn";
    public static final String FONT_SIZE = "fontSize";

    public static final String IN_ID = "IN_ID";
    public static final String IN_PW = "IN_PW";
    public static final String IN_NAME = "IN_NAME";
    public static final String AUTO_LOGIN = "AUTO_LOGIN";
    public static final String COMPANY_IDX = "COMPANY_IDX";
    public static final String COMPANY = "COMPANY";
    public static final String SHOP_IDX = "SHOP_IDX";
    public static final String SHOP = "SHOP";

    public static final String CO_DIV = "CO_DIV";
    public static final String CO_DIV_NM = "CO_DIV_NM";

    //다운로드 데이터
    public static List<CompanyEntity> mCompanys = new ArrayList<>();
    public static List<CosEntity> mCoses = new ArrayList<>();
    public static List<ShopEntity> mShops = new ArrayList<>();
    public static List<DiscountEntity> mDiscounts = new ArrayList<>();
    public static List<SaleDivEntity> mSaleDivs = new ArrayList<>();
    public static List<MenuDivisionEntity> mMenuDivs = new ArrayList<>();
    public static List<MenuEntity> mMenus = new ArrayList<>();
}
