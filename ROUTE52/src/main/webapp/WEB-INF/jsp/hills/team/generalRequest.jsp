<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<jsp:include page="../include/popup/pop_general.jsp" />

<script type="text/javascript">
	
	var mDate;
	var mYear, mMonth;
	var mInterval;
	var mRows;
	var mGpRow;

	$(document).ready(function() {
		init();
		
		var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/hills/member/login.do'/>";	
    		return;
		}
		
		var date = addMonth2(new Date().yyyymmdd(), 2);
		mYear = date.yyyy();
		mMonth = date.mm();
		
		initCalendar();
		
		getTeamInfoByGeneralAffairs();
		
		initOptionSelectBox();
	}
	
	function getTeamInfoByGeneralAffairs() {
		sUrl = "<c:url value='/hills/reservation/getTeamInfoByGeneralAffairs.do'/>";
		sParams = "";
		 
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				mGpRow = data.rows;
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function initOptionSelectBox() {
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "65");
		sParams += String.format("&cdDiv={0}", "123");
		 
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#poSelOption").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#poSelOption").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE4 + "</option>");
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function initCalendar() {
		var sUrl = "<c:url value='/hills/reservation/getGeneralTeamCalendar.do'/>";
		var sParams = "";
		
		sParams += String.format("&selYM={0}", mYear + mMonth);	
		
		mAjax(sUrl, sParams, function(data) {			
			if(data.resultCode == "0000") {
				$("#calendarBox1 #calHeader").html(mYear + " / " + mMonth);
				
				var currentDay = new Date().yyyymmdd();
				var tBody = $("#calendarBox1 #calBody");				
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
						if(rows[i].EL_STATE == '1') {
							td.addClass('possible_w');
							td.data('date', rows[i].CL_SOLAR)
							td.on('click', function() {
								onClickDay($(this).data('date'));
							});
						} else if(rows[i].EL_STATE == '0') {
							td.addClass('beforeOpen');
						} else if(rows[i].EL_STATE == '2') {
							td.addClass('deadLine');	
						} else if(rows[i].EL_STATE == '3') {
							td.addClass('deadLine');	
						}
					} 
					
					row.append(td);
										
					if(rows[i].CL_DAYDIV == 7) {
						row.appendTo(tBody); 
						row = $("<tr></tr>");
					}					
				}			

				row.appendTo(tBody);   
				
				var $openInfo = $("ul.memList > li");
				
				var openSeq = 0;
				
				for(i=0; i<data.subData.length; i++) {
					if(data.subData[i].EL_REMAIN > 0) {
						openSeq = i;
						break;
					}
				}
				
				if(data.subData[openSeq].OPEN_TIME == "X") {
					$openInfo.eq(0).html("");
					$openInfo.eq(1).html("");
				} else {
					var elMonth = data.subData[openSeq].EL_MONTH.substring(4, 6);
					var openDay = getDateFormat(data.subData[openSeq].OPEN_TIME.substring(0, 8));
					var openTime = data.subData[openSeq].OPEN_TIME.substring(8, 12);
					
					$openInfo.eq(0).html(String.format("{0}월 신청 가능 : {1}월 {2}일 {3}요일"
							, Number(elMonth)
							, Number(openDay.mm())
							, Number(openDay.dd())
							, openDay.week()
							/* , Number(openTime.substring(0, 2))
							, (openTime.substring(2, 4) == "00" ? "" : (Number(openTime.substring(2, 4)) + "분")) */
					));
					
					if(addMonth2(new Date().yyyymmdd(), 2).yyyymmdd().substring(0, 6) < data.subData[openSeq].EL_MONTH) {
						$openInfo.eq(0).prepend(Number(addMonth2(new Date().yyyymmdd(), 2).mm()) + "월 신청은 모두 마감 되었습니다.<br>");
					} 
					
				    if(mInterval) clearInterval(mInterval);
				    
				    mInterval = setInterval(function() {
				    	var openDate = new Date(openDay.yyyy(), Number(openDay.mm()) - 1, Number(openDay.dd()), Number(openTime.substring(0, 2)), Number(openTime.substring(2, 4)));
						var current = new Date();
						
						var dateGap = openDate.getTime() - current.getTime();
					    var timeGap = new Date(0, 0, 0, 0, 0, 0, openDate - current); 
					    var diffHour = timeGap.getHours() + (Math.floor(dateGap / (1000 * 60 * 60 * 24)) * 24);
					    var diffMin  = timeGap.getMinutes();
					    var diffSec  = timeGap.getSeconds();
					    
					    $openInfo.eq(1).html(String.format("D-{0}<br>{1}시간 {2}분 {3}초 남음"
					    		, Math.ceil(dateGap / (1000 * 60 * 60 * 24))
					    		, diffHour, diffMin, diffSec));
					    
					    if(openDate.getTime() - current.getTime() < 0) {
					    	clearInterval(mInterval);
					    	
					    	$openInfo.eq(1).hide();
					    }
				    }, 1000);
				}
			} else {
				alert(data.resultMessage);	
			}
		});	
	}
	
	function onClickDay(sDate) {
		mDate = sDate;
		
		doSearch();
	}
	
	function doSearch() {			
		if(mDate == null || mDate == '') {
			alert("날짜를 선택하세요.");
			return;
		}
		
		var sUrl = "<c:url value='/hills/reservation/getGeneralTeamTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", mDate);
		sParams += String.format("&time={0}", $("#selSearchTime").val());
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {				
				var tbody = $("#tbody");
				tbody.empty();
				
				mRows = data.rows;
				
				if(mRows.length == 0) {
					tbody.append("<tr><td colspan='8'><span class='txt'>※ 조회된 예약이 없습니다. </span></td></tr>")
				}
				 
				for(i=0; i<mRows.length; i++) {
					if(mRows[i].EL_REMAIN == 0) continue;
					
					var day = getDateFormat(mRows[i].EL_DAY);
					
					var tr = $("<tr></tr>");
					var td1 = $(String.format("<td>{0}</td>", (tbody.children("tr").length + 1)));
					var td2 = $(String.format("<td>{0}/{1}/{2}</td>", day.yyyy(), day.mm(), day.dd()));
					var td3 = $(String.format("<td>{0}부</td>", mRows[i].EL_PART));
					var td4 = $(String.format("<td>{0}시대</td>", mRows[i].EL_TIME));
					var td5 = $(String.format("<td>{0}홀</td>", mRows[i].EL_HOLE));
					var td6 = $(String.format("<td>팀당{0}인</td>", mRows[i].EL_PERSON));
					var td7 = $(String.format("<td class='blue bold'>{0}</td>", mRows[i].EL_REMAIN));
					var td8 = $(String.format("<td><input type='button' class='orangeBtn' value='신청' onclick='general_popupOpen(1, {0})'></td>", i));
					
					tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7, td8));
				}
			}
			
			progressStop();
		});
	}
	
	function nextMonth() {
		if(mMonth == "12") {
			mYear += 1;
			mMonth = "01";
		} else {
			mMonth = Number(mMonth) + 1;
			mMonth = (mMonth>9 ? '' : '0') + mMonth;
		}
		
		initCalendar();
	}
	
	function prevMonth() {
		if(mMonth == "01") {
			mYear -= 1;
			mMonth = "12";
		} else {
			mMonth = Number(mMonth) - 1;
			mMonth = (mMonth>9 ? '' : '0') + mMonth;
		}
		
		initCalendar();		
	}
	
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>일반단체</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="">연단체신청</a>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="on">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
		</div>
		
		<div class="subTitle">
			<span class="title">일반단체신청</span><span style="font-size:12px; color:#bebebe;"> 단체 예약을 하실수 있습니다</span>
		</div>
		<div class="subLine"></div>
		<div class="generalGuideBox">
			<strong>※ 얼리버드 멤버스 전용 월별 예약 신청 접수 페이지 입니다.</strong>
			<!-- reserCalBox -->
			<div class="reserCalBox">
				<div class="box-left" style="margin-top:20px;">
					<div class="waitCalBox">
						<div id="calendarBox1">
						  <div class="monthChoice">
							<span><a href="javascript:prevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달"></a></span>
							<span class="month" id="calHeader"></span>
							<span><a href="javascript:nextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달"></a></span>
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
							<tbody id="calBody">	 
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
						  </div>
					</div>
					<!-- <div class="btnBox">
						<a href="javascript:actionWaitReservation()" class="orangeBtn">신 청</a>
					</div>	 -->
				</div>
				<!-- box-left End -->
				<!-- box-Right -->
				<div class="box-right-wait">
					<div class="grayCommonBox">
						<ul class="memList">
							<li></li>
							<li></li>
						</ul>
					</div>
					<ul class="reserExTxt">
						<li>
						&bull; 월별 신청은 얼리버드 멤버스 전용 계정으로만 신청 가능합니다.<br>
&bull; 예약은 추첨을 통해 예약 진행됩니다.<br>
<span class="red bold">&bull; 매월 실적 (이용금액, 에티켓 등) 50% 상위 단체에게는 5~12월 단체 예약 신청 시<br>우선순위 혜택 적용됩니다.<br> 
&bull; 연간 실적 (이용금액, 에티켓 등) 상위 단체에게는 차년도 연단체 모집 신청 시 우선순위<br>혜택 적용됩니다.<br></span>
&bull; 특정 코스 지정은 불가합니다.<br>
&bull; 1팀 4인 필수 팀요금 적용됩니다.<br>
&bull; 골프장 내 다수의 사람들에게 노출될 수 있는 유튜브 등의 모든 촬영을 제제하고<br>있으며, 사전 협의가 되지 않은 촬영 시 퇴장조치 될 수 있습니다.
						</li>
					</ul>
					<!-- <p class="rightTxt">
						대기 예약은 위약기간(라운딩 3일전 17시 이후 ~ 라운딩 하루전)에 해당되는 취소건에 대해 선착순으로 배정합니다.
					</p> -->
				</div>
			</div>
			<!-- Box-Right -->
		</div>
		
		<div class="generalGuideBox">
			<div class="selectBox">
				<select name="" id="selSearchTime" class="select-arrow" onchange="doSearch()">
					<option value=''>전체</option>
					<option value='05'>5시</option>
					<option value='06'>6시</option>
					<option value='07'>7시</option>
					<option value='08'>8시</option>
					<option value='09'>9시</option>
					<option value='10'>10시</option>
					<option value='11'>11시</option>
					<option value='12'>12시</option>
					<option value='13'>13시</option>
					<option value='14'>14시</option>
					<option value='15'>15시</option>
					<option value='16'>16시</option>
					<option value='17'>17시</option>
					<option value='18'>18시</option>
				</select>
			</div>
			<span class="timeHits">시간대조회</span>
			
			<table class="commonTable" summary="실시간 예약" cellspacing="5">
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
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>예약일</th>
						<th>부</th>
						<th>시간대</th>
						<th>홀</th>
						<th>인원</th>
						<th>신청가능 잔여팀</th>
						<th>신청하기</th>					
					</tr>
				</thead>
				<tbody id="tbody">
					<tr><td colspan='8'><span class='txt'>※ 조회된 예약이 없습니다. </span></td></tr>
				</tbody>
			</table>
		</div>
		
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />