package kr.co.itsone.route52.util;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.media.SoundPool;
import android.net.Uri;
import android.os.Build;
import android.os.PowerManager;
import android.os.Vibrator;
import android.util.Log;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.activity.CallAlert;

public class MyFirebaseMessagingService extends FirebaseMessagingService {

    private final String TAG = getClass().getSimpleName();
    private static FirebaseMessagingListener mListener;
    private static FirebaseMessagingListener2 mListener2;
    private static FirebaseMessagingListener3 mListener3;
    private static FirebaseMessagingListener4 mListener4;

    private final int SYNC_TABLES = 1000;
    private final int SYNC_GMS = 1100;
    private final int CALL_EMPLOYEE = 2000;
    private final int PRINT = 3000;
    private final int ORDER_COMPLETE = 4000;
    private final int ALARM = 5000;

    private SoundPool mSound;
    private int mAlarm;

    @Override
    public void onNewToken(String token) {
        Log.d(TAG, "Refreshed token: " + token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        String mCompany = Utils.loadSharedPreferences(this, Globals.COMPANY);
        String mShop = Utils.loadSharedPreferences(this, Globals.SHOP);

        String coDiv = remoteMessage.getData().get("coDiv");
        String shop = remoteMessage.getData().get("shop");

        if(!mCompany.equals(coDiv) || !mShop.equals(shop)) {
            return;
        }

        if(Integer.valueOf(remoteMessage.getData().get("division")) == SYNC_TABLES) {
            if(mListener != null) {
                mListener.onSyncTables();
            }
        } else if(Integer.valueOf(remoteMessage.getData().get("division")) == SYNC_GMS) {
            if(mListener != null) {
                mListener.onSyncTables();
            }

            String slNo = remoteMessage.getData().get("title");

            if(mListener2 != null && slNo != null && !slNo.equals("")) {
                mListener2.onSyncTables(slNo);
            }

            if(mListener3 != null && slNo != null && !slNo.equals("")) {
                mListener3.onSyncTables(slNo);
            }

            if(mListener4 != null && slNo != null && !slNo.equals("")) {
                mListener4.onSyncTables(slNo);
            }
        } else if(Integer.valueOf(remoteMessage.getData().get("division")) == CALL_EMPLOYEE) {
            String message = remoteMessage.getData().get("tableName") + "\n고객님 호출입니다.";

            showNotification(message);

            PowerManager pm = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
            PowerManager.WakeLock wakelock = pm.newWakeLock(PowerManager.FULL_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP, TAG);
            wakelock.acquire(5000);

            Vibrator vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
            vibe.vibrate(1000);

            Uri uri = RingtoneManager.getActualDefaultRingtoneUri(getApplicationContext(),RingtoneManager.TYPE_NOTIFICATION);
            Ringtone ringtone = RingtoneManager.getRingtone(getApplicationContext(), uri);
            ringtone.play();

            Intent intent;
            intent = new Intent(this, CallAlert.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("message", message);
            startActivity(intent);
        } else if(Integer.valueOf(remoteMessage.getData().get("division")) == ORDER_COMPLETE) {
            String slDay = remoteMessage.getData().get("slDay");
            String slNo = remoteMessage.getData().get("slNo");
            String tableNm = remoteMessage.getData().get("tableNm");
            String pdName = remoteMessage.getData().get("pdName");
            String slCount = remoteMessage.getData().get("slCount");
            String message = String.format("[%s]\n%s * %s\n조리 완료되었습니다.", tableNm, pdName, slCount);

            showNotification(message);

            PowerManager pm = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
            PowerManager.WakeLock wakelock = pm.newWakeLock(PowerManager.FULL_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP, TAG);
            wakelock.acquire(5000);

            Vibrator vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
            vibe.vibrate(1000);

            Uri uri = RingtoneManager.getActualDefaultRingtoneUri(getApplicationContext(),RingtoneManager.TYPE_NOTIFICATION);
            Ringtone ringtone = RingtoneManager.getRingtone(getApplicationContext(), uri);
            ringtone.play();

            Intent intent;
            intent = new Intent(this, CallAlert.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("slDay", slDay);
            intent.putExtra("slNo", slNo);
            intent.putExtra("message", message);
            startActivity(intent);
        } else if(Integer.valueOf(remoteMessage.getData().get("division")) == PRINT) {
            /*Map<String, Object> data = Utils.orderParsingJsonToList(remoteMessage.getData().get("message"));

            PrinterThread thread = new PrinterThread(this, data.get("againYn").toString(), data.get("slNo").toString(), data.get("table").toString(), data.get("user").toString(), (List<OrderEntity>)data.get("list"));

            thread.start();*/
        }
    }

    public static void setFirebaseMessagingListener(FirebaseMessagingListener listener) {
        mListener = listener;
    }

    public static void setFirebaseMessagingListener2(FirebaseMessagingListener2 listener) {
        mListener2 = listener;
    }

    public static void setFirebaseMessagingListener3(FirebaseMessagingListener3 listener) {
        mListener3 = listener;
    }

    public static void setFirebaseMessagingListener4(FirebaseMessagingListener4 listener) {
        mListener4 = listener;
    }

    private void showNotification(String message) {
        try {
            NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

            Notification.Builder mBuilder = new Notification.Builder(this);

            mBuilder.setContentTitle(getString(R.string.app_name))
                    .setContentText(message)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setAutoCancel(true);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                manager.notify(0, mBuilder.build());
            }
        }  catch (Exception e) {
            e.printStackTrace();
        }
    }
}
