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

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.StatementAdapter;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.entity.StatementEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class StatementActivity extends AppCompatActivity {

    private SwipeRefreshLayout mSwipe;

    private StatementAdapter mAdapter;
    private List<StatementEntity> mStatements = new ArrayList<>();
    private RecyclerView mList;

    private int selIdx = -1;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_statement);

        init();
    }

    private void init() {
        TextView txtTitle = findViewById(R.id.txt_action_title);
        ImageView btnMemo = findViewById(R.id.btn_action_memo);

        String shop = Utils.loadSharedPreferences(this, Globals.SHOP);

        //int iCompany = Utils.loadSharedPreferences(StatementActivity.this, Globals.COMPANY_IDX, 0);
        //String coDiv = Globals.mCompanys.get(iCompany).getCode();

        String coDiv = Utils.loadSharedPreferences(StatementActivity.this, Globals.CO_DIV);
        String coDivNM = Utils.loadSharedPreferences(StatementActivity.this, Globals.CO_DIV_NM);
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
                MemoDialog dialog = new MemoDialog(StatementActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });

        findViewById(R.id.btn_statement_exit).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        mList = findViewById(R.id.list_statement);
        mList.setLayoutManager(new LinearLayoutManager(StatementActivity.this));

        mAdapter = new StatementAdapter(StatementActivity.this, mStatements, new StatementAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                if(selIdx != -1) {
                    mStatements.get(selIdx).setSelected(false);
                }

                selIdx = idx;

                mStatements.get(selIdx).setSelected(true);

                mAdapter.notifyDataSetChanged();
            }
        });

        mList.setAdapter(mAdapter);

        mSwipe = findViewById(R.id.swipe_statement);

        mSwipe.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                getStatementList();

                mSwipe.setRefreshing(false);
            }
        });

        getStatementList();
    }

    private void getStatementList() {
        mStatements.clear();

        String sUrl = getString(R.string.host) + getString(R.string.getStatementList);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", Utils.loadSharedPreferences(StatementActivity.this, Globals.COMPANY));
        params.put("shop", Utils.loadSharedPreferences(StatementActivity.this, Globals.SHOP));

        new AQueryUtil(StatementActivity.this, sUrl, params, true, "알림", "조회 중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        StatementEntity entity = new StatementEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setSlShop(Utils.isNullOrEmpty(obj.getString("SL_SHOP"), ""));
                        entity.setSlNo(Utils.isNullOrEmpty(obj.getString("SL_NO"), ""));
                        entity.setSlTableNo(Utils.isNullOrEmpty(obj.getString("SL_TABLE_NO"), ""));
                        entity.setSlTableName(Utils.isNullOrEmpty(obj.getString("SL_TABLE_NAME"), ""));
                        entity.setGpName(Utils.isNullOrEmpty(obj.getString("GP_NAME"), ""));
                        entity.setSlTime(Utils.isNullOrEmpty(obj.getString("SL_TIME"), ""));
                        entity.setSlTotalAmount(Utils.isNullOrEmpty(obj.getString("SL_TOTAL_AMOUNT"), ""));
                        entity.setSlState(Utils.isNullOrEmpty(obj.getString("SL_STATE"), ""));

                        mStatements.add(entity);
                    }

                    mAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    AlertUtil.okDialog(StatementActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(StatementActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }
}
