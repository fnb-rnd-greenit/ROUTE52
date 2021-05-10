package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.ItemTouchHelper;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.OrderAdapter;
import kr.co.itsone.route52.adapter.SpinnerAdapter;
import kr.co.itsone.route52.dialog.MemoDialog;
import kr.co.itsone.route52.entity.BillEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.OrderEntity;
import kr.co.itsone.route52.entity.VisitorEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.FirebaseMessagingListener2;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.MyFirebaseMessagingService;
import kr.co.itsone.route52.util.Utils;

public class OrderActivity extends AppCompatActivity implements FirebaseMessagingListener2 {

    private final String INSERT = "insert";
    private final String UPDATE = "update";

    private boolean isGallery = false;

    private BillEntity mBill;

    private final int VISITOR = 1000;
    private final int MENU = 2000;

    private String mDay, mCos, mTime;
    private String mAction;
    private String mTableCode;
    private String mTableName;
    private String mRound, mPerson, mPayDiv;

    private RecyclerView mList;
    private OrderAdapter mAdapter;
    private List<OrderEntity> mOrders = new ArrayList<>();

    private Spinner selRound;
    private Spinner selPerson;
    private Spinner selPayDiv;

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == VISITOR && resultCode == RESULT_OK && data != null) {
            String finish = data.getStringExtra("finish");
            if(finish != null && finish.equals("Y")) {
                finish();
                return;
            }

            int idx = data.getIntExtra("idx", -1);

            VisitorEntity visitor = data.getParcelableExtra("visitor");

            mDay = visitor.getDay();
            mCos = visitor.getCos();
            mTime = visitor.getTime();

            mOrders.get(idx).setVisitor(visitor);

            mAdapter.notifyDataSetChanged();
        } else if(requestCode == MENU && resultCode == RESULT_OK && data != null) {
            String finish = data.getStringExtra("finish");
            if(finish != null && finish.equals("Y")) {
                finish();
                return;
            }

            int idx = data.getIntExtra("idx", -1);

            ArrayList<MenuEntity> menus = data.getParcelableArrayListExtra("menus");

            mOrders.get(idx).getMenues().addAll(menus);

            mAdapter.notifyDataSetChanged();
        }
    }

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_order);

        mAction = getIntent().getStringExtra("action");
        mTableCode = getIntent().getStringExtra("tableCode");
        mTableName = getIntent().getStringExtra("tableName");

        initActionBar();

        init();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    protected void onStart() {
        super.onStart();

        MyFirebaseMessagingService.setFirebaseMessagingListener2(this);
    }

    @Override
    protected void onStop() {
        super.onStop();

        MyFirebaseMessagingService.setFirebaseMessagingListener2(null);
    }

    @Override
    public void onSyncTables(final String slNo) {
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    if(mBill.getSlNo() != null && mBill.getSlNo().equals(slNo)) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "GMS에서 전표 데이터를 변경하였습니다.", new AlertUtil.okDialogListener() {
                            @Override
                            public void onOk() {
                                finish();
                            }
                        });
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0);
    }

    private void init() {
        if(mAction.equals(INSERT)) {
            OrderEntity order = new OrderEntity();

            mOrders.add(order);
        } else if(mAction.equals(UPDATE)) {
            mBill = getIntent().getParcelableExtra("bill");
            mDay = mBill.getSlDay();
            mCos = mBill.getSlCos();
            mTime = mBill.getSlTime();

            getOrder();

            findViewById(R.id.btn_order_print).setVisibility(View.VISIBLE);
            findViewById(R.id.btn_order_delete).setVisibility(View.VISIBLE);
            findViewById(R.id.btn_order_calculate).setVisibility(View.VISIBLE);
            findViewById(R.id.btn_order_kitchen).setVisibility(View.GONE);
        }

        selRound = findViewById(R.id.spinner_order_round);
        selPerson = findViewById(R.id.spinner_order_person);
        selPayDiv = findViewById(R.id.spinner_order_pay_div);

        ArrayList<String> roundData = new ArrayList<>();
        ArrayList<String> personData = new ArrayList<>();
        ArrayList<String> payData = new ArrayList<>();

        roundData.add("전");
        roundData.add("후");

        for(int i=0; i<=100; i++) {
            personData.add(String.valueOf(i));
        }

        payData.add("후불");
        payData.add("선불");

        SpinnerAdapter rAdapter = new SpinnerAdapter(OrderActivity.this, android.R.layout.simple_spinner_item, roundData);
        selRound.setAdapter(rAdapter);
        selRound.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mRound = position == 0 ? "1" : "2";
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        SpinnerAdapter pAdapter = new SpinnerAdapter(OrderActivity.this, android.R.layout.simple_spinner_item, personData);
        selPerson.setAdapter(pAdapter);
        selPerson.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mPerson = String.valueOf(position);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        SpinnerAdapter dAdapter = new SpinnerAdapter(OrderActivity.this, android.R.layout.simple_spinner_item, payData);
        selPayDiv.setAdapter(dAdapter);
        selPayDiv.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mPayDiv = String.valueOf(position + 1);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        if(mAction.equals(UPDATE)) {
            selRound.setSelection(mBill.getSlRound().equals("1") ? 0 : 1);
            selPerson.setSelection(Integer.valueOf(mBill.getSlTablePerson()));
            selPayDiv.setSelection(Integer.valueOf(mBill.getSlPayDiv()) - 1);
            selPayDiv.setEnabled(false);
        } else {
            selRound.setSelection(0);
            selPerson.setSelection(0);
            selPayDiv.setSelection(0);
        }

        mList = findViewById(R.id.list_order);
        mList.setLayoutManager(new LinearLayoutManager(OrderActivity.this));
        mAdapter = new OrderAdapter(OrderActivity.this, mOrders, new OrderAdapter.ItemSelectedListener() {
            @Override
            public void onSeatNoChange(final int idx) {
                String[] seats = new String[20];
                for(int i=1; i<=20; i++) {
                    seats[i-1] = String.valueOf(i);
                }

                AlertUtil.optionDialog(OrderActivity.this, getString(R.string.message_header), seats, 0, new AlertUtil.OptionDialogListener() {
                    @Override
                    public void onSelected(int i) {
                        mOrders.get(idx).getVisitor().setSeatNo(String.valueOf(i + 1));

                        mAdapter.notifyDataSetChanged();
                    }
                });
            }

            @Override
            public void doVisitorSearch(int idx) {
                if(mOrders.get(idx).getVisitor().isLock()) {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "내장객을 변경 할 수 없습니다.", null);
                } else {
                    Intent intent = new Intent(OrderActivity.this, VisitorChoiceActivity.class);

                    intent.putExtra("idx", idx);
                    intent.putExtra("tableName", mTableName);
                    intent.putExtra("day", mDay);
                    intent.putExtra("cos", mCos);
                    intent.putExtra("time", mTime);
                    if(mBill != null) {
                        intent.putExtra("slNo", mBill.getSlNo());
                    }

                    if(mOrders.size() > 0) {
                        intent.putExtra("gpNum", mOrders.get(0).getVisitor().getGpNum());
                    }

                    startActivityForResult(intent, VISITOR);
                }
            }

            @Override
            public void doProductSearch(int idx) {
                Intent intent = new Intent(OrderActivity.this, OrderWriteActivity.class);

                intent.putExtra("idx", idx);
                intent.putExtra("tableName", mTableName);
                if(mBill != null) {
                    intent.putExtra("slNo", mBill.getSlNo());
                }

                startActivityForResult(intent, MENU);
            }

            @Override
            public void delProduct(final int position, final int index) {
                if(mOrders.get(position).getMenues().get(index).isNewYn()) {
                    mOrders.get(position).getMenues().remove(index);
                    mAdapter.notifyDataSetChanged();
                } else {
                    AlertUtil.yesNoDialog(OrderActivity.this, getString(R.string.message_header), "상품을 삭제 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                        @Override
                        public void onSelected(DialogInterface dialog, int num) {
                            if(num == 1) {
                                delOneProduct(position, index);
                            }
                        }
                    });
                }
            }
        });

        mList.setAdapter(mAdapter);
        new ItemTouchHelper(new ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT | ItemTouchHelper.RIGHT) {
            @Override
            public boolean onMove(RecyclerView recyclerView, RecyclerView.ViewHolder viewHolder, RecyclerView.ViewHolder target) {
                return false;
            }

            @Override
            public void onSwiped(RecyclerView.ViewHolder viewHolder, int direction) {
                int position = viewHolder.getAdapterPosition();

                if(!mOrders.get(position).getVisitor().isLock()) {
                    mOrders.remove(position);

                    mAdapter.notifyDataSetChanged();

                    if(mOrders.size() == 0) {
                        mDay = mCos = mTime = null;
                    }
                } else {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "삭제 할 수 없는 주문입니다.", null);

                    mAdapter.notifyDataSetChanged();
                }
            }
        }).attachToRecyclerView(mList);

        findViewById(R.id.btn_order_print).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String[] printOption = new String[]{"전체", "최근"};

                AlertUtil.optionDialog(OrderActivity.this, getString(R.string.message_header), printOption, 0, new AlertUtil.OptionDialogListener() {
                    @Override
                    public void onSelected(int idx) {
                        if(idx == 0) {
                            List<OrderEntity> rePrint = new ArrayList<>();
                            try {
                                for(OrderEntity tmp : mOrders) {
                                    OrderEntity entity = new OrderEntity();
                                    entity.setVisitor(tmp.getVisitor());
                                    for(MenuEntity tmp2 : tmp.getMenues()) {
                                        MenuEntity entity2 = (MenuEntity) tmp2.clone();
                                        entity2.setNewYn(true);
                                        entity2.setSlAmount(entity2.getPdAmount());
                                        entity.getMenues().add(entity2);
                                    }
                                    rePrint.add(entity);
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                            }

                            JSONObject data = Utils.orderParsingListToJson(mBill.getSlNo(), mTableName, Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_NAME), rePrint);

                            String sUrl = getString(R.string.host) + getString(R.string.receiptPrinting);

                            Map<String, Object> params = new HashMap<>();

                            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
                            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
                            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
                            params.put("slNo", mBill.getSlNo());
                            params.put("againYn", "N");
                            params.put("sData", data);

                            new AQueryUtil(OrderActivity.this, sUrl, params, false, "", "", null);

                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "프린터 데이터를 전송했습니다.", null);
                        } else if(idx == 1) {
                            String sUrl = getString(R.string.host) + getString(R.string.latelyReceiptPrinting);

                            Map<String, Object> params = new HashMap<>();

                            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
                            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
                            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
                            params.put("slNo", mBill.getSlNo());

                            new AQueryUtil(OrderActivity.this, sUrl, params, false, "", "", null);

                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "프린터 데이터를 전송했습니다.", null);
                        }
                    }
                });

            }
        });

        findViewById(R.id.btn_order_add).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(isGallery) {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "갤러리는 시트를 추가할 수 없습니다.", null);
                } else {
                    OrderEntity order = new OrderEntity();

                    order.getVisitor().setSeatNo(String.valueOf(mOrders.size() + 1));

                    mOrders.add(order);

                    mAdapter.notifyDataSetChanged();

                    mList.scrollToPosition(mAdapter.getItemCount() - 1);
                }
            }
        });

        findViewById(R.id.btn_order_delete).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertUtil.yesNoDialog(OrderActivity.this, getString(R.string.message_header), "주문을 취소 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                    @Override
                    public void onSelected(DialogInterface dialog, int num) {
                        if(num == 1) {
                            cancelOrder();
                        }
                    }
                });
            }
        });

        findViewById(R.id.btn_order_calculate).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(mBill.getSlPayDiv().equals("2")) {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "선불전표는 정산할 수 없습니다.", null);
                    return;
                }

                AlertUtil.yesNoDialog(OrderActivity.this, getString(R.string.message_header), "주문을 정산 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                    @Override
                    public void onSelected(DialogInterface dialog, int num) {
                        if(num == 1) {
                            actionCalculate();
                        }
                    }
                });
            }
        });

        findViewById(R.id.btn_order_kitchen).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(OrderActivity.this, KitchenOrderActivity.class);

                intent.putExtra("slDay", mBill.getSlDay());
                intent.putExtra("slNo", mBill.getSlNo());

                startActivity(intent);
            }
        });

        findViewById(R.id.btn_order_save).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                for(int i=0; i<mOrders.size(); i++) {
                    if(mOrders.get(0).getVisitor().getName() != null) {
                        if(mOrders.get(i).getVisitor().getSeatNo() == null || mOrders.get(i).getVisitor().getSeatNo().equals("")) {
                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), (i + 1) + "번째 시트의 시트번호를 입력해주세요.", null);
                            return;
                        }
                    }

                    if(mOrders.get(i).getMenues().size() == 0) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), (i + 1) + "번 시트 상품을 선택해주세요.", null);
                        return;
                    }
                }

                AlertUtil.yesNoDialog(OrderActivity.this, getString(R.string.message_header), "작성한 내용을 저장 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                    @Override
                    public void onSelected(DialogInterface dialog, int num) {
                        if(num == 1) {
                            if(mOrders.get(0).getVisitor().getName() == null) {
                                AlertUtil.yesNoDialog(OrderActivity.this, getString(R.string.message_header), "선택 된 내장객이 없습니다. 갤러리로 등록 하시겠습니까?", "예", "아니오", new AlertUtil.yesNoDialogListener() {
                                    @Override
                                    public void onSelected(DialogInterface dialog, int num) {
                                        if(num == 1) {
                                            isGallery = true;

                                            actionOrder();
                                        }
                                    }
                                });
                            } else {
                                actionOrder();
                            }
                        }
                    }
                });
            }
        });
    }

    public void delOneProduct(final int position, final int index) {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.delProduct);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", mBill.getCoDiv());
            params.put("shop", mBill.getSlShop());
            params.put("slDay", mBill.getSlDay());
            params.put("slNo", mBill.getSlNo());
            params.put("slSeq", mOrders.get(position).getMenues().get(index).getSlSeq());
            params.put("slPdCd", mOrders.get(position).getMenues().get(index).getPdCd());
            params.put("enChkInNo", mOrders.get(position).getVisitor().getChkInNo());
            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));

            new AQueryUtil(OrderActivity.this, sUrl, params, true, getString(R.string.message_header), "삭제 처리중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.showToastLong(OrderActivity.this, "상품이 삭제 처리되었습니다.");

                            List<OrderEntity> delProducts = new ArrayList<>();

                            for(OrderEntity tmp : mOrders) {
                                OrderEntity entity = new OrderEntity();
                                entity.setVisitor(tmp.getVisitor());
                                for(MenuEntity tmp2 : tmp.getMenues()) {
                                    MenuEntity entity2 = (MenuEntity) tmp2.clone();
                                    entity.getMenues().add(entity2);
                                }
                                delProducts.add(entity);
                            }

                            OrderEntity delProduct = new OrderEntity();

                            delProduct.setVisitor(mOrders.get(position).getVisitor());
                            delProduct.getMenues().add(mOrders.get(position).getMenues().get(index));
                            int cnt = delProduct.getMenues().get(0).getOrderCnt() * -1;
                            delProduct.getMenues().get(0).setOrderCnt(cnt);
                            delProduct.getMenues().get(0).setNewYn(true);

                            delProducts.add(delProduct);

                            JSONObject data = Utils.orderParsingListToJson(mBill.getSlNo(), mTableName, Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_NAME), delProducts);

                            String sUrl = getString(R.string.host) + getString(R.string.receiptPrinting);

                            Map<String, Object> params = new HashMap<>();

                            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
                            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
                            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
                            params.put("slNo", mBill.getSlNo());
                            params.put("againYn", "N");
                            params.put("sData", data);

                            new AQueryUtil(OrderActivity.this, sUrl, params, false, "", "", null);

                            AlertUtil.showToastLong(OrderActivity.this, "프린터 데이터를 전송했습니다.");

                            getOrder();
                        } else {
                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    } catch (Exception e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void initActionBar() {
        TextView txtTitle = findViewById(R.id.txt_action_title);
        ImageView btnMemo = findViewById(R.id.btn_action_memo);
        TextView txtDate = findViewById(R.id.txt_action_date);
        TextView txtShop = findViewById(R.id.txt_action_shop);

        txtTitle.setText("주문작성 - " + mTableName);
        btnMemo.setVisibility(View.VISIBLE);
        txtDate.setVisibility(View.VISIBLE);
        txtShop.setVisibility(View.VISIBLE);
        txtDate.setText(new SimpleDateFormat("yy-MM-dd").format(new Date()));

        //String coDiv = Globals.mCompanys.get(Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY_IDX, 0)).getCode();
        String coDiv = Utils.loadSharedPreferences(OrderActivity.this, Globals.CO_DIV);
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
                MemoDialog dialog = new MemoDialog(OrderActivity.this);
                dialog.setCancelable(false);
                dialog.show();
            }
        });
    }

    private void getOrder() {
        String sUrl = getString(R.string.host) + getString(R.string.getOrder);
        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", mBill.getCoDiv());
        params.put("shop", mBill.getSlShop());
        params.put("slDay", mBill.getSlDay());
        params.put("slNo", mBill.getSlNo());

        new AQueryUtil(OrderActivity.this, sUrl, params, true, getString(R.string.message_header), "조회 중입니다.", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    mOrders.clear();
                    
                    String tmpSeatNo = "X";
                    OrderEntity order = new OrderEntity();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        if(!Utils.isNullOrEmpty(obj.getString("SL_SEAT_NO"), "").equals(tmpSeatNo)) {
                            tmpSeatNo = Utils.isNullOrEmpty(obj.getString("SL_SEAT_NO"), "");

                            if(i != 0) {
                                mOrders.add(order);
                            }

                            order = new OrderEntity();

                            String time = Utils.isNullOrEmpty(obj.getString("EN_TIME"), "");
                            String chkInNo = Utils.isNullOrEmpty(obj.getString("EN_CHKINNO"), "");

                            if(i == 0 && ((time.trim().length() >= 4 && Integer.valueOf(time) >= 2500) || chkInNo.substring(0, 1).equals("S"))) {
                                isGallery = true;
                            }

                            order.getVisitor().setSeatNo(tmpSeatNo);
                            order.getVisitor().setLock(true);
                            order.getVisitor().setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                            order.getVisitor().setChkInNo(Utils.isNullOrEmpty(obj.getString("EN_CHKINNO"), ""));
                            order.getVisitor().setDay(Utils.isNullOrEmpty(obj.getString("EN_DAY"), ""));
                            order.getVisitor().setCos(Utils.isNullOrEmpty(obj.getString("EN_COS"), ""));
                            order.getVisitor().setCosNm(Utils.isNullOrEmpty(obj.getString("EN_COS_NM"), ""));
                            order.getVisitor().setTime(Utils.isNullOrEmpty(obj.getString("EN_TIME"), ""));
                            order.getVisitor().setName(Utils.isNullOrEmpty(obj.getString("EN_NAME"), ""));
                            order.getVisitor().setLocker(Utils.isNullOrEmpty(obj.getString("EN_LOCKER"), ""));
                            order.getVisitor().setGpNum(Utils.isNullOrEmpty(obj.getString("EN_GPNUM"), ""));
                            order.getVisitor().setGpName(Utils.isNullOrEmpty(obj.getString("GP_NAME"), ""));
                            order.getVisitor().setMsNum(Utils.isNullOrEmpty(obj.getString("EN_MSNUM"), ""));
                            order.getVisitor().setPart(Utils.isNullOrEmpty(obj.getString("BK_PART"), ""));
                            order.getVisitor().setBkName(Utils.isNullOrEmpty(obj.getString("BK_NAME"), ""));
                            order.getVisitor().setCaddyNum(Utils.isNullOrEmpty(obj.getString("EN_CADDYNUM"), ""));
                            order.getVisitor().setCyName(Utils.isNullOrEmpty(obj.getString("CY_NAME"), ""));
                            order.getVisitor().setCartNo(Utils.isNullOrEmpty(obj.getString("EN_CARTNO"), ""));
                        }

                        MenuEntity menu = new MenuEntity();
                        menu.setNewYn(false);
                        menu.setSlSeq(Utils.isNullOrEmpty(obj.getString("SL_SEQ"), ""));
                        menu.setPdCd(Utils.isNullOrEmpty(obj.getString("SL_PD_CD"), ""));
                        menu.setPdName(Utils.isNullOrEmpty(obj.getString("PD_NAME"), ""));
                        menu.setOrderCnt(Integer.valueOf(Utils.isNullOrEmpty(obj.getString("SL_COUNT"), "0")));
                        menu.setSlAmount(Utils.isNullOrEmpty(obj.getString("SL_AMOUNT"), ""));
                        menu.setPdAmount(Utils.isNullOrEmpty(obj.getString("PD_AMOUNT"), ""));
                        menu.setSlDcRate(Utils.isNullOrEmpty(obj.getString("SL_DC_RATE"), ""));
                        menu.setSaleDiv(Utils.isNullOrEmpty(obj.getString("SL_GUBUN"), ""));
                        menu.setPrintYn(Utils.isNullOrEmpty(obj.getString("PRINT_YN"), ""));
                        menu.setSlCancel(Utils.isNullOrEmpty(obj.getString("SL_CANCEL"), "N"));

                        order.getMenues().add(menu);

                        if(i == jsonObject.getJSONArray("rows").length() - 1) {
                            mOrders.add(order);
                        }
                    }

                    mAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void cancelOrder() {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.cancelOrder);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
            params.put("slNo", mBill.getSlNo());

            JSONArray orderData = new JSONArray();

            for (OrderEntity tmp : mOrders) {
                VisitorEntity visitor = tmp.getVisitor();

                JSONObject obj = new JSONObject();

                obj.put("enChkInNo", visitor.getChkInNo());
                obj.put("enDay", visitor.getDay());

                orderData.put(obj);
            }

            params.put("visitors", orderData.toString());

            new AQueryUtil(OrderActivity.this, sUrl, params, true, getString(R.string.message_header), "주문을 취소중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.showToastLong(OrderActivity.this, "주문이 취소되었습니다.");

                            List<OrderEntity> delProducts = new ArrayList<>();

                            for(OrderEntity tmp : mOrders) {
                                OrderEntity entity = new OrderEntity();
                                entity.setVisitor(tmp.getVisitor());
                                for(MenuEntity tmp2 : tmp.getMenues()) {
                                    MenuEntity entity2 = (MenuEntity) tmp2.clone();
                                    MenuEntity entity3 = (MenuEntity) tmp2.clone();

                                    int cnt = entity3.getOrderCnt() * -1;
                                    entity3.setOrderCnt(cnt);
                                    entity3.setNewYn(true);

                                    entity.getMenues().add(entity2);
                                    entity.getMenues().add(entity3);
                                }
                                delProducts.add(entity);
                            }

                            JSONObject data = Utils.orderParsingListToJson(mBill.getSlNo(), mTableName, Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_NAME), delProducts);

                            String sUrl = getString(R.string.host) + getString(R.string.receiptPrinting);

                            Map<String, Object> params = new HashMap<>();

                            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
                            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
                            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
                            params.put("slNo", mBill.getSlNo());
                            params.put("againYn", "N");
                            params.put("sData", data);

                            new AQueryUtil(OrderActivity.this, sUrl, params, false, "", "", null);

                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    finish();
                                }
                            }, 300);
                        } else {
                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    } catch (Exception e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void actionCalculate() {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.actionCalculate);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
            params.put("slNo", mBill.getSlNo());
            params.put("tableNo", mTableCode);

            JSONArray orderData = new JSONArray();

            for (OrderEntity tmp : mOrders) {
                VisitorEntity visitor = tmp.getVisitor();

                JSONObject obj = new JSONObject();

                obj.put("enChkInNo", visitor.getChkInNo());
                obj.put("enDay", visitor.getDay());

                orderData.put(obj);
            }

            params.put("visitors", orderData.toString());

            new AQueryUtil(OrderActivity.this, sUrl, params, true, getString(R.string.message_header), "정산 중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.showToastLong(OrderActivity.this, "정산 처리되었습니다.");

                            finish();
                        } else {
                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void actionOrder() {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.actionOrder);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
            params.put("tableNo", mTableCode);
            params.put("tableName", mTableName);
            params.put("enChkInNo", mOrders.get(0).getVisitor().getChkInNo());
            params.put("slCos", mOrders.get(0).getVisitor().getCos());
            params.put("slTime", mOrders.get(0).getVisitor().getTime());
            params.put("slEnName", mOrders.get(0).getVisitor().getName());
            params.put("slTablePerson", mPerson);
            params.put("slRound", mRound);
            params.put("isGallery", isGallery);
            params.put("slPayDiv", mPayDiv);

            if(mAction.equals(UPDATE)) {
                params.put("slNo", mBill.getSlNo());
            }

            JSONArray orderData = new JSONArray();

            for (OrderEntity tmp : mOrders) {
                VisitorEntity visitor = tmp.getVisitor();
                ArrayList<MenuEntity> menus = new ArrayList<>();
                menus.addAll(tmp.getMenues());

                if(visitor.getChkInNo() == null) {
                    visitor.setVisitorEntity(mOrders.get(0).getVisitor());
                }

                JSONObject obj = new JSONObject();

                if(!isGallery) {
                    obj.put("enChkInNo", visitor.getChkInNo());
                    obj.put("enDay", visitor.getDay());
                    obj.put("enCos", visitor.getCos());
                    obj.put("enTime", visitor.getTime());
                    obj.put("enName", visitor.getName());
                    obj.put("enLocker", visitor.getLocker());
                    obj.put("gpNum", visitor.getGpNum());
                    obj.put("msNum", visitor.getMsNum());
                    obj.put("seatNo", visitor.getSeatNo());
                }

                JSONArray menuData = new JSONArray();

                for (int i = 0; i < menus.size(); i++) {
                    if(!menus.get(i).isNewYn()) {
                        continue;
                    }

                    JSONObject menu = new JSONObject();
                    int amount = Integer.valueOf(menus.get(i).getSlAmount());
                    int cnt = Integer.valueOf(menus.get(i).getOrderCnt());
                    float disc = Float.valueOf(menus.get(i).getSlDcRate()) / 100;
                    int single = amount - (int) (amount * disc);
                    amount = cnt * single;
                    int pdCost;
                    if (menus.get(i).getPdVatYn().equals("Y")) {
                        pdCost = Math.round((float) (amount / 1.1));
                    } else {
                        pdCost = amount;
                    }

                    menu.put("pdCd", menus.get(i).getPdCd());
                    menu.put("slCount", cnt);
                    menu.put("slAmount", amount);
                    menu.put("slCost", pdCost);
                    menu.put("slVat", amount - pdCost);
                    menu.put("slPrice", single);
                    menu.put("slRate", menus.get(i).getSlDcRate());
                    menu.put("slGubun", menus.get(i).getSaleDiv());
                    menuData.put(menu);
                }

                if(menuData.length() > 0) {
                    obj.put("menus", menuData.toString());
                    orderData.put(obj);
                }
            }

            if(orderData.length() == 0 && mPerson.equals(mBill.getSlTablePerson()) && mRound.equals(mBill.getSlRound())) {
                AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), "변경 된 항목이 없습니다.", null);
                return;
            }

            params.put("data", orderData.toString());

            final int orderSize = orderData.length();

            new AQueryUtil(OrderActivity.this, sUrl, params, true, getString(R.string.message_header), "주문을 저장중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            if(orderSize > 0) {
                                final String slNo = new JSONObject(jsonObject.get("subData").toString()).get("slNo").toString();

                                JSONObject data = Utils.orderParsingListToJson(slNo, mTableName, Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_NAME), mOrders);

                                String sUrl = getString(R.string.host) + getString(R.string.receiptPrinting);

                                Map<String, Object> params = new HashMap<>();

                                params.put("coDiv", Utils.loadSharedPreferences(OrderActivity.this, Globals.COMPANY));
                                params.put("shop", Utils.loadSharedPreferences(OrderActivity.this, Globals.SHOP));
                                params.put("userId", Utils.loadSharedPreferences(OrderActivity.this, Globals.IN_ID));
                                params.put("slNo", slNo);
                                params.put("againYn", "N");
                                params.put("sData", data);

                                new AQueryUtil(OrderActivity.this, sUrl, params, false, "", "", null);
                            }

                            AlertUtil.showToastLong(OrderActivity.this, "주문내역이 저장되었습니다.");

                            finish();
                        } else {
                            AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(OrderActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
