<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_reser_cancel.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script type="text/javascript"> 

	var resData, waitData, weekData;

	$(document).ready(function() { 
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		} 
		
		doSearch(); 
	});
	 
	function doSearch() {
		var sUrl = "<c:url value='/valley/reservation/getReservationList.do'/>";
		var sParams = "";
		
		var stDate = new Date().yyyymmdd();
		var edDate = addDate(stDate, 100).yyyymmdd();
		
		sParams += String.format("&stDate={0}", stDate);
		sParams += String.format("&edDate={0}", edDate);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {
				var tBodyRes = $("#tbody-reservation");
				var tBodyWait = $("#tbody-waitRes");
				var tBodyWeek = $("#tbody-weekRes");
				
				tBodyRes.empty();
				tBodyWait.empty();
				tBodyWeek.empty();
				
				resData = data.rows.resData;
				waitData = data.rows.waitData;
				weekData = data.rows.weekData;
				
				if(resData.length == 0) {
					var row = $("<tr><td colspan='7'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyRes); 
				} else {
					for(i=0; i<resData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = resData[i].BK_DAY;
						bkDay = bkDay.substring(2, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime = resData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
						var bkCos = resData[i].BK_COS;
						var bkCosNm = resData[i].CD_TITLE1;
						
						var person = resData[i].BK_PERSON;
						
					    var col1 = $("<td>" + bkDay + "</td>"); 
					    var col2 = $("<td>" + bkTime + "</td>");
					    var col3 = $("<td>" + bkCosNm + "</td>");
					    var col4 = $("<td>" + person + "</td>");
					    var col5 = $("<td><a href='javascript:doChangeReservation(" + i + ")' class='blueBtn'>변경</a></td>");
					    var col6 = $("<td><a href='javascript:doRegistMember(" + i + ")' class='orangeBtn'>등록</a></td>");
					    var col7 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelPopupOpen(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7).appendTo(tBodyRes); 
					} 	
				}
				
				if(weekData.length == 0) {
					var row = $("<tr><td colspan='5'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyWeek); 
				} else {
					for(i=0; i<weekData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = weekData[i].BK_WDAY;
						bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime1 = weekData[i].BK_WTIME;
						bkTime1 = bkTime1.substring(0, 2) + ":00";
						var bkTime2 = weekData[i].BK_WTIME2;
						if(bkTime2 != null && bkTime2 != ""){
							bkTime2 = bkTime2.substring(0, 2) + ":00";
						} else {
							bkTime2 = "";
						}       
						var bkState = weekData[i].BK_DEL_DIV == "N" ? "미배정" : weekData[i].BK_TIME == "X" ? "배정전" : "배정";
						 
					    var col1 = $("<td>" + bkDay + "</td>"); 
					    var col2 = $("<td>" + bkTime1 + "</td>");
					    var col3 = $("<td>" + bkTime2 + "</td>");
					    var col4 = $("<td>" + bkState + "</td>");
					    var col5;
					    if(weekData[i].DEL_YN == "Y") {
					    	col5 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(0, " + i + ")'></td>");
					    } else {
					    	col5 = $("<td></td>");
					    }
					    
					    row.append(col1,col2,col3,col4,col5).appendTo(tBodyWeek); 
					} 	
				}
				
				if(waitData.length == 0) {
					var row = $("<tr><td colspan='6'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyWait); 
				} else {
					for(i=0; i<waitData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = waitData[i].BK_WDAY;
						bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime1 = waitData[i].BK_WTIME;
						bkTime1 = bkTime1.substring(0, 2) + ":00";
						var bkTime2 = waitData[i].BK_WTIME2;
						if(bkTime2 != null && bkTime2 != ""){
							bkTime2 = bkTime2.substring(0, 2) + ":00";
						} else {
							bkTime2 = "";
						}
						var inputTime = waitData[i].INPUT_TIME;
						var bkState = waitData[i].BK_DEL_DIV == "N" ? "미배정" : waitData[i].BK_TIME == "X" ? "배정전" : "배정";
						 
					    var col1 = $("<td>" + bkDay + "</td>");  
					    var col2 = $("<td>" + bkTime1 + "</td>");
					    var col3 = $("<td>" + bkTime2 + "</td>");
					    var col4 = $("<td>" + inputTime + "</td>");
					    var col5 = $("<td>" + bkState + "</td>");
					    var col6 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(1, " + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBodyWait); 
					} 	
				}
			} else {
				alert(data.resultMessage);
			}
			
			progressStop();
		});
	}
	
	function doCancelPopupOpen(i) {
		cancelPopupOpen(resData[i]);
	}
	
	function doCancelWaitRes(div, i) {
		var data = div == 0 ? weekData : waitData;
		
		var bkDay = data[i].BK_WDAY;
		bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
		var bkTime1 = data[i].BK_WTIME;
		bkTime1 = bkTime1.substring(0, 2);
		var bkTime2 = data[i].BK_WTIME2;
		if(bkTime2 != null && bkTime2 != ""){
			bkTime2 = bkTime2.substring(0, 2);
		} else {
			bkTime2 = "";
		}
		
		var message = String.format("희망일자 : {0}\r\n희망시간1 : {1}\r\n희망시간2 : {2}\r\n신청을 취소하시겠습니까?", bkDay, bkTime1, bkTime2);
		
		if(confirm(message)) {
			var sUrl = "<c:url value='/valley/reservation/delWaitReservation.do'/>";
			var sParams = "";			
			
			sParams += String.format("&bkDay={0}", data[i].BK_WDAY);
			sParams += String.format("&bkTime={0}", data[i].BK_WTIME);
			sParams += String.format("&bkCos={0}", data[i].BK_WCOS);
			sParams += String.format("&bkNo={0}", data[i].BK_WNO);
			
			progressStart();
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				alert(data.resultMessage);
				
				doSearch();
			});
		}
	}
	
	function doRegistMember(i) {
		var sUrl = "<c:url value='/m_valley/reservation/reservationRegist.do'/>";
		var sParams = "";
		
		var bkDay = resData[i].BK_DAY;
		var bkCos = resData[i].BK_COS;
		var bkCosNm = resData[i].CD_TITLE1;
		var bkTime = resData[i].BK_TIME;
		var bkRsvNo = resData[i].BK_RSVNO;
		
		sParams += String.format("?bkDay={0}", bkDay);
		sParams += String.format("&bkCos={0}", bkCos);
		sParams += String.format("&bkCosNm={0}", bkCosNm);
		sParams += String.format("&bkTime={0}", bkTime);
		sParams += String.format("&bkRsvNo={0}", bkRsvNo);
		
		location.href = sUrl + encodeURI(sParams);
	} 
	
	function doChangeReservation(i) {
		var sUrl = "<c:url value='/m_valley/reservation/reservationChange.do'/>";
		var sParams = "";
		
		var bkDay = resData[i].BK_DAY;
		var bkCos = resData[i].BK_COS;
		var bkCosNm = resData[i].CD_TITLE1;
		var bkTime = resData[i].BK_TIME;
		var bkRsvNo = resData[i].BK_RSVNO;
		var bkName = resData[i].BK_NAME;
		var bkRoundf = resData[i].BK_ROUNDF;
		var bkRoundfNm = resData[i].BK_ROUNDF == "1" ? "18홀" : "9홀";
		var phone1 = resData[i].BK_FIRST_PHONE1;
		var phone2 = resData[i].BK_MID_PHONE1;
		var phone3 = resData[i].BK_LAST_PHONE1;
		var person = resData[i].BK_PERSON;
		var personCd = resData[i].BK_PERSON_CD;
		var bkCharge = resData[i].BK_LAST_PHONE1;
		var bkChargeNm = resData[i].BK_CHARGE_NM;

		sParams += String.format("?bkDay={0}", bkDay);
		sParams += String.format("&bkCos={0}", bkCos);
		sParams += String.format("&bkCosNm={0}", bkCosNm);
		sParams += String.format("&bkTime={0}", bkTime);
		sParams += String.format("&bkRsvNo={0}", bkRsvNo);
		sParams += String.format("&bkName={0}", bkName);
		sParams += String.format("&bkRoundf={0}", bkRoundf);
		sParams += String.format("&bkRoundfNm={0}", bkRoundfNm);
		sParams += String.format("&phone1={0}", phone1);
		sParams += String.format("&phone2={0}", phone2);
		sParams += String.format("&phone3={0}", phone3);
		sParams += String.format("&person={0}", person);
		sParams += String.format("&personCd={0}", personCd);
		sParams += String.format("&bkCharge={0}", bkCharge);
		sParams += String.format("&bkChargeNm={0}", bkChargeNm);
		
		location.href = sUrl + encodeURI(sParams);
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
			<div class="commonDot"> 실시간예약 현황</div>
			<table class="commonTable bgBottom">
				<caption>실시간 현황</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tr>
					<th>예약일자</th>
					<th>예약시간</th>
					<th>코스</th>
					<th>동반자수</th>
					<th>예약변경</th>
					<th>동반자등록</th>
					<th>취소</th>
				</tr>
				<tbody id="tbody-reservation">
				</tbody>
			</table>
			<div class="commonDot"> 주말예약접수 현황</div>
			<table class="commonTable">
				<caption> 주말예약접수 현황</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tr>
					<th>희망일자</th>
					<th>희망시간1</th>
					<th>희망시간2</th>
					<th>상태</th>
					<th>취소</th>
				</tr>
				<tbody id="tbody-weekRes">
				</tbody>
			</table>
			<div class="commonDot"> 대기예약접수 현황</div>
			<table class="commonTable">
				<caption> 대기예약접수 현황</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tr>
					<th>희망일자</th>
					<th>희망시간1</th>
					<th>희망시간2</th>
					<th>신청일자</th>
					<th>상태</th>
					<th>취소</th>
				</tr>
				<tbody id="tbody-waitRes">
				</tbody>
			</table>
		</div>		
	</div><!-- contents End -->	 
    
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>