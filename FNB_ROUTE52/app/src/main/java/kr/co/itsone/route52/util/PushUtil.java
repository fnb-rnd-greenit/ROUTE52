package kr.co.itsone.route52.util;

import android.content.Context;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONObject;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import kr.co.itsone.route52.R;

public class PushUtil {

    public static final int SYNC_TABLES = 1000;
    public static final int CALL_EMPLOYEE = 2000;
    public static final int PRINT = 3000;

    public static void pushMessage(Context context, int division){
        PushThread thread = new PushThread(context, division);
        thread.start();
    }

    private static class PushThread extends Thread {
        Context context;
        int division;

        public PushThread(Context context, int division) {
            this.context = context;
            this.division = division;
        }

        @Override
        public void run() {
            try {
                String msg = "";
                if(division == SYNC_TABLES){

                }

                JSONObject root = new JSONObject();
                JSONObject data = new JSONObject();
                data.put("division", division);
                data.put("message", msg);

                root.put("data", data);
                root.put("to", "/topics/syncTables");

                URL Url = new URL(context.getString(R.string.fcm_message_url));
                HttpURLConnection conn = (HttpURLConnection) Url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                conn.setDoInput(true);
                conn.addRequestProperty("Authorization", "key=" + context.getString(R.string.fcm_server_key));
                conn.setRequestProperty("Accept", "application/json");
                conn.setRequestProperty("Content-type", "application/json");
                OutputStream os = conn.getOutputStream();
                os.write(root.toString().getBytes("utf-8"));
                os.flush();
                conn.getResponseCode();
            } catch (Exception e) {
                e.printStackTrace();
                FirebaseCrashlytics.getInstance().recordException(e);
            }
        }
    }
}
