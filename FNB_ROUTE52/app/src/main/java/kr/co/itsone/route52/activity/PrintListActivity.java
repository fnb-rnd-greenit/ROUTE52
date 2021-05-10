package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.ReceiptAdapter;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.OrderEntity;
import kr.co.itsone.route52.entity.ReceiptEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class PrintListActivity extends AppCompatActivity {

    private SwipeRefreshLayout mSwipe;

    private ReceiptAdapter mAdapter;
    private List<ReceiptEntity> mReceipts = new ArrayList<>();
    private RecyclerView mList;

    private int selIdx = -1;

    private ImageView chkPrint;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_print_list);

        init();
    }

    private void init() {
        TextView txtTitle = findViewById(R.id.txt_action_title);
        ImageView btnMemo = findViewById(R.id.btn_action_memo);

        String shop = Utils.loadSharedPreferences(this, Globals.SHOP);

        String coDiv = Utils.loadSharedPreferences(PrintListActivity.this, Globals.CO_DIV);
        String coDivNM = Utils.loadSharedPreferences(PrintListActivity.this, Globals.CO_DIV_NM);
        String shopNm = "";

        for(int i=0; i<Globals.mShops.size(); i++) {
            if(Globals.mShops.get(i).getCoDiv().equals(coDiv) && Globals.mShops.get(i).getCode().equals(shop)) {
                shopNm = Globals.mShops.get(i).getName();
            }
        }

        txtTitle.setText(coDivNM + " - " + shopNm);
        btnMemo.setVisibility(View.VISIBLE);

        btnMemo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MemoDialog dialog = new MemoDialog(PrintListActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });

        findViewById(R.id.btn_print_exit).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        findViewById(R.id.btn_print_cancel).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cancelReceipt();
            }
        });

        mList = findViewById(R.id.list_print_list);
        mList.setLayoutManager(new LinearLayoutManager(PrintListActivity.this));

        mAdapter = new ReceiptAdapter(PrintListActivity.this, mReceipts, new ReceiptAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                if(selIdx != -1) {
                    mReceipts.get(selIdx).setSelected(false);
                }

                selIdx = idx;

                mReceipts.get(selIdx).setSelected(true);

                if(!mReceipts.get(idx).getPrintYn().equals("Y")) {
                    mReceipts.get(idx).setChecked(!mReceipts.get(idx).isChecked());
                }

                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onDoubleClicked(int idx) {
                getOrder(idx);
            }

            @Override
            public void onLongClicked(int idx) {
                if(selIdx != -1) {
                    mReceipts.get(selIdx).setSelected(false);
                }

                selIdx = idx;

                mReceipts.get(selIdx).setSelected(true);

                mAdapter.notifyDataSetChanged();

                getOrder(idx);
            }
        });

        mList.setAdapter(mAdapter);

        mSwipe = findViewById(R.id.swipe_print_list);

        mSwipe.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                getReceiptList();

                mSwipe.setRefreshing(false);
            }
        });

        chkPrint = findViewById(R.id.chk_print_all);
        chkPrint.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                chkPrint.setSelected(!chkPrint.isSelected());

                for(int i=0; i<mReceipts.size(); i++) {
                    if(!mReceipts.get(i).getPrintYn().equals("Y")) {
                        mReceipts.get(i).setChecked(chkPrint.isSelected());
                    }
                }

                mAdapter.notifyDataSetChanged();
            }
        });

        getReceiptList();
    }

    private void cancelReceipt() {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.cancelReceipt);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(PrintListActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(PrintListActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(PrintListActivity.this, Globals.IN_ID));

            JSONArray data = new JSONArray();

            for (ReceiptEntity tmp : mReceipts) {
                JSONObject obj = new JSONObject();

                if(tmp.isChecked()) {
                    obj.put("date", tmp.getDate());
                    obj.put("seq", tmp.getSeq());
                }

                data.put(obj);
            }

            params.put("data", data.toString());

            new AQueryUtil(PrintListActivity.this, sUrl, params, true, "알림", "조회 중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(Utils.isNullOrEmpty(jsonObject.getString("resultCode"), "9999").equals("0000")) {
                            chkPrint.setSelected(false);

                            AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), "출력이 취소되었습니다.", new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    getReceiptList();
                                }
                            });
                        } else {
                            AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), Utils.isNullOrEmpty(jsonObject.getString("resultMessage"), ""), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });
        } catch(Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    private void getReceiptList() {
        mReceipts.clear();

        String sUrl = getString(R.string.host) + getString(R.string.getReceiptList);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", Utils.loadSharedPreferences(PrintListActivity.this, Globals.COMPANY));
        params.put("shop", Utils.loadSharedPreferences(PrintListActivity.this, Globals.SHOP));

        new AQueryUtil(PrintListActivity.this, sUrl, params, true, "알림", "조회 중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        ReceiptEntity entity = new ReceiptEntity();

                        entity.setDate(Utils.isNullOrEmpty(obj.getString("FB_DATE"), ""));
                        entity.setSeq(Utils.isNullOrEmpty(obj.getString("FB_SEQ"), ""));
                        entity.setTime(Utils.isNullOrEmpty(obj.getString("INPUT_DATETIME"), ""));

                        String content = Utils.isNullOrEmpty(obj.getString("FB_CONTENT"), "");
                        Map<String, Object> data = Utils.orderParsingJsonToList(content);

                        entity.setMenus(((List<OrderEntity>) data.get("list")).get(0).getMenues());
                        entity.setSlNo(data.get("slNo").toString());
                        entity.setTable(data.get("table").toString());
                        entity.setStaff(data.get("user").toString());
                        entity.setPrintYn(Utils.isNullOrEmpty(obj.getString("FB_PRINT_YN"), "N"));

                        mReceipts.add(entity);
                    }

                    mAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                } catch (Exception e) {
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void getOrder(int idx) {
        String message = "테이블 : " + mReceipts.get(idx).getTable() + "\n\n----------- 메뉴 -----------";

        for(MenuEntity tmp : mReceipts.get(idx).getMenus()){
            if (tmp.isNewYn() && tmp.getPrintYn().equals("Y")) {
                String name = tmp.getPdName();
                int cnt = tmp.getOrderCnt();

                message += "\n" + name + " * " + cnt;
            }
        }

        AlertUtil.okDialog(PrintListActivity.this, getString(R.string.message_header), message, null);
    }
}