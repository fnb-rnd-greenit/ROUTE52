<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<link type='text/css' href='../../css/hills/modal_2.css' rel='stylesheet' media='screen' />
<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	
	var resData, waitData, royalData, teamData;

	$(document).ready(function() { 
		init();

		var offset = $(".myzoneTabList7").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}   
		
		var date = new Date();
		var date2 = addDate(date.yyyymmdd(), 40);
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
		var sUrl = "<c:url value='/hills/reservation/getReservationList.do'/>";
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
					var row = $("<tr><td colspan='11'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>"); 
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
						var charge = resData[i].BK_CHARGE_NM;
						var person = resData[i].BK_PERSON;

						var proDcGu = resData[i].BK_MATCH_DIV;
						var proDcVal = resData[i].BK_MATCH_VALUE;
						
						var royalGu = resData[i].BK_ROYAL_GU;
						var greenAmt = resData[i].BK_ROYAL_GREEN_SUM;
						var cartAmt = resData[i].BK_ROYAL_CART_SUM;
						var foodAmt = resData[i].BK_ROYAL_FOOD_SUM;
						var roundB = resData[i].BK_ROYAL_ROUND_B_SUM;
						var roundA = resData[i].BK_ROYAL_ROUND_A_SUM;
						
						var amtGu = resData[i].BK_ROYAL_AMT_GU == "1" ? "<span class='icon_team'>팀</span>" : "";
						
						var chargeNm = charge;
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
					    	
				    		var advYn = resData[i].BK_MATCH_ADV_YN;
				    		var foodYn = resData[i].BK_MATCH_FOOD_YN;
				    		var sTag = ""			    		
				    		if(advYn == "Y") {
				    			sTag = "조기맞춤";
				    		} else {
				    			sTag = "맞춤";
				    		}
				    		if(foodYn == "Y") {
				    			sTag += "+식사";
				    		}
				    		event = "<span class='event_c'>" + sTag + "</span>";
					    }
						
						if(royalGu != "X") {							
							if(royalGu == "1") {
								event = "<span class='event_r'>로얄타임</span>"; 
					    	} else if(royalGu == "2") {
					    		event = "<span class='event_e'>조기예약</span>";
					    	} else if(royalGu == "3") {
					    		event = "<span class='event_f'>식사제공</span>"; 
					    	}

							chargeNm = Number(greenAmt) + Number(cartAmt) + Number(foodAmt) + Number(roundB) + Number(roundA);
						}
												
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + bkDay + "</td>"); 
					    var col3 = $("<td>" + bkTime + "</td>");					    
					    var col4 = $("<td>" + bkCosNm + "</td>");
					    var col5 = $("<td>" + event + "</td>");
					    var col6 = $("<td class='last'>" + amtGu + numberWithCommas(chargeNm) + "</td>");
					    var col7 = $("<td>" + phone + "</td>");
					    var col8 = $("<td>" + person + "</td>");
					    var col9 = $("<td><a href='javascript:doChangeReservation(" + i + ")' class='blueBtn'>변경</a></td>");
					    if(royalGu == "1") {
					    	col9 = $("<td></td>");
					    }
					    var col10;
					    if("${agencyYn}" == "Y") {
					    	col10 = $("<td></td>");
					    } else {
					    	col10 = $("<td><a href='javascript:doRegistMember(" + i + ")' class='orangeBtn'>등록</a></td>");
					    }
					    var col11 = $("<td><input type='button' class='grayBtn' value='취소' onclick='cehckCancelCount(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11).appendTo(tBodyRes); 
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
					    var col8 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelWaitRes(" + i + ")'></td>");
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyWait); 
					} 	
				}
				
				if(royalData.length == 0) {
					var row = $("<tr><td colspan='8'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyRoyal); 
				} else {
					for(i=0; i<royalData.length; i++) {
						var row = $("<tr></tr>"); 

						var bkDay = royalData[i].BK_DAY;
						bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
						var bkTime = royalData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
						var bkCosNm = royalData[i].BK_COS_NM;
						var phone = royalData[i].BK_FIRST_PHONE + "-" + royalData[i].BK_MID_PHONE + "-" + royalData[i].BK_LAST_PHONE;
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
						
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + bkDay + "</td>");      
					    var col3 = $("<td>" + bkCosNm + "</td>");
					    var col4 = $("<td>" + bkTime + "</td>");
					    var col5 = $("<td>" + phone + "</td>");
					    var col6 = $("<td>" + inputTime + "</td>");
					    var col7 = $("<td>" + bkState + "</td>");
					    var col8 = $("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelRoyal(" + i + ")'></td>");
					    if(royalData[i].DEL_YN != "N" || royalData[i].CONF_YN != "N") {
					    	col8 = $("<td></td>");
					    }
					        
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyRoyal); 
					} 	
				}
				
				if(teamData.length == 0) {
					var row = $("<tr><td colspan='9'><span class='txt'>※ 등록된 예약이 없습니다. </span></td></tr>");
				    row.appendTo(tBodyTeam); 
				} else {
					for(i=0; i<teamData.length; i++) {
						var row = $("<tr></tr>"); 

						var elDay = teamData[i].EL_WDAY;
						elDay = elDay.substring(0, 4) + "/" + elDay.substring(4, 6) + "/" + elDay.substring(6, 8);
						
					    var col1 = $("<td>" + (i + 1) + "</td>"); 
					    var col2 = $("<td>" + elDay + "</td>"); 
					    var col3 = $("<td>" + teamData[i].EL_WTIME + "시대</td>");
					    var col4 = $("<td>" + teamData[i].EL_TEAM_CNT + "팀</td>");
					    var col5 = $("<td>" + teamData[i].INPUT_DATETIME + "</td>");
					    var col6 = $("<td class='orange bold'>" + teamData[i].EL_STATE_NM + "</td>");
					    var col7 = $("<td class='red bold'>" + numberWithCommas(teamData[i].EL_AMOUNT) + "원</td>");
					    var col8 = $(String.format("<td><input type='button' class='orangeBtn' value='결제' onclick='doCancelTeam({0})' style='display:{1}'></td>", i, (teamData[i].EL_STATE == "3" ? "block" : "none")));
					    var col9 = $(String.format("<td><input type='button' class='grayBtn' value='취소' onclick='doCancelTeam({0})' style='display:{1}'></td>", i, (teamData[i].EL_STATE == "1" ? "block" : "none")));
					    
					    row.append(col1,col2,col3,col4,col5,col6,col7,col8,col9).appendTo(tBodyTeam);
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
	        smMonth = "12";
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
	        fmMonth = "12";
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
			var sUrl = "<c:url value='/hills/reservation/delReservation.do'/>";
			var sParams = "";			
			
			sParams += String.format("&bkDay={0}", resData[i].BK_DAY);
			sParams += String.format("&bkTime={0}", resData[i].BK_TIME);
			sParams += String.format("&bkCos={0}", resData[i].BK_COS);
			sParams += String.format("&bkRoyalGu={0}", resData[i].BK_ROYAL_GU);
			
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
	
	var delIdx = -1;
	
	function cehckCancelCount(i) {
		if(resData[i].BK_ROYAL_GU == "1") {
			alert("로얄타임패키지 타임 취소는 전화로만 취소 가능합니다. 예약실로 문의바랍니다.")
			return;
		}
		
		delIdx = i;
		
		var sUrl = "<c:url value='/hills/reservation/cehckCancelCount.do'/>";
		var sParams = String.format("bkDay={0}", resData[i].BK_DAY);
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {					
				doCancelReservation(delIdx);
			} else {
				if(confirm(data.resultMessage)) {		
					doCancelReservation(delIdx);					
				}	
			}	
			
			delIdx = -1;
		});	
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
	
	function doRegistMember(i) {
		var sUrl = "<c:url value='/hills/reservation/reservationRegist.do'/>";
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
		var sUrl = "<c:url value='/hills/reservation/reservationChange.do'/>";
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
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>예약확인</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">	
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="on">예약확인/취소</a>
			<a href="<c:url value='/hills/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/hills/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/hills/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/hills/member/coupon.do'/>" class="">쿠폰함</a>
			<!-- <a href="javascript:alert('준비중입니다.')" class="">마이포인트</a> -->
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/hills/member/memModify.do'/>" class="">회원정보수정</a>
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
							<a href="javascript:smPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:smNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
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
				<img src="<c:url value='/images/hills/resCal_w.png'/>" alt="">
				<span>&nbsp;&nbsp; ~ &nbsp;&nbsp;</span>
				<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub5"></div>								                
                        <div class="SubMonthBox5" id="subMonthBox2">
						  <div class="monthChoice">
							<a href="javascript:fmPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:fmNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
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
				<img src="<c:url value='/images/hills/resCal_w.png'/>" alt="">
				<a href="javascript:doSearch()" class="inquiryBtn">검색</a>
			</div>
		</div>

		<div class="midTitleBox">
			<span class="commonDot"> 실시간예약 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/hills/reservation/reservation.do'/>"><span>▶</span> 예약하기</a>
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
				<col width="*">
				<col width="*">
			</colgroup>			
			<tr>
				<th>번호</th>
				<th>예약일자</th>
				<th>예약시간</th>
				<th>코스</th>
				<th>구분</th>
				<th>최종그린피</th>
				<th>핸드폰</th>
				<th>동반자수</th>
				<th>변경</th>
				<th>동반자등록</th>
				<th>취소</th>
			</tr> 
			<tbody id="tbody-reservation">
			</tbody>
		</table>

		<ul class="userGuideText">
			<li class="orange">· 위약기간에 변경 또는 취소시 패널티가 적용됩니다.</li>
			<li class="orange">· 예약자 변경은 하루전까지 예약자가 유선상으로 요청하셔야지만 가능합니다(당일 예약자 변경 불가)<br><br><br><br><br></li>
		</ul>
			
		
		<%-- <div class="midTitleBox">
			<span class="commonDot"> 주말예약접수 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/hills/reservation/reservation.do'/>"><span>▶</span> 예약하기</a>
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
		</table> --%>
		<div class="midTitleBox">
			<span class="commonDot"> 대기예약접수 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/hills/reservation/reservationWait.do'/>"><span>▶</span> 예약하기</a>
		</div>

		<table class="commonTable tableBottom">
			<caption>대기예약접수 현황 </caption>
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
		
		<div class="midTitleBox">
			<span class="commonDot"> ROYAL타임 접수 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/hills/reservation/reservation.do'/>"><span>▶</span> 예약하기</a>
		</div>

		<table class="commonTable tableBottom">
			<caption>ROYAL타임 접수 현황</caption>
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
				<th>희망코스</th>
				<th>희망시간</th>
				<th>핸드폰</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>취소</th>
			</tr>
			<tbody id="tbody-royal">
			
			</tbody>
		</table>
		
		<div class="midTitleBox">
			<span class="commonDot"> 얼리버드 멤버스(일반단체) 신청 현황</span>
			<a class="bookingBtn miniReser" href="<c:url value='/hills/team/generalRequest.do'/>"><span>▶</span> 예약하기</a>
		</div>
		<p class="stepLevel">※상태 단계 <span>신청</span> ▶ <span>결제대기</span> ▶ <span>결제완료</span> ▶  <span>예약완료</span> / <span>탈락</span><p>
		<p><br><span class="red"> ※기타 문의 사항은 유선 문의 바랍니다.(031-940-9400/ARS. 2번)</span><br><br><br>			
		</p>
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
				<col width="*">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>희망일자</th>
				<th>희망시간</th>
				<th>희망팀수</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>결제금액</th>
				<th>결제</th>
				<th>취소</th>
			</tr>
			<tbody id="tbody-team">
			
			</tbody>
		</table>
		
		<script type='text/javascript' src='<c:url value='/js/hills/jquery.simplemodal.js'/>'></script>
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
						<img src="<c:url value='/images/hills/r_c_img.png'/>" alt="">
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
						<img src='<c:url value='/images/hills/x.png'/>' alt='' />
					</div>
				</div><!-- modal content End-->

			</div>
        <!-- Modal container End -->
		
	</div><!-- contents End -->
</div>
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />