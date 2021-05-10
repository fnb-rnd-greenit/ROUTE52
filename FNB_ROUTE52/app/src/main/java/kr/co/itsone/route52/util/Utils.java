package kr.co.itsone.route52.util;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Service;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.OrderEntity;

/**
 * @author Administrator
 * @description
 */
public class Utils {
	public static final String PROFILE_DATA = "PROFILE_DATA";

	/**
	 * UTF-8 인코딩
	 * @param sParam 인고딩할 문자
	 * */
	public static String getEncodeUTF8(String sParam){
		String sReturnValue = "";
		try {
			sReturnValue = java.net.URLEncoder.encode(sParam, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return sReturnValue;
	}

	/**
	 * SharedPreferences 저장
	 * @param context
	 * @param key
	 * @param value
	 * */
	public static void saveSharedPreferences(Context context, String key, String value) {
		SharedPreferences spf = context.getSharedPreferences(PROFILE_DATA, Service.MODE_PRIVATE);
		SharedPreferences.Editor edit = spf.edit();
		edit.putString(key, value);
		edit.commit();
	}

	/**
	 * SharedPreferences 저장
	 * @param context
	 * @param key
	 * @param value
	 * */
	public static void saveSharedPreferences(Context context, String key, int value) {
		SharedPreferences spf = context.getSharedPreferences(PROFILE_DATA, Service.MODE_PRIVATE);
		SharedPreferences.Editor edit = spf.edit();
		edit.putInt(key, value);
		edit.commit();
	}

	/**
	 * SharedPreferences 로드
	 * @param context
	 * @param key
	 * */
	public static String loadSharedPreferences(Context context, String key) {
		SharedPreferences spf = context.getSharedPreferences(PROFILE_DATA, Service.MODE_PRIVATE);
		return spf.getString(key, "");
	}

	/**
	 * SharedPreferences 로드
	 * @param context
	 * @param key
	 * */
	public static String loadSharedPreferences(Context context, String key, String defValue) {
		SharedPreferences spf = context.getSharedPreferences(PROFILE_DATA, Service.MODE_PRIVATE);
		String value = spf.getString(key, defValue);
		return value.equals("") ? defValue : value;
	}

	/**
	 * SharedPreferences 로드
	 * @param context
	 * @param key
	 * */
	public static int loadSharedPreferences(Context context, String key, int defValue) {
		SharedPreferences spf = context.getSharedPreferences(PROFILE_DATA, Service.MODE_PRIVATE);
		return spf.getInt(key, defValue);
	}

	/**
	 * 현재시간 가져오기
	 * @param type 형식 yyyy-MM-dd'T'hh:mm:ss
	 * @return
	 */
	public static String getCurrentDate(String type){
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat(type , Locale.KOREA);
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format(currentTime);

		return mTime;
	}

	/**
	 * 날짜 포맷
	 * @param sDate
	 * @param type
	 * @return
	 */
	public static String getDateFormat(String sDate, String type){
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Date date;
		String sValue = "";
		try {
			date = format.parse(sDate);
			SimpleDateFormat sdf = new SimpleDateFormat(type);
			sValue = sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return sValue;
	}

	/**
	 * 날짜계산
	 * @param type return 날짜포맷형식
	 * @param sDate 계산기준날짜
	 * @param addValue 더할 날짜
	 * */
	public static String getAddDate(String type, String sDate, int addValue){
		String returnValue = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(type);
			Date date = sdf.parse(sDate);

			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, addValue);

			returnValue = sdf.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnValue;
	}

	/**
	 * 날짜계산(오늘기준)
	 * @param type return 날짜포맷형식
	 * @param addValue 더할 날짜
	 * */
	public static String getAddDate(String type, int addValue){
		String returnValue = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(type);

			Calendar cal = Calendar.getInstance();

			cal.add(Calendar.DATE, addValue);

			returnValue = sdf.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnValue;
	}

	/**
	 * 화면 폭 구하기
	 * @param activity
	 * @return
	 */
	public static int getDisplayWidth(Activity activity){
		DisplayMetrics displayMetrics = new DisplayMetrics();
		activity.getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		return displayMetrics.widthPixels;
	}

	/**
	 * 천원단위 콤마 포맷
	 * @param money
	 */
	public static String moneyDecimalFormat(int money){
		String sValue = "";

		try{
			DecimalFormat df = new DecimalFormat("###,###.####");
			sValue = df.format(money);
		}catch (Exception e){
			e.printStackTrace();
		}

		return sValue;
	}

	/**
	 * 천원단위 콤마 포맷(Long)
	 * @param money
	 * @return
	 */
	public static String moneyDecimalFormat(long money){
		String sValue = "";

		try{
			DecimalFormat df = new DecimalFormat("###,###.####");
			sValue = df.format(money);
		}catch (Exception e){
			e.printStackTrace();
		}

		return sValue;
	}

	/**
	 * Json Value is Null Or Empty
	 * @param value
	 * @param defaultValue
	 * @return
	 * */
	public static String isNullOrEmpty(String value, String defaultValue){
		return value == null || value.equals("null") || value.equals("") ? defaultValue : value;
	}

	/**
	 * Uri -> Path 변환
	 * @param context
	 * @param uri
	 * @return
	 * */
	public static String getPathFromUri(Context context, Uri uri){
		Cursor cursor = context.getContentResolver().query(uri, null, null, null, null );
		cursor.moveToNext();
		String path = cursor.getString( cursor.getColumnIndex( "_data" ) );
		cursor.close();
		return path;
	}

	/**
	 * 파일 확장자 가져오기
	 * */
	public static String getFileExtend(String name) {
		String returnValue = "";

		try {
			if (name.lastIndexOf(".") > 0) {
				returnValue = name.substring(name.lastIndexOf("."), name.length());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnValue;
	}

	/**
	 * 인터넷상태 확인
	 * */
	public static boolean getNetworkStatus(Context context){
		boolean returnValue = false;

		try {
			ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
			NetworkInfo activeNetwork = cm.getActiveNetworkInfo();
			if (activeNetwork != null) {
				if (activeNetwork.getType() == ConnectivityManager.TYPE_WIFI) {
					returnValue = true;
				} else if (activeNetwork.getType() == ConnectivityManager.TYPE_MOBILE) {
					returnValue = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			returnValue = false;
		} finally {
			return returnValue;
		}
	}

	public static void keyboardShow(Activity activity) {
		InputMethodManager imm = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
		View v = activity.getCurrentFocus();
		if (v == null) {
			v = new View(activity);
		}
		imm.showSoftInput(v, 0);
	}

	public static void keyboardHide(Activity activity) {
		InputMethodManager imm = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
		View v = activity.getCurrentFocus();
		if (v == null) {
			v = new View(activity);
		}
		imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
	}

	public static String getTimeFormat(String time) {
		try {
			return time.substring(0, 2) + ":" + time.substring(2, 4);
		} catch (Exception e) {
			return "";
		}
	}

	public static String getEncryptName(String name) {
		String returnValue = "";

		if(name.length() >= 3) {
			String sEncrypt = "";
			for(int i=0; i<name.length()-2; i++) {
				sEncrypt += "*";
			}
			returnValue = String.format("%s %s %s", name.substring(0, 1), sEncrypt, name.substring(name.length() - 1, name.length()));
		} else if(name.length() >= 2 && name.length() < 3) {
			returnValue = name.substring(0, 1) + " *";
		} else {
			returnValue = "*";
		}

		return returnValue;
	}

	public static JSONObject orderParsingListToJson(String slNo, String table, String user, List<OrderEntity> items) {
		JSONObject returnValue = new JSONObject();

		try {
			returnValue.put("slNo", slNo);
			returnValue.put("table", table);
			returnValue.put("user", user);

			JSONArray orders = new JSONArray();

			for(OrderEntity order : items) {
				JSONObject tmp = new JSONObject();

				JSONObject visitor = new JSONObject();

				visitor.put("isSelected", order.getVisitor().isSelected());
				visitor.put("isLock", order.getVisitor().isLock());
				visitor.put("coDiv", order.getVisitor().getCoDiv());
				visitor.put("chkInNo", order.getVisitor().getChkInNo());
				visitor.put("day", order.getVisitor().getDay());
				visitor.put("cos", order.getVisitor().getCos());
				visitor.put("cosNm", order.getVisitor().getCosNm());
				visitor.put("time", order.getVisitor().getTime());
				visitor.put("name", order.getVisitor().getName());
				visitor.put("locker", order.getVisitor().getLocker());
				visitor.put("gpNum", order.getVisitor().getGpNum());
				visitor.put("gpName", order.getVisitor().getGpName());
				visitor.put("msNum", order.getVisitor().getMsNum());
				visitor.put("part", order.getVisitor().getPart());
				visitor.put("bkName", order.getVisitor().getBkName());
				visitor.put("caddyNum", order.getVisitor().getCaddyNum());
				visitor.put("cyName", order.getVisitor().getCyName());
				visitor.put("cartNo", order.getVisitor().getCartNo());
				visitor.put("seatNo", order.getVisitor().getSeatNo());

				tmp.put("visitor", visitor);

				JSONArray menus = new JSONArray();

				for(MenuEntity menu : order.getMenues()) {
					JSONObject tmp2 = new JSONObject();

					tmp2.put("newYn", menu.isNewYn());
					tmp2.put("coDiv", menu.getCoDiv());
					tmp2.put("pdShop", menu.getPdShop());
					tmp2.put("midCode", menu.getMidCode());
					tmp2.put("midName", menu.getMidName());
					tmp2.put("smallCode", menu.getSmallCode());
					tmp2.put("smallName", menu.getSmallName());
					tmp2.put("slSeq", menu.getSlSeq());
					tmp2.put("pdCd", menu.getPdCd());
					tmp2.put("pdName", menu.getPdName());
					tmp2.put("pdVatYn", menu.getPdVatYn());
					tmp2.put("pdVat", menu.getPdVat());
					tmp2.put("pdCost", menu.getPdCost());
					tmp2.put("slAmount", menu.getSlAmount());
					tmp2.put("pdAmount", menu.getPdAmount());
					tmp2.put("pdImageUrl", menu.getPdImageUrl());
					tmp2.put("slDcRate", menu.getSlDcRate());
					tmp2.put("slGubun", menu.getSaleDiv());
					tmp2.put("memo", menu.getMemo());
					tmp2.put("printYn", menu.getPrintYn());
					tmp2.put("slDcRateIdx", menu.getSlDcRateIdx());
					tmp2.put("orderCnt", menu.getOrderCnt());
					tmp2.put("orderCost", menu.getOrderCost());

					menus.put(tmp2);
				}

				tmp.put("menus", menus);

				orders.put(tmp);
			}

			returnValue.put("items", orders);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnValue;
	}
	public static Map<String, Object> orderParsingJsonToList(String data) {
		Map<String, Object> returnValue = new HashMap<>();
		List<OrderEntity> list = new ArrayList<>();

		try {
			String againYn = new JSONObject(data).getString("againYn");
			returnValue.put("againYn", againYn);

			JSONObject obj = new JSONObject(data).getJSONObject("sData");

			returnValue.put("slNo", obj.get("slNo").toString());
			returnValue.put("table", obj.get("table").toString());
			returnValue.put("user", obj.get("user").toString());

			JSONArray items = obj.getJSONArray("items");

			for(int i=0; i<items.length(); i++) {
				OrderEntity order = new OrderEntity();

				JSONObject item = items.getJSONObject(i).getJSONObject("visitor");

				order.getVisitor().setSelected(getJsonValue(item, "isSelected", false));
				order.getVisitor().setLock(getJsonValue(item, "isLock", true));
				order.getVisitor().setCoDiv(getJsonValue(item, "coDiv", ""));
				order.getVisitor().setChkInNo(getJsonValue(item, "chkInNo", ""));
				order.getVisitor().setDay(getJsonValue(item, "day", ""));
				order.getVisitor().setCos(getJsonValue(item, "cos", ""));
				order.getVisitor().setCosNm(getJsonValue(item, "cosNm", ""));
				order.getVisitor().setTime(getJsonValue(item, "time", ""));
				order.getVisitor().setName(getJsonValue(item, "name", ""));
				order.getVisitor().setLocker(getJsonValue(item, "locker", ""));
				order.getVisitor().setGpNum(getJsonValue(item, "gpNum", ""));
				order.getVisitor().setGpName(getJsonValue(item, "gpName", ""));
				order.getVisitor().setMsNum(getJsonValue(item, "msNum", ""));
				order.getVisitor().setPart(getJsonValue(item, "part", ""));
				//order.getVisitor().setName(getJsonValue(item, "bkName", ""));
				order.getVisitor().setCaddyNum(getJsonValue(item, "caddyNum", ""));
				order.getVisitor().setCyName(getJsonValue(item, "cyName", ""));
				order.getVisitor().setCartNo(getJsonValue(item, "cartNo", ""));
				order.getVisitor().setSeatNo(getJsonValue(item, "seatNo", "999"));

				JSONArray menus = items.getJSONObject(i).getJSONArray("menus");

				for(int j=0; j<menus.length(); j++) {
					JSONObject menu = menus.getJSONObject(j);

					MenuEntity tmp = new MenuEntity();

					tmp.setNewYn(getJsonValue(menu, "newYn", true));
					tmp.setCoDiv(getJsonValue(menu, "coDiv", ""));
					tmp.setPdShop(getJsonValue(menu, "pdShop", ""));
					tmp.setMidCode(getJsonValue(menu, "midCode", ""));
					tmp.setMidName(getJsonValue(menu, "midName", ""));
					tmp.setSmallCode(getJsonValue(menu, "smallCode", ""));
					tmp.setSmallName(getJsonValue(menu, "smallName", ""));
					tmp.setSlSeq(getJsonValue(menu, "slSeq", ""));
					tmp.setPdCd(getJsonValue(menu, "pdCd", ""));
					tmp.setPdName(getJsonValue(menu, "pdName", ""));
					tmp.setPdVatYn(getJsonValue(menu, "pdVatYn", ""));
					tmp.setPdVat(getJsonValue(menu, "pdVat", ""));
					tmp.setPdCost(getJsonValue(menu, "pdCost", ""));
					tmp.setSlAmount(getJsonValue(menu, "slAmount", ""));
					tmp.setPdAmount(getJsonValue(menu, "pdAmount", ""));
					tmp.setPdImageUrl(getJsonValue(menu, "pdImageUrl", ""));
					tmp.setSlDcRate(getJsonValue(menu, "slDcRate", ""));
					tmp.setSaleDiv(getJsonValue(menu, "slGubun", ""));
					tmp.setMemo(getJsonValue(menu, "memo", ""));
					tmp.setPrintYn(getJsonValue(menu, "printYn", ""));
					tmp.setSlDcRateIdx(getJsonValue(menu, "slDcRateIdx", 0));
					tmp.setOrderCnt(getJsonValue(menu, "orderCnt", 0));
					tmp.setOrderCost(getJsonValue(menu, "orderCost", 0));

					order.getMenues().add(tmp);
				}

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			returnValue.put("list", list);
		}

		return returnValue;
	}

	public static String getJsonValue(JSONObject obj, String key, String defaultValue){
		String returnValue = defaultValue;

		try {
			returnValue = obj.getString(key);

			returnValue = returnValue == null || returnValue.equals("null") || returnValue.equals("") ? defaultValue : returnValue;
		} catch (Exception e) {
			returnValue = defaultValue;
		}

		return returnValue;
	}

	public static boolean getJsonValue(JSONObject obj, String key, boolean defaultValue){
		boolean returnValue = defaultValue;

		try {
			returnValue = obj.getBoolean(key);
		} catch (Exception e) {
			returnValue = defaultValue;
		}

		return returnValue;
	}

	public static int getJsonValue(JSONObject obj, String key, int defaultValue){
		int returnValue = defaultValue;

		try {
			returnValue = obj.getInt(key);
		} catch (Exception e) {
			returnValue = defaultValue;
		}

		return returnValue;
	}

	@SuppressLint("UnsupportedChromeOsCameraSystemFeature")
	public static boolean checkCameraHardware(Context context) {
		if (context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA)){
			// this device has a camera
			return true;
		} else {
			// no camera on this device
			return false;
		}
	}
}
