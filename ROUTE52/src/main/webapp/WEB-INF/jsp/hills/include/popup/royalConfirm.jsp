<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/reservation_popup.css'/>" rel='stylesheet' />
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
		var green = Number(royalRow.R_GREEN_AMT);
		var cart = Number(royalRow.R_CART_AMT);
		var food = Number(royalRow.R_FOOD_AMT);
		var roundB = Number(royalRow.R_ROUND_B_AMT);
		var roundA = Number(royalRow.R_ROUND_A_AMT);
		var amtGu = royalRow.R_AMT_GU == "1" ? "팀 " : "";
		
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
		
		$("#poRoyalInclude").html(include);
		
		showRoyalAlertMessage();
	}
		
	function royalPopupClose() {
		$("#royal_popup").css("display", "none");
		$("#royal_overlay").css("display", "none");
	}
 
	function showRoyalAlertMessage() {
		var sUrl = "<c:url value='/common/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", globals.coDiv.hills);
		sParams += String.format("&hpDiv={0}", "3");
		sParams += String.format("&type={0}", "6");
		sParams += String.format("&date={0}", royalRow.BK_DAY);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var rows = data.rows;
				if(rows.length == 1) {
					if(rows[0].HP_CONTENTS != null && rows[0].HP_CONTENTS != "") {
						alert(rows[0].HP_CONTENTS);	
					}
				}
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
	
	function actionRoyalTime() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/hills/member/login.do'/>";
    		return;
		}
		
		var bkDay = royalRow.BK_DAY;
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
		
		var d = getDateFormat(bkDay);
		
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
				location.href = "<c:url value='/hills/reservation/reservationCheck.do'/>";
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
	<a class="closeImg" href="javascript:royalPopupClose()"></a>
	<div class="informBox1">    
		<h4><img src="<c:url value='/images/hills/r_c_img.png'/>" alt=""></h4>
		<p class="informTitle1">ROYAL타임 우선예약 신청접수 확인</p>
		
		<div class="notice_info1">
			<p><b>※ 신청 절차안내</b><br>     
			    하단 신청 완료 버튼 클릭 후 예약금을 입금 기한 내 입금을 해주셔야만 최종 예약이 확정되며, 시간 내 입금되지 않을 시 자동으로 신청 취소됩니다. <br>
				★ 예약금 입금 기한: 접수일 오후 16시까지 신청 시 → 접수일 17시까지 <br>
				<span style="padding-left:109px;"></span>  접수일 오후 16시이후 신청 시 → 익일 17시까지<br>
				★ 시간내 입금되지 않을 시 자동 취소처리됩니다.<br>
				※카드 결제는 유선 문의바랍니다. (031-940-9400 ARS. 2번)		    
			</p>
		</div>
		
		<ul>
			<li><span class="title">신청자</span><span>${sessionScope.msMember.msName}</span></li>
			<li><span class="title">핸드폰</span><span>${sessionScope.msMember.phone1}-${sessionScope.msMember.phone2}-${sessionScope.msMember.phone3}</span></li>
			<li><span class="title">신청일자</span><span class="blue" id="poRoyalDate"></span></li>
			<li><span class="title">코스/홀/시간</span><span id="poRoyalTime"></span></li>
			<li><span class="title">예약인원</span><span>4명/인원 미달시 1팀 패키지 금액 그대로 적용됩니다.</span>			
			<li><span class="title">로얄패키지금액</span><span class="last"><strong id="poRoyalCost"></strong></span></li>
			<li><span class="title">패키지포함내역</span><span id="poRoyalInclude"></span></li>						
			<li><span class="title">예약금(10%)</span><span id="poRoyalDownPay"></span><!--  (패키지금액의 10%)--></li>
			<li><span class="title">은행(예금주)</span><span>국민은행(서원레저(주))</span></li>
			<li><span class="title">계좌번호</span><span>211-25-0015-269</span></li>
			<li><span class="title" style="vertical-align:top">취소규정 </span>
			<span class="reserText1">
			주중 5일 전, 주말 7일 전 17:00까지 페널티 없이 취소 가능합니다. <br>
			단, 예약금의 경우 하단 규정 적용 <br>
			라운드 10일 전 취소 → 예약금 100% 환불 <br>
			라운드 9~4일 전 취소 → 예약금 50% 환불 <br>
			라운드 3~0일 전 취소 → 예약금 소멸(환불X)
    
			</span>
			</li>
		</ul>
	</div>
	<div class="btnBox" style="padding-top:10px; margin-bottom:20px;">
		<a href="javascript:royalReservationCheck()" class="motion">신청완료</a>
		<a href="javascript:royalPopupClose()" class="cancel">취 소</a>
	</div>
</div>
<div id="royal_overlay" class="overlay" onclick="royalPopupClose()">		
</div>