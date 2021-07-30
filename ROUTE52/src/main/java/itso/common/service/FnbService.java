package itso.common.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import itso.common.dao.AbstractDAO;
import itso.common.utils.ResultVO;
import itso.common.utils.Utils;

@Component
@Service("FnbService")
public class FnbService extends AbstractDAO{
    
    @Autowired
    private DataSourceTransactionManager transactionManager;
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> versionCheck() throws Exception {
		return (Map<String, Object>) selectOne("fnb.versionCheck");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCompanyList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getCompanyList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCosList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getCosList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getShopList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getShopList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDiscountList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getDiscountList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSaleDivList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getSaleDivList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMenuDivList() throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getMenuDivList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMenuList(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getMenuList", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> actionLogin(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.actionLogin", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCurrentSales(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getCurrentSales", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getTotalAmount(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.getTotalAmount", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMemoList(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getMemoList", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStatementList(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getStatementList", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getVisitors(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getVisitors", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> tableCheck(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.tableCheck", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getRemainTable(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.getRemainTable", params);
	}
	
	public int makeSlNo(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.makeSlNo", params);
	}
	
	public int makeSlSeq(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.makeSlSeq", params);
	}
	
	public int visitorCheck(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.visitorCheck", params);
	}
	
	public String calculateCheck(Map<String, Object> params) throws Exception {
		return (String) selectOne("fnb.calculateCheck", params);
	}
	
	public void insSlMaster(Map<String, Object> params) throws Exception {
		insert("fnb.insSlMaster", params);
	}
	
	public void insSlHistory(Map<String, Object> params) throws Exception {
		insert("fnb.insSlHistory", params);
	}
	
	public void updTotalAmount(Map<String, Object> params) throws Exception {
		insert("fnb.updTotalAmount", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOrder(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getOrder", params);
	}
	
	public int makeSlMasterLogSeq(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.makeSlMasterLogSeq", params);
	}
	
	public void insSlMasterLog(Map<String, Object> params) throws Exception {
		insert("fnb.insSlMasterLog", params);
	}
	
	public int makeSlHistoryLogSeq(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.makeSlHistoryLogSeq", params);
	}
	
	public void insSlHistoryLog(Map<String, Object> params) throws Exception {
		insert("fnb.insSlHistoryLog", params);
	}
	
	public int getPersonTotalAmt(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.getPersonTotalAmt", params);
	}
	
	public void updAjHistory(Map<String, Object> params) throws Exception {
		insert("fnb.updAjHistory", params);
	}
	
	public void updAjTotalAmount(Map<String, Object> params) throws Exception {
		insert("fnb.updAjTotalAmount", params);
	}
	
	public void updSlHistoryCalYn(Map<String, Object> params) throws Exception {
		insert("fnb.updSlHistoryCalYn", params);
	}
	
	public void delSlHistory(Map<String, Object> params) throws Exception {
		insert("fnb.delSlHistory", params);
	}
	
	public void delSlHistory2(Map<String, Object> params) throws Exception {
		insert("fnb.delSlHistory2", params);
	}
	
	public void delSlMaster(Map<String, Object> params) throws Exception {
		insert("fnb.delSlMaster", params);
	}
	
	public int checkTableSales(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.checkTableSales", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> checkTableGallery(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.checkTableGallery", params);
	}
	
	public void actionCalculate(Map<String, Object> params) throws Exception {
		insert("fnb.actionCalculate", params);
	}
	
	public void moveTable(Map<String, Object> params) throws Exception {
		insert("fnb.moveTable", params);
	}
	
	public void mergeTable(Map<String, Object> params) throws Exception {
		insert("fnb.mergeTable", params);
	}
	
	public void deleteSlHistory(Map<String, Object> params) throws Exception {
		insert("fnb.deleteSlHistory", params);
	}
	
	public void deleteSlMaster(Map<String, Object> params) throws Exception {
		insert("fnb.deleteSlMaster", params);
	}
	
	public int getMaxSeatNo(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.getMaxSeatNo", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRestoreList(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getRestoreList", params);
	}
	
	public void actionRestore(Map<String, Object> params) throws Exception {
		update("fnb.actionRestore", params);
	}
	
	public void delProduct(Map<String, Object> params) throws Exception {
		update("fnb.delProduct", params);
	}
	
	public void delProduct2(Map<String, Object> params) throws Exception {
		update("fnb.delProduct2", params);
	}
	
	public void setPrinterRelay(Map<String, Object> params) throws Exception {
		update("fnb.setPrinterRelay", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> makeGalleryTime(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.makeGalleryTime", params);
	}
	
	public String makeGalleryLocker(Map<String, Object> params) throws Exception {
		return (String) selectOne("fnb.makeGalleryLocker", params);
	}
	
	public String chkSlState(Map<String, Object> params) throws Exception {
		return (String) selectOne("fnb.chkSlState", params);
	}
	
	public String makeGalleryChkInNo(Map<String, Object> params) throws Exception {
		return (String) selectOne("fnb.makeGalleryChkInNo", params);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<String> getPrinterToken(Map<String, Object> params) throws Exception {
		return (ArrayList<String>) selectList("fnb.getPrinterToken", params);
	}
	
	public void makeGallery(Map<String, Object> params) throws Exception {
		insert("fnb.makeGallery", params);
	}
		
	public int makePrinterSeq(Map<String, Object> params) throws Exception {
		return selectCnt("fnb.makePrinterSeq", params);
	}
	
	public void insFnbReceipt(Map<String, Object> params) throws Exception {
		insert("fnb.insFnbReceipt", params);
	}
	
	public void updFnbReceipt(Map<String, Object> params) throws Exception {
		insert("fnb.updFnbReceipt", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getReceiptData(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getReceiptData", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getKitchenOrder(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getKitchenOrder", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getReceiptList(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) selectList("fnb.getReceiptList", params);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getLatelyReceiptData(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) selectOne("fnb.getLatelyReceiptData", params);
	}
	
	public void sucReceiptPrint(Map<String, Object> params) throws Exception {
		update("fnb.sucReceiptPrint", params);
	}
	
	public void uptReceiptLocktime(Map<String, Object> params) throws Exception {
		update("fnb.uptReceiptLocktime", params);
	}
	
	public void cancelReceipt(Map<String, Object> params) throws Exception {
		update("fnb.cancelReceipt", params);
	}
	
	public synchronized ResultVO actionOrder(@RequestParam Map<String, Object> map) {	
		ResultVO result = new ResultVO();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("action-order-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		if(map.get("arrivalTime") == null || map.get("arrivalTime").toString().equals("")) {
			map.put("arrivalTime", "");
		}
		if(map.get("orderId") == null || map.get("orderId").toString().equals("")) {
			map.put("orderId", "");
		}
		
		try {
			boolean isGallery = Boolean.parseBoolean(map.get("isGallery").toString());
			String payDiv = map.get("slPayDiv").toString();
			
			String slNo = (String) map.get("slNo") == null ? "" : (String) map.get("slNo");
			
			String sData = String.valueOf(map.get("data")).replaceAll("&quot;", "\"");

            JSONArray arrData = new JSONArray(sData);
			
			if(slNo.equals("")) {			
				List<Map<String, Object>> tableCheck = this.tableCheck(map);
				if(tableCheck.size() > 0) {
					throw new Exception(String.format("%s번 테이블에 이미 %s님의 전표가 생성되어있습니다.\n추가주문 또는 다른 테이블로 주문을 진행해주세요.", tableCheck.get(0).get("SL_TABLE_NO"), tableCheck.get(0).get("SL_EN_NAME")));
				}	
				
				slNo = String.valueOf(this.makeSlNo(map));
				map.put("slNo", slNo);
				
				if(isGallery && payDiv.equals("1")) {
					String time, locker, chkInNo;
					
					Map<String, Object> gTime = this.makeGalleryTime(map);
					String hour = gTime.get("TIME_NUM").toString();
					String min = gTime.get("NUM").toString();
					
					if(min.length() >= 3) {
						time = hour + "01";
					} else if(min.length() == 1) {
						time = hour + "0" + min;
					} else {
						time = hour + min;
					}
					
					map.put("type", "G");
					
					locker = this.makeGalleryLocker(map);
					chkInNo = this.makeGalleryChkInNo(map);

					map.put("enChkInNo", chkInNo);
					map.put("enDay", new SimpleDateFormat("yyyyMMdd").format(new Date()));
					map.put("enCos", "A");
					map.put("enTime", time);
					map.put("enName", "갤러리후불");
					map.put("slDay", new SimpleDateFormat("yyyyMMdd").format(new Date()));
					map.put("slCos", "A");
					map.put("slTime", time);
					map.put("slEnName", "갤러리후불");
	            	map.put("enLocker", locker);
                	map.put("gpNum", "");
                	map.put("msNum", "");
                	
                	this.makeGallery(map);
				} else if(isGallery && payDiv.equals("2")) {
					map.put("type", "S");
					
					String chkInNo = this.makeGalleryChkInNo(map);

					map.put("enChkInNo", chkInNo);
					map.put("enDay", new SimpleDateFormat("yyyyMMdd").format(new Date()));
					map.put("enCos", "A");
					map.put("enTime", "    ");
					map.put("enName", "갤러리선불");
					map.put("slDay", new SimpleDateFormat("yyyyMMdd").format(new Date()));
					map.put("slCos", "A");
					map.put("slTime", "    ");
					map.put("slEnName", "갤러리선불");
	            	map.put("enLocker", "9999");
                	map.put("gpNum", "");
                	map.put("msNum", "");
				}
				
				this.insSlMaster(map);
			}
			
			String state = this.chkSlState(map);
			if(state != null && state.equals("2")) {
				throw new Exception("이미 정산된 전표입니다.");
			}
			if(state != null && state.equals("3")) {
				throw new Exception("이미 취소된 전표입니다.");
			}
			
			for(int i=0; i<arrData.length(); i++){
            	JSONObject obj = arrData.getJSONObject(i);
            	
            	if(!isGallery) {
            		map.put("enChkInNo", Utils.getJsonValue(obj, "enChkInNo"));
                	map.put("enDay", Utils.getJsonValue(obj, "enDay"));
                	map.put("enCos", Utils.getJsonValue(obj, "enCos"));
                	map.put("enTime", Utils.getJsonValue(obj, "enTime"));
                	map.put("enName", Utils.getJsonValue(obj, "enName"));
                	map.put("enLocker", Utils.getJsonValue(obj, "enLocker"));
                	map.put("gpNum", Utils.getJsonValue(obj, "gpNum"));
                	map.put("msNum", Utils.getJsonValue(obj, "msNum"));
                	map.put("seatNo", Utils.getJsonValue(obj, "seatNo"));
                	map.put("qrNum", Utils.getJsonValue(obj, "qrNum"));
                	
                	if(this.visitorCheck(map) == 0) {
                		throw new Exception("등록 전에 프론트에서 내장객정보가 변경되었습니다. 매출이 등록되지 않습니다.\n내장객 정보를 다시 입력해 주세요.");						
                	}
                	
                	String calCehck = this.calculateCheck(map);
                	if(calCehck != null && !calCehck.equals("")) {
                		throw new Exception(calCehck);						
                	}
            	}
            	
            	JSONArray menus = new JSONArray(obj.get("menus").toString());
            	
            	int slSeq = this.makeSlSeq(map);	 
            	
            	for(int j=0; j<menus.length(); j++) {
            		JSONObject menu = menus.getJSONObject(j);

	            	map.put("pdCd", Utils.getJsonValue(menu, "pdCd"));
	            	map.put("slCount", Utils.getJsonValue(menu, "slCount"));
	            	map.put("slAmount", Utils.getJsonValue(menu, "slAmount"));
	            	map.put("slCost", Utils.getJsonValue(menu, "slCost"));
	            	map.put("slVat", Utils.getJsonValue(menu, "slVat"));
	            	map.put("slPrice", Utils.getJsonValue(menu, "slPrice"));
	            	map.put("slRate", Utils.getJsonValue(menu, "slRate"));
	            	map.put("slRate", Utils.getJsonValue(menu, "slRate"));
	            	map.put("slGubun", Utils.getJsonValue(menu, "slGubun"));
	            	map.put("slSeq", String.valueOf(slSeq + j));

            		this.insSlHistory(map);
                    
                    if(!map.get("shop").toString().equals("10")) {
                    	int totalAmt = this.getPersonTotalAmt(map);
		            	map.put("totalAmt", totalAmt);
	            		
		            	this.updAjHistory(map);
		            	this.updAjTotalAmount(map);
		            	this.updSlHistoryCalYn(map);
                    }
            	}
            }		
            
			result.setSub("{\"slNo\" : \"" + slNo + "\"}");
            
            this.updTotalAmount(map);    
			
			int logSeq = this.makeSlMasterLogSeq(map);
			
			map.put("logSeq", logSeq);
			map.put("type", "I");
			
			this.insSlMasterLog(map);
			
			logSeq = this.makeSlHistoryLogSeq(map);
			
			map.put("logSeq", logSeq);        	
        	
    		this.insSlHistoryLog(map);

			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		}
		
		return result;
	}
	
	public ResultVO cancelOrderLogic(@RequestParam Map<String, Object> map) {	
		ResultVO result = new ResultVO();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("action-order-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			String sData = String.valueOf(map.get("visitors")).replaceAll("&quot;", "\"");

            JSONArray arrData = new JSONArray(sData);
			
			for(int i=0; i<arrData.length(); i++){
            	JSONObject obj = arrData.getJSONObject(i);
            	
            	map.put("enChkInNo", Utils.getJsonValue(obj, "enChkInNo"));
            	map.put("enDay", Utils.getJsonValue(obj, "enDay"));
            	
            	String calCehck = this.calculateCheck(map);
            	if(calCehck != null && !calCehck.equals("")) {
            		throw new Exception(calCehck);						
            	}
            }	
            	
			int slSeq = this.makeSlSeq(map) - 1; 

        	map.put("slSeq", slSeq);

            this.delSlMaster(map);

            this.delSlHistory(map);
            
            this.delSlHistory2(map);
            
            this.updTotalAmount(map);

        	int logSeq = this.makeSlMasterLogSeq(map);

        	map.put("logSeq", logSeq);
        	map.put("type", "V");
        	
        	this.insSlMasterLog(map);
        	
        	logSeq = this.makeSlHistoryLogSeq(map);

        	map.put("logSeq", logSeq);

        	this.insSlHistoryLog(map);
        	
        	for(int i=0; i<arrData.length(); i++){
            	JSONObject obj = arrData.getJSONObject(i);
            	
            	map.put("enChkInNo", Utils.getJsonValue(obj, "enChkInNo"));
            	
            	if(!map.get("shop").toString().equals("10")) {
                	int totalAmt = this.getPersonTotalAmt(map);
                	map.put("totalAmt", totalAmt);
            		
                	this.updAjHistory(map);
                	this.updAjTotalAmount(map);
                	this.updSlHistoryCalYn(map);
                }
            }	
        	
			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		}
		
		return result;
	}
	
	public ResultVO delProductLogic(@RequestParam Map<String, Object> map) {	
		ResultVO result = new ResultVO();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("action-order-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			int newSlSeq = this.makeSlSeq(map);
			
			map.put("newSlSeq", newSlSeq);
			
			this.delProduct(map);
			
			this.delProduct2(map);
			
			this.updTotalAmount(map);
			
			int logSeq = this.makeSlHistoryLogSeq(map);

			map.put("type", "I");
			map.put("logSeq", logSeq);        	
        	
			this.insSlHistoryLog(map);
			
			if(!map.get("shop").toString().equals("10")) {
            	int totalAmt = this.getPersonTotalAmt(map);
            	map.put("totalAmt", totalAmt);
        		
            	this.updAjHistory(map);
            	this.updAjTotalAmount(map);
            	this.updSlHistoryCalYn(map);
            }
        	
			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		}
		
		return result;
	}
	
	public ResultVO doCalclate(@RequestParam Map<String, Object> map) {	
		ResultVO result = new ResultVO();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("action-order-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			String sData = String.valueOf(map.get("visitors")).replaceAll("&quot;", "\"");

            JSONArray arrData = new JSONArray(sData);
            
            int check = this.checkTableSales(map);
            
            if(check == 0) {
            	throw new Exception("판매중인 테이블이 아닙니다. 정산 불가능합니다.");
            }
			
			for(int i=0; i<arrData.length(); i++){
            	JSONObject obj = arrData.getJSONObject(i);
            	
            	map.put("enChkInNo", Utils.getJsonValue(obj, "enChkInNo"));
            	map.put("enDay", Utils.getJsonValue(obj, "enDay"));
            	
            	String calCehck = this.calculateCheck(map);
            	if(calCehck != null && !calCehck.equals("")) {
            		throw new Exception(calCehck);						
            	}
            }	
            	
			this.actionCalculate(map);
        	
			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		}
		
		return result;
	}
	
	public ResultVO mergeTableLogic(@RequestParam Map<String, Object> map) {	
		ResultVO result = new ResultVO();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("action-order-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {        
			map.put("slNo", map.get("aSlNo").toString());
            map.put("tableNo", map.get("tableNo2"));
			
            int check = this.checkTableSales(map);
            
            if(check == 0) {
            	throw new Exception("판매중인 테이블이 아닙니다. 병합 불가능합니다.");
            }
            
            map.put("tableNo", map.get("tableNo1"));
            
            Map<String, Object> check2 = this.checkTableGallery(map);
            
            if(Integer.valueOf(check2.get("SL_TIME").toString()) >= 2500 || check2.get("EN_CHKINNO").toString().equals("S")) {
            	throw new Exception("갤러리는 병합기능을 사용 할 수 없습니다.");
            }
            
            map.put("tableNo", map.get("tableNo2"));
            
            check2 = this.checkTableGallery(map);
            
            if(Integer.valueOf(check2.get("SL_TIME").toString()) >= 2500 || check2.get("EN_CHKINNO").toString().equals("S")) {
            	throw new Exception("갤러리는 병합기능을 사용 할 수 없습니다.");
            }
            
			map.put("slNo", map.get("bSlNo").toString());
			
            int logSeq = this.makeSlMasterLogSeq(map);

        	map.put("logSeq", logSeq);
        	map.put("type", "A");
        	
        	this.insSlMasterLog(map);
        	
        	logSeq = this.makeSlHistoryLogSeq(map);

        	map.put("logSeq", logSeq);

        	this.insSlHistoryLog(map);
            	
        	int slSeq = this.makeSlSeq(map) - 1;
        	
        	map.put("slSeq", slSeq);
        	
        	int seatNo = this.getMaxSeatNo(map);
        	
        	map.put("seatNo", seatNo);
        	
        	this.mergeTable(map);
        	
			map.put("slNo", map.get("aSlNo").toString());
        	
        	this.updTotalAmount(map);
        	
        	this.deleteSlHistory(map);
        	
        	this.deleteSlMaster(map);
        	
			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		}
		
		return result;
	}
}
 