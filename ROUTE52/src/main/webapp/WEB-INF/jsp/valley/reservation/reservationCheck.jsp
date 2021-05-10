<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<link type='text/css' href='../../css/valley/modal_2.css' rel='stylesheet' media='screen' />
<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	
	var resData, waitData, weekData;

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/valley/member/login.do'/>";	
		}
		
		var date = new Date();
		var date2 = new Date(date.yyyy(), date.mm(), date.dd());
		smYear = fmYear = date.yyyy();
		smMonth = date.mm();
		fmMonth = date2.mm();
		
		$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));
		
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		doSearch();
	}
	
	function doSearch() {
		var sUrl = "<c:url value='/valley/reservation/getReservationList.do'/>";
		var sParams = "";
		
		var stDate, edDate;
		stDate = replaceAll($("#show_hideSub4").html(), "/", "");
		edDate = replaceAll($("#show_hideSub5").html(), "/", "");
		
		if(stDate == null || stDate == "") {
			alert("조회 시작일을 선택하세요.");
		}
		
		if(edDate == null || edDate == "") {
			alert("조회 종료일을 선택하세요.");
		}
		
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
					var row = $("<tr><td colspan='9'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyRes); 
				} else {
					for(i=0; i<resData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = resData[i].BK_DAY;
						bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime = resData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
						var bkCos = resData[i].BK_COS;
						var bkCosNm = resData[i].CD_TITLE1;
						var phone = resData[i].BK_FIRST_PHONE1 + "-" + resData[i].BK_MID_PHONE1 + "-" + resData[i].BK_LAST_PHONE1;
						
						var person = resData[i].BK_PERSON;
						
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + bkDay + "</td>"); 
					    var col3 = $("<td>" + bkTime + "</td>");
					    var col4 = $("<td>" + bkCosNm + "</td>");
					    var col5 = $("<td>" + phone + "</td>");
					    var col6 = $("<td>" + person + "</td>");
					    var col7 = $("<td><a href='javascript:doChangeReservation(" + i + ")' class='blueBtn'>변경</a></td>");
					    var col8 = $("<td><a href='javascript:doRegistMember(" + i + ")' class='orangeBtn'>등록</a></td>");
					    var col9 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelReservation(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8,col9).appendTo(tBodyRes); 
					} 	
				}
				
				if(weekData.length == 0) {
					var row = $("<tr><td colspan='8'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
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
						var phone = weekData[i].BK_FIRST_WPHONE + "-" + weekData[i].BK_MID_WPHONE + "-" + weekData[i].BK_LAST_WPHONE;
						var inputTime = weekData[i].INPUT_TIME;
						var bkState = weekData[i].BK_DEL_DIV == "N" ? "미배정" : weekData[i].BK_TIME == "X" ? "배정전" : "배정";
						
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + bkDay + "</td>"); 
					    var col3 = $("<td>" + bkTime1 + "</td>");
					    var col4 = $("<td>" + bkTime2 + "</td>");
					    var col5 = $("<td>" + phone + "</td>");
					    var col6 = $("<td>" + inputTime + "</td>");
					    var col7 = $("<td>" + bkState + "</td>");
					    var col8;
					    if(weekData[i].DEL_YN == "Y") {
						    col8 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(0, " + i + ")'></td>");
					    } else {
					    	col8 = $("<td></td>");
					    }
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyWeek); 
					} 	
				}
				
				if(waitData.length == 0) {
					var row = $("<tr><td colspan='8'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
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
						var phone = waitData[i].BK_FIRST_WPHONE + "-" + waitData[i].BK_MID_WPHONE + "-" + waitData[i].BK_LAST_WPHONE;
						var inputTime = waitData[i].INPUT_TIME;
						var bkState = waitData[i].BK_DEL_DIV == "N" ? "미배정" : waitData[i].BK_TIME == "X" ? "배정전" : "배정";
						
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + bkDay + "</td>"); 
					    var col3 = $("<td>" + bkTime1 + "</td>");
					    var col4 = $("<td>" + bkTime2 + "</td>");
					    var col5 = $("<td>" + phone + "</td>");
					    var col6 = $("<td>" + inputTime + "</td>");
					    var col7 = $("<td>" + bkState + "</td>");
					    var col8 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(1, " + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyWait); 
					} 	
				}
			} else {
				alert(data.resultMessage);
			}
			
			progressStop();
		});
	}
	
	function initSubCalendar(selector, year, month) {
		var rows = getCalendar(year, month);
			
		$(selector + " #calHeader").html(year + " / " + month);		
				
		var tBody = $(selector + " #calendar-body");				
		tBody.empty();
		
		var row = $("<tr></tr>");
		
		var fWeek = rows[0].week - 1;
		
		for(i=0; i<fWeek; i++) {
			row.append($("<td><div></div></td>"));
		}		
		
		for(i=0; i<rows.length; i++) {
			var td = $("<td><div>" + rows[i].day + "</div></td>");
			
			if(rows[i].date == new Date().yyyymmdd()) {
				td.addClass('today');
			}
			
			td.addClass('possible');
			td.data('date', rows[i].date);
			if(selector == "#subMonthBox1"){
				td.data("div", "start");
			} else {
				td.data("div", "finish");							
			}
			td.on('click', function() {
				onClickMiniDay($(this).data('div'), $(this).data('date')); 
			});
			
			row.append(td);
								
			if(rows[i].week == 7) {
				row.appendTo(tBody); 
				row = $("<tr></tr>");
			}					
		}			

		row.appendTo(tBody);     
	}
	
	function smNextMonth() {
	    if(smMonth == "12") {
	        smYear += 1;
	        smMonth = "01";
	    } else {
	        smMonth = Number(smMonth) + 1;
	        smMonth = (smMonth>9 ? '' : '0') + smMonth;
	    }

	    initSubCalendar("#subMonthBox1", smYear, smMonth);
	}

	function smPrevMonth() {
	    if(smMonth == "01") {
	        smYear -= 1;
	        smMonth = "11";
	    } else {
	        smMonth = Number(smMonth) - 1;
	        smMonth = (smMonth>9 ? '' : '0') + smMonth;
	    }

	    initSubCalendar("#subMonthBox1", smYear, smMonth);		
	}

	function fmNextMonth() {
	    if(fmMonth == "12") {
	        fmYear += 1;
	        fmMonth = "01";
	    } else {
	        fmMonth = Number(fmMonth) + 1;
	        fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
	    }

	    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
	}

	function fmPrevMonth() {
	    if(fmMonth == "01") {
	        fmYear -= 1;
	        fmMonth = "11";
	    } else {
	        fmMonth = Number(fmMonth) - 1;
	        fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
	    }

	    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
	}
	
	function onClickMiniDay(div, sDate) {
		var date = getDateFormat(sDate);
		
		if(div == "start") {
			stDate = sDate;
			$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox4").slideToggle();			
		} else if(div == "finish") {
			fnDate = sDate;
			$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox5").slideToggle();			
		} 		
	}
	
	function doCancelReservation(i) {
		var bkDay = resData[i].BK_DAY;
		bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
		var bkTime = resData[i].BK_TIME;
		bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
		var bkCosNm = resData[i].CD_TITLE1;
		
		var person = resData[i].BK_PERSON;
		
		var message = String.format("예약일자 : {0}\r\n예약시간 : {1}\r\n코스 : {2}코스\r\n예약을 취소하시겠습니까?", bkDay, bkTime, bkCosNm);
		
		if(confirm(message)) {
			var sUrl = "<c:url value='/valley/reservation/delReservation.do'/>";
			var sParams = "";			
			
			sParams += String.format("&bkDay={0}", resData[i].BK_DAY);
			sParams += String.format("&bkTime={0}", resData[i].BK_TIME);
			sParams += String.format("&bkCos={0}", resData[i].BK_COS);
			
			progressStart();
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				alert(data.resultMessage);
				
				if(data.resultCode == "0000") {
					doSearch();
				}
			});
		}
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
		var sUrl = "<c:url value='/valley/reservation/reservationRegist.do'/>";
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
		var sUrl = "<c:url value='/valley/reservation/reservationChange.do'/>";
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

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>예약확인</span></p>
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

		<div class="grayCommonBox">
			<div class="inquiry">
				<span class="inquiryTitle">조회기간</span>
				<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub4"></div>								                
                        <div class="SubMonthBox4" id="subMonthBox1">
						  <div class="monthChoice">
							<a href="javascript:smPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:smNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
						  </div>
																				
						  <table class="mainCalendar" summary="실시간 예약" cellspacing="5">
                                 <caption>
                                 실시간 예약
                                 </caption>
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
                                    <th scope="col" class="sun">SUN</th>
                                    <th scope="col">MON</th>
                                    <th scope="col">TUE</th>
                                    <th scope="col">WEN</th>
                                    <th scope="col">THU</th>
                                    <th scope="col">FRI</th>
                                    <th scope="col">SAT</th>
                                  </tr>
                                 <tbody id="calendar-body">
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
						</tbody>
                    </table>
					</div><!--//미니달력 끝-->
				<img src="<c:url value='/images/valley/resCal_w.png'/>" alt="">
				<span>&nbsp;&nbsp; ~ &nbsp;&nbsp;</span>
				<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub5"></div>								                
                        <div class="SubMonthBox5" id="subMonthBox2">
						  <div class="monthChoice">
							<a href="javascript:fmPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:fmNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
						  </div>
																				
						  <table class="mainCalendar" summary="실시간 예약" cellspacing="5">
                                 <caption>
                                 실시간 예약
                                 </caption>
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
                                    <th scope="col" class="sun">SUN</th>
                                    <th scope="col">MON</th>
                                    <th scope="col">TUE</th>
                                    <th scope="col">WEN</th>
                                    <th scope="col">THU</th>
                                    <th scope="col">FRI</th>
                                    <th scope="col">SAT</th>
                                  </tr>
                                 <tbody id="calendar-body">
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
						</tbody>
                    </table>
					</div><!--//미니달력 끝-->
				<img src="<c:url value='/images/valley/resCal_w.png'/>" alt="">
				<a href="javascript:doSearch()" class="inquiryBtn">검색</a>
			</div>
		</div>

		<div class="midTitleBox">
			<span class="commonDot"> 실시간예약 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/valley/reservation/reservation.do'/>"><span>▶</span> 예약하기</a>
		</div>

		<table class="commonTable tableBottom">
			<caption> 실시간예약 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>			
			<tr>
				<th>번호</th>
				<th>예약일자</th>
				<th>예약시간</th>
				<th>코스</th>
				<th>핸드폰</th>
				<th>동반자수</th>
				<th>변경</th>
				<th>동반자등록</th>
				<th>취소</th>
			</tr> 
			<tbody id="tbody-reservation">
			</tbody>
		</table>

		<div class="midTitleBox">
			<span class="commonDot"> 주말예약접수 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/valley/reservation/reservation.do'/>"><span>▶</span> 예약하기</a>
		</div>

		<table class="commonTable tableBottom">
			<caption>주말예약접수 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>희망일자</th>
				<th>희망시간1</th>
				<th>희망시간2</th>
				<th>핸드폰</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>취소</th>
			</tr>
			<tbody id="tbody-weekRes">
			
			</tbody>
		</table>
		<div class="midTitleBox">
			<span class="commonDot"> 대기예약접수 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/valley/reservation/reservationWait.do'/>"><span>▶</span> 예약하기</a>
		</div>

		<table class="commonTable">
			<caption>대기예약접수 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>희망일자</th>
				<th>희망시간1</th>
				<th>희망시간2</th>
				<th>핸드폰</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>취소</th>
			</tr>
			<tbody id="tbody-waitRes">
			
			</tbody>
		</table>
		
		<script type='text/javascript' src='<c:url value='/js/valley/jquery.simplemodal.js'/>'></script>
		<script type="text/javascript">			
			function onLoadCancelModal() {
				$('#basic-modal-content').modal();
			}
		</script>
		
		<!-- The Modal -->
		 <div id='container'>		
			<div id='content'>
				
				<!-- modal content -->
				<div id="basic-modal-content">
					<div class="informBox">
						<img src="<c:url value='/images/valley/r_c_img.png'/>" alt="">
						<p class="informTitle">예약취소</p>
						<ul>
							<li><span class="title">신청자</span><span>홍길동</span></li>
							<li><span class="title">핸드폰</span><span>010-0000-0000</span></li>
							<li><span class="title">예약일자</span><span class="orange">2019년 1월 23일 (수요일)</span></li>
							<li><span class="title">코스/홀/시간</span><span>서원/18홀/09:47</span></li>
							<li><span class="title">예약인원</span><span>4명</span></li>
						</ul>
					</div>

					<div class="btnBox">
							<a href="" class="motion">예 약</a>
							<a href="javascript:void(0)" class="cancel">취 소</a>
						</div>
										
					<div style='display:none'>
						<img src='<c:url value='/images/valley/x.png'/>' alt='' />
					</div>
				</div><!-- modal content End-->

			</div>
        <!-- Modal container End -->
		
	</div><!-- contents End -->
</div>
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />