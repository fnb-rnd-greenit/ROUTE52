package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.bxl.config.util.BXLNetwork;
import com.google.firebase.crashlytics.FirebaseCrashlytics;
import com.google.firebase.iid.FirebaseInstanceId;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import jpos.JposException;
import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.SpinnerAdapter;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.BixolonPrinter;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class SettingActivity extends AppCompatActivity {

    private ProgressDialog mDialog;
    private String[] networks;

    private String mDeviceName;
    private String mPortType;
    private String mPrintYn;
    private EditText editNetwork;
    private EditText editCompany;
    private EditText editAddress;
    private EditText editTel;
    private EditText editHomepage;
    private EditText editFontSize;
    private Switch switchRelay;

    private BixolonPrinter bxlPrinter = null;

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_setting);

        init();
    }

    private void init() {
        TextView txtTitle = findViewById(R.id.txt_action_title);
        txtTitle.setText("프린터 설정");

        Spinner spinnerDevice = findViewById(R.id.spinner_setting_device);
        SpinnerAdapter deviceAdapter = new SpinnerAdapter(SettingActivity.this, android.R.layout.simple_spinner_item, new ArrayList<>(Arrays.asList(getResources().getStringArray(R.array.device_list))));
        spinnerDevice.setAdapter(deviceAdapter);
        spinnerDevice.setSelection(11);
        spinnerDevice.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mDeviceName = (String) parent.getItemAtPosition(position);
            }

            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        ArrayList<String> ports = new ArrayList<>();
        ports.add("USB");
        ports.add("NETWORK");

        Spinner spinnerPort = findViewById(R.id.spinner_setting_port_type);
        SpinnerAdapter portAdapter = new SpinnerAdapter(SettingActivity.this, android.R.layout.simple_spinner_item, ports);
        spinnerPort.setAdapter(portAdapter);
        spinnerPort.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mPortType = position == 0 ? "2" : "3";
            }

            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        spinnerPort.setSelection(0);

        ArrayList<String> yesNo = new ArrayList<>();
        yesNo.add("출력");
        yesNo.add("미출력");

        Spinner spinnerPrintYn = findViewById(R.id.spinner_setting_print_yn);
        SpinnerAdapter printAdapter = new SpinnerAdapter(SettingActivity.this, android.R.layout.simple_spinner_item, yesNo);
        spinnerPrintYn.setAdapter(printAdapter);
        spinnerPrintYn.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mPrintYn = position == 0 ? "Y" : "N";
            }

            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        spinnerPrintYn.setSelection(0);

        editNetwork = findViewById(R.id.edit_setting_network);
        editCompany = findViewById(R.id.edit_setting_company_name);
        editAddress = findViewById(R.id.edit_setting_address);
        editTel = findViewById(R.id.edit_setting_tel);
        editHomepage = findViewById(R.id.edit_setting_homepage);
        editFontSize = findViewById(R.id.edit_setting_font_size);
        switchRelay = findViewById(R.id.switch_setting_relay);

        String portType, device, network, companyNm, address, tel, homepage, printYn, relayYn, fontSize;
        portType = Utils.loadSharedPreferences(SettingActivity.this, Globals.PORT_TYPE);
        device = Utils.loadSharedPreferences(SettingActivity.this, Globals.PRODUCT_NAME);
        network = Utils.loadSharedPreferences(SettingActivity.this, Globals.IP);
        companyNm = Utils.loadSharedPreferences(SettingActivity.this, Globals.COMPANY_NM);
        address = Utils.loadSharedPreferences(SettingActivity.this, Globals.ADDRESS);
        tel = Utils.loadSharedPreferences(SettingActivity.this, Globals.TEL_NO);
        homepage = Utils.loadSharedPreferences(SettingActivity.this, Globals.HOMEPAGE);
        printYn = Utils.loadSharedPreferences(SettingActivity.this, Globals.PRINT_YN);
        relayYn = Utils.loadSharedPreferences(SettingActivity.this, Globals.RELAY_YN);
        fontSize = Utils.loadSharedPreferences(SettingActivity.this, Globals.FONT_SIZE);

        if(device != null && !device.equals("")) {
            String[] devices = getResources().getStringArray(R.array.device_list);
            for(int i=0; i<devices.length; i++) {
                if(device.equals(devices[i])) {
                    spinnerDevice.setSelection(i);
                    break;
                }
            }
        }

        if(network != null && !network.equals("")) editNetwork.setText(network);
        if(companyNm != null && !companyNm.equals("")) editCompany.setText(companyNm);
        if(address != null && !address.equals("")) editAddress.setText(address);
        if(tel != null && !tel.equals("")) editTel.setText(tel);
        if(homepage != null && !homepage.equals("")) editFontSize.setText(fontSize);
        if(fontSize != null && !homepage.equals("")) editHomepage.setText(homepage);
        if(relayYn != null && !relayYn.equals("")) {
            switchRelay.setChecked(relayYn.equals("Y") ? true : false);
        }
        if(portType != null && !portType.equals("")) {
            spinnerPort.setSelection(portType.equals("2") ? 0 : 1);
        }
        if(printYn != null && !printYn.equals("")) {
            spinnerPrintYn.setSelection(printYn.equals("Y") ? 0 : 1);
        }

        findViewById(R.id.btn_setting_cancel).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        findViewById(R.id.btn_setting_save).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                doSave();
            }
        });

        findViewById(R.id.btn_setting_relay).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setPrinterRelay();
            }
        });

        findViewById(R.id.btn_setting_reset).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Utils.saveSharedPreferences(SettingActivity.this, Globals.PORT_TYPE, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.PRODUCT_NAME, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.IP, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.COMPANY_NM, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.ADDRESS, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.TEL_NO, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.HOMEPAGE, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.PRINT_YN, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.FONT_SIZE, "");
                Utils.saveSharedPreferences(SettingActivity.this, Globals.RELAY_YN, "");

                AlertUtil.okDialog(SettingActivity.this, "알림", "초기화 되었습니다.", new AlertUtil.okDialogListener() {
                    @Override
                    public void onOk() {
                        Intent intent = new Intent();
                        setResult(RESULT_OK, intent);
                        finish();
                    }
                });
            }
        });

        findViewById(R.id.btn_setting_network_test).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mDialog.setMessage("프린터에 연결중입니다.");
                mDialog.show();

                new PrinterConnectionThread().start();
            }
        });

        Button btnSearch = findViewById(R.id.btn_setting_network_search);
        btnSearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setNetworkDevices();
            }
        });

        mDialog = new ProgressDialog(this);
        mDialog.setTitle("알림");
        mDialog.setCancelable(false);
    }

    private void setNetworkDevices() {
        BXLNetwork.setWifiSearchOption(5, 1);
        new searchNetworkPrinterTask().execute();
    }

    private void setPrinterRelay() {
        try {
            String sUrl = getString(R.string.host) + getString(R.string.setPrinterRelay);

            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(SettingActivity.this, Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(SettingActivity.this, Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(SettingActivity.this, Globals.IN_ID));
            params.put("token", FirebaseInstanceId.getInstance().getToken());

            new AQueryUtil(SettingActivity.this, sUrl, params, true, getString(R.string.message_header), "단말기를 중계설정 중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").equals("0000")) {
                            AlertUtil.okDialog(SettingActivity.this, getString(R.string.message_header), "처리되었습니다.", null);
                        } else {
                            AlertUtil.okDialog(SettingActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(SettingActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(SettingActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void doSave() {
        String network, companym, address, tel, homepage, fontSize;

        network = editNetwork.getText().toString();
        companym = editCompany.getText().toString();
        address = editAddress.getText().toString();
        tel = editTel.getText().toString();
        homepage = editHomepage.getText().toString();
        fontSize = editFontSize.getText().toString();
        boolean relayYn = switchRelay.isChecked();

        if(mDeviceName == null || mDeviceName.equals("")) {
            AlertUtil.showToastShort(SettingActivity.this, "기종을 선택해주세요.");
            return;
        }

        if(network == null || network.equals("")) {
            AlertUtil.showToastShort(SettingActivity.this, "아이피를 입력해주세요.");
            return;
        }

        Utils.saveSharedPreferences(SettingActivity.this, Globals.PORT_TYPE, mPortType);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.PRODUCT_NAME, mDeviceName);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.IP, network);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.COMPANY_NM, companym);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.ADDRESS, address);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.TEL_NO, tel);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.HOMEPAGE, homepage);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.PRINT_YN, mPrintYn);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.FONT_SIZE, fontSize);
        Utils.saveSharedPreferences(SettingActivity.this, Globals.RELAY_YN, relayYn ? "Y" : "N");

        AlertUtil.okDialog(SettingActivity.this, "알림", "저장되었습니다.", new AlertUtil.okDialogListener() {
            @Override
            public void onOk() {
                Intent intent = new Intent();
                setResult(RESULT_OK, intent);
                finish();
            }
        });
    }

    class PrinterConnectionThread extends Thread {
        @Override
        public void run() {
            try {
                bxlPrinter = new BixolonPrinter(getApplicationContext());

                if (bxlPrinter.printerOpen(Integer.valueOf(mPortType), mDeviceName, editNetwork.getText().toString(), true)) {
                    AlertUtil.showToastLong(SettingActivity.this, "프린터(" + mDeviceName + ")에 연결 되었습니다.");

                    bxlPrinter.beginTransactionPrint();

                    Bitmap img = BitmapFactory.decodeResource(getResources(), R.drawable.logo_print);
                    bxlPrinter.printImage(img, 600, bxlPrinter.ALIGNMENT_CENTER, 50);
                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("프린터 테스트", bxlPrinter.ALIGNMENT_CENTER
                            , bxlPrinter.ATTRIBUTE_FONT_A | bxlPrinter.ATTRIBUTE_BOLD, 2);
                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("\n", 0, 0, 1);
                    bxlPrinter.printText("\n", 0, 0, 1);

                    bxlPrinter.endTransactionPrint();
                    bxlPrinter.cutPaper();
                } else {
                    AlertUtil.showToastLong(SettingActivity.this, "프린터(" + mDeviceName + ")에 연결 실패했습니다.");
                }

                mDialog.dismiss();

                Handler handler = new Handler(Looper.getMainLooper());

                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        if(bxlPrinter != null) {
                            bxlPrinter.printerClose();
                        }
                    }
                }, 1000);
            } catch (Exception e) {
                AlertUtil.showToastLong(SettingActivity.this, "프린터(" + mDeviceName + ")에 연결 실패했습니다.");
                mDialog.dismiss();
                FirebaseCrashlytics.getInstance().recordException(e);
            }
        }
    }

    private class searchNetworkPrinterTask extends AsyncTask<Integer, Integer, Set<CharSequence>> {

        @Override
        protected void onPreExecute() {
            mDialog.setMessage("네트워크를 조회중입니다.");
            mDialog.show();
        }

        @Override
        protected void onPostExecute(Set<CharSequence> NetworkDeviceSet) {
            try {
                mDialog.dismiss();

                networks = null;

                if (NetworkDeviceSet != null && !NetworkDeviceSet.isEmpty()) {
                    networks = NetworkDeviceSet.toArray(new String[NetworkDeviceSet.size()]);

                    AlertUtil.optionDialog(SettingActivity.this, "네트워크를 선택하세요.", networks, 0, new AlertUtil.OptionDialogListener() {
                        @Override
                        public void onSelected(int idx) {
                            editNetwork.setText(networks[idx]);
                        }
                    });
                } else {
                    AlertUtil.showToastLong(getApplicationContext(), "연결 가능한 네트워크 프린터가 없습니다.");
                }
            } catch(Exception e) {
                FirebaseCrashlytics.getInstance().recordException(e);
            }
        }

        @Override
        protected Set<CharSequence> doInBackground(Integer... params) {
            try {
                return BXLNetwork.getNetworkPrinters(SettingActivity.this, BXLNetwork.SEARCH_WIFI_ALWAYS);
            } catch (NumberFormatException | JposException e) {
                return new HashSet<>();
            }
        }
    }
}
