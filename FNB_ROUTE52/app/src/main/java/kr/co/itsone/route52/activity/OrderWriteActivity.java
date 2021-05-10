package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.astuetz.PagerSlidingTabStrip;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.dialog.ItemListDialog;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.entity.MenuDivisionEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.fragment.MenuFragment;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.FirebaseMessagingListener4;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.MyFirebaseMessagingService;
import kr.co.itsone.route52.util.Utils;

public class OrderWriteActivity extends AppCompatActivity implements FirebaseMessagingListener4 {

    private String mCoDiv;
    private String mShop;

    public List<MenuDivisionEntity> mMidDiv = new ArrayList<>();
    public List<MenuDivisionEntity> mSmallDiv = new ArrayList<>();
    public List<MenuEntity> mMenus = new ArrayList<>();

    private List<MenuFragment> mFragments = new ArrayList<>();
    private HeaderPagerAdapter mPagerAdapter;
    private String[] titles;

    private Button btnSave;
    private Button btnCancel;
    private Button btnAddOpen;
    private PagerSlidingTabStrip tabs;
    private ViewPager pager;

    private EditText editSearch;
    private ImageView btnSearch;

    private ArrayList<MenuEntity> mOrderMenus = new ArrayList<>();

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_order_write);

        initActionBar();

        init();
    }

    @Override
    protected void onStart() {
        super.onStart();

        MyFirebaseMessagingService.setFirebaseMessagingListener4(this);
    }

    @Override
    protected void onStop() {
        super.onStop();

        MyFirebaseMessagingService.setFirebaseMessagingListener4(null);
    }

    @Override
    public void onSyncTables(final String slNo) {
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    String no = getIntent().getStringExtra("slNo");

                    if(no != null && slNo.equals(no)) {
                        AlertUtil.okDialog(OrderWriteActivity.this, getString(R.string.message_header), "GMS에서 전표 데이터를 변경하였습니다.", new AlertUtil.okDialogListener() {
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

        txtTitle.setText("주문작성 - " + getIntent().getStringExtra("tableName"));
        btnMemo.setVisibility(View.VISIBLE);
        txtDate.setVisibility(View.VISIBLE);
        txtShop.setVisibility(View.VISIBLE);
        txtDate.setText(new SimpleDateFormat("yy-MM-dd").format(new Date()));

        //String coDiv = Globals.mCompanys.get(Utils.loadSharedPreferences(OrderWriteActivity.this, Globals.COMPANY_IDX, 0)).getCode();
        String coDiv = Utils.loadSharedPreferences(OrderWriteActivity.this, Globals.CO_DIV);
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
                MemoDialog dialog = new MemoDialog(OrderWriteActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });
    }

    private void init() {
        try {
            mCoDiv = Utils.loadSharedPreferences(this, Globals.COMPANY);
            mShop = Utils.loadSharedPreferences(this, Globals.SHOP);

            String tmpCode = "";

            for(MenuDivisionEntity tmp : Globals.mMenuDivs) {
                if(mCoDiv.equals(tmp.getCoDiv()) && mShop.equals(tmp.getPdShop())) {
                    if(!tmp.getMidCode().equals(tmpCode)) {
                        tmpCode = tmp.getMidCode();

                        mMidDiv.add(tmp);
                    }

                    mSmallDiv.add(tmp);
                }
            }

            titles = new String[mMidDiv.size() + 1];

            for(int i=0; i<titles.length-1; i++) {
                MenuFragment fragment = new MenuFragment();
                fragment.setMidDiv(mMidDiv.get(i).getMidCode());
                fragment.setMode(fragment.MODE_NORMAL);

                titles[i] = mMidDiv.get(i).getMidName();
                mFragments.add(fragment);
            }

            titles[titles.length - 1] = "상품조회";
            MenuFragment fragment = new MenuFragment();
            fragment.setMode(fragment.MODE_SEARCH);
            mFragments.add(fragment);

            for(MenuEntity entity : Globals.mMenus) {
                if(entity.getCoDiv().equals(mCoDiv) && entity.getPdShop().equals(mShop)) {
                    mMenus.add((MenuEntity) entity.clone());
                }
            }

            editSearch = findViewById(R.id.edit_order_write_keyword);
            btnSearch = findViewById(R.id.btn_order_write_search);

            btnSearch.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    String keyword = editSearch.getText().toString();

                    if(keyword.length() < 1) {
                        AlertUtil.showToastShort(OrderWriteActivity.this, "키워드를 입력하세요.");
                        return;
                    }

                    mFragments.get(mFragments.size() - 1).setKeyword(keyword);
                    editSearch.setText("");
                    pager.setCurrentItem(titles.length - 1);

                    Utils.keyboardHide(OrderWriteActivity.this);
                }
            });

            tabs = findViewById(R.id.tabs_order_write);
            pager = findViewById(R.id.pager_order_write);

            mPagerAdapter = new HeaderPagerAdapter(getSupportFragmentManager());
            pager.setAdapter(mPagerAdapter);
            tabs.setViewPager(pager);

            btnSave = findViewById(R.id.btn_order_write_save);
            btnCancel = findViewById(R.id.btn_order_write_cancel);
            btnAddOpen = findViewById(R.id.btn_order_write_add_menu_open);

            btnSave.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(mOrderMenus.size() == 0) {
                        AlertUtil.okDialog(OrderWriteActivity.this, getString(R.string.message_header), "선택된 상품이 없습니다.", null);
                        return;
                    }

                    doSave();
                }
            });

            btnCancel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    finish();
                }
            });

            btnAddOpen.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ItemListDialog itemDialog = new ItemListDialog(OrderWriteActivity.this, new ItemListDialog.ItemListListener() {
                        @Override
                        public void onDeleted(int idx) {
                            mOrderMenus.remove(idx);

                            for(int i=0; i<mFragments.size(); i++) {
                                (mFragments.get(i)).notifyDataSetChanged();
                            }
                        }
                    });

                    itemDialog.setItems(mOrderMenus);
                    itemDialog.show();
                }
            });

        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void doSave() {
        Intent intent = new Intent();
        intent.putExtra("idx", getIntent().getIntExtra("idx", -1));
        intent.putParcelableArrayListExtra("menus", mOrderMenus);
        setResult(RESULT_OK, intent);
        finish();
    }

    public void addMenu(MenuEntity entity) {
        try {
            boolean updFlag = false;

            for(int i = 0; i< mOrderMenus.size(); i++){
                if(mOrderMenus.get(i).getPdCd().equals(entity.getPdCd())){
                    updFlag = true;
                    if(entity.getOrderCnt() == 0) {
                        mOrderMenus.remove(i);
                        AlertUtil.showToastShort(OrderWriteActivity.this, String.format("%s 상품이 삭제되었습니다.", entity.getPdName()));
                    }
                }
            }

            if(!updFlag){
                mOrderMenus.add(0, entity);
                AlertUtil.showToastShort(OrderWriteActivity.this, String.format("%s 상품이 추가되었습니다.", entity.getPdName()));
            }
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    class HeaderPagerAdapter extends FragmentPagerAdapter {
        public HeaderPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            try {
                return mFragments.get(position);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }

        @Override
        public int getCount() {
            return titles.length;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            return titles[position];
        }
    }
}
