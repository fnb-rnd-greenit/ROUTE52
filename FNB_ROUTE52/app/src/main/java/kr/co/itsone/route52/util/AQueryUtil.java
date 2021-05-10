package kr.co.itsone.route52.util;

import android.app.ProgressDialog;
import android.content.Context;

import com.androidquery.AQuery;
import com.androidquery.callback.AjaxCallback;
import com.androidquery.callback.AjaxStatus;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONObject;

import java.util.Map;

public class AQueryUtil {

	private final int TIME_OUT = 60000;
	private String url;
	private Map<String, Object> params;
	private Context context;
	private String proTitle;
	private String proMessage;
	private boolean proFlag;
	private AQueryListener listener;
	private ProgressDialog dialog;

	/**
	 * @param context
	 * @param url 보낼주소
	 * @param params 파라미터
	 * @param proFlag 다이얼로그 사용 true 미사용 false
	 * @param proTitle 로딩에 타이틀
	 * @param proMessage 로딩에 메시지
	 * @param listener 콜백받을 인터페이스
	 */
	public AQueryUtil(Context context, String url, Map<String, Object> params, boolean proFlag, String proTitle, String proMessage, AQueryListener listener){
		this.context = context;
		this.url = url;
		this.params = params;
		this.proTitle = proTitle;
		this.proMessage = proMessage;
		this.listener = listener;
		this.proFlag = proFlag;

		progressInit();

		init();
	}

	private void progressInit(){
		dialog = new ProgressDialog(context);
		dialog.setTitle(proTitle);
		dialog.setMessage(proMessage);
		dialog.setCancelable(false);
	}

	private void progressDismiss(){
		if(dialog.isShowing()) dialog.dismiss();
	}

	private void init(){
		if(proFlag) dialog.show();

		try{
			AQuery aq = new AQuery(context);

			AjaxCallback<JSONObject> cb = new AjaxCallback<JSONObject>(){
				@Override
				public void callback(String url, JSONObject object, AjaxStatus status) {
					try{
						if(status.getCode() == 200){
							if(object != null){
								if(listener!= null) {
									listener.httpRequestComplete(object);
								}
								progressDismiss();
							}else{
								if(listener!= null) {
									listener.httpRequestError();
								}
								progressDismiss();
							}
						}else{
							if(listener!= null) {
								listener.httpRequestError();
							}
							progressDismiss();
						}
					} catch (Exception e){
						e.printStackTrace();
					}
				}
			};

			cb.setTimeout(TIME_OUT);

			aq.ajax(url, params, JSONObject.class, cb);
		}catch (Exception e){
			FirebaseCrashlytics.getInstance().recordException(e);
			if(listener!= null) {
				listener.httpRequestError();
			}
			progressDismiss();
		}
	}

	public interface AQueryListener {
		void httpRequestComplete(JSONObject jsonObject);
		void httpRequestError();
	}
}
