package kr.co.itsone.route52.service;

import android.annotation.TargetApi;
import android.app.ActivityManager;
import android.app.Notification;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.androidquery.AQuery;
import com.androidquery.callback.AjaxCallback;
import com.androidquery.callback.AjaxStatus;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.activity.MainActivity;
import kr.co.itsone.route52.entity.OrderEntity;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.IdleChangeReceiver;
import kr.co.itsone.route52.util.PrinterThread;
import kr.co.itsone.route52.util.Utils;

import static kr.co.itsone.route52.App.CHANNEL_ID;

public class PrinterService extends Service {

    private final String TAG = getClass().getSimpleName();

    PrinterServiceThread thread = new PrinterServiceThread();
    private BroadcastReceiver receiver = new IdleReceiver();

    public PrinterService() {
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Intent notificationIntent = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, 0);

        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("프린터 서비스")
                .setContentText("프린터 서비스가 작동중입니다.")
                .setSmallIcon(R.mipmap.ic_launcher)
                //.setContentIntent(pendingIntent)
                .build();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            registerReceiver(receiver, IdleReceiver.Filter);
        }

        startForeground(1, notification);

        thread.start();

        return START_NOT_STICKY;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        thread.setStop(true);
    }

    class PrinterServiceThread extends Thread {
        boolean isStop = false;

        public PrinterServiceThread() {
        }

        @Override
        public void run() {
            try {
                while(!isStop) {
                    Thread.sleep(5000);

                    getReceiptData();

                    dumpProcessPriority();
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        public void setStop(boolean isStop) {
            this.isStop = isStop;
        }

        private void getReceiptData() {
            String sUrl = getString(R.string.host) + getString(R.string.getReceiptData);
            Map<String, Object> params = new HashMap<>();

            params.put("coDiv", Utils.loadSharedPreferences(getApplicationContext(), Globals.COMPANY));
            params.put("shop", Utils.loadSharedPreferences(getApplicationContext(), Globals.SHOP));
            params.put("userId", Utils.loadSharedPreferences(getApplicationContext(), Globals.IN_ID));

            AQuery aq = new AQuery(getApplicationContext());

            AjaxCallback<JSONObject> cb = new AjaxCallback<JSONObject>(){
                @Override
                public void callback(String url, JSONObject jsonObject, AjaxStatus status) {
                    try{
                        if(status.getCode() == 200){
                            try {
                                for(int i=0; i<jsonObject.getJSONArray("rows").length(); i++){
                                    JSONObject obj = jsonObject.getJSONArray("rows").getJSONObject(i);

                                    String coDiv = Utils.isNullOrEmpty(obj.getString("FB_CODIV"), "");
                                    String shop = Utils.isNullOrEmpty(obj.getString("FB_SHOP"), "");
                                    String date = Utils.isNullOrEmpty(obj.getString("FB_DATE"), "");
                                    String seq = Utils.isNullOrEmpty(obj.getString("FB_SEQ"), "");
                                    String content = Utils.isNullOrEmpty(obj.getString("FB_CONTENT"), "");

                                    Map<String, Object> data = Utils.orderParsingJsonToList(content);

                                    PrinterThread printerThread = new PrinterThread(getApplicationContext(), coDiv, shop, date, seq, data.get("againYn").toString(), data.get("slNo").toString(), data.get("table").toString(), data.get("user").toString(), (List<OrderEntity>)data.get("list"));

                                    printerThread.start();
                                    printerThread.join();
                                }
                            } catch (JSONException e) {
                                FirebaseCrashlytics.getInstance().recordException(e);
                            }
                        }
                    } catch (Exception e){
                        e.printStackTrace();
                    }
                }
            };

            cb.setTimeout(5000);

            aq.ajax(sUrl, params, JSONObject.class, cb);
        }
    }

    public static class IdleReceiver extends IdleChangeReceiver {
        @TargetApi(Build.VERSION_CODES.M)
        @Override
        public void onReceive(Context context, Intent intent) {

            PowerManager pm = (PowerManager) context.getSystemService(POWER_SERVICE);
            if (pm.isDeviceIdleMode()){
                launchMaskActivtiy(context);
            }
        }
    }

    private void dumpProcessPriority() {
        try {
            ActivityManager am = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
            List<ActivityManager.RunningAppProcessInfo> processList = am.getRunningAppProcesses();
            for(ActivityManager.RunningAppProcessInfo info : processList) {
                Log.d(TAG, "Process Name:" + info.processName + "[" + getPriorityDesc(info.importance) + "]");
            }
        } catch(Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    private String getPriorityDesc(int priority) {

        if(priority <= 100) {
            return "IMPORTANCE_FOREGROUND";
        } else if (priority <= 125) {
            return "IMPORTANCE_FOREGROUND_SERVICE";
        } else if (priority <=150) {
            return "IMPORTANCE_TOP_SLEEPING";
        } else if (priority <= 200) {
            return "IMPORTANCE_VISIBLE";
        }

        return "IMPORTANCE_ETC";
    }
}
