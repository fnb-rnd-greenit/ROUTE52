<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type='text/javascript' src="<c:url value='/js/hills/basic.js'/>"></script>
<script type="text/javascript">

	var mDate;
	var sYear, sMonth, fYear, fMonth;

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/hills/member/login.do'/>";	
    		return;
		}
		
		var phone1 = "<c:out value='${sessionScope.msMember.phone1}'/>";
		var phone2 = "<c:out value='${sessionScope.msMember.phone2}'/>";
		var phone3 = "<c:out value='${sessionScope.msMember.phone3}'/>";
		
		if(phone1 == "" || phone2 == "" || phone3 == "") {
			alert("연락처를 입력한 후 예약할 수 있습니다.");
			location.href = "<c:url value='/hills/member/memModify.do'/>";
		}
		
		var date = new Date();
		sYear = fYear = smYear = fmYear = date.yyyy();
		sMonth = fMonth = smMonth = fmMonth = date.mm();
		
		initCalendar("#calendarBox1", sYear, sMonth);
		initCalendar("#calendarBox2", fYear, fMonth);
	}
	
	function initCalendar(selector, year, month) {
		var sUrl = "<c:url value='/hills/reservation/getWaitCalendar.do'/>";
		var sParams = "";
		
		sParams += String.format("&selYM={0}", year + month);	
		
		mAjax(sUrl, sParams, function(data) {			
			if(data.resultCode == "0000") {
				$(selector + " #calHeader").html(year + " / " + month);
				
				var currentDay = new Date().yyyymmdd();
				var tBody = $(selector + " #calendar-body");				
				tBody.empty();
				
				var rows = data.rows;
				var row = $("<tr></tr>");
				
				var fWeek = rows[0].CL_DAYDIV - 1;
				
				for(i=0; i<fWeek; i++) {
					row.append($("<td><div></div></td>"));
				}		
				
				for(i=0; i<rows.length; i++) {
					var td = $("<td><div>" + rows[i].DAYNUM + "</div></td>");
					
					if(rows[i].CL_SOLAR == currentDay) {
						td.addClass('today');
					} else if(rows[i].CL_SOLAR > currentDay) {
						if(rows[i].BK_TEAM > 0) {
							td.addClass('possible_w');
							td.data('date', rows[i].CL_SOLAR)
							td.on('click', function() {
								onClickDay($(this).data('date'));
							});
						} else {
							td.addClass('impossible_w');							
						}
					} 
					
					row.append(td);
										
					if(rows[i].CL_DAYDIV == 7) {
						row.appendTo(tBody); 
						row = $("<tr></tr>");
					}					
				}			

				row.appendTo(tBody);     
			} else {
				alert(data.resultMessage);	
			}
		});	
	}
	
	function onClickDay(sDate) {
		mDate = sDate;
		
		var date = getDateFormat(sDate);
		$("#txtSelectedDate").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		doSearch();
	}
	
	function doSearch() {			
		if(mDate == null || mDate == '') {
			alert("날짜를 선택하세요.");
			return;
		}
		
		var sUrl = "<c:url value='/hills/reservation/getWaitTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", mDate);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {				
				var rows = data.rows;
				
				if(rows.length == 0) {
					progressStop();
					
					return;
				}
				
				$('#selLikeTime1').find('option').remove();
				$('#selLikeTime2').find('option').remove();
				
				$('#selLikeTime1').append($('<option>', {
				    value: "",
				    text: "선택"
				}));
				
				$('#selLikeTime2').append($('<option>', {
				    value: "",
				    text: "선택"
				}));
				
				for(i=0; i<rows.length; i++) {
					var value, text;
					value = rows[i].TIME;
					text = rows[i].BK_PART + "부 - " + Number(rows[i].TIME) + "시대";
					
					$('#selLikeTime1').append($('<option>', {
					    value: value,
					    text: text
					}));
					
					$('#selLikeTime2').append($('<option>', {
					    value: value,
					    text: text
					}));
				}
			}
			
			progressStop();
		});
	}
	
	function actionWaitReservation() {
		var sUrl = "<c:url value='/hills/reservation/actionWaitReservation.do'/>";
		var sParams = "";
		
		var selTime1 = $("#selLikeTime1").val();
		var selTime2 = $("#selLikeTime2").val();
		var comment = $("#txtComment").val();
		
		if(mDate == null) {
			alert("날짜를 선택하세요.");
			return;
		}
		
		if(selTime1 == "") {
			alert("희망시간1 선택하세요.");
			return;
		}

		sParams += String.format("&date={0}", mDate);
		sParams += String.format("&selTime1={0}", selTime1);
		
		if(selTime2 != "") {
			sParams += String.format("&selTime2={0}", selTime2);
		}
		
		if(comment != "") {
			sParams += String.format("&comment={0}", comment);
		}
		
		sParams += String.format("&lotteryGu={0}", "N");
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);	
			
			if(data.resultCode == "0000") {		
				location.href = "<c:url value='/hills/reservation/reservationCheck.do'/>";
			}				
		});	
	}
	
	function sNextMonth() {
		if(sMonth == "12") {
			sYear += 1;
			sMonth = "01";
		} else {
			sMonth = Number(sMonth) + 1;
			sMonth = (sMonth>9 ? '' : '0') + sMonth;
		}
		
		initCalendar("#calendarBox1", sYear, sMonth);
	}
	
	function sPrevMonth() {
		if(sMonth == "01") {
			sYear -= 1;
			sMonth = "11";
		} else {
			sMonth = Number(sMonth) - 1;
			sMonth = (sMonth>9 ? '' : '0') + sMonth;
		}
		
		initCalendar("#calendarBox1", sYear, sMonth);		
	}
	
	function fNextMonth() {
		if(fMonth == "12") {
			fYear += 1;
			fMonth = "01";
		} else {
			fMonth = Number(fMonth) + 1;
			fMonth = (fMonth>9 ? '' : '0') + fMonth;
		}
		
		initCalendar("#calendarBox2", fYear, fMonth);
	}
	
	function fPrevMonth() {
		if(fMonth == "01") {
			fYear -= 1;
			fMonth = "11";
		} else {
			fMonth = Number(fMonth) - 1;
			fMonth = (fMonth>9 ? '' : '0') + fMonth;
		}
		
		initCalendar("#calendarBox2", fYear, fMonth);		
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>예약서비스 &nbsp;&nbsp;&nbsp; ＞ <span>대기예약</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="reserTabList">
			<a href="<c:url value='/hills/reservation/reservation.do'/>" class="">실시간예약</a>	
			<a href="<c:url value='/hills/reservation/reservationWait.do'/>" class="on">대기예약</a>
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
		</div>

		<div class="subTitle">
			<span class="title">대기예약</span>
			<span class="titleDes">실시간 예약을 하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<!-- reserCalBox -->
		<div class="reserCalBox">
			<div class="box-left">
				<div class="waitCalBox">
					<div id="calendarBox1">
					  <div class="monthChoice">
						<span><a href="javascript:sPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달"></a></span>
						<span class="month" id="calHeader"></span>
						<span><a href="javascript:sNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달"></a></span>
					  </div>
					  <table class="waitCalendar" summary="실시간 예약" cellspacing="5">
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
					</div>
					  <div class="resChoice">
						<img src="<c:url value='/images/hills/dot2_blue.png'/>" alt=""><span> 예약가능</span>
						<img src="<c:url value='/images/hills/dot2_red.png'/>" alt=""><span> 예약불가능</span>
					  </div>
					</div>

					<div class="waitCalBox">
					<div id="calendarBox2">
					  <div class="monthChoice">
						<span><a href="javascript:fPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달"></a></span>
						<span class="month" id="calHeader"></span>
						<span><a href="javascript:fNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달"></a></span>
					  </div>
					  <table class="waitCalendar" summary="실시간 예약" cellspacing="5">
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
					</div>
					  <div class="resChoice">
						<img src="<c:url value='/images/hills/dot2_blue.png'/>" alt=""><span> 예약가능</span>
						<img src="<c:url value='/images/hills/dot2_red.png'/>" alt=""><span> 예약불가능</span>
					  </div>
					</div>
			</div>
			<!-- box-left End -->
			<!-- box-Right -->
			<div class="box-right-wait">
				<div class="midTitleBox">
					<span class="commonDot"> 예약시간</span>
					<a href="<c:url value='/hills/reservation/reservationGuide.do'/>" class="reserGuide"> <img src="<c:url value='/images/hills/red_arrow.png'/>" alt=""> 예약가이드 자세히보기</a>
				</div>
				<!-- <p class="rightTxt">
					대기 예약은 위약기간(라운딩 3일전 17시 이후 ~ 라운딩 하루전)에 해당되는 취소건에 대해 선착순으로 배정합니다.
				</p> -->
				<table class="waitTable">
					<caption>실시간 예약 코스,시간별 가격 안내</caption>
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tbody>
						<tr>
							<th>번호</th>
							<td>${sessionScope.msMember.msName}</td>
						</tr>
						<tr>
							<th>핸드폰</th>
							<td>${sessionScope.msMember.msPhone}</td>							
						</tr>
						<tr>
							<th>희망일자</th>
							<td><span class="orangeRed" id="txtSelectedDate"></span></td>
						</tr>
						<tr>							
							<th>희망시간1</th>
							<td><select id="selLikeTime1" class="select-arrow2">
							</select></td>
						</tr>
						<tr>							
							<th>희망시간2</th>
							<td><select id="selLikeTime2" class="select-arrow2">
							</select></td>
						</tr>
						<tr>
							<th style="border-bottom: 1px solid #45454f;">코멘트</th>
							<td style="border-bottom: 1px solid #45454f;"><textarea id="txtComment"></textarea>
						</tr>
					</tbody>
				</table>
				<div class="btnBox">
					<a href="javascript:actionWaitReservation()" class="orangeBtn">신 청</a>
				</div>
			</div>
		</div>
		<!-- Box-Right -->	

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />