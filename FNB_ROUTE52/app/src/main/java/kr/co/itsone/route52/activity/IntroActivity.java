package kr.co.itsone.route52.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.view.WindowManager;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.google.firebase.crashlytics.FirebaseCrashlytics;
import com.google.firebase.messaging.FirebaseMessaging;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import kr.co.itsone.route52.BuildConfig;
import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.CompanyEntity;
import kr.co.itsone.route52.entity.CosEntity;
import kr.co.itsone.route52.entity.DiscountEntity;
import kr.co.itsone.route52.entity.MenuDivisionEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.SaleDivEntity;
import kr.co.itsone.route52.entity.ShopEntity;
import kr.co.itsone.route52.util.AQueryUtil;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class IntroActivity extends AppCompatActivity {

    ProgressBar mProgressBar;
    TextView mTxtDownload;
    String mProgressString = "데이터를 다운로드 중입니다.... (%d/8)";

    @SuppressLint("SourceLockedOrientationActivity")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_intro);

        init();
    }

    private void init() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    if(!Utils.getNetworkStatus(IntroActivity.this)) {
                        AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
                        return;
                    }

                    FirebaseMessaging.getInstance().subscribeToTopic("syncTables");

                    mProgressBar = findViewById(R.id.progress_intro_download);
                    mTxtDownload = findViewById(R.id.txt_intro_download);

                    mProgressBar.setProgress(0);
                    mProgressBar.setMax(7);
                    mTxtDownload.setText(String.format(mProgressString, 0));

                    Globals.mCompanys.clear();
                    Globals.mCoses.clear();
                    Globals.mShops.clear();
                    Globals.mDiscounts.clear();
                    Globals.mMenuDivs.clear();
                    Globals.mMenus.clear();

                    versionCheck();
                } catch (Exception e) {
                    FirebaseCrashlytics.getInstance().recordException(e);
                    e.printStackTrace();
                }
            }
        }, 500);
    }

    private void versionCheck(){
        String sUrl = getString(R.string.host) + getString(R.string.versionCheck);

        Map<String, Object> params = new HashMap<>();

        new AQueryUtil(IntroActivity.this, sUrl, params, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    if(!jsonObject.getString("rows").equals("")) {
                        JSONObject obj = jsonObject.getJSONObject("rows");

                        int versionCode = Integer.valueOf(obj.getString("VERSION_CODE"));
                        final String downloadUrl = obj.getString("DOWNLOAD_URL");

                        if(BuildConfig.VERSION_CODE >= versionCode){
                            mProgressBar.setProgress(1);
                            mTxtDownload.setText(String.format(mProgressString, 1));

                            downloadCompany();
                        } else {
                            AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), "새로운 버전의 앱을 다운로드 받습니다.\n" +
                                    "다운로드가 완료되면 다운로드 받은 파일을 설치해주세요.", new AlertUtil.okDialogListener() {
                                @Override
                                public void onOk() {
                                    try {
                                        Uri downloadUri = Uri.parse(downloadUrl);
                                        Intent downloadIntent  = new Intent(Intent.ACTION_VIEW, downloadUri);
                                        startActivity(downloadIntent);
                                    } catch (Exception e) {
                                        FirebaseCrashlytics.getInstance().recordException(e);
                                    }
                                }
                            });
                        }
                    } else {
                        AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), "서버에 버전정보가 없습니다.\n관리자에게 문의하세요.", null);
                    }
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadCompany(){
        String sUrl = getString(R.string.host) + getString(R.string.getCompanyList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mCompanys.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        CompanyEntity entity = new CompanyEntity();

                        entity.setCode(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("CO_NAME"), ""));

                        Globals.mCompanys.add(entity);
                    }

                    mProgressBar.setProgress(2);
                    mTxtDownload.setText(String.format(mProgressString, 2));

                    downloadCos();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadCos(){
        String sUrl = getString(R.string.host) + getString(R.string.getCosList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mCoses.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        CosEntity entity = new CosEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setCode(Utils.isNullOrEmpty(obj.getString("CD_CODE"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("CD_NAME"), ""));

                        Globals.mCoses.add(entity);
                    }

                    mProgressBar.setProgress(3);
                    mTxtDownload.setText(String.format(mProgressString, 3));

                    downloadShop();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadShop(){
        String sUrl = getString(R.string.host) + getString(R.string.getShopList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mShops.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        ShopEntity entity = new ShopEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setCode(Utils.isNullOrEmpty(obj.getString("CD_CODE"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("CD_NAME"), ""));

                        Globals.mShops.add(entity);
                    }

                    mProgressBar.setProgress(4);
                    mTxtDownload.setText(String.format(mProgressString, 4));

                    downloadDiscount();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadDiscount(){
        String sUrl = getString(R.string.host) + getString(R.string.getDiscountList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mDiscounts.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        DiscountEntity entity = new DiscountEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setCode(Utils.isNullOrEmpty(obj.getString("CD_CODE"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("CD_NAME"), ""));

                        Globals.mDiscounts.add(entity);
                    }

                    mProgressBar.setProgress(5);
                    mTxtDownload.setText(String.format(mProgressString, 5));

                    downloadSaleDiv();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadSaleDiv(){
        String sUrl = getString(R.string.host) + getString(R.string.getSaleDivList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mSaleDivs.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        SaleDivEntity entity = new SaleDivEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setCode(Utils.isNullOrEmpty(obj.getString("CD_CODE"), ""));
                        entity.setName(Utils.isNullOrEmpty(obj.getString("CD_NAME"), ""));

                        Globals.mSaleDivs.add(entity);
                    }

                    mProgressBar.setProgress(6);
                    mTxtDownload.setText(String.format(mProgressString, 6));

                    downloadMenuDiv();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadMenuDiv(){
        String sUrl = getString(R.string.host) + getString(R.string.getMenuDivList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mMenuDivs.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        MenuDivisionEntity entity = new MenuDivisionEntity();

                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setPdShop(Utils.isNullOrEmpty(obj.getString("PD_SHOP"), ""));
                        entity.setMidCode(Utils.isNullOrEmpty(obj.getString("MID_CODE"), ""));
                        entity.setMidName(Utils.isNullOrEmpty(obj.getString("MID_NAME"), ""));
                        entity.setSmallCode(Utils.isNullOrEmpty(obj.getString("SMALL_CODE"), ""));
                        entity.setSmallName(Utils.isNullOrEmpty(obj.getString("SMALL_NAME"), ""));

                        Globals.mMenuDivs.add(entity);
                    }

                    mProgressBar.setProgress(7);
                    mTxtDownload.setText(String.format(mProgressString, 7));

                    downloadMenu();
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void downloadMenu(){
        String sUrl = getString(R.string.host) + getString(R.string.getMenuList);

        new AQueryUtil(IntroActivity.this, sUrl, null, false, "", "", new AQueryUtil.AQueryListener() {
            @Override
            public void httpRequestComplete(JSONObject jsonObject) {
                try {
                    Globals.mMenus.clear();

                    for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                        JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                        MenuEntity entity = new MenuEntity();


                        entity.setCoDiv(Utils.isNullOrEmpty(obj.getString("CO_DIV"), ""));
                        entity.setPdShop(Utils.isNullOrEmpty(obj.getString("PD_SHOP"), ""));
                        entity.setMidCode(Utils.isNullOrEmpty(obj.getString("MID_CODE"), ""));
                        entity.setSmallCode(Utils.isNullOrEmpty(obj.getString("SMALL_CODE"), ""));
                        entity.setPdCd(Utils.isNullOrEmpty(obj.getString("PD_CD"), ""));
                        entity.setPdName(Utils.isNullOrEmpty(obj.getString("PD_NAME"), ""));
                        entity.setPdVatYn(Utils.isNullOrEmpty(obj.getString("PD_VAT_YN"), ""));
                        entity.setPdCost(Utils.isNullOrEmpty(obj.getString("PD_COST"), ""));
                        entity.setPdVat(Utils.isNullOrEmpty(obj.getString("PD_VAT"), ""));
                        entity.setSlAmount(Utils.isNullOrEmpty(obj.getString("PD_AMOUNT"), ""));
                        entity.setPdAmount(Utils.isNullOrEmpty(obj.getString("PD_AMOUNT"), ""));
                        entity.setPdImageUrl(Utils.isNullOrEmpty(obj.getString("PD_IMAGE_URL"), ""));
                        entity.setPrintYn(Utils.isNullOrEmpty(obj.getString("PRINT_YN"), ""));

                        Globals.mMenus.add(entity);
                    }

                    mProgressBar.setProgress(8);
                    mTxtDownload.setText(String.format(mProgressString, 8));

                    new Handler().postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            sucDownload();
                        }
                    }, 500);
                } catch (JSONException e) {
                    AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), e.toString(), null);
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void httpRequestError() {
                AlertUtil.okDialog(IntroActivity.this, getString(R.string.message_header), getString(R.string.network_error), null);
            }
        });
    }

    private void sucDownload() {
        try {
            Intent intent = new Intent(IntroActivity.this, LoginActivity.class);

            startActivity(intent);

            finish();
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }
}
