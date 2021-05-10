<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	

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
		smMonth = fmMonth = date.mm();
		
		$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));
		
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		doSearch();
	}
	
	function doSearch() {
		var tBody = $("#tbody");
		
		var sUrl = "<c:url value='/valley/member/getPlaceboList.do'/>";
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
				tBody.empty();
				
				var rowData = data.rows;
				
				if(rowData.length == 0) {
					if(rowData.length == 0) {
						var row = $("<tr><td colspan='6'><span class='txt'>※ 등록된 위약이 없습니다. </span></td></tr>");
						row.appendTo(tBody); 
					}
				}
				
				for(i=0; i<rowData.length; i++) {
					var day = rowData[i].BL_BKDAY;
					day = day.substring(0, 4) + "/" + day.substring(4, 6) + "/" + day.substring(6, 8);

					var time = rowData[i].BL_BK_TIME;
					if(time != null && time != "") {
						time = time.substring(0, 2) + ":" + time.substring(2, 4);
					}
					
					var cos = rowData[i].COS_NM;
					var remark = rowData[i].BL_REMARK1;
					var noend = rowData[i].BL_BK_NOEND;
					noend = noend.substring(0, 4) + "/" + noend.substring(4, 6) + "/" + noend.substring(6, 8);
			
					var row = $("<tr></tr>"); 
				    var col1 = $("<td>" + (i + 1) + "</td>"); 
				    var col2 = $("<td>" + day + "</td>"); 
				    var col3 = $("<td>" + time + "</td>");
				    var col4 = $("<td>" + cos + "</td>");
				    var col5 = $("<td>" + remark + "</td>"); 
				    var col6 = $("<td>" + noend + "</td>"); 
				    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody); 
				}
				
				$("#txtTotalCount").html(rowData.length);
 
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
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>위약현황</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/valley/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/valley/member/statePenal.do'/>" class="on">위약현황</a>
			<a href="<c:url value='/valley/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/valley/member/memModify.do'/>" class="">회원정보수정</a>
		</div>


		
		<div class="subTitle">
			<span class="title">위약현황</span>
			<span class="titleDes">고객님의 위약현황을 확인하실 수 있습니다.</span>
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
			<span class="commonDot"> TOTAL: <span class="blue" id="txtTotalCount"></span></span>
		</div>

		<table class="commonTable tableBottom">
			<caption> 실시간예약 현황</caption>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="40%">
				<col width="15%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>예약일자</th>
				<th>예약시간</th>
				<th>코스</th>
				<th>위약내용</th>
				<th>제재기간</th>
			</tr>
			<tbody id="tbody">
			</tbody>
		</table>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />