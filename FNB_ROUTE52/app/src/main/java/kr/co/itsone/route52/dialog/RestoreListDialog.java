package kr.co.itsone.route52.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.LinearLayout;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.activity.MainActivity;
import kr.co.itsone.route52.adapter.RestoreAdapter;
import kr.co.itsone.route52.entity.RestoreEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class RestoreListDialog extends Dialog {

    private Context context;
    private RecyclerView listRestore;
    private LinearLayout btnClose;
    private String tableNo;

    private List<RestoreEntity> restores = new ArrayList<>();
    private RestoreAdapter mAdapter;

    public RestoreListDialog(Context context, String tableNo) {
        super(context);
        this.context = context;
        this.tableNo = tableNo;
    }

    @Override
    public void cancel() {
        super.cancel();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.view_restore_dialog);

        init();
    }

    private void init() {
        listRestore = findViewById(R.id.list_restore);
        listRestore.setLayoutManager(new LinearLayoutManager(context));

        mAdapter = new RestoreAdapter(context, restores, new RestoreAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                actionRestore(idx);
            }
        });

        listRestore.setAdapter(mAdapter);

        btnClose = findViewById(R.id.btn_restore_close);

        btnClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cancel();
            }
        });

        getRestoreList();
    }

    private void getRestoreList() {
        restores.clear();

        String sUrl = context.getString(R.string.host) + context.getString(R.string.getRestoreList);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", Utils.loadSharedPreferences(context, Globals.COMPANY));
        params.put("shop", Utils.loadSharedPreferences(context, Globals.SHOP));
        params.put("tableNo", tableNo);


        new AQueryUtil(context, sUrl, params, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    if(jsonObject.getJSONArray("rows").length() == 0) {
                        AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), "환원 할 데이터가 없습니다.", null);
                        dismiss();
                        return;
                    }

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        RestoreEntity entity = new RestoreEntity();

                        entity.setDay(Utils.isNullOrEmpty(obj.getString("EN_DAY"), ""));
                        entity.setCosNm(Utils.isNullOrEmpty(obj.getString("COS_NM"), ""));
                        entity.setTime(Utils.isNullOrEmpty(obj.getString("EN_TIME"), ""));
                        entity.setLocker(Utils.isNullOrEmpty(obj.getString("EN_LOCKER"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("EN_NAME"), ""));
                        entity.setSlNo(Utils.isNullOrEmpty(obj.getString("SL_NO"), ""));
                        entity.setTotalAmt(Utils.isNullOrEmpty(obj.getString("SL_TOTAL_AMOUNT"), "0"));
                        entity.setChkInNo(Utils.isNullOrEmpty(obj.getString("EN_CHKINNO"), ""));

                        restores.add(entity);
                    }

                    mAdapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), context.getString(R.string.network_error), null);
            }
        });
    }

    public void actionRestore(int idx) {
        try {
            String sUrl = context.getString(R.string.host) + context.getString(R.string.actionRestore);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(context, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(context, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(context, Globals.IN_ID));
            params.put("enDay", restores.get(idx).getDay());
            params.put("enChkInNo", restores.get(idx).getChkInNo());
            params.put("slNo", restores.get(idx).getSlNo());
            params.put("tableNo", tableNo);

            new AQueryUtil(context, sUrl, params, true, context.getString(R.string.message_header), "환원 처리중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), "환원 처리되었습니다.", new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    ((MainActivity) context).loadBillList();

                                    dismiss();
                                }
                            });
                        } else {
                            AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog((MainActivity) context, context.getString(R.string.message_header), context.getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
