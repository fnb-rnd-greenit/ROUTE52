package kr.co.itsone.route52.activity;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.SpinnerAdapter;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class LoginActivity extends AppCompatActivity {

    private Spinner selCompany;
    private Spinner selShop;
    private SpinnerAdapter companyAdapter;
    private SpinnerAdapter shopAdapter;
    private int iCompany = 0;
    private int iShop = 0;
    private int adminCount = 5;

    private EditText editId;
    private EditText editPw;
    private Button btnLogin;
    private CheckBox chkAuto;
    private CheckBox chkSavePw;
    private TextView txtAuto;
    private TextView txtSavePw;
    private ImageView imgLogo;

    private boolean finishFlag = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_login);

        init();
    }

    @Override
    public void onBackPressed() {
        if (!finishFlag) {
            AlertUtil.showToastShort(LoginActivity.this, "뒤로가기를 한 번 더 누르면 종료됩니다.");
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
        adminCount = 5;

        super.onResume();
    }

    private void init(){
        try {
            selCompany = findViewById(R.id.login_spinner_company);
            selShop = findViewById(R.id.login_spinner_shop);
            editId = findViewById(R.id.edit_login_id);
            editPw = findViewById(R.id.edit_login_pw);
            btnLogin = findViewById(R.id.btn_login_action);
            chkAuto = findViewById(R.id.chk_login_auto);
            chkSavePw = findViewById(R.id.chk_login_save_pw);
            txtAuto = findViewById(R.id.txt_login_auto);
            txtSavePw = findViewById(R.id.txt_login_save_pw);
            imgLogo = findViewById(R.id.btn_login_logo);

            String id = Utils.loadSharedPreferences(LoginActivity.this, Globals.IN_ID);
            String pw = Utils.loadSharedPreferences(LoginActivity.this, Globals.IN_PW);
            String auto = Utils.loadSharedPreferences(LoginActivity.this, Globals.AUTO_LOGIN);

            iCompany = Utils.loadSharedPreferences(LoginActivity.this, Globals.COMPANY_IDX, -1) + 1;
            iShop = Utils.loadSharedPreferences(LoginActivity.this, Globals.SHOP_IDX, -1) + 1;

            btnLogin.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    actionLogin();
                }
            });

            txtAuto.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    chkAuto.setChecked(!chkAuto.isChecked());
                }
            });

            txtSavePw.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    chkSavePw.setChecked(!chkSavePw.isChecked());
                }
            });

            imgLogo.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /* if(adminCount == 0) {
                        startActivity(new Intent(LoginActivity.this, SettingActivity.class));

                        return;
                    }

                    if(adminCount <= 3) {
                        AlertUtil.showToastShort(LoginActivity.this, adminCount + "회 클릭시 설정메뉴로 이동됩니다.");
                    }

                    adminCount -= 1; */
                }
            });

            List<String> sCompany = new ArrayList<>();
            sCompany.add("선택");

            for(int i=0; i<Globals.mCompanys.size(); i++){
                sCompany.add(Globals.mCompanys.get(i).getName());
            }

            companyAdapter = new SpinnerAdapter(LoginActivity.this, android.R.layout.simple_spinner_item, sCompany);
            selCompany.setAdapter(companyAdapter);
            if(iCompany >= sCompany.size()) {
                iCompany = 0;
            }
            selCompany.setSelection(iCompany);

            selCompany.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                    List<String> sShop = new ArrayList<>();
                    sShop.add("선택");

                    if(position > 0) {
                        String coDiv = Globals.mCompanys.get(position - 1).getCode();

                        for(int i=0; i<Globals.mShops.size(); i++){
                            if(Globals.mShops.get(i).getCoDiv().equals(coDiv)) {
                                sShop.add(Globals.mShops.get(i).getName());
                            }
                        }
                    }

                    shopAdapter = new SpinnerAdapter(LoginActivity.this, android.R.layout.simple_spinner_item, sShop);
                    selShop.setAdapter(shopAdapter);

                    if(iShop >= sShop.size()) {
                        iShop = 0;
                    }
                    selShop.setSelection(iShop);
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });

            if(!id.equals("")){
                editId.setText(id);
            }

            if(!pw.equals("")){
                chkSavePw.setChecked(true);
                editPw.setText(pw);
            }

            if(auto.equals("1")){
                chkAuto.setChecked(true);

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        actionLogin();
                    }
                }, 200);
            }
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    private void actionLogin(){
        try {
            Utils.keyboardHide(LoginActivity.this);

            if(editId.getText().toString().equals("")){
                AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "아이디를 입력하세요.", null);
                return;
            }

            if(editPw.getText().toString().equals("")){
                AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "비밀번호를 입력하세요.", null);
                return;
            }

            if(selCompany.getSelectedItemPosition() == 0){
                AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "사업장을 선택하세요.", null);
                return;
            }

            if(selShop.getSelectedItemPosition() == 0){
                AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "영업장을 선택하세요.", null);
                return;
            }

            String sUrl = getString(R.string.host) + getString(R.string.actionLogin);

            HashMap<String, Object> params = new HashMap<>();

            params.put("coDiv", Globals.mCompanys.get(selCompany.getSelectedItemPosition() - 1).getCode());
            params.put("userId", editId.getText().toString());
            params.put("userPw", editPw.getText().toString());

            new AQueryUtil(LoginActivity.this, sUrl, params, true, getString(R.string.message_header), "로그인 중입니다.", new AQueryUtil.AQueryListener() {
                @Override
                public void httpRequestComplete(JSONObject jsonObject) {
                    try {
                        if(jsonObject.get("resultCode").toString().equals("0000")) {
                            JSONObject obj = jsonObject.getJSONObject("rows");

                            String[] arrGrant = obj.getString("GRANT_CODIV").split(",");
                            boolean grantYn = false;

                            for(int i=0; i<arrGrant.length; i++) {
                                if(arrGrant[i].equals(Globals.mCompanys.get(selCompany.getSelectedItemPosition() - 1).getCode())) {
                                    grantYn = true;
                                    break;
                                }
                            }

                            if(!grantYn) {
                                AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "선택한 사업장에 접속할 권한이 없습니다.", null);
                                return;
                            }

                            Utils.saveSharedPreferences(LoginActivity.this, Globals.IN_ID, obj.getString("USER_STAFF"));
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.IN_NAME, obj.getString("USER_NAME"));

                            if(chkSavePw.isChecked()) {
                                Utils.saveSharedPreferences(LoginActivity.this, Globals.IN_PW, editPw.getText().toString());

                                if(chkAuto.isChecked()) {
                                    Utils.saveSharedPreferences(LoginActivity.this, Globals.AUTO_LOGIN, "1");
                                } else {
                                    Utils.saveSharedPreferences(LoginActivity.this, Globals.AUTO_LOGIN, "0");
                                }
                            } else {
                                Utils.saveSharedPreferences(LoginActivity.this, Globals.IN_PW, "");
                            }

                            Utils.saveSharedPreferences(LoginActivity.this, Globals.COMPANY_IDX, selCompany.getSelectedItemPosition() - 1);
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.COMPANY, Globals.mCompanys.get(selCompany.getSelectedItemPosition() - 1).getCode());
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.SHOP_IDX, selShop.getSelectedItemPosition() - 1);
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.SHOP, Globals.mShops.get(selShop.getSelectedItemPosition() - 1).getCode());
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.CO_DIV, Globals.mCompanys.get(selCompany.getSelectedItemPosition() - 1).getCode());
                            Utils.saveSharedPreferences(LoginActivity.this, Globals.CO_DIV_NM, Globals.mCompanys.get(selCompany.getSelectedItemPosition() - 1).getName());

                            AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), String.format("%s님 반갑습니다.", Utils.isNullOrEmpty(obj.getString("USER_NAME"), "")), new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    Intent intent = new Intent(LoginActivity.this, MainActivity.class);
                                    startActivity(intent);
                                    finish();
                                }
                            });
                        } else if(jsonObject.get("resultCode").toString().equals("1000")) {
                            AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), "아이디, 비밀번호 또는 화면 권환을 다시 확인하세요.", null);
                        } else if(jsonObject.getJSONArray("rows").length() == 1) {
                            AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), jsonObject.get("resultMessage").toString(), null);
                        }
                    } catch (JSONException e) {
                        AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    } catch (Exception e) {
                        AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), e.toString(), null);
                        FirebaseCrashlytics.getInstance().recordException(e);
                    }
                }

                @Override
                public void httpRequestError() {
                    AlertUtil.okDialog(LoginActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                }
            });
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }
}
