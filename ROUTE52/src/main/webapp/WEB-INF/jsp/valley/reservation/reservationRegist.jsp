<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">
	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/valley/member/login.do'/>";	
		}
		
		var bkDay = "${bkDay}";
		var bkCos = "${bkCosNm}";
		var bkTime = "${bkTime}";
		
		var date = getDateFormat(bkDay);
		$("#txtDay").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		$("#txtCos").html(bkCos);
		$("#txtTime").html(bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4));
		
		var togetherList = eval("${togetherList}");
		
		if(togetherList != null && togetherList != "") {
			for(i = 1; i <= togetherList.length; i++) {
				$("#name" + i).val(togetherList[i-1].name);
				$("#phoneFirst" + i).val(togetherList[i-1].phone1);
				$("#phoneMid" + i).val(togetherList[i-1].phone2);
				$("#phoneLast" + i).val(togetherList[i-1].phone3);
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
			var phone1 = $("#phoneFirst" + i).val();
			var phone2 = $("#phoneMid" + i).val();
			var phone3 = $("#phoneLast" + i).val();
			
			if(name != "") {
				if(phone1 == "" || phone2 == "" || phone3 == "" ) {
					alert(String.format("동반자 {0}의 연락처를 확인하세요.", name));
					return;
				}
				
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
				location.href = document.referrer	
			}
		});		
	}
	
	function doResetMember(i) {
		$("#name" + i).val("");
		$("#phoneFirst" + i).val("");
		$("#phoneMid" + i).val("");
		$("#phoneLast" + i).val("");
		$("#joinYn" + i).attr("checked", false);
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ 예약확인 &nbsp;&nbsp;&nbsp; ＞ <span>동반자등록</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">		
		<div class="myzoneTabList">
			<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="on">예약확인/취소</a>
			<a href="<c:url value='/valley/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/valley/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/valley/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/valley/member/memModify.do'/>" class="">회원정보수정</a>
		</div>
		
		<div class="subTitle">
			<span class="title">예약확인</span>
			<span class="titleDes">고객님의 예약을 확인하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>
		
		<div class="whiteBgBox">
			<span class="infoDot"></span>
			<span class="title">예약일자</span>
			<span class="blue" id="txtDay"></span>
		</div>

		<table class="commonTable tableLine">
			<caption>주말예약접수 현황</caption>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="5%">
				<col width="20%"> 
				<col width="35%">
				<col width="15%%">
			</colgroup>
			<tbody>
			<tr>
				<th>코스</th>
				<th>예약시간</th>
				<th>조인</th>
				<th>동반자이름</th>
				<th>동반자연락처</th>
				<th>초기화</th>
			</tr>
			<tr>
				<td rowspan="4" style="border-bottom:1px solid #45454f" id="txtCos"></td>
				<td rowspan="4" style="border-bottom:1px solid #45454f" id="txtTime"></td>
				<td>
					<input type="checkbox" id="joinYn1">
				</td>
				<td>
					<input type="text" class="nameIp" id="name1">
				</td>
				<td>
					<input type="text" class="nameIp numIp" id="phoneFirst1"> - 
					<input type="text" class="nameIp numIp" id="phoneMid1"> -
					<input type="text" class="nameIp numIp" id="phoneLast1">	
				</td>
				<td><a href="javascript:doResetMember(1)"><img src="<c:url value='/images/valley/initial.png'/>" alt=""></a></td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="joinYn2">
				</td>
				<td>
					<input type="text" class="nameIp" id="name2">
				</td>
				<td>
					<input type="text" class="nameIp numIp" id="phoneFirst2"> - 
					<input type="text" class="nameIp numIp" id="phoneMid2"> -
					<input type="text" class="nameIp numIp" id="phoneLast2">	
				</td>
				<td><a href="javascript:doResetMember(2)"><img src="<c:url value='/images/valley/initial.png'/>" alt=""></a></td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="joinYn3">
				</td>
			  	<td>
					<input type="text" class="nameIp" id="name3">
				</td>
				<td>
					<input type="text" class="nameIp numIp" id="phoneFirst3"> - 
					<input type="text" class="nameIp numIp" id="phoneMid3"> -
					<input type="text" class="nameIp numIp" id="phoneLast3">	
				</td>
				<td><a href="javascript:doResetMember(3)"><img src="<c:url value='/images/valley/initial.png'/>" alt=""></a></td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="joinYn4">
				</td>
			  	<td>
					<input type="text" class="nameIp" id="name4">
				</td>
				<td>
					<input type="text" class="nameIp numIp" id="phoneFirst4"> - 
					<input type="text" class="nameIp numIp" id="phoneMid4"> -
					<input type="text" class="nameIp numIp" id="phoneLast4">	
				</td>
				<td><a href="javascript:doResetMember(4)"><img src="<c:url value='/images/valley/initial.png'/>" alt=""></a></td>
			</tr>
			
			</tbody>
		</table>
		<div class="btnBox">
			<a href="javascript:doRegistMember()" class="motion">예 약</a>
			<a href="javascript:location.href = document.referrer" class="cancel">취 소</a>
		</div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />