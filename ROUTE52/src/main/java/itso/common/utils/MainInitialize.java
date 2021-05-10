package itso.common.utils;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MainInitialize {
	Logger log = Logger.getLogger(this.getClass());
	
	@PostConstruct
	public void init() {
		try {
			log.info("======================= Initialize Start =======================");
			
			Globals.serverIpAddress = Utils.getLocalIpAddr();
			log.info("Server Ip Address : " + Globals.serverIpAddress);		
			Globals.fcmServerKey = Utils.getProperties("Globals.fcm.serverKey", "");
			log.info("FCM Server Key : " + Globals.fcmServerKey);

			log.info("======================= Initialize Finish =======================");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
