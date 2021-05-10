<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/valley/reservation_popup.css'/>" rel='stylesheet' />
<script type="text/javascript">

	var poRow;
	var poAction;
	var poBeforeData;

	function initPopup() {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number(replaceAll($("#reservationPopup").css("width"), "px", "")) / 2;
		var cH = Number(replaceAll($("#reservationPopup").css("height"), "px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;
		
		$("#reservationPopup").css("left", mW);
		$("#reservationPopup").css("top", mH);
		
		$("#reservationPopup").css("display", "block");
		$("#overlay").css("display", "block");
		
		if(poAction == "I") {
			$("#poAction").html("예 약");
		} else if(poAction == "U") {
			$("#poAction").html("변 경");			
		}
	}

	function popupOpen(action, row, beforeData) {
		poAction = action;
		poRow = row;
		if(poAction == "U") {
			poBeforeData = beforeData;
		}
		
		initPopup();		
		
		var bkDay, bkTime, bkCosNm, bkRoundfNm, bkPhone, bkCharge;
		bkDay = poRow.BK_DAY;
		bkTime = poRow.BK_TIME;
		bkCosNm = poRow.BK_COS_NM;
		bkRoundfNm = poRow.BK_ROUNDF_NM;
		if(poRow.BK_CHARGE != null && poRow.BK_CHARGE != ""){
			bkCharge = numberWithCommas(poRow.BK_CHARGE.split(",")[1]);
		}
		
		bkPhone = "${sessionScope.msMember.msPhone}";
		bkPhone = phoneNumberFormat(bkPhone, " - ");
		
		$("#poMsPhone").html(bkPhone);
		
		var date = getDateFormat(bkDay);
		$("#poBkDay").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		$("#poCosTime").html(String.format("{0} / {1}홀 / {2}:{3}", bkCosNm, bkRoundfNm, bkTime.substring(0, 2), bkTime.substring(2, 4)));
		
		$("#poBkCharge").html(bkCharge + " 원");
		
		if(globals.personCd.three != poRow.BK_PERSON_CD) {
			$("#poBkPerson").val(4);
			$("#poBkPerson").prop("disabled", true);
		}
		
		showAlertMessage();
	}
	
	function showAlertMessage() {
		var sUrl = "<c:url value='/common/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", globals.coDiv.valley);
		sParams += String.format("&hpDiv={0}", "3");
		sParams += String.format("&type={0}", "1");
		sParams += String.format("&date={0}", poRow.BK_DAY);
		
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
	
	function reservationCheck() {
		if(poAction == "I") {
			var sUrl = "<c:url value='/valley/reservation/getReservationCount.do'/>";
			var sParams = String.format("bkDay={0}", poRow.BK_DAY);
			
			progressStart();		
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				if(data.resultCode == "0000") {					
					reservationCheck2();
				} else if(data.resultCode == "2000") {					
					if(confirm(data.resultMessage)) {			
						reservationCheck2();						
					}	
				} else {
					alert(data.resultMessage);
				}			
			});	
		} else {
			reservationCheck2();
		}
	}
	
	function reservationCheck2() {
		if(poAction == "I") {
			var sUrl = "<c:url value='/valley/reservation/cehckPlaceboPeriod.do'/>";
			var sParams = String.format("bkDay={0}", poRow.BK_DAY);
			
			progressStart();		
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				if(data.resultCode == "0000") {					
					actionReservation();
				} else {
					if(confirm(data.resultMessage)) {			
						actionReservation();						
					}	
				}			
			});	
		} else {
			actionReservation();
		}
	}
	
	function actionReservation() {
		var sUrl;
		var sParams = "";
		
		var bkDay, bkTime, bkCos, bkRoundf, bkPerson, charge;
		bkDay = poRow.BK_DAY;
		bkTime = poRow.BK_TIME;
		bkCos = poRow.BK_COS;
		bkRoundf = poRow.BK_ROUNDF;
		bkPerson = $("#poBkPerson").val();
		charge = poRow.BK_CHARGE.split(",")[0];
		
		if(poAction == "I") {
			sUrl = "<c:url value='/valley/reservation/actionReservation.do'/>";
			sParams += String.format("&bkDay={0}", bkDay);
			sParams += String.format("&bkTime={0}", bkTime);
			sParams += String.format("&bkCos={0}", bkCos);
			sParams += String.format("&bkRoundf={0}", bkRoundf);
			sParams += String.format("&bkPerson={0}", bkPerson);
			sParams += String.format("&bkCharge={0}", charge);
			sParams += String.format("&media={0}", "R");
		} else if(poAction == "U") {
			sUrl = "<c:url value='/valley/reservation/actionReservationChange.do'/>";
			sParams += String.format("&bBkDay={0}", poBeforeData.bkDay);
			sParams += String.format("&bBkTime={0}", poBeforeData.bkTime);
			sParams += String.format("&bBkCos={0}", poBeforeData.bkCos);
			sParams += String.format("&aBkDay={0}", bkDay);
			sParams += String.format("&aBkTime={0}", bkTime);
			sParams += String.format("&aBkCos={0}", bkCos);
			sParams += String.format("&aBkRoundf={0}", bkRoundf);
			sParams += String.format("&aBkPerson={0}", bkPerson);
			sParams += String.format("&aBkCharge={0}", charge);
			sParams += String.format("&media={0}", "R");
		}
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);	
			
			if(data.resultCode == "0000") {					
				location.href = "<c:url value='/valley/reservation/reservationCheck.do'/>";
			}				
		});	
	}
	
	function popupClose() {
		$("#reservationPopup").css("display", "none");
		$("#overlay").css("display", "none");
	}
</script>
<div id="reservationPopup" class="white_content">	
	<a class="closeImg" href="javascript:popupClose()"></a>
	<div class="informBox">
		<img src="<c:url value='/images/valley/r_c_img.png'/>" alt="">
		<p class="informTitle">예약정보 확인</p>
		<ul>
			<li><span class="title">신청자</span><span>${sessionScope.msMember.msName}</span></li>
			<li><span class="title">핸드폰</span><span id="poMsPhone"></span></li>
			<li><span class="title">예약일자</span><span class="blue" id="poBkDay"></span></li>
			<li><span class="title">코스/홀/시간</span><span id="poCosTime"></span></li>
			<li><span class="title">예약인원</span>
			<span>
				<select id="poBkPerson" class="select-arrow" style="width: 55px; height: 30px">
					<option value='3'>3명</option>
					<option value='4'>4명</option>
				</select>
			</span>
			<span> / 내장인원 미달시 예약인원 요금적용</span></li>
			<li><span class="title">동반자그린피</span><span class="last" id="poBkCharge"></span></li>
			<li><span class="title">취소규정</span><span class="reserText">주중은 예약일자 제외 후 4일전 17:00전까지,<br>
			주말은 예약일자 제외 후 5일전 17:00전까지 패널티없이 취소 가능합니다. </span></li>
		</ul>
	</div>
	<div class="btnBox" style="padding-top:20px;">
		<a href="javascript:reservationCheck()" class="motion" id="poAction">예 약</a>
		<a href="javascript:popupClose()" class="cancel">취 소</a>
	</div>
	<div class="notice_info">
		<p><span class="blackText">※ 알려드립니다.</span><br><br>        
		      당 클럽에서는 TEE-OFF 시간을 준수하고 있습니다.<br>
		      원활한 경기진행을 위해 <span class="redText">라운드 전 40분까지</span>내장하여 주시기 바랍니다.<br><br>     
		   TEE-OFF란?<br>
		     첫 홀 마지막분이 티샷을 마치고 티잉 그라운드를 벗어나는 것       
		   <!-- <span class="underline">TEE-OFF 시간 미준수</span> 라운드 불가 및 1개월 예약정지 <span class="underline">당일미내장 (Not-Show)</span> 예약 및 내장 불가 -->
		</p>
	 </div>
</div>
<div id="overlay" class="overlay">		
</div>