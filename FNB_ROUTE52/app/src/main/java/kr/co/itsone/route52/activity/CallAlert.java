package kr.co.itsone.route52.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.util.AlertUtil;

public class CallAlert extends Activity {

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_call_alert);

        AlertUtil.yesNoDialog(this, getString(R.string.message_header), getIntent().getStringExtra("message"), "주문보기", "닫기", new AlertUtil.yesNoDialogListener() {
            @Override
            public void onSelected(DialogInterface dialog, int num) {
                if(num == 1) {
                    Intent intent = new Intent(CallAlert.this, KitchenOrderActivity.class);

                    intent.putExtra("slDay", getIntent().getStringExtra("slDay"));
                    intent.putExtra("slNo", getIntent().getStringExtra("slNo"));

                    startActivity(intent);
                } else {
                    finish();
                }
            }
        });
    }
}