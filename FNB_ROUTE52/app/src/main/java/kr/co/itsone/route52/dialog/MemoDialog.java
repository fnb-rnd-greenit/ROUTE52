package kr.co.itsone.route52.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.LinearLayout;
import android.widget.TextView;

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
import kr.co.itsone.route52.adapter.MemoAdapter;
import kr.co.itsone.route52.entity.MemoEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class MemoDialog extends Dialog {

    private Context context;
    private RecyclerView listMemo;
    private LinearLayout btnClose;
    private TextView txtMemo;

    private List<MemoEntity> memos = new ArrayList<>();
    private MemoAdapter mAdapter;

    public MemoDialog(Context context) {
        super(context);
        this.context = context;
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
        setContentView(R.layout.view_memo_dialog);

        init();
    }

    private void init() {
        listMemo = findViewById(R.id.list_memo);
        listMemo.setLayoutManager(new LinearLayoutManager(context));

        mAdapter = new MemoAdapter(context, memos, new MemoAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                for(int i=0; i<memos.size(); i++) {
                    if(i == idx) {
                        memos.get(i).setSelected(true);
                    } else {
                        memos.get(i).setSelected(false);
                    }
                }

                mAdapter.notifyDataSetChanged();

                String memo = "%s\n%s->%s:[%s]\n\n%s";

                memo = String.format(memo, memos.get(idx).getInputTime(), memos.get(idx).getSendName(), memos.get(idx).getReceiveName(), memos.get(idx).getUserName(), memos.get(idx).getRemark());

                txtMemo.setText(memo);
            }
        });

        listMemo.setAdapter(mAdapter);

        txtMemo = findViewById(R.id.txt_memo_remark);

        btnClose = findViewById(R.id.btn_memo_close);

        btnClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cancel();
            }
        });

        getMemoList();
    }

    private void getMemoList() {
        memos.clear();

        String sUrl = context.getString(R.string.host) + context.getString(R.string.getMemoList);

        Map<String, Object> params = new HashMap<>();

        params.put("coDiv", Utils.loadSharedPreferences(context, Globals.COMPANY));

        new AQueryUtil(context, sUrl, params, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        MemoEntity entity = new MemoEntity();

                        entity.setTime(Utils.isNullOrEmpty(obj.getString("EN_TIME"), ""));
                        entity.setCos(Utils.isNullOrEmpty(obj.getString("EN_COS"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("BK_NAME"), ""));
                        entity.setInputTime(Utils.isNullOrEmpty(obj.getString("INPUT_DATETIME"), ""));
                        entity.setSendName(Utils.isNullOrEmpty(obj.getString("SEND_NAME"), ""));
                        entity.setReceiveName(Utils.isNullOrEmpty(obj.getString("RECEIVE_NAME"), ""));
                        entity.setUserName(Utils.isNullOrEmpty(obj.getString("USER_NAME"), ""));
                        entity.setRemark(Utils.isNullOrEmpty(obj.getString("EN_REMARK"), ""));

                        memos.add(entity);
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
}
