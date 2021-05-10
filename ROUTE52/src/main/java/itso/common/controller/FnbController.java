package itso.common.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itso.common.service.FnbService;
import itso.common.utils.ResultVO;
import itso.common.utils.Utils;

@Controller
@RequestMapping("/fnb")
public class FnbController {
	
Logger log = Logger.getLogger(this.getClass());  
	
    @Resource(name="FnbService")
    private FnbService fnbService;  
    
	@RequestMapping(value = "/versionCheck.do")
	public void versionCheck(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
		
		try {  	
			Map<String, Object> vInfo = fnbService.versionCheck();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getCompanyList.do")
	public void getCompanyList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getCompanyList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getCosList.do")
	public void getCosList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getCosList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getShopList.do")
	public void getShopList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getShopList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getDiscountList.do")
	public void getDiscountList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getDiscountList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getSaleDivList.do")
	public void getSaleDivList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
		
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getSaleDivList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getMenuDivList.do")
	public void getMenuDivList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getMenuDivList();
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getMenuList.do")
	public void getMenuList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getMenuList(params);
			
			result.setData(vInfo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
    
	@RequestMapping(value="/actionLogin.do")
	public void actionLogin(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> map) throws Exception{
		ResultVO result = new ResultVO();
		
		try {
			Map<String,Object> memInfo = fnbService.actionLogin(map);
			
			if(memInfo == null) {
				result.setCode("1000");
			} else {
				result.setData(memInfo);				
			}
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getCurrentSales.do")
	public void getCurrentSales(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> vInfo = fnbService.getCurrentSales(params);
			
			result.setData(vInfo);
			
			Map<String, Object> amount = fnbService.getTotalAmount(params);
			
			result.setSub(amount);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getMemoList.do")
	public void getMemoList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> memo = fnbService.getMemoList(params);
			
			result.setData(memo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/chkSlState.do")
	public void chkSlState(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
		
		try {  	
			String state = fnbService.chkSlState(params);
			if(state != null && state.equals("2")) {
				throw new Exception("이미 정산된 전표입니다.");
			}
			if(state != null && state.equals("3")) {
				throw new Exception("이미 취소된 전표입니다.");
			}
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getStatementList.do")
	public void getStatementList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> memo = fnbService.getStatementList(params);
			
			result.setData(memo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getVisitors.do")
	public void getVisitors(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> memo = fnbService.getVisitors(params);
			
			result.setData(memo);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value="/actionOrder.do")
	public void actionOrder(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception{
		ResultVO result = null;

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		} 
		
		try {
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			result = fnbService.actionOrder(params); 
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value="/cancelOrder.do")
	public void cancelOrder(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception{
		ResultVO result = null;

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
		
		try {
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			result = fnbService.cancelOrderLogic(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value="/actionCalculate.do")
	public void actionCalculate(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = null;

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
		
		try {
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			result = fnbService.doCalclate(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value = "/getOrder.do")
	public void getOrder(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> order = fnbService.getOrder(params);
			
			result.setData(order);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/moveTable.do")
	public void moveTable(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			int check = fnbService.checkTableSales(params);
			
			if(check > 0) {
				throw new Exception("현재 판매중인 테이블 입니다.");
			}
			
			fnbService.moveTable(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value = "/mergeTable.do")
	public void mergeTable(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			result = fnbService.mergeTableLogic(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value = "/getRestoreList.do")
	public void getRestoreList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> list = fnbService.getRestoreList(params);
			
			result.setData(list);
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/actionRestore.do")
	public void actionRestore(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			int check = fnbService.checkTableSales(params);
			
			if(check > 0) {
				throw new Exception("현재 판매중인 테이블 입니다.");
			}
			
			String calCehck = fnbService.calculateCheck(params);
        	if(calCehck != null && !calCehck.equals("")) {
        		throw new Exception(calCehck);						
        	}
			
			fnbService.actionRestore(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
			
			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value = "/delProduct.do")
	public void delProduct(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();

		String coDiv = null;
		String shop = null;
		if(params.get("coDiv") != null) {
			coDiv = params.get("coDiv").toString();
		}
		if(params.get("shop") != null) {
			shop = params.get("shop").toString();
		}
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			result = fnbService.delProductLogic(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));

			Utils.sendPushMessaging(Utils.SYNC_TABLES, "topic", "syncTables", null, null, null, coDiv, shop);
		}
	}
	
	@RequestMapping(value = "/setPrinterRelay.do")
	public void setPrinterRelay(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			fnbService.setPrinterRelay(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/receiptPrinting.do")
	public void receiptPrinting(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			/* ArrayList<String> tokens = fnbService.getPrinterToken(params);
			
			if(tokens.size() > 0) {
				Utils.sendPushMessaging(Utils.PRINT, "users", null, tokens, null, params.toString());
			} */
			int seq = fnbService.makePrinterSeq(params);
			
			params.put("seq", seq);
			params.put("content", params.toString());
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			fnbService.insFnbReceipt(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/latelyReceiptPrinting.do")
	public void latelyReceiptPrinting(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			Map<String, Object> lately = fnbService.getLatelyReceiptData(params);

			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			fnbService.updFnbReceipt(lately);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getReceiptData.do")
	public void getReceiptData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> list = fnbService.getReceiptData(params);

			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			for(int i=0; i<list.size(); i++) {
				params.put("coDiv", list.get(i).get("FB_CODIV"));
				params.put("shop", list.get(i).get("FB_SHOP"));
				params.put("date", list.get(i).get("FB_DATE"));
				params.put("seq", list.get(i).get("FB_SEQ"));
				
				fnbService.uptReceiptLocktime(params);
			}
			
			result.setData(list);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getReceiptList.do")
	public void getReceiptList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			List<Map<String, Object>> list = fnbService.getReceiptList(params);
			
			result.setData(list);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getKitchenOrder.do")
	public void getKitchenOrder(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		
		try {  	
			List<Map<String, Object>> list = fnbService.getKitchenOrder(params);
			
			result.setData(list);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/getRemainTable.do")
	public void getRemainTable(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		
		try {  	
			Map<String, Object> map = fnbService.getRemainTable(params);
			
			result.setData(map);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/sucReceiptPrint.do")
	public void sucReceiptPrint(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			fnbService.sucReceiptPrint(params);
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	
	@RequestMapping(value = "/cancelReceipt.do")
	public void cancelReceipt(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		
		String sData = String.valueOf(params.get("data")).replaceAll("&quot;", "\"");

        JSONArray arrData = new JSONArray(sData);
	
		try {  	
			params.put("ipAddr", Utils.getClientIpAddress(request));
			
			for(int i=0; i<arrData.length(); i++){
            	JSONObject obj = arrData.getJSONObject(i);
            	
            	params.put("date", Utils.getJsonValue(obj, "date"));
            	params.put("seq", Utils.getJsonValue(obj, "seq"));
            	
    			fnbService.cancelReceipt(params);
			}
		} catch (Exception e) {
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
    
	@RequestMapping(value="/syncTable.do")
	public void syncTable(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> map) throws Exception{
		ResultVO result = new ResultVO();
		
		try {			
			String slNo = null;
			String coDiv = null;
			String shop = null;
			
			if(map.get("slNo") != null) {
				slNo = map.get("slNo").toString();
			}
			if(map.get("coDiv") != null) {
				coDiv = map.get("coDiv").toString();
			}
			if(map.get("shop") != null) {
				shop = map.get("shop").toString();
			}
			
			if(slNo != null) {
				Utils.sendPushMessaging(Utils.SYNC_GMS, "topic", "syncTables", null, slNo, null, coDiv, shop);				
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
    
	@RequestMapping(value="/testAlarm.do")
	public void testAlarm(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> map) throws Exception{
		ResultVO result = new ResultVO();
		
		try {			
			String coDiv = null;
			String shop = null;
			
			if(map.get("coDiv") != null) {
				coDiv = map.get("coDiv").toString();
			}
			if(map.get("shop") != null) {
				shop = map.get("shop").toString();
			}
			
			Utils.sendPushMessaging(Utils.ALARM, "topic", "syncTables", null, null, null, coDiv, shop);				
		} catch (Exception e) {
			e.printStackTrace();
			result.setCode(result.getCode().equals("0000") ? "9999" : result.getCode());
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
}
