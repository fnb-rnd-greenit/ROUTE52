package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.KitchenAdapter;
import kr.co.itsone.route52.entity.KitchenEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class KitchenOrderActivity extends AppCompatActivity {

    private SwipeRefreshLayout mSwipe;

    private KitchenAdapter mAdapter;
    private List<KitchenEntity> mOrders = new ArrayList<>();
    private RecyclerView mList;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_kitchen_order);

        init();
    }

    private void init() {
        TextView txtTitle = findViewById(R.id.txt_action_title);

        String shop = Utils.loadSharedPreferences(this, Globals.SHOP);

        String coDiv = Utils.loadSharedPreferences(KitchenOrderActivity.this, Globals.CO_DIV);
        String coDivNM = Utils.loadSharedPreferences(KitchenOrderActivity.this, Globals.CO_DIV_NM);
        String shopNm = "";

        for(int i=0; i<Globals.mShops.size(); i++) {
            if(Globals.mShops.get(i).getCoDiv().equals(coDiv) && Globals.mShops.get(i).getCode().equals(shop)) {
                shopNm = Globals.mShops.get(i).getName();
            }
        }

        txtTitle.setText(coDivNM + " - " + shopNm);

        findViewById(R.id.btn_kitchen_order_exit).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        mList = findViewById(R.id.list_kitchen_order);
        mList.setLayoutManager(new LinearLayoutManager(KitchenOrderActivity.this));

        mAdapter = new KitchenAdapter(KitchenOrderActivity.this, mOrders, new KitchenAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                for(int i=0; i<mOrders.size(); i++) {
                    mOrders.get(i).setSelected(i == idx);
                }

                mAdapter.notifyDataSetChanged();
            }
        });

        mList.setAdapter(mAdapter);

        mSwipe = findViewById(R.id.swipe_kitchen_order);

        mSwipe.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                getKitchenOrder();

                mSwipe.setRefreshing(false);
            }
        });

        getKitchenOrder();
    }

    private void getKitchenOrder() {
        mOrders.clear();

        String sUrl = getString(R.string.host) + getString(R.string.getKitchenOrder);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", Utils.loadSharedPreferences(KitchenOrderActivity.this, Globals.COMPANY));
        params.put("shop", Utils.loadSharedPreferences(KitchenOrderActivity.this, Globals.SHOP));
        params.put("slDay", getIntent().getStringExtra("slDay"));
        params.put("slNo", getIntent().getStringExtra("slNo"));

        new AQueryUtil(KitchenOrderActivity.this, sUrl, params, true, "알림", "조회 중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        KitchenEntity entity = new KitchenEntity();

                        entity.setNo(Utils.isNullOrEmpty(obj.getString("SL_NO"), ""));
                        entity.setTable(Utils.isNullOrEmpty(obj.getString("SL_TABLE_NAME"), ""));
                        entity.setMenu(Utils.isNullOrEmpty(obj.getString("PD_NAME"), ""));
                        entity.setCnt(Utils.isNullOrEmpty(obj.getString("SL_COUNT"), ""));
                        entity.setStatus(Utils.isNullOrEmpty(obj.getString("SL_KITCHEN_STATUS"), ""));

                        mOrders.add(entity);
                    }

                    mAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    AlertUtil.okDialog(KitchenOrderActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(KitchenOrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }
}
