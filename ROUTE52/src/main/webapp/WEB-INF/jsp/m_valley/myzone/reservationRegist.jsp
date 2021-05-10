<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<script type="text/javascript">

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		}
		
		var bkCos = "${bkCosNm}";
		var bkTime = "${bkTime}";
		
		$("#txtCos").html(bkCos);
		$("#txtTime").html(bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4));
		
		var togetherList = eval("${togetherList}");
		
		if(togetherList != null && togetherList != "") {
			for(i = 1; i <= togetherList.length; i++) {
				$("#name" + i).val(togetherList[i-1].name);
				$("#phone" + i).val(String.format("{0}-{1}-{2}", togetherList[i-1].phone1, togetherList[i-1].phone2, togetherList[i-1].phone3));;
				if(togetherList[i-1].joinYn == "Y") {
					$("#joinYn" + i).attr("checked", true); 
				}
			}
		}		
	}
	
	function doRegistMember() {
		var sUrl = "<c:url value='/valley/reservation/doRegistMember.do'/>";
		var sParams;
		var sData = "";
		
		var data = [];
		
		for(i=1; i<=4; i++) {
			var join = $("input[id='joinYn" + i + "']:checked").val();
			var name = $("#name" + i).val();
			var phone = $("#phone" + i).val();
			phone = replaceAll(phone, "-", "");
			phone = replaceAll(phone, " ", "");
			
			if(name != "") {
				if(phone.length != 11) {
					alert(String.format("동반자 {0}의 연락처를 확인하세요.", name));
					return;					
				}
				
				var phone1 = phone.substring(0, 3);
				var phone2 = phone.substring(3, 7);
				var phone3 = phone.substring(7, 11);
				
				var mem = {
					"name" : encodeURI(name),
					"join" : join != null ? "Y" : "N",
					"firstPhone" : phone1,
					"midPhone" : phone2,
					"lastPhone" : phone3
				}
				
				data.push(mem);
			}
		}
		
		if(data.length == 0) {
			alert("입력된 동반자가 없습니다.");
		}
		
		sData = JSON.stringify(data);

		sParams = {
			"bkDay" : "${bkDay}",
			"bkCos" : "${bkCos}",
			"bkTime" : "${bkTime}",
			"bkRsvNo" : "${bkRsvNo}",
			"sData" : sData
		};
		
		jQuery.ajaxSettings.traditional = true;
		
		progressStart();
		
		mAjax2(sUrl, sParams, function(data) {
			progressStop();
			
			alert(data.resultMessage);
			
			if(data.resultCode == "0000") {
				location.href = document.referrer;
			}
		});		
	}
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> MY ZONE <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList">			
		<li class="on"><a href="<c:url value='/m_valley/reservation/reservationCheck.do'/>">예약현황</a></li>
		<li class=""><a href="<c:url value='/m_valley/member/stateVisit.do'/>">내장현황</a></li>
		<li class=""><a href="<c:url value='/m_valley/member/score.do'/>">스코어카드</a></li>
	</ul>
	<div class="contents">
		<div class="contentBg">
			<div class="commonDot"> 동반자 등록</div>
			<table class="commonTable">
				<caption>실시간 현황</caption>
				<colgroup>
					<col width="14%">
					<col width="14%">
					<col width="12%">
					<col width="25%">
					<col width="45%">
				</colgroup>
				<tbody>
					<tr>
						<th>코스</th>
						<th>예약시간</th>
						<th>조인</th>
						<th>동반자명</th>
						<th>연락처</th>
					</tr>
					<tr>
						<td rowspan="4" style="border-bottom:1px solid #45454f;" id="txtCos"></td>
						<td rowspan="4" style="border-bottom:1px solid #45454f;" id="txtTime"></td>
						<td><input type="checkbox" id="joinYn1"></td>
						<td><input type="text" id="name1"></td>
						<td><input type="text" id="phone1"></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="joinYn2"></td>
						<td><input type="text" id="name2"></td>
						<td><input type="text" id="phone2"></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="joinYn3"></td>
						<td><input type="text" id="name3"></td>
						<td><input type="text" id="phone3"></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="joinYn4"></td>	
						<td><input type="text" id="name4"></td>
						<td><input type="text" id="phone4"></td>
					</tr>
				</tbody>
			</table>
			<ul class="btnBox">
				<li class="motion"><a href="javascript:doRegistMember()">변경</a></li>
				<li class="cancel"><a href="javascript:location.href = document.referrer">취소</a></li>
			</ul>
		</div>
	</div><!-- contents End -->	    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>