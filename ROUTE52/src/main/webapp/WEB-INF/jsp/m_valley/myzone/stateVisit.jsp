<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	
	var rowData;

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		}
		
		var date = new Date();
		var date2 = new Date(date.yyyy(), date.mm(), date.dd());
		smYear = fmYear = date.yyyy();
		smMonth = fmMonth = date.mm();
		
		$("#show_hideSub3").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));
		
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		$("#show_hideSub3").click(function() {
			$(".SubMonthBox1").slideToggle();
			$(".SubMonthBox2").slideUp();
		});
		
		$("#show_hideSub4").click(function() {
			$(".SubMonthBox2").slideToggle();
			$(".SubMonthBox1").slideUp();
		});
		
		doSearch();
	}
	
	function doSearch() {
		var tBody = $("#tbody");
		
		var sUrl = "<c:url value='/valley/member/getEnHistoryLog.do'/>";
		var sParams = "";
		
		var stDate, edDate;
		stDate = replaceAll($("#show_hideSub3").html(), "/", "");
		edDate = replaceAll($("#show_hideSub4").html(), "/", "");
		
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
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					if(rowData.length == 0) {
						var row = $("<tr><td colspan='5'><span class='txt'> 등록된 내장현황이 없습니다. </span></td></tr>");
						row.appendTo(tBody); 
					}
				}
				
				for(i=0; i<rowData.length; i++) {
					var enDay = rowData[i].EN_DAY;
					enDay = enDay.substring(0, 4) + "/" + enDay.substring(4, 6) + "/" + enDay.substring(6, 8);

					var sTime = rowData[i].EN_START_TIME;
					if(sTime != null && sTime != "") {
						sTime = sTime.substring(0, 2) + ":" + sTime.substring(2, 4);
					}
					var eTime = rowData[i].EN_END_TIME;
					if(eTime != null && eTime != "") {
						eTime = eTime.substring(0, 2) + ":" + eTime.substring(2, 4);
					}
			
					var row = $("<tr></tr>"); 
				    var col1 = $("<td>" + enDay + "</td>");
				    var col2 = $("<td>" + rowData[i].GP_NAME + "</td>"); 
				    var col3 = $("<td>" + rowData[i].EN_COS_NM + "코스</td>");
				    var col4 = $("<td>" + sTime + "</td>"); 
				    var col5 = $("<td>" + eTime + "</td>"); 
				    row.append(col1,col2,col3,col4,col5).appendTo(tBody); 
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
			$("#show_hideSub3").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox1").slideToggle();			
		} else if(div == "finish") {
			fnDate = sDate;
			$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox2").slideToggle();			
		} 		
		
		doSearch();
	}
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> MY ZONE <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList">			
		<li class=""><a href="<c:url value='/m_valley/reservation/reservationCheck.do'/>">예약현황</a></li>
		<li class="on"><a href="<c:url value='/m_valley/member/stateVisit.do'/>">내장현황</a></li>
		<li class=""><a href="<c:url value='/m_valley/member/score.do'/>">스코어카드</a></li>
	</ul>
	<div class="contents">
		<div class="contentBg">

			<div class="roundBox">				
				<div class="inquiry">
					<span class="inquiryTitle">조회기간</span>
					<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub3"></div>								                
                        <div class="SubMonthBox1" id="subMonthBox1">
						  <div class="monthChoice">
							<a href="javascript:smPrevMonth()"><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:smNextMonth()"><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
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

					<img class="inquiryImg" src="<c:url value='/images/m_valley/resCal_w.png'/>" alt="">
					<span style="color:#fff;">~</span>
					<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub4"></div>								                
                        <div class="SubMonthBox2" id="subMonthBox2">
						  <div class="monthChoice">
							<a href="javascript:fmPrevMonth()"><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:fmNextMonth()"><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
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
					<img class="inquiryImg" src="<c:url value='/images/m_valley/resCal_w.png'/>" alt="">
				</div>
			</div>

			<div class="commonDot"> 실시간예약 현황</div>
			<table class="commonTable bgBottom">
				<caption>실시간 현황</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tr>
					<th>내장일자</th>
					<th>클럽</th>
					<th>코스</th>
					<th>시작시간</th>
					<th>종료시간</th>
				</tr>
				<tbody id="tbody">
				</tbody>
			</table>

		</div>		
	</div><!-- contents End -->	    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>