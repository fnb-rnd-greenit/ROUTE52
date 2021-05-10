package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Typeface;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.entity.CosEntity;
import kr.co.itsone.route52.entity.VisitorEntity;
import kr.co.itsone.route52.fragment.VisitorFragment;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.FirebaseMessagingListener3;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.MyFirebaseMessagingService;
import kr.co.itsone.route52.util.Utils;

public class VisitorChoiceActivity extends AppCompatActivity implements FirebaseMessagingListener3 {

    private String mCoDiv;
    private String mPart = "0";
    private List<String> mCosNames = new ArrayList<>();
    private Map<String, Object> mCosIdx = new HashMap<>();

    private List<VisitorEntity> mVisitors = new ArrayList<>();
    private VisitorEntity selectVisitor;

    private ViewPager pager;
    private PagerAdapter adapter;
    private int page = 0;

    private TextView txtCosName;
    private EditText editSearch;

    private List<VisitorFragment> visitorFragments = new ArrayList<>();

    private Button btnSave;
    private Button btnCancel;

    private TextView[] btnPart = new TextView[4];
    //private TextView btnPrevPart;
    //private TextView btnNextPart;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_visitor_choice);

        initActionBar();

        init();
    }

    @Override
    protected void onStart() {
        super.onStart();

        MyFirebaseMessagingService.setFirebaseMessagingListener3(this);
    }

    @Override
    protected void onStop() {
        super.onStop();

        MyFirebaseMessagingService.setFirebaseMessagingListener3(null);
    }

    @Override
    public void onSyncTables(final String slNo) {
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    String no = getIntent().getStringExtra("slNo");

                    if(no != null && slNo.equals(no)) {
                        AlertUtil.okDialog(VisitorChoiceActivity.this, getString(R.string.message_header), "GMS에서 전표 데이터를 변경하였습니다.", new AlertUtil.okDialogListener() {
                            @Override
                            public void onOk() {
                                Intent intent = new Intent();
                                intent.putExtra("finish", "Y");
                                setResult(RESULT_OK, intent);
                                finish();
                            }
                        });
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0);
    }

    private void initActionBar() {
        TextView txtTitle = findViewById(R.id.txt_action_title);
        ImageView btnMemo = findViewById(R.id.btn_action_memo);
        TextView txtDate = findViewById(R.id.txt_action_date);
        TextView txtShop = findViewById(R.id.txt_action_shop);

        txtTitle.setText("내장객 조회");
        btnMemo.setVisibility(View.VISIBLE);
        txtDate.setVisibility(View.VISIBLE);
        txtShop.setVisibility(View.VISIBLE);
        txtDate.setText(new SimpleDateFormat("yy-MM-dd").format(new Date()));

        //String coDiv = Globals.mCompanys.get(Utils.loadSharedPreferences(VisitorChoiceActivity.this, Globals.COMPANY_IDX, 0)).getCode();
        String coDiv = Utils.loadSharedPreferences(VisitorChoiceActivity.this, Globals.CO_DIV);
        String shop = Utils.loadSharedPreferences(this, Globals.SHOP);

        for(int i=0; i<Globals.mShops.size(); i++) {
            if(Globals.mShops.get(i).getCoDiv().equals(coDiv) && Globals.mShops.get(i).getCode().equals(shop)) {
                String shopName = Globals.mShops.get(i).getName();
                if(shopName.length() > 3) {
                    shopName = shopName.substring(0, 3);
                }
                txtShop.setText(shopName);
                break;
            }
        }

        btnMemo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MemoDialog dialog = new MemoDialog(VisitorChoiceActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });
    }

    private void init() {
        try {
            mCoDiv = Utils.loadSharedPreferences(VisitorChoiceActivity.this, Globals.COMPANY);

            for(CosEntity tmp : Globals.mCoses) {
                if(tmp.getCoDiv().equals(mCoDiv)) {
                    VisitorFragment fragment = new VisitorFragment();
                    fragment.setCos(tmp.getCode());
                    mCosNames.add(tmp.getName());
                    visitorFragments.add(fragment);
                    mCosIdx.put(tmp.getCode(), mCosNames.size() - 1);
                }
            }

            TextView txtTitle = findViewById(R.id.txt_action_title);
            txtTitle.setText("내장객 조회");

            pager = findViewById(R.id.pager_visitor_choice);
            adapter = new PagerAdapter(getSupportFragmentManager());
            pager.setAdapter(adapter);

            pager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                @Override
                public void onPageScrolled(int i, float v, int i1) {

                }

                @Override
                public void onPageSelected(int i) {
                    page = i;
                    visitorFragments.get(page).setVisitors(mVisitors);
                    visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);
                    txtCosName.setText(mCosNames.get(page));
                }

                @Override
                public void onPageScrollStateChanged(int i) {

                }
            });

            editSearch = findViewById(R.id.edit_visitor_choice_search);
            txtCosName = findViewById(R.id.txt_visitor_choice_cos_name);
            txtCosName.setText(mCosNames.get(page));

            editSearch.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) {

                }

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {

                }

                @Override
                public void afterTextChanged(Editable s) {
                    try {
                        visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                }
            });

            btnSave = findViewById(R.id.btn_visitor_choice_save);
            btnCancel = findViewById(R.id.btn_visitor_choice_cancel);

            btnSave.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(selectVisitor == null) {
                        AlertUtil.okDialog(VisitorChoiceActivity.this, getString(R.string.message_header), "선택된 내장객이 없습니다.", null);
                        return;
                    }

                    visitorChoice();
                }
            });

            btnCancel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    finish();
                }
            });

            btnPart[0] = findViewById(R.id.btn_visitor_part_all);
            btnPart[1] = findViewById(R.id.btn_visitor_part1);
            btnPart[2] = findViewById(R.id.btn_visitor_part2);
            btnPart[3] = findViewById(R.id.btn_visitor_part3);
            //btnPrevPart = findViewById(R.id.btn_visitor_prev_part);
            //btnNextPart = findViewById(R.id.btn_visitor_next_part);

            setPartTab();

            for(int i=0; i<btnPart.length; i++) {
                final int part = i;
                btnPart[i].setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        mPart = String.valueOf(part);
                        visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);

                        setPartTab();
                    }
                });
            }

            /*btnPrevPart.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mPart = String.valueOf(Integer.valueOf(mPart) - 1);
                    if(mPart.equals("-1")) mPart = "3";

                    visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);

                    setPartTab();
                }
            });

            btnNextPart.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mPart = String.valueOf(Integer.valueOf(mPart) + 1);
                    if(mPart.equals("4")) mPart = "0";

                    visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);

                    setPartTab();
                }
            });*/

            loadVisitorList();
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    private void setPartTab() {
        for(int i=0; i<btnPart.length; i++) {
            if(mPart.equals(String.valueOf(i))) {
                btnPart[i].setSelected(true);
                btnPart[i].setTypeface(null, Typeface.BOLD);
                btnPart[i].setTextColor(getResources().getColor(R.color.dark_gray3));
            } else {
                btnPart[i].setSelected(false);
                btnPart[i].setTypeface(null, Typeface.NORMAL);
                btnPart[i].setTextColor(getResources().getColor(R.color.dark_gray));
            }
        }
    }

    public void visitorChoice() {
        Intent intent = new Intent();
        intent.putExtra("idx", getIntent().getIntExtra("idx", -1));
        intent.putExtra("visitor", selectVisitor);
        setResult(RESULT_OK, intent);
        finish();
    }

    public class PagerAdapter extends FragmentStatePagerAdapter {

        public PagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            return visitorFragments.get(position);
        }

        @Override
        public int getCount() {
            return visitorFragments.size();
        }
    }

    private void loadVisitorList(){
        String sUrl = getString(R.string.host) + getString(R.string.getVisitors);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", mCoDiv);
        params.put("day", getIntent().getStringExtra("day"));
        params.put("cos", getIntent().getStringExtra("cos"));
        params.put("time", getIntent().getStringExtra("time"));
        params.put("gpNum", getIntent().getStringExtra("gpNum"));

        new AQueryUtil(VisitorChoiceActivity.this, sUrl, params, true, getString(R.string.message_header), "로딩중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        VisitorEntity entity = new VisitorEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setChkInNo(Utils.isNullOrEmpty(obj.getString("EN_CHKINNO"), ""));
                        entity.setDay(Utils.isNullOrEmpty(obj.getString("EN_DAY"), ""));
                        entity.setCos(Utils.isNullOrEmpty(obj.getString("EN_COS"), ""));
                        entity.setCosNm(Utils.isNullOrEmpty(obj.getString("EN_COS_NM"), ""));
                        entity.setTime(Utils.isNullOrEmpty(obj.getString("EN_TIME"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("EN_NAME"), ""));
                        entity.setLocker(Utils.isNullOrEmpty(obj.getString("EN_LOCKER"), ""));
                        entity.setGpNum(Utils.isNullOrEmpty(obj.getString("EN_GPNUM"), ""));
                        entity.setGpName(Utils.isNullOrEmpty(obj.getString("GP_NAME"), ""));
                        entity.setMsNum(Utils.isNullOrEmpty(obj.getString("EN_MSNUM"), ""));
                        entity.setPart(Utils.isNullOrEmpty(obj.getString("BK_PART"), ""));
                        entity.setBkName(Utils.isNullOrEmpty(obj.getString("BK_NAME"), ""));
                        entity.setCaddyNum(Utils.isNullOrEmpty(obj.getString("EN_CADDYNUM"), ""));
                        entity.setCyName(Utils.isNullOrEmpty(obj.getString("CY_NAME"), ""));
                        entity.setCartNo(Utils.isNullOrEmpty(obj.getString("EN_CARTNO"), ""));

                        mVisitors.add(entity);
                    }

                    for(int i=0; i<visitorFragments.size(); i++) {
                        visitorFragments.get(i).setVisitors(mVisitors);
                    }

                    String cos = getIntent().getStringExtra("cos");
                    if(cos != null) {
                        int index = (int) mCosIdx.get(cos);
                        pager.setCurrentItem(index);
                    }

                    visitorFragments.get(page).filter(editSearch.getText().toString(), mPart);
                } catch (JSONException e) {
                    AlertUtil.okDialog(VisitorChoiceActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                } catch (Exception e) {
                    AlertUtil.okDialog(VisitorChoiceActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(VisitorChoiceActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    public void setVisitor(VisitorEntity entity){
        selectVisitor = entity;

        for(int i=0; i<visitorFragments.size(); i++) {
            if(!entity.getCos().equals(visitorFragments.get(i).mCos)){
                visitorFragments.get(i).clearSelected();
            }
        }
    }
}
