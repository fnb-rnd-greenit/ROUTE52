<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_reser_cancel.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">
<script type="text/javascript"> 
	var resData, waitData, royalData, teamData;

	$(document).ready(function() { 
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_hills/member/login.do'/>";	
		} 
		
		doSearch(); 
	});
	 
	function doSearch() {
		var sUrl = "<c:url value='/hills/reservation/getReservationList.do'/>";
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
				var tBodyRoyal = $("#tbody-royal");
				var tBodyTeam = $("#tbody-team");
				
				tBodyRes.empty();
				tBodyWait.empty();
				tBodyRoyal.empty();
				tBodyTeam.empty();
				
				resData = data.rows.resData;
				waitData = data.rows.waitData;
				royalData = data.rows.royalData;
				teamData = data.rows.teamData;
				
				if(resData.length == 0) {
					var row = $("<tr><td colspan='8'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
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
						var bkCharge = resData[i].BK_CHARGE_NM;						
						var person = resData[i].BK_PERSON;
						
						var proDcGu = resData[i].BK_MATCH_DIV;
						var proDcVal = resData[i].BK_MATCH_VALUE;	
						
						var royalGu = resData[i].BK_ROYAL_GU;
						var greenAmt = resData[i].BK_ROYAL_GREEN_SUM;
						var cartAmt = resData[i].BK_ROYAL_CART_SUM;
						var foodAmt = resData[i].BK_ROYAL_FOOD_SUM;
						var roundA = resData[i].BK_ROYAL_ROUND_A_SUM;
						var roundB = resData[i].BK_ROYAL_ROUND_B_SUM;
						
						var chargeNm = bkCharge;
						
						var event = "";

						if(proDcGu != "X") {
							var basicCharge = resData[i].BK_BASIC_CHARGE.split(",")[1];  
						    
					    	if(proDcGu == "1") {					    	
					    		chargeNm = Number(proDcVal) / 4;
						    } else if(proDcGu == "2") {	
						    	chargeNm = Number(basicCharge) - (Number(basicCharge) * Number(proDcVal) / 100);					    	
						    } else if(proDcGu == "3") {
						    	chargeNm = Number(basicCharge) - Number(proDcVal);
						    } 
					    	
					    	event = "<span class='event_sc'>맞춤</span>";
					    	
					    	var advYn = resData[i].BK_MATCH_ADV_YN;
				    		var foodYn = resData[i].BK_MATCH_FOOD_YN;
				    		
				    		var sTag = "맞춤";			    		
				    		if(foodYn == "Y") {
				    			sTag += "<br>+<br>식사";
				    		}
				    		event = "<span class='event_sc'>" + sTag + "</span>";
					    }
						
						if(royalGu != "X") {							
							if(royalGu == "1") {
								event = "<span class='event_sr'>로얄</span>"; 
					    	} else if(royalGu == "2") {
					    		event = "<span class='event_se'>조기</span>";
					    	} else if(royalGu == "3") {
					    		event = "<span class='event_sf'>식사</span>"; 
					    	}

							chargeNm = Number(greenAmt) + Number(cartAmt) + Number(foodAmt) + Number(roundB) + Number(roundA);
						}
						
						var amtGu = resData[i].BK_ROYAL_AMT_GU == "1" ? "<span class='icon_team'>팀</span>" : "";
						
					    var col1 = $("<td>" + bkDay + "</td>"); 
					    var col2 = $("<td>" + bkTime + "</td>");
					    var col3 = $("<td>" + bkCosNm + "</td>");  
					    var col4 = $("<td>" + event + "</td>");
					    var col5 = $("<td class='last'>" + amtGu + numberWithCommas(chargeNm) + "</td>");
					    var col6 = $("<td><a href='javascript:doChangeReservation(" + i + ")' class='orangeBtn'>변경</a></td>");
					    var col7;
					    if("${agencyYn}" == "Y") {
					    	col7 = $("<td></td>");
					    } else {
					    	col7 = $("<td><a href='javascript:doRegistMember(" + i + ")' class='blueBtn'>등록</a></td>");
					    }
					    var col8 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelPopupOpen(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyRes); 
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
						var phone = waitData[i].BK_FIRST_WPHONE + "-" + waitData[i].BK_MID_WPHONE + "-" + waitData[i].BK_LAST_WPHONE;
						var inputTime = waitData[i].INPUT_TIME;
						var bkState = waitData[i].BK_DEL_DIV == "N" ? "미배정" : waitData[i].BK_TIME == "X" ? "배정전" : "배정";
						
					    var col1 = $("<td>" + bkDay + "</td>"); 
					    var col2 = $("<td>" + bkTime1 + "</td>");
					    var col3 = $("<td>" + bkTime2 + "</td>");
					    var col4 = $("<td>" + inputTime + "</td>");
					    var col5 = $("<td>" + bkState + "</td>");
					    var col6 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBodyWait); 
					} 	
				}
				
				if(royalData.length == 0) {
					var row = $("<tr><td colspan='6'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyRoyal); 
				} else {
					for(i=0; i<royalData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = royalData[i].BK_DAY;
						bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime = royalData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
						var bkCosNm = royalData[i].BK_COS_NM;
						var inputTime = royalData[i].INPUT_DATETIME;
						var bkState = "대기";
 						
						if(royalData[i].CONF_YN == "Y") {
							bkState = "확정";
						}
						if(royalData[i].DEL_YN == "Y") {
							bkState = "취소";
						}
						if(royalData[i].CONF_YN == "C") {
							bkState = "확정후취소";
						}
						if(royalData[i].CONF_YN == "D") {
							bkState = "미입금취소";
						}
						
					    var col1 = $("<td>" + bkDay + "</td>");      
					    var col2 = $("<td>" + bkCosNm + "</td>");
					    var col3 = $("<td>" + bkTime + "</td>");
					    var col4 = $("<td>" + inputTime + "</td>");
					    var col5 = $("<td>" + bkState + "</td>");
					    var col6 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelRoyal(" + i + ")'></td>");
					    if(royalData[i].DEL_YN != "N" || royalData[i].CONF_YN != "N") {
					    	col6 = $("<td></td>");
					    }
					    
					    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBodyRoyal); 
					} 	
				}
				
				if(teamData.length == 0) {
					var row = $("<tr><td colspan='8'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyTeam); 
				} else {
					for(i=0; i<teamData.length; i++) {
						var row = $("<tr></tr>"); 

						var elDay = teamData[i].EL_WDAY;
						elDay = elDay.substring(2, 4) + "/" + elDay.substring(4, 6) + "/" + elDay.substring(6, 8);
						
					    var col1 = $("<td>" + elDay + "</td>"); 
					    var col2 = $("<td>" + teamData[i].EL_WTIME + "시대</td>");
					    var col3 = $("<td>" + teamData[i].EL_TEAM_CNT + "팀</td>");
					    var col4 = $("<td>" + teamData[i].INPUT_DATETIME.substring(2, 10) + "</td>");
					    var col5 = $("<td class='orange bold'>" + teamData[i].EL_STATE_NM + "</td>");
					    var col6 = $("<td class='red bold'>" + numberWithCommas(teamData[i].EL_AMOUNT) + "원</td>");
					    var col7 = $(String.format("<td><input type='button' class='orangeBtn' value='결제' onclick='doCancelTeam({0})' style='display:{1}'></td>", i, (teamData[i].EL_STATE == "3" ? "block" : "none")));
					    var col8 = $(String.format("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelTeam({0})' style='display:{1}'></td>", i, (teamData[i].EL_STATE == "1" ? "block" : "none")));
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyTeam);
					    
					    /*
					    
					<tr>
						<td>21/04/01</td>					
						<td>08시대</td>
						<td>5팀</td>
						<td>21/02/15</td>
						<td class="orange">결제대기</td>
						<td class="red">0원</td>
						<td><a href='' class='orangeBtn'>결제</a></td>
						<td><a href='' class='grayBtn'>취소</a></td>
					</tr>
					*/
					} 	
				}
			} else {
				alert(data.resultMessage);
			}
			
			progressStop();
		});
	}
	
	function doCancelTeam(i) {
		var data = teamData;
		
		if(data[i].EL_STATE != "1") {
			alert("취소할 수 없는 예약입니다.");     
			return;
		}
		
		var elDay = getDateFormat(data[i].EL_WDAY);
		var elTime = data[i].EL_WTIME;
		
		var message = String.format("희망일자 : {0}-{1}-{2}\r\n희망시간 : {3}\r\n예약을 취소하시겠습니까?", elDay.yyyy(), elDay.mm(), elDay.dd(), elTime);
		
		if(confirm(message)) {
			var sUrl = "<c:url value='/hills/reservation/delWaitTeam.do'/>";
			var sParams = "";			
			
			sParams += String.format("&elDay={0}", data[i].EL_WDAY);
			sParams += String.format("&elTime={0}", data[i].EL_WTIME);
			sParams += String.format("&elWno={0}", data[i].EL_WNO);
			
			progressStart();
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				alert(data.resultMessage);
				
				doSearch();
			});
		}
	}
	
	function doCancelPopupOpen(i) {
		if(resData[i].BK_ROYAL_GU == "1") {
			alert("로얄타임패키지 타임 취소는 전화로만 취소 가능합니다. 예약실로 문의바랍니다.")
			return;
		}
		
		cancelPopupOpen(resData[i]);
	}
	
	function doCancelWaitRes(i) {
		var data = waitData;
		
		var bkDay = data[i].BK_WDAY;
		bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
		var bkTime1 = data[i].BK_WTIME;
		bkTime1 = bkTime1.substring(0, 2) + ":" + bkTime1.substring(2, 4);
		var bkTime2 = data[i].BK_WTIME2;
		if(bkTime2 != null && bkTime2 != ""){
			bkTime2 = bkTime2.substring(0, 2) + ":" + bkTime2.substring(2, 4);
		} else {
			bkTime2 = "";
		}
		
		var message = String.format("희망일자 : {0}\r\n희망시간1 : {1}\r\n희망시간2 : {2}\r\n예약을 취소하시겠습니까?", bkDay, bkTime1, bkTime2);
		
		if(confirm(message)) {
			var sUrl = "<c:url value='/hills/reservation/delWaitReservation.do'/>";
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
	
	function doCancelRoyal(i) {
		var data = royalData;
		
		if(data[i].CONF_YN == "Y") {
			alert("배정된 예약입니다.");     
			return;
		}
		
		var bkDay = getDateFormat(data[i].BK_DAY);
		var bkTime = data[i].BK_TIME;
		bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
		var bkCos = data[i].BK_COS_NM;
		
		var message = String.format("희망일자 : {0}-{1}-{2}\r\n희망코스 : {3}\r\n희망시간 : {4}\r\n예약을 취소하시겠습니까?", bkDay.yyyy(), bkDay.mm(), bkDay.dd(), bkCos, bkTime);
		
		if(confirm(message)) {
			var sUrl = "<c:url value='/hills/reservation/delRoyalReservation.do'/>";
			var sParams = "";			
			
			sParams += String.format("&bkDay={0}", data[i].BK_DAY);
			sParams += String.format("&bkTime={0}", data[i].BK_TIME);
			sParams += String.format("&bkCos={0}", data[i].BK_COS);
			sParams += String.format("&rSeq={0}", data[i].R_SEQ);
			
			progressStart();
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				alert(data.resultMessage);
				
				doSearch();
			});
		}
	}
	
	function doRegistMember(i) {
		var sUrl = "<c:url value='/m_hills/reservation/reservationRegist.do'/>";
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
		var sUrl = "<c:url value='/m_hills/reservation/reservationChange.do'/>";
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
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> MY ZONE <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList">			
		<!-- <li class=""><a href="javascript:alert('준비중입니다')">추천예약</a></li> -->
		<li class="on"><a href="<c:url value='/m_hills/reservation/reservationCheck.do'/>">예약현황</a></li>
		<li class=""><a href="<c:url value='/m_hills/member/coupon.do'/>">쿠폰함</a></li>
		<li class=""><a href="<c:url value='/m_hills/member/score.do'/>">스코어카드</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">MY연단체</a></li>
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
					<th>구분</th>
					<th>최종그린피</th>
					<th>예약변경</th>
					<th>동반자등록</th>
					<th>취소</th>
				</tr>
				<tbody id="tbody-reservation">
				</tbody>
			</table>
			<div class="commonDot"> 대기예약접수 현황</div>
			<table class="commonTable bgBottom">
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
			
			<div class="commonDot"> ROYAL타임 접수 현황</div>
			<table class="commonTable bgBottom">
				<caption>로얄타임현황</caption>
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
					<th>희망코스</th>
					<th>희망시간</th>
					<th>신청일자</th>
					<th>상태</th>
					<th>취소</th>
				</tr>
				<tbody id="tbody-royal">
				</tbody>    
			</table>
			
			<div class="commonDot"> 얼리버드 멤버스(일반단체)신청 현황</div>
			<p class="stepLevel">※상태 단계 <span>신청</span> ▶ <span>결제대기</span> ▶ <span>결제완료</span> ▶  <span>예약완료</span> / <span>탈락</span><p>
			<p class="stepLevel red"> ※기타 문의 사항은 유선 문의 바랍니다.(031-940-9400/ARS. 2번)</p>
			<table class="commonTable">
				<caption>얼리버드 멤버스(일반단체) 신청 현황 </caption>
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
						<th>희망일자</th>
						<th>희망시간</th>
						<th>희망팀수</th>
						<th>신청일자</th>
						<th>상태</th>
						<th>결제금액</th>
						<th>결제</th>
						<th>취소</th>
					</tr>
				</thead>
				<tbody id="tbody-team">
				</tbody>    
			</table>
		</div>		
	</div><!-- contents End -->	 
    
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>