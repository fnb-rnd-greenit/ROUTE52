package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.app.ActivityManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.astuetz.PagerSlidingTabStrip;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.dialog.RestoreListDialog;
import kr.co.itsone.route52.entity.BillEntity;
import kr.co.itsone.route52.fragment.RoomFragment;
import kr.co.itsone.route52.fragment.TableFragment;
import kr.co.itsone.route52.service.PrinterService;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.FirebaseMessagingListener;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.MyFirebaseMessagingService;
import kr.co.itsone.route52.util.Utils;

public class MainActivity extends AppCompatActivity implements FirebaseMessagingListener {

    private final int PRINT_SETTING = 1000;
    public final int MODE_NORMAL = 1;
    public final int MODE_MOVE = 2;
    public final int MODE_MERGE = 3;
    public int mMode = MODE_NORMAL;

    private boolean finishFlag = false;
    public int selectedIndex = -1;

    private String mCompany;
    private String mShop;

    public List<BillEntity> mSales = new ArrayList<>();

    private Button btnRestore;
    private Button btnTableMove;
    private Button btnTableMerge;
    public Button btnWriteOrder;

    private TableFragment tableFragment;
    private RoomFragment roomFragment;
    private MainPagerAdapter mPagerAdapter;
    private PagerSlidingTabStrip tabs;
    private ViewPager pager;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setContentView(R.layout.activity_main);

        init();
    }

    @Override
    public void onBackPressed() {
        if (!finishFlag) {
            AlertUtil.showToastShort(MainActivity.this, "뒤로가기를 한 번 더 누르면 종료됩니다.");
            finishFlag = true;
            Handler han = new Handler();
            han.postDelayed(new Runnable() {
                @Override
                public void run() {
                    finishFlag = false;
                }
            }, 2000);
        } else {
            finish();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        loadBillList();
    }

    @Override
    public void onSyncTables() {
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                loadBillList();
            }
        }, 0);
    }

    @Override
    protected void onStart() {
        super.onStart();

        MyFirebaseMessagingService.setFirebaseMessagingListener(this);
    }

    @Override
    protected void onStop() {
        super.onStop();

        MyFirebaseMessagingService.setFirebaseMessagingListener(null);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == PRINT_SETTING && resultCode == RESULT_OK && data != null) {
            String relayYn = Utils.loadSharedPreferences(MainActivity.this, Globals.RELAY_YN);

            if(relayYn != null && !relayYn.equals("") && relayYn.equals("Y")) {
                if(!isPrinterServiceRunning()) {
                    startPrinterService();
                }
            } else {
                if(isPrinterServiceRunning()) {
                    stopPrinterService();
                }
            }
        }

        super.onActivityResult(requestCode, resultCode, data);
    }

    public boolean isPrinterServiceRunning() {
        ActivityManager manager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);

        for (ActivityManager.RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE))
        {
            if (PrinterService.class.getName().equals(service.service.getClassName()))
                return true;
        }
        return false;
    }

    private void init() {
        mCompany = Utils.loadSharedPreferences(this, Globals.COMPANY);
        mShop = Utils.loadSharedPreferences(this, Globals.SHOP);

        tabs = findViewById(R.id.tabs_main);
        pager = findViewById(R.id.pager_main);

        tableFragment = new TableFragment();
        roomFragment = new RoomFragment();

        mPagerAdapter = new MainPagerAdapter(getSupportFragmentManager());
        pager.setAdapter(mPagerAdapter);
        tabs.setViewPager(pager);

        TextView txtTitle = findViewById(R.id.txt_action_title);
        ImageView btnLogout = findViewById(R.id.btn_action_logout);
        ImageView btnStatement = findViewById(R.id.btn_action_statement);
        ImageView btnMemo = findViewById(R.id.btn_action_memo);
        ImageView btnPrint = findViewById(R.id.btn_action_printer);
        ImageView btnReceipt = findViewById(R.id.btn_action_receipt);

        /*int iCompany = Utils.loadSharedPreferences(MainActivity.this, Globals.COMPANY_IDX, 0);
        String coDiv = Globals.mCompanys.get(iCompany).getCode();*/
        String coDiv = Utils.loadSharedPreferences(MainActivity.this, Globals.CO_DIV);
        String coDivNm = Utils.loadSharedPreferences(MainActivity.this, Globals.CO_DIV_NM);
        String shopNm = "";

        for(int i=0; i<Globals.mShops.size(); i++) {
            if(Globals.mShops.get(i).getCoDiv().equals(coDiv) && Globals.mShops.get(i).getCode().equals(mShop)) {
                shopNm = Globals.mShops.get(i).getName();
            }
        }

        txtTitle.setText(coDivNm + " - " + shopNm);
        btnLogout.setVisibility(View.VISIBLE);
        btnStatement.setVisibility(View.VISIBLE);
        btnMemo.setVisibility(View.VISIBLE);
        btnPrint.setVisibility(View.VISIBLE);
        btnReceipt.setVisibility(View.VISIBLE);

        btnStatement.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, StatementActivity.class);

                startActivity(intent);
            }
        });

        btnMemo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MemoDialog dialog = new MemoDialog(MainActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });

        btnPrint.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivityForResult(new Intent(MainActivity.this, SettingActivity.class), PRINT_SETTING);
            }
        });

        btnReceipt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, PrintListActivity.class));
            }
        });

        btnRestore = findViewById(R.id.btn_main_restore);
        btnTableMove = findViewById(R.id.btn_main_table_move);
        btnTableMerge = findViewById(R.id.btn_main_table_merge);
        btnWriteOrder = findViewById(R.id.btn_main_write_order);

        btnLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertUtil.yesNoDialog(MainActivity.this, getString(R.string.message_header), "로그아웃 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                    @Override
                    public void onSelected(DialogInterface dialog, int num) {
                        if(num == 1) {
                            Utils.saveSharedPreferences(MainActivity.this, Globals.AUTO_LOGIN, "0");
                            startActivity(new Intent(MainActivity.this, LoginActivity.class));
                            finish();
                        }
                    }
                });
            }
        });

        btnRestore.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(selectedIndex == -1) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "선택된 테이블이 없습니다.", null);
                    return;
                }

                if(!mSales.get(selectedIndex).getSlNo().equals("")) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "판매중인 테이블입니다.", null);
                    return;
                }

                RestoreListDialog dialog = new RestoreListDialog(MainActivity.this, mSales.get(selectedIndex).getSlTableNo());


                dialog.setCancelable(false);

                dialog.show();
            }
        });

        btnTableMove.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(selectedIndex == -1) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "선택된 테이블이 없습니다.", null);
                    return;
                }

                if(mSales.get(selectedIndex).getSlNo().equals("")) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "주문내역이 없는 테이블입니다.", null);
                    return;
                }

                mMode = MODE_MOVE;
                AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "이동할 테이블을 선택해주세요.", null);
            }
        });

        btnTableMerge.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(selectedIndex == -1) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "선택된 테이블이 없습니다.", null);
                    return;
                }

                if(mSales.get(selectedIndex).getSlNo().equals("")) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "주문내역이 없는 테이블입니다.", null);
                    return;
                }

                if(mSales.get(selectedIndex).getSlPayDiv().equals("2")) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "선불전표는 병합할 수 없습니다.", null);
                    return;
                }

                mMode = MODE_MERGE;
                AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "병합할 테이블을 선택해주세요.", null);
            }
        });

        btnWriteOrder.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                writeOrder();
            }
        });

        String relayYn = Utils.loadSharedPreferences(this, Globals.RELAY_YN);

        if(relayYn != null && !relayYn.equals("") && relayYn.equals("Y")) {
            if(!isPrinterServiceRunning()) {
                startPrinterService();
            }
        }
    }

    public void startPrinterService() {
        Intent serviceIntent = new Intent(this, PrinterService.class);

        /*ContextCompat.startForegroundService(this, serviceIntent);*/
        startService(serviceIntent);
    }

    public void stopPrinterService() {
        Intent serviceIntent = new Intent(this, PrinterService.class);

        stopService(serviceIntent);
    }

    public void writeOrder() {
        if(selectedIndex == -1) {
            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "선택된 테이블이 없습니다.", null);
            return;
        }

        if(!mSales.get(selectedIndex).getSlNo().equals("")) {
            Intent intent = new Intent(MainActivity.this, OrderActivity.class);

            intent.putExtra("action", "update");
            intent.putExtra("tableCode", mSales.get(selectedIndex).getSlTableNo());
            intent.putExtra("tableName", mSales.get(selectedIndex).getSlTableName());
            intent.putExtra("bill", mSales.get(selectedIndex));

            startActivity(intent);
        } else {
            Intent intent = new Intent(MainActivity.this, OrderActivity.class);

            intent.putExtra("action", "insert");
            intent.putExtra("tableCode", mSales.get(selectedIndex).getSlTableNo());
            intent.putExtra("tableName", mSales.get(selectedIndex).getSlTableName());

            startActivity(intent);
        }
    }

    public void moveTable(int idx) {
        mMode = MODE_NORMAL;

        if(!mSales.get(idx).getSlNo().equals("")) {
            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "현재 판매중인 테이블입니다.", null);
            return;
        }

        try {
            String sUrl = getString(R.string.host) + getString(R.string.moveTable);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(MainActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(MainActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(MainActivity.this, Globals.IN_ID));
            params.put("slNo", mSales.get(selectedIndex).getSlNo());
            params.put("tableNo", mSales.get(idx).getSlTableNo());

            new AQueryUtil(MainActivity.this, sUrl, params, true, getString(R.string.message_header), "테이블 이동 처리중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "테이블 이동 처리되었습니다.", new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    loadBillList();
                                }
                            });
                        } else {
                            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void mergeTable(int idx) {
        mMode = MODE_NORMAL;

        if(mSales.get(idx).getSlNo().equals("")) {
            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "판매중인 테이블이 아닙니다. 병합 불가능합니다.", null);
            return;
        }

        if(selectedIndex == idx) {
            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "병합할 테이블을 선택해주세요.", null);
            mMode = MODE_MERGE;
            return;
        }

        try {
            String sUrl = getString(R.string.host) + getString(R.string.mergeTable);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(MainActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(MainActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(MainActivity.this, Globals.IN_ID));
            params.put("tableNo1", mSales.get(selectedIndex).getSlTableNo());
            params.put("tableNo2", mSales.get(idx).getSlTableNo());
            params.put("bSlNo", mSales.get(selectedIndex).getSlNo());
            params.put("aSlNo", mSales.get(idx).getSlNo());

            new AQueryUtil(MainActivity.this, sUrl, params, true, getString(R.string.message_header), "테이블 병합 처리중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), "테이블 병합 처리되었습니다.", new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    loadBillList();
                                }
                            });
                        } else {
                            AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void loadBillList(){
        String sUrl = getString(R.string.host) + getString(R.string.getCurrentSales);

        Map<String, Object> params = new HashMap<>();
        params.put("coDiv", mCompany);
        params.put("shop", mShop);

        new AQueryUtil(MainActivity.this, sUrl, params, true, getString(R.string.message_header), "로딩중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    mSales.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        BillEntity entity = new BillEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setSlShop(Utils.isNullOrEmpty(obj.getString("SL_SHOP"), ""));
                        entity.setSlDiv(Utils.isNullOrEmpty(obj.getString("SL_DIV"), ""));
                        entity.setSlTableNo(Utils.isNullOrEmpty(obj.getString("SL_TABLE_NO"), ""));
                        entity.setSlTableName(Utils.isNullOrEmpty(obj.getString("SL_TABLE_NAME"), ""));
                        entity.setSlDay(Utils.isNullOrEmpty(obj.getString("SL_DAY"), ""));
                        entity.setSlCos(Utils.isNullOrEmpty(obj.getString("SL_COS"), ""));
                        entity.setSlCosNm(Utils.isNullOrEmpty(obj.getString("SL_COS_NM"), ""));
                        entity.setSlTime(Utils.isNullOrEmpty(obj.getString("SL_TIME"), ""));
                        entity.setSlEnName(Utils.isNullOrEmpty(obj.getString("SL_EN_NAME"), ""));
                        entity.setEnChkinno(Utils.isNullOrEmpty(obj.getString("EN_CHKINNO"), ""));
                        entity.setSlNo(Utils.isNullOrEmpty(obj.getString("SL_NO"), ""));
                        entity.setSlTotalAmount(Utils.isNullOrEmpty(obj.getString("SL_TOTAL_AMOUNT"), ""));
                        entity.setSlPayDiv(Utils.isNullOrEmpty(obj.getString("SL_PAYDIV"), "1"));
                        entity.setSlTablePerson(Utils.isNullOrEmpty(obj.getString("SL_TABLE_PERSON"), "0"));
                        entity.setSlRound(Utils.isNullOrEmpty(obj.getString("SL_ROUND"), "1"));
                        entity.setOrderId("");

                        mSales.add(entity);
                    }

                    JSONObject obj = jsonObject.getJSONObject("subData");

                    TextView totalAmount = findViewById(R.id.txt_main_total_amount);
                    TextView preAmount = findViewById(R.id.txt_main_pre_total_amount);

                    totalAmount.setText("매출금액 : " + Utils.moneyDecimalFormat(Integer.valueOf(obj.getString("TOTAL_AMOUNT"))) + "원");
                    preAmount.setText("선불매출금액 : " + Utils.moneyDecimalFormat(Integer.valueOf(obj.getString("PRE_TOTAL_AMOUNT"))) + "원");

                    setListArray();
                } catch (JSONException e) {
                    AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(MainActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void setListArray(){
        tableFragment.mTables.clear();
        roomFragment.mRooms.clear();

        for(int i = 0; i< mSales.size(); i++) {
            if(mSales.get(i).getSlDiv().equals("1")){
                roomFragment.mRooms.add(mSales.get(i));
                roomFragment.roomAdapter.notifyDataSetChanged();
            } else {
                tableFragment.mTables.add(mSales.get(i));
                tableFragment.tableAdapter.notifyDataSetChanged();
            }
        }
    }

    class MainPagerAdapter extends FragmentPagerAdapter {
        public MainPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            try {
                if(position == 0) {
                    return tableFragment;
                } else {
                    return roomFragment;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }

        @Override
        public int getCount() {
            return 2;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            if(position == 0) {
                return "테이블";
            } else {
                return "룸";
            }
        }
    }
}
