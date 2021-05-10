<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/pop_reser_cancel.css?v=1'/>">
<script>
	var poCancelRow;

    function cancelPopupOpen(poRow) {   	
    	initCancelPopup();
        
    	poCancelRow = poRow;
        
        var bkDay, bkTime, bkCosNm, bkName, bkRoundfNm, bkPhone, bkPerson;
		bkDay = poRow.BK_DAY;
		bkTime = poRow.BK_TIME;
		bkCosNm = poRow.CD_TITLE1;
		bkName = poRow.BK_NAME;
		bkRoundfNm = poRow.BK_ROUNDF_NM;
		bkPhone = poRow.BK_FIRST_PHONE1 + "-" + poRow.BK_MID_PHONE1 + "-" + poRow.BK_LAST_PHONE1;
		bkPerson = poRow.BK_PERSON;
		
		var date = getDateFormat(bkDay);
		
		$("#cPoName").html(bkName);
		$("#cPoPhone").html(bkPhone);
		$("#cPoDay").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));		
		$("#cPoCos").html(String.format("{0} / {1}홀 / {2}:{3}", bkCosNm, bkRoundfNm, bkTime.substring(0, 2), bkTime.substring(2, 4)));
		$("#cPoPerson").html(bkPerson + "인");
    } 

    function initCancelPopup() {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#popupId").css("width").replace("px", "")) / 2;
        var cH = Number($("#popupId").css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#popupId").css("left", mW);
        $("#popupId").css("top", mH);

        $("#popupId").css("display", "block");
        $("#overlay").css("display", "block");
    }

    function cancelPopupClose() {
        $("#popupId").css("display", "none");
        $("#overlay").css("display", "none");
    } 
	
	function doCancelReservation() {
		var sUrl = "<c:url value='/hills/reservation/delReservation.do'/>";
		var sParams = "";		
		
		sParams += String.format("&bkDay={0}", poCancelRow.BK_DAY);
		sParams += String.format("&bkTime={0}", poCancelRow.BK_TIME);
		sParams += String.format("&bkCos={0}", poCancelRow.BK_COS);
		sParams += String.format("&bkRoyalGu={0}", poCancelRow.BK_ROYAL_GU);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			alert(data.resultMessage);
			
			if(data.resultCode == "0000") {
				cancelPopupClose();
				
				doSearch();
			}
		});
	}
	
	function cehckCancelCount() {
		var sUrl = "<c:url value='/hills/reservation/cehckCancelCount.do'/>";
		var sParams = String.format("bkDay={0}", poCancelRow.BK_DAY);
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {					
				doCancelReservation();
			} else {
				if(confirm(data.resultMessage)) {		
					doCancelReservation();					
				}	
			}	
			
			delIdx = -1;
		});	
	}
	
</script>
<div id="popupId" class="white_content">	
	<div class="white_content_relative">
        <p><img src="<c:url value='/images/m_hills/r_c_img.png'/>"></p>
        <h2>예약 취소</h2>
        <hr>
        <div class="cancelBox">
			<!--예약정보-->
			<table class="cancel_info">
				<caption>
				예약정보확인
				</caption>
				<colgroup>
				<col width="25%">
				<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th scope="col">신청자</th>
						<td scope="col" id="cPoName"></td>
					</tr>
					<tr>
						<th>핸드폰</th>
						<td class="redText" id="cPoPhone"></td>
					</tr>
					<tr>
						<th>예약일자</th>
						<td id="cPoDay"></td>
					</tr>
					<tr>
						<th>코스/홀/시간</th>
						<td id="cPoCos"></td>
					</tr>
					<tr>
						<th>예약인원</th>
						<td id="cPoPerson"></td>
					</tr>       
				</tbody>
			</table>
		</div>
		<ul class="btnBox1">
			<li class="motion"><a href="javascript:cehckCancelCount()">예약취소</a></li>
			<li class="cancel"><a href="javascript:cancelPopupClose()">이전단계</a></li>
		</ul>
	</div>
</div>
<div id="overlay" class="overlay"></div>