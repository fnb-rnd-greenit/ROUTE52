package itso.common.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Utils {
	
	private static Logger log = Logger.getLogger(Utils.class);
	
    public static void sendData(HttpServletResponse response, Object data) {
    	try {
    		response.setCharacterEncoding("UTF-8"); 
        	response.setContentType("text/html; charset=UTF-8");
        	
        	PrintWriter out = response.getWriter();
            
            out.print(data);
            out.flush();
            out.close();
            
            String logData = data.toString();
            
            logData = logData.length() > 1000 ? logData.substring(0, 1000) : logData;
            
            log.debug(String.format("[SendData] %s", logData));
    	} catch(Exception e) {
    		e.printStackTrace();
    	}    	
    }
	
    public static void sendData(HttpServletResponse response, Object data, boolean logYn) {
    	try {
    		response.setCharacterEncoding("UTF-8"); 
        	response.setContentType("text/html; charset=UTF-8");
        	
        	PrintWriter out = response.getWriter();
            
            out.print(data);
            out.flush();
            out.close();
            
            if(logYn) {
            	log.debug(String.format("[SendData] %s", data.toString()));
            } else {
            	log.debug(String.format("[SendData] %s", "데이터가 길어서 로그 제외"));
            }
    	} catch(Exception e) {
    		e.printStackTrace();
    	}    	
    }
    
    public static String makeJsonString(ResultVO result) {
    	String returnValue = "{ \"resultCode\" : \"%s\", \"resultMessage\" : \"%s\", \"rows\" : %s, \"subData\" : %s }";
    	String mainData = "\"\"";
    	String subData = "\"\"";

    	Gson gson = new GsonBuilder().serializeNulls().create(); 
    	
    	if(result.getData() != null) {
    		mainData = gson.toJson(result.getData());
    	}
    	
    	if(result.getSub() != null) {
    		subData = gson.toJson(result.getSub());
    	}
    	
		returnValue = String.format(returnValue, result.getCode(), result.getMessage(), mainData, subData);
    	
    	return returnValue;
    }
    
    public static String getJsonValue(JSONObject obj, String key){
    	return obj.has(key) ? (obj.get(key) == null ? "" : obj.get(key).toString()) : "";
    }	
    
    public static String getLocalIpAddr() {
    	String returnValue = "";
    	InetAddress local;
		try {
		    local = InetAddress.getLocalHost();
		    returnValue = local.getHostAddress();
		} catch (UnknownHostException e1) {
		    e1.printStackTrace();
		}
		
		return returnValue;
    }
    
    public static String getProperties(String key, String defaultValue) {
    	String returnValue = null;
        
        try{            
            String propFile = new ClassPathResource("globals.properties").getURI().getPath();

            Properties props = new Properties();
             
            FileInputStream fis = new FileInputStream(propFile);
             
            props.load(new java.io.BufferedInputStream(fis));           
            
            returnValue = props.getProperty(key) ;
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return returnValue == null ? defaultValue : returnValue;
    }
    
    public static String getExtension(String fileName) {
    	String returnValue = "";
    	
    	try {
    		returnValue = fileName.substring(fileName.lastIndexOf(".") + 1);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return returnValue;
    }
    
    public static String convertSpecialCharacters(String content) {
    	String returnValue = content;

		returnValue = returnValue.replaceAll("&", "&amp;");
		returnValue = returnValue.replaceAll("<", "&lt;");
		returnValue = returnValue.replaceAll(">", "&gt;");
		returnValue = returnValue.replaceAll("\"", "&quot;");
    	
    	return returnValue;
    }
    
    /**
     * Disposition 지정하기
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    public static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String browser = getBrowser(request);
        
        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;
        
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else {
            throw new IOException("Not supported browser");
        }
        
        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        
        if ("Opera".equals(browser)) {
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
    }
    
    /**
     * 브라우저 구분 얻기
     * @param request
     * @return
     */
    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
            return "Trident";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    public static String getClientIpAddress(HttpServletRequest request) { 
        String ip = request.getHeader("X-Forwarded-For");
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
 
        return ip; 
    }
    
    public static String getClientIpAddress(MultipartHttpServletRequest request) { 
        String ip = request.getHeader("X-Forwarded-For");
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
 
        return ip; 
    }
    
    public static String getCurrentDate(String format) {
    	return new SimpleDateFormat(format).format(new Date());
    }
    
    public static int getDiffOfDate(String begin, String end) {
    	int returnValue = 0;
    	
    	try {
    		 SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    	      
    	      Date beginDate = formatter.parse(begin);
    	      Date endDate = formatter.parse(end);

    	      long diff = endDate.getTime() - beginDate.getTime();
    	      returnValue = (int) (diff / (24 * 60 * 60 * 1000));
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
     
      return returnValue;
    }

    public static final String SYNC_TABLES = "1000";
    public static final String SYNC_GMS = "1100";
    public static final String CALL_EMPLOYEE = "2000";
    public static final String PRINT = "3000";
    public static final String ORDER_COMPLETE = "4000";
    public static final String ALARM = "5000";
    
    /** 
     * @param division 알림 구분
     * @param sendDivision 'topic' : 토픽전송 , 'users' : 유저전송
     * @param topic 토픽
     * @param users 유저
     * @param title 알림 타이틀
     * @param msg 알림 메세지
     * */
    public static void sendPushMessaging(String division, String sendDivision, String topic, ArrayList<String> users, String title, String msg, String coDiv, String shop) throws Exception{
		if(division == null) division = "";
    	if(sendDivision == null) sendDivision = "";
    	if(topic == null) topic = "";
    	if(title == null) title = "";
    	if(msg == null) msg = "";
    	if(users == null) users = new ArrayList<>();
		
		JSONObject root = new JSONObject();
        JSONObject data = new JSONObject();
        data.put("division", division);
        data.put("title", title);
        data.put("message", msg);
        data.put("coDiv", coDiv);
        data.put("shop", shop);

        root.put("data", data);
        
        switch(sendDivision){
			case "topic" : 
		        root.put("to", "/topics/" + topic);
				break;
			case "users" :
				for(String token : users) {
					root.put("to", token);
				}
				break;
		}

        URL Url = new URL("https://fcm.googleapis.com/fcm/send");
        HttpURLConnection conn = (HttpURLConnection) Url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setDoInput(true);
        conn.addRequestProperty("Authorization", "key=" + Globals.fcmServerKey);
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Content-type", "application/json");
        OutputStream os = conn.getOutputStream();
        os.write(root.toString().getBytes("utf-8"));
        os.flush();
        conn.getResponseCode();
    }
    
    public static void sendPushMessaging(String division, String sendDivision, String topic, ArrayList<String> users, JSONObject data) throws Exception{
		if(division == null) division = "";
    	if(sendDivision == null) sendDivision = "";
    	if(topic == null) topic = "";
    	if(users == null) users = new ArrayList<>();
		
		JSONObject root = new JSONObject();
        data.put("division", division);
        
        root.put("data", data);
        
        switch(sendDivision){
			case "topic" : 
		        root.put("to", "/topics/" + topic);
				break;
			case "users" :
				for(String token : users) {
					root.put("to", token);
				}
				break;
		}

        URL Url = new URL("https://fcm.googleapis.com/fcm/send");
        HttpURLConnection conn = (HttpURLConnection) Url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setDoInput(true);
        conn.addRequestProperty("Authorization", "key=" + Globals.fcmServerKey);
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Content-type", "application/json");
        OutputStream os = conn.getOutputStream();
        os.write(root.toString().getBytes("utf-8"));
        os.flush();
        conn.getResponseCode();
    }
}
