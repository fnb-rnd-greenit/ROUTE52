<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/pop_reser_confirm.css'/>">
<script type="text/javascript">

	var royalRow;

	function initRoyalPopup() {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number(replaceAll($("#royal_popup").css("width"), "px", "")) / 2;
		var cH = Number(replaceAll($("#royal_popup").css("height"), "px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;
		
		$("#royal_popup").css("left", mW);
		$("#royal_popup").css("top", mH);
		
		$("#royal_popup").css("display", "block");
		$("#royal_overlay").css("display", "block");
	}

	function royalPopupOpen(data) {	
		royalRow = data;
	
		initRoyalPopup();	
		
		var d = getDateFormat(royalRow.BK_DAY);
		var t = royalRow.BK_TIME;   
		
		var include = "";
		var green = Number(data.R_GREEN_AMT);
		var cart = Number(data.R_CART_AMT);
		var food = Number(data.R_FOOD_AMT);
		var roundB = Number(data.R_ROUND_B_AMT);
		var roundA = Number(data.R_ROUND_A_AMT);
		var amtGu = data.R_AMT_GU == "1" ? "팀 " : "";
		
		$("#poRoyalDate").html(String.format("{0}년 {1}월 {2}일 ({3}요일)", d.yyyy(), d.mm(), d.dd(), d.week()));
		$("#poRoyalTime").html(royalRow.BK_COS_NM + " / " + "18홀 / " + (Number(t) < 1200 ? "오전" : "오후") + " " + t.substring(0, 2) + ":" + t.substring(2, 4));
		$("#poRoyalCost").html(amtGu + numberWithCommas(green + cart + food + roundB + roundA) + "원");
		$("#poRoyalDownPay").html(numberWithCommas((green + cart + food + roundB + roundA) / 10) + "원");
		
		include += "<b class='event_s'>그린피</b>";
		if(cart != 0) {
			include += " + <b class='event_f'>카트비</b>";			
		}
		if(roundB != 0 && roundA != 0) {
			include += " + <b class='event_c'>라운드 전/후 식사</b>";
		} else if(roundB != 0) {
			include += " + <b class='event_c'>라운드 전 식사</b>";
		} else if(roundA != 0) {
			include += " + <b class='event_c'>라운드 후 식사</b>";
		}
		if(food != 0) {
			include += " + <b class='event_e'>스타트안주</b>";
		}
		
		$("#poRoyalInclude").html(include + "");
	}
		
	function royalPopupClose() {
		$("#royal_popup").css("display", "none");
		$("#royal_overlay").css("display", "none");
	}
	
	function actionRoyalTime() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/m_hills/member/login.do'/>";
    		return;
		}
		
		var bkDay = royalRow.BK_DAY;
		var d = getDateFormat(bkDay);
		var bkCos = royalRow.BK_COS;
		var bkCosNm = royalRow.BK_COS_NM;
		var bkTime = royalRow.BK_TIME;
		var green = royalRow.R_GREEN_AMT;
		var cart = royalRow.R_CART_AMT;
		var food = royalRow.R_FOOD_AMT;
		var roundB = royalRow.R_ROUND_B_AMT;
		var roundA = royalRow.R_ROUND_A_AMT;
		var amtGu = royalRow.R_AMT_GU;
		var phone1 = "<c:out value='${sessionScope.msMember.phone1}'/>";
		var phone2 = "<c:out value='${sessionScope.msMember.phone2}'/>";
		var phone3 = "<c:out value='${sessionScope.msMember.phone3}'/>";
		
		if(phone1 == "" || phone2 == "" || phone3 == "") {
			alert("연락처를 입력한 후 예약할 수 있습니다.");
			location.href = "<c:url value='/hills/member/memModify.do'/>";
			return;
		}
		
		var sUrl = "<c:url value='/hills/reservation/actionRoyalTime.do'/>";
		var sParams = String.format("&bkDay={0}", bkDay);
		sParams += String.format("&bkCos={0}", bkCos);
		sParams += String.format("&bkCosNm={0}", bkCosNm);
		sParams += String.format("&bkTime={0}", bkTime);
		sParams += String.format("&green={0}", green);
		sParams += String.format("&cart={0}", cart);
		sParams += String.format("&food={0}", food);
		sParams += String.format("&roundB={0}", roundB);
		sParams += String.format("&roundA={0}", roundA);
		sParams += String.format("&amtGu={0}", amtGu);
		sParams += String.format("&sDate={0}", String.format("{0}월 {1}일 ({2})", d.mm(), d.dd(), d.week()));
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);	
			
			if(data.resultCode == "0000") {					
				location.href = "<c:url value='/m_hills/reservation/reservationCheck.do'/>";
			}				
		});	
	}
	
	function royalReservationCheck() {
		var sUrl = "<c:url value='/hills/reservation/getReservationCount.do'/>";
		var sParams = String.format("bkDay={0}", royalRow.BK_DAY);
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {					
				actionRoyalTime();
			} else if(data.resultCode == "2000") {					
				if(confirm(data.resultMessage)) {			
					actionRoyalTime();						
				}	
			} else {
				alert(data.resultMessage);
			}			
		});	
	}
	
</script>

<div id="royal_popup" class="white_content">	
	<div class="white_content_relative">
        <p><img src="<c:url value='/images/m_hills/r_c_img.png'/>"></p>
        <h2>ROYAL타임 우선예약 신청접수 확인</h2>
        <hr>
        <div class="notice_info"> 
			<p><strong>※신청 절차안내</strong><br>    
			  하단 신청 완료 버튼 클릭 후 예약금을 입금 기한 내 입금을 해주셔야만 최종 예약이 확정되며,시간 내 입금되지 않을 시 자동으로 신청 취소됩니다. <br>
★ 예약금 입금 기한: <br> 
 접수일 오후 16시까지 신청 시 → 접수일 17시까지 <br>
                             접수일 오후 16시이후 신청 시 → 익일 17시까지 <br>
★ 시간내 입금되지 않을 시 자동 취소처리됩니다.<br>
※카드 결제는 유선 문의바랍니다. (031-940-9400 ARS. 2번)
			</p>
		</div>
		
        <div class="cancelBox">
			<!--예약정보-->
			<table class="cancel_info">
				<caption>
				예약정보 확인
				</caption>
				<colgroup>
				<col width="25%">
				<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>신청자</th>
						<td>${sessionScope.msMember.msName}</td>
					</tr>
					<tr>
						<th>핸드폰</th>
						<td>${sessionScope.msMember.phone1}-${sessionScope.msMember.phone2}-${sessionScope.msMember.phone3}</td>
					</tr>
					<tr>
						<th>신청일자</th>
						<td class="blue" id="poRoyalDate"></td>
					</tr>
					<tr>
						<th>코스/홀/시간</th>
						<td id="poRoyalTime"></td>
					</tr>
					<tr>
						<th>예약인원</th>
						<td>4명/인원 미달시 1팀 패키지 금액 그대로 적용됩니다.
						</td>
					</tr>
					<tr>
						<th>로얄패키지금액</th>
						<td class="last" id="poRoyalCost">125,000
							<span>(※ 식사비에 음, 주류는 포함되지 않습니다.)</span> 
						</td>
					</tr>
					<tr> 
						<th>패키지포함내역</th>
						<td id="poRoyalInclude"></td>
					<tr>
						<th>예약금(10%)</th>
						<td class="last" id="poRoyalDownPay">132,000원</td>						
					</tr>
					<tr>
						<th>은행(예금주)</th>
						<td>국민은행(서원레저(주))</td>						
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>211-25-0015-269</td>						
					</tr>    
					<tr>
						<th style="vertical-align:top">취소 규정</th>
						<td class="textBox">
						주중 5일 전, 주말 7일 전 17:00까지 페널티 없이 취소 가능합니다. <br>
						단, 예약금의 경우 하단 규정 적용<br>
						라운드 10일 전 취소 → 예약금 100% 환불<br>
						라운드 9~4일 전 취소 → 예약금 50% 환불<br>
						라운드 3~0일 전 취소 → 예약금 소멸(환불X)
				
						</td>
					</tr>   
				</tbody>
			</table>
			<div class="btnBox4">
				<ul>
		        	<li><input type="button" class="motion" onclick="royalReservationCheck()" value="신청완료" /> </li>
		        	<li><input type="button" class="cancel" onclick="royalPopupClose()" value="취소" /></li>
		        </ul>
		    </div>
		</div>
       
	</div>
</div>
<div id="royal_overlay" class="reservationOverlay"></div>