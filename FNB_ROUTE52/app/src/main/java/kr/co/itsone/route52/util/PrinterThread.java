package kr.co.itsone.route52.util;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.androidquery.AQuery;
import com.androidquery.callback.AjaxCallback;
import com.androidquery.callback.AjaxStatus;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.OrderEntity;

public class PrinterThread extends Thread {

    private BixolonPrinter bxlPrinter = null;
    
    private Context context;
    String coDiv;
    String shop;
    String date;
    String seq;
    private String againYn;
    private String slNo;
    private String table;
    private String user;
    private List<OrderEntity> items;

    public PrinterThread(Context context, String coDiv, String shop, String date, String seq, String againYn, String slNo, String table, String user, List<OrderEntity> items) {
        this.context = context;
        this.coDiv = coDiv;
        this.shop = shop;
        this.date = date;
        this.seq = seq;
        this.againYn = againYn;
        this.slNo = slNo;
        this.table = table;
        this.user = user;
        this.items = items;
    }

    private void sucReceiptPrint() {
        String sUrl = context.getString(R.string.host) + context.getString(R.string.sucReceiptPrint);
        Map<String, Object> params = new HashMap<>();

        params.put("userId", Utils.loadSharedPreferences(context, Globals.IN_ID));
        params.put("coDiv", coDiv);
        params.put("shop", shop);
        params.put("date", date);
        params.put("seq", seq);

        AQuery aq = new AQuery(context);

        AjaxCallback<JSONObject> cb = new AjaxCallback<JSONObject>(){
            @Override
            public void callback(String url, JSONObject jsonObject, AjaxStatus status) {
                try{
                    if(status.getCode() == 200){

                    }
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
        };

        cb.setTimeout(1000);

        aq.ajax(sUrl, params, JSONObject.class, cb);
    }

    @Override
    public void run() {
        try {
            String portType = Utils.loadSharedPreferences(context, Globals.PORT_TYPE);
            String device = Utils.loadSharedPreferences(context, Globals.PRODUCT_NAME);
            String network = Utils.loadSharedPreferences(context, Globals.IP);
            String printYn = Utils.loadSharedPreferences(context, Globals.PRINT_YN);
            int fontSize = Integer.valueOf(Utils.loadSharedPreferences(context, Globals.FONT_SIZE, "1"));
            printYn = printYn.equals("") ? "Y" : printYn;

            bxlPrinter = new BixolonPrinter(context);

            if (bxlPrinter.printerOpen(Integer.valueOf(portType), device, network, true)) {
                String visitInfo = "";

                try {
                    if(!items.get(0).getVisitor().getName().equals("")) {
                        String sVisitor = "";
                        for(int i=0; i<items.size(); i++) {
                            if(i == 0) {
                                sVisitor += items.get(i).getVisitor().getName();
                            } else {
                                sVisitor += ", " + items.get(i).getVisitor().getName();
                            }
                        }

                        visitInfo = String.format("\n내장정보 : %s / %s:%s / %s", items.get(0).getVisitor().getCosNm()
                                , items.get(0).getVisitor().getTime().substring(0, 2), items.get(0).getVisitor().getTime().substring(2, 4)
                                , sVisitor);

                        if(items.get(0).getVisitor().getGpName() != null && !items.get(0).getVisitor().getGpName().equals("")) {
                            visitInfo += "(" + items.get(0).getVisitor().getGpName() + ")";
                        }
                    }
                } catch (Exception e) {
                    visitInfo = "";
                }

                bxlPrinter.beginTransactionPrint();

                if(againYn.equals("Y") || printYn.equals("Y")) {
                    Bitmap img = BitmapFactory.decodeResource(context.getResources(), R.drawable.logo_print);
                    bxlPrinter.printImage(img, 600, bxlPrinter.ALIGNMENT_CENTER, 50);
                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("루트52 주문서", bxlPrinter.ALIGNMENT_CENTER
                            , bxlPrinter.ATTRIBUTE_FONT_A | bxlPrinter.ATTRIBUTE_BOLD, 2);

                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("\n테이블 : " + table, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n주문번호 : " + slNo, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n주문일자 : " + new SimpleDateFormat("yyyy-MM-dd").format(new Date()), bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    if (!visitInfo.equals("")) {
                        bxlPrinter.printText(visitInfo, bxlPrinter.ALIGNMENT_LEFT
                                , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    }

                    bxlPrinter.printText("\n등록자 : " + user, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n상품명                       수량     금액", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    int totalCost = 0;
                    for (int i = 0; i < items.size(); i++) {
                        for (int j = 0; j < items.get(i).getMenues().size(); j++) {
                            String seat = items.get(i).getVisitor().getSeatNo();
                            String name = items.get(i).getMenues().get(j).getPdName();
                            String slGubun = items.get(i).getMenues().get(j).getSaleDiv();
                            if(slGubun.equals("3")) {
                                name = "캐디)" + name;
                            }
                            int cnt = items.get(i).getMenues().get(j).getOrderCnt();
                            String sCnt = String.valueOf(items.get(i).getMenues().get(j).getOrderCnt());
                            int amount;
                            if(items.get(i).getMenues().get(j).isNewYn()) {
                                amount = Math.abs(Integer.valueOf(items.get(i).getMenues().get(j).getSlAmount()));
                            } else {
                                amount = Math.abs(Integer.valueOf(items.get(i).getMenues().get(j).getPdAmount()));
                            }
                            float disc = Float.valueOf(items.get(i).getMenues().get(j).getSlDcRate()) / 100;
                            int cost = cnt * (amount - (int) (amount * disc));
                            String sCost = Utils.moneyDecimalFormat(cost);
                            totalCost += cost;

                            if (name.getBytes("ms949").length > 26) {
                                name = rPad(subString(name, 26), 26);
                            } else {
                                name = rPad(name, 26);
                            }
                            if (sCnt.getBytes("ms949").length > 5) {
                                sCnt = subString(sCnt, 5);
                            } else {
                                sCnt = lPad("  " + sCnt, 5);
                            }
                            if (sCost.getBytes("ms949").length > 11) {
                                sCost = subString(sCost, 11);
                            } else {
                                sCost = lPad(sCost, 11);
                            }

                            bxlPrinter.printText("\n" + name + sCnt + sCost, bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        }
                    }

                    bxlPrinter.printText("\n" + lPad("합계: " + Utils.moneyDecimalFormat(totalCost), 42), bxlPrinter.ALIGNMENT_RIGHT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    String company = Utils.isNullOrEmpty(Utils.loadSharedPreferences(context, Globals.COMPANY_NM), "");
                    String address = Utils.isNullOrEmpty(Utils.loadSharedPreferences(context, Globals.ADDRESS), "");
                    String telNo = Utils.isNullOrEmpty(Utils.loadSharedPreferences(context, Globals.TEL_NO), "");
                    String homepage = Utils.isNullOrEmpty(Utils.loadSharedPreferences(context, Globals.HOMEPAGE), "");

                    if (!company.equals("") || !address.equals("") || !telNo.equals("") || !homepage.equals("")) {
                        bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                                , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        if (!company.equals("")) {
                            bxlPrinter.printText(String.format("\n%s", company), bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        }
                        if (!address.equals("")) {
                            bxlPrinter.printText(String.format("\n%s", address), bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        }
                        if (!telNo.equals("")) {
                            bxlPrinter.printText(String.format("\n%s", telNo), bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        }
                        if (!homepage.equals("")) {
                            bxlPrinter.printText(String.format("\n%s", homepage), bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                        }
                        bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                                , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    }

                    bxlPrinter.printText("주문시간 : " + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()) + "\n", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n\n", 0, 0, 1);

                    bxlPrinter.cutPaper();
                }

                ArrayList<int[]> kitchen = new ArrayList<>();

                for (int i = 0; i < items.size(); i++) {
                    for (int j = 0; j < items.get(i).getMenues().size(); j++) {
                        if (items.get(i).getMenues().get(j).isNewYn() && items.get(i).getMenues().get(j).getPrintYn().equals("Y")) {
                            kitchen.add(new int[]{i, j});
                        }
                    }
                }

                if(kitchen.size() > 0) {
                    bxlPrinter.printText("주방 오더", bxlPrinter.ALIGNMENT_CENTER
                            , bxlPrinter.ATTRIBUTE_FONT_A | bxlPrinter.ATTRIBUTE_BOLD, 2);

                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("\n테이블 : " + table, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 2);
                    bxlPrinter.printText("\n주문번호 : " + slNo, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n주문일자 : " + new SimpleDateFormat("yyyy-MM-dd").format(new Date()), bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    if(!visitInfo.equals("")) {
                        bxlPrinter.printText(visitInfo, bxlPrinter.ALIGNMENT_LEFT
                                , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    }
                    bxlPrinter.printText("\n등록자 : " + user, bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n상품명                       수량     좌석", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, fontSize);
                    bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    for(int[] tmp : kitchen) {
                        String seat = items.get(tmp[0]).getVisitor().getSeatNo();
                        String name = items.get(tmp[0]).getMenues().get(tmp[1]).getPdName();
                        String slGubun = items.get(tmp[0]).getMenues().get(tmp[1]).getSaleDiv();
                        if(slGubun.equals("3")) {
                            name = "캐디)" + name;
                        }
                        String cnt = String.valueOf(items.get(tmp[0]).getMenues().get(tmp[1]).getOrderCnt());
                        String memo = items.get(tmp[0]).getMenues().get(tmp[1]).getMemo();

                        if (name.getBytes("ms949").length > 30) {
                            name = rPad(subString(name, 28), 30);
                        } else {
                            name = rPad(name, 30);
                        }
                        if (cnt.getBytes("ms949").length > 5) {
                            cnt = subString(cnt, 5);
                        } else {
                            cnt = rPad(cnt, 5);
                        }
                        if (seat.getBytes("ms949").length > 5) {
                            seat = subString(seat, 5);
                        } else {
                            seat = lPad("  " + seat, 5);
                        }

                        bxlPrinter.printText("\n" + name + cnt + seat, bxlPrinter.ALIGNMENT_LEFT
                                , bxlPrinter.ATTRIBUTE_FONT_A, fontSize);

                        if(memo != null && !memo.equals("")) {
                            bxlPrinter.printText("\n>>" + memo, bxlPrinter.ALIGNMENT_LEFT
                                    , bxlPrinter.ATTRIBUTE_FONT_A, fontSize);
                        }
                    }
                    bxlPrinter.printText("\n------------------------------------------", bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);

                    bxlPrinter.printText("\n주문시간 : " + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()), bxlPrinter.ALIGNMENT_LEFT
                            , bxlPrinter.ATTRIBUTE_FONT_A, 1);
                    bxlPrinter.printText("\n\n", 0, 0, 1);

                    bxlPrinter.cutPaper();

                }

                sucReceiptPrint();

                bxlPrinter.endTransactionPrint();
            }

            Thread.sleep(1000);

            if(bxlPrinter != null) {
                bxlPrinter.printerClose();
            }
            /*new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                @Override
                public void run() {
                    if(bxlPrinter != null) {
                        bxlPrinter.printerClose();

                    }
                }
            }, 1000);*/
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    private String rPad(String s, int max) throws UnsupportedEncodingException {
        int emptyCnt = max - s.getBytes("ms949").length;
        for(int i=0; i<emptyCnt; i++){
            s += " ";
        }
        return s;
    }

    private String lPad(String s, int max) throws UnsupportedEncodingException{
        int emptyCnt = max - s.getBytes("ms949").length;
        for(int i=0; i<emptyCnt; i++){
            s = " " + s;
        }
        return s;
    }

    private String subString(String s, int max) {
        int DB_FIELD_LENGTH = max;

        Charset charset = Charset.forName("ms949");
        CharsetDecoder cd = charset.newDecoder();

        try {
            byte[] sba = s.getBytes("ms949");
            // Ensure truncating by having byte buffer = DB_FIELD_LENGTH
            ByteBuffer bb = ByteBuffer.wrap(sba, 0, DB_FIELD_LENGTH); // len in [B]
            CharBuffer cb = CharBuffer.allocate(DB_FIELD_LENGTH); // len in [char] <= # [B]
            // Ignore an incomplete character
            cd.onMalformedInput(CodingErrorAction.IGNORE);
            cd.decode(bb, cb, true);
            cd.flush(cb);
            s = new String(cb.array(), 0, cb.position());
        } catch (UnsupportedEncodingException e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }

        return s;
    }
}