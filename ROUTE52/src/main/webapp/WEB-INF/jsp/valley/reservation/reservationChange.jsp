<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	var rowData;
	var mCos;

	$(document).ready(function() { 
		init();
		
		initTable();
	});
	
	function initTable() {
		var $table = $("#time-table");
		var $header = $table.children("tbody").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-grid";
			var imgAsc = "<c:url value='/images/valley/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/valley/t_arw1.png'/>";
			
			if(index == 1 || index == 2 || index == 4) {
				var type = index == 4 ? "n" : "s";
				var sLen = $(this)[0].innerText.length;
				var fSize = Number($(this).css("font-size").replace("px", "")) / 2;
				//var mid = Number($(this).css("width").replace("px", "")) / 2;
				var mid = 100;
				var left = mid + (sLen * fSize);
				
				$(this).css("background-image", "url(" + imgAsc + "), url(" + imgDesc + ")");
				$(this).css("background-position", String.format("{0}px 50%, {1}px 50%", left, left + 10));
				$(this).css("background-size", "12px 7px, 12px 7px");
				$(this).css("background-repeat", "no-repeat");
				$(this).css("cursor", "pointer");
				
				$(this).data("order", "asc");
				$(this).data("left", left);
				
				$(this).on("click", function() {
					sortTable(selector, type, $(this).data("order"), index);
					if($(this).data("order") == "asc") {
						$(this).css("background-image", "url(" + imgAsc + ")");
						$(this).data("order", "desc");
					} else {
						$(this).css("background-image", "url(" + imgDesc + ")");
						$(this).data("order", "asc");
					}
					$(this).css("background-position", String.format("{0}px 50%", $(this).data("left")));
					$(this).css("background-size", "12px 7px");
				});
			}
		});
	}
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/valley/member/login.do'/>";	
		}
		
		var bkName = "${bkName}";
		var bkDay = getDateFormat("${bkDay}");
		bkDay = String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", bkDay.yyyy(), bkDay.mm(), bkDay.dd(), bkDay.week());
		var bkPhone = String.format("{0}-{1}-{2}", "${phone1}", "${phone2}", "${phone3}");
		var bkCos = "${bkCosNm}";
		var bkRoundf = "${bkRoundfNm}";
		var bkTime = "${bkTime}";
		bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
		var bkPerson = "${person}";
		var bhChargeNm = "${bkChargeNm}";

		$("#txtName").html(bkName);
		$("#txtDate").html(bkDay);
		$("#txtPhone").html(bkPhone);
		$("#txtCos").html(String.format("{0}코스 / {1} / {2}", bkCos, bkRoundf, bkTime));
		$("#selPerson").val(bkPerson);
		$("#txtCost").html(numberWithCommas(bhChargeNm));
		
		if(globals.personCd.three != "${personCd}") {
			$("#selPerson").prop("disabled", true);
		}
		
		doSearch();
	}
	
	function doSearch() {	
		var sUrl = "<c:url value='/valley/reservation/getTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", "${bkDay}");
		
		if(mCos != null && mCos != "") {
			sParams += String.format("&cos={0}", mCos);
		}
		
		if($("#cbSelTime").val() != "") {
			var sTime, eTime;
			
			sTime = Number($("#cbSelTime").val());
			eTime = sTime + 99;
			
			sParams += String.format("&sTime={0}", sTime);
			sParams += String.format("&eTime={0}", eTime);
		}
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {
				var tBody = $("#time-grid");				
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					var row = $("<tr></tr>"); 

					var bkDay = rowData[i].BK_DAY;
					bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
					var bkTime = rowData[i].BK_TIME;
					bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
					var bkCharge;
					if(rowData[i].BK_CHARGE != null && rowData[i].BK_CHARGE != ""){
						bkCharge = rowData[i].BK_CHARGE.split(",")	
					}
					
				    var col1 = $("<td>" + bkDay + "</td>"); 
				    var col2 = $("<td>" + bkTime + "</td>"); 
				    var col3 = $("<td>" + rowData[i].BK_COS_NM + "</td>");
				    var col4 = $("<td>" + rowData[i].BK_ROUNDF_NM + "홀</td>");
				    var col5 = $("<td>" + numberWithCommas(bkCharge[1]) + "</td>");
				    var col6 = $("<td><input type='button' class='blueBtn' value='예약' onclick='onClickRow(" + i + ")'></td>"); 
				    
				    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody); 
				}
			}
			
			progressStop();
		});
	}
	
	function onClickRow(i) {
		var beforeData = {
			bkDay : "${bkDay}",
			bkCos : "${bkCos}",
			bkTime : "${bkTime}"
		}
		
		popupOpen("U", rowData[i], beforeData);
	}
	
	function onCosTapChange(cos) {
		if(cos == '') {
			$(".courseTabList #cosAll").addClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").removeClass("on");
		} else if(cos == 'A') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").addClass("on");
			$(".courseTabList #cosB").removeClass("on");			
		} else if(cos == 'B') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").addClass("on");			
		}
		
		mCos = cos;
		doSearch(); 
	}
	
	function doChangePerson() {
		var sUrl = "<c:url value='/valley/reservation/changeReservationPerson.do'/>";
		var sParams = "";
		
		var bkDay = "${bkDay}";
		var bkCos = "${bkCos}";
		var bkTime = "${bkTime}";
		var bkRsvNo = "${bkRsvNo}";
		var bkPerson = $("#selPerson").val();

		sParams += String.format("&bkDay={0}", bkDay);
		sParams += String.format("&bkCos={0}", bkCos);
		sParams += String.format("&bkTime={0}", bkTime);
		sParams += String.format("&bkRsvNo={0}", bkRsvNo);		
		sParams += String.format("&bkPerson={0}", bkPerson);
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);				
		});	
	}
	
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ 예약확인 &nbsp;&nbsp;&nbsp; ＞ <span>변경</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">		
		<div class="myzoneTabList6">
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

		<div class="midTitleBox">
			<span class="commonDot"> 예약시간</span>
		</div>

		<div class="infoChangeBox">
			<ul class="infoList">
				<li>
					<span class="infoDot"></span><span class="title">신청자</span><span id="txtName"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">예약일자</span><span class="blue" id="txtDate"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">핸드폰</span><span id="txtPhone"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">코스/홀/시간</span><span id="txtCos"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">인원</span>
					<select name="" id="selPerson" class="select-arrow">
						<option value="3">3명</option>
						<option value="4">4명</option>
					</select>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">인터넷회원가</span><span class="orangeRed" id="txtCost"></span>
				</li>
			</ul>
			<div class="dotLine"></div>
			<div class="info_Ch"><a class="cancel" href="javascript:doChangePerson()">정보변경</a></div>
		</div>


		<div class="courseTabList">
			<a href="javascript:onCosTapChange('')" class="on" id="cosAll">전체코스</a>
			<a href="javascript:onCosTapChange('A')" class="" id="cosA">서원코스</a>
			<a href="javascript:onCosTapChange('B')" class="" id="cosB">밸리코스</a>
			
			<div class="selectBox">
				<select name="" id="cbSelTime" class="select-arrow" onchange="doSearch()">
					<option value=''>전체</option>
					<option value='600'>6시</option>
					<option value='700'>7시</option>
					<option value='800'>8시</option>
					<option value='900'>9시</option>
					<option value='1000'>10시</option>
					<option value='1100'>11시</option>
					<option value='1200'>12시</option>
					<option value='1300'>13시</option>
					<option value='1400'>14시</option>
				</select>
			</div>
			<span class="timeHits">코스 시간대조회</span>
		</div>
		<table class="commonTable" id="time-table">
			<caption>실시간 예약 코스,시간별 가격 안내</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tr>
				<th>날짜</th>
				<th>시간대</th>
				<th>코스</th>
				<th>홀</th>
				<th>동반자그린피</th>
				<th>예약</th>
			</tr>
			<tbody id="time-grid">
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="../include/popup/reservationConfirm.jsp" flush="true" />
<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />