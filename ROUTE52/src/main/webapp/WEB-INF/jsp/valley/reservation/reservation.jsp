<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<link type='text/css' href="<c:url value='/css/valley/modal.css'/>" rel='stylesheet' media='screen' />
<script type='text/javascript' src="<c:url value='/js/valley/jquery.simplemodal.js'/>"></script>
<script type="text/javascript">
	
	var rowData;
	var rowDataA = new Array();
	var rowDataB = new Array();
	var mDate;
	var mCos;
	var sYear, sMonth, fYear, fMonth;
	var smYear, smMonth, fmYear, fmMonth;
	var miniStDate, miniFnDate;	

	jQuery(function ($) {		
		$('#basic-modal .basic').click(function (e) {
			$('#basic-modal-content').modal();
		});
		
		$('.btnBox .cancel').click(function (e) {
			$.modal.close();
		});

		$("#show_hideSub").click(function () {
	    	$(".SubMonthBox").slideToggle();
	    	$(".SubMonthBox1").slideUp();
	  	});
		
		$("#show_hideSub1").click(function () {
	    	$(".SubMonthBox1").slideToggle();
	    	$(".SubMonthBox").slideUp();
	  	});
	});
	
	$(document).ready(function() { 
		init();
		
		initTable();
		
		initTable2();
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
	
	function initTable2() {
		var $table = $("#time-popup-table");
		var $header = $table.children("thead").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-popup-grid";
			var imgAsc = "<c:url value='/images/valley/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/valley/t_arw1.png'/>";
			
			if(index == 0 || index == 1 || index == 2 || index == 4) {
				var type = index == 4 ? "n" : "s";
				var sLen = $(this)[0].innerText.length;
				var fSize = Number($(this).css("font-size").replace("px", "")) / 2;
				var mid = Number($(this).css("width").replace("px", "")) / 2;
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
		
		var date = new Date(); 
		sYear = smYear = date.yyyy();
		sMonth = smMonth = date.mm();
		var date2 = addMonth(date.yyyymmdd(), 1); 
		fYear = fmYear = date2.yyyy();
		fMonth = fmMonth = date2.mm();
		
		initCalendar("#calendarBox1", sYear, sMonth);
		initCalendar("#calendarBox2", fYear, fMonth);
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		$("#weekdayContainer").hide();
		$("#weekendContainer").hide();
		
		var offset = $("#searchPopupButton").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
		
		var action = "<c:out value='${action}'/>";		
		if(action != "") {
			var type = "<c:out value='${type}'/>";
			if(type == "weekend") {
				onClickWeekendDay("<c:out value='${date}'/>");
			} else {
				onClickDay("<c:out value='${date}'/>");
			}
			onCosTapChange("<c:out value='${cos}'/>");
		}
	}
	
	function onClickRow(i) {		
		popupOpen("I", rowData[i], null);
	}
	
	function doSearch() {			
		if(mDate == null || mDate == '') {
			alert("날짜를 선택하세요.");
			return;
		}
		
		var date = new Date(mDate.substring(0, 4) + "-" + mDate.substring(4, 6) + "-" + mDate.substring(6, 8));
		$("#memDate").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		var sUrl = "<c:url value='/valley/reservation/getTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", mDate);
		
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
				
				var offset = $(".courseTabList").offset();
		        $('html, body').animate({scrollTop : offset.top}, 400);
			}
			
			progressStop();
		});
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
	
	function initCalendar(selector, year, month) {
		var sUrl = "<c:url value='/valley/reservation/getCalendar.do'/>";
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
					
					if(rows[i].CL_BUSINESS != 5) {
						if(rows[i].CL_SOLAR == currentDay) {
							td.addClass('today');
						} else if(rows[i].CL_SOLAR > currentDay) {
							if(rows[i].BK_TEAM > 0 || rows[i].CL_WAIT_START_DAY != null || rows[i].CL_WAIT_START_DAY2 != null) {
								td.data('date', rows[i].CL_SOLAR);
								
								if(rows[i].CL_WAIT_START_DAY != null || rows[i].CL_WAIT_START_DAY2 != null) {
									var regular = "${sessionScope.msMember.msRegular}";
									var current = Number(new Date().yyyymmddhhmm());
									
									if(regular == "Y") {
										if(rows[i].CL_WAIT_START_DAY != "" || rows[i].CL_WAIT_END_DAY != "") {
											var start = Number(rows[i].CL_WAIT_START_DAY);
											var end = Number(rows[i].CL_WAIT_END_DAY);
											
											if(current >= start && current <= end) {
												td.addClass('weekend');
												td.on('click', function() {
													onClickWeekendDay($(this).data('date'));
												});	
											} else if(current > end && rows[i].BK_TEAM > 0) {
												td.addClass('possible');
												td.on('click', function() {
													onClickDay($(this).data('date'));
												});	
											} else {
												if(rows[i].BK_TOTAL == 0) {
													td.addClass('beforeOpen');
												} else {
													td.addClass('deadLine');	
												}
											}
										} else {
											td.addClass('possible');	
										}
									} else {
										if(rows[i].CL_WAIT_START_DAY2 != "" || rows[i].CL_WAIT_END_DAY2 != "") {
											var start2 = Number(rows[i].CL_WAIT_START_DAY2);
											var end2 = Number(rows[i].CL_WAIT_END_DAY2);

											if(current >= start2 && current <= end2) { 
												td.addClass('weekend');
												td.on('click', function() {
													onClickWeekendDay($(this).data('date'));
												});	
											} else if(current > end2 && rows[i].BK_TEAM > 0) {
												td.addClass('possible');
												td.on('click', function() {
													onClickDay($(this).data('date'));
												});	
											} else {
												if(rows[i].BK_TOTAL == 0) {
													td.addClass('beforeOpen');
												} else {
													td.addClass('deadLine');	
												}
											}							
										} else {
											td.addClass('possible');	
										}
									}
								} else {
									if(rows[i].BK_TEAM > 0) {
										td.addClass('possible');
										td.on('click', function() {
											onClickDay($(this).data('date'));
										});	
									} else {
										if(rows[i].BK_TOTAL == 0) {
											td.addClass('beforeOpen');
										} else {
											td.addClass('deadLine');	
										}
									}
								}
							} else {
								if(rows[i].BK_TOTAL == 0) {
									td.addClass('beforeOpen');
								} else {
									td.addClass('deadLine');	
								}						
							}
						} 
					} else {
						td.addClass('holi');
					}
					
					if(rows[i].CL_BUSINESS == 2) {
						td.children('div').addClass('blue');
					} else if(rows[i].CL_BUSINESS == 3 || rows[i].CL_BUSINESS == 4) {
						td.children('div').addClass('red');
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
	
	function initSubCalendar(selector, year, month) {
		var sUrl = "<c:url value='/valley/reservation/getCalendar.do'/>";
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
						td.addClass('possible');
						td.data('date', rows[i].CL_SOLAR);
						if(selector == "#subMonthBox1"){
							td.data("div", "start");
						} else {
							td.data("div", "finish");							
						}
						td.on('click', function() {
							onClickMiniDay($(this).data('div'), $(this).data('date')); 
						});
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
	
	function onClickDay(date) {
		var tomorrow = addDate(new Date().yyyymmdd(), 1).yyyymmdd();
		var hour = Number(new Date().hh());
		
		if(date == tomorrow && hour >= 17) {
			alert("인터넷 예약이 불가능한 날짜입니다.\n예약실로 문의 바랍니다.");
			return;
		}
		
		mDate = date;
		
		$("#weekdayContainer").show();
		$("#weekendContainer").hide();

		doSearch();
	}
	
	function onClickWeekendDay(date) {
		mDate = date;
		
		var date = getDateFormat(date);
		$("#txtSelectedDate").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		$("#weekdayContainer").hide();
		$("#weekendContainer").show();
		
		doSearchWait();
	}
	
	function doSearchWait() {			
		var sUrl = "<c:url value='/valley/reservation/getWeekendTeeList.do'/>"; 
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
				
				var sub = data.subData;
				var partTime = "";
				
				for(i=0; i<sub.length; i++) {
					if(i != 0) {
						partTime += ", ";
					}
					
					var minTime = sub[i].MIN_TIME.substring(0, 2) + ":" + sub[i].MIN_TIME.substring(2, 4);
					var maxTime = sub[i].MAX_TIME.substring(0, 2) + ":" + sub[i].MAX_TIME.substring(2, 4);
					
					partTime += String.format("{0}부 : {1} ~ {2}", sub[i].BK_PART, minTime, maxTime);
				}
				
				$("#txtPartTime").html(partTime);
				
				var offset = $("#weekendContainer").offset();
		        $('html, body').animate({scrollTop : offset.top}, 400);
			}
			
			progressStop();
		});
	}
	
	function onClickMiniDay(div, sDate) {
		var date = getDateFormat(sDate);
		
		if(div == "start") {
			miniStDate = sDate;
			$("#show_hideSub").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox").slideToggle();			
		} else if(div == "finish") {
			miniFnDate = sDate;
			$("#show_hideSub1").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox1").slideToggle();			
		} 		
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
	
	function doPopupSearch() {		
		var sUrl = "<c:url value='/valley/reservation/getSearchTeeList.do'/>";
		var sParams = "";	
		
		if(miniStDate == null || miniStDate == "") {
			alert("조회 시작일을 선택하세요.");
			return;
		}

		if(miniFnDate == null || miniFnDate == "") {
			alert("조회 종료일을 선택하세요.");
			return;
		}

		if(miniStDate > miniFnDate) {
			alert("조회기간을 확인하세요.");
			return;
		}

		var chkCos = $('input[name="poChkSearchCos"]:checked').val();
		var chkWeekday = $("#poSearchDayWeekday").is(":checked");
		var chkWeekend = $("#poSearchDayWeekend").is(":checked");
		
		var stTime, fnTime;
		if($("#poSearchStTime").val() == "") {
			stTime = 0;
		} else {
			stTime = $("#poSearchStTime").val();
		}
		
		if($("#poSearchFnTime").val() == "") {
			fnTime = 2400;
		} else {
			fnTime = $("#poSearchFnTime").val() - 1;
		}

		sParams += String.format("&stDate={0}", miniStDate);
		sParams += String.format("&fnDate={0}", miniFnDate);
		sParams += String.format("&sTime={0}", stTime);
		sParams += String.format("&eTime={0}", fnTime);
		
		if(chkCos != "") {
			sParams += String.format("&cos={0}", chkCos);
		}
		
		if(chkWeekday) {
			sParams += String.format("&weekday={0}", true);
		}
		
		if(chkWeekend) {
			sParams += String.format("&weekend={0}", true);
		}		
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					if(rowData[i].BK_COS == "A") {
						rowDataA[rowDataA.length] = rowData[i];
					}
										
					if(rowData[i].BK_COS == "B") {
						rowDataB[rowDataB.length] = rowData[i];						
					}
				}		
				
				initSearchTable($('input[name="poChkSearchCos"]:checked').val());
			}
			
			progressStop();
		});
	}
	
	function initSearchTable(cos) {
		var data;
		
		if(cos == null || cos == '') {
			$("#poSearchTapALL").addClass("on");
			$("#poSearchTapA").removeClass("on");
			$("#poSearchTapB").removeClass("on");
			data = rowData;
		} else if(cos == 'A') {
			$("#poSearchTapALL").removeClass("on");
			$("#poSearchTapA").addClass("on");
			$("#poSearchTapB").removeClass("on");	
			data = rowDataA;	
		} else if(cos == 'B') {
			$("#poSearchTapALL").removeClass("on");
			$("#poSearchTapA").removeClass("on");
			$("#poSearchTapB").addClass("on");	
			data = rowDataB;		
		}
		
		var tBody = $("#time-popup-grid");	
		
		tBody.empty();
		
		for(i=0; i<data.length; i++) {
			var row = $("<tr onclick='onClickSearchRow(" + i + ")'></tr>"); 

			var bkDay = data[i].BK_DAY;
			bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
			var bkTime = data[i].BK_TIME;
			bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
			var bkCharge;
			if(rowData[i].BK_CHARGE != null && rowData[i].BK_CHARGE != ""){
				bkCharge = rowData[i].BK_CHARGE.split(",")	
			}
			
		    var col1 = $("<td>" + bkDay + "</td>"); 
		    var col2 = $("<td>" + bkTime + "</td>"); 
		    var col3 = $("<td>" + data[i].BK_COS_NM + "</td>");
		    var col4 = $("<td>" + data[i].BK_ROUNDF_NM + "홀</td>");
		    var col5 = $("<td>" + numberWithCommas(bkCharge[1]) + "</td>");
		    
		    row.append(col1,col2,col3,col4,col5).appendTo(tBody); 
		}
	}
	
	function onClickSearchRow(i) {	
		if($("#poSearchTapALL").attr("class") == "on") {
			popupOpen("I", rowData[i], null);
		} else if($("#poSearchTapA").attr("class") == "on") {
			popupOpen("I", rowDataA[i], null);
		} else if($("#poSearchTapB").attr("class") == "on") {
			popupOpen("I", rowDataB[i], null);
		}
	}
	
	function actionWaitReservation() {
		var sUrl = "<c:url value='/valley/reservation/actionWaitReservation.do'/>";
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
		
		sParams += String.format("&lotteryGu={0}", "Y");
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);	
			
			if(data.resultCode == "0000") {		
				location.href = "<c:url value='/valley/reservation/reservationCheck.do'/>";
			}				
		});	
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>예약서비스 &nbsp;&nbsp;&nbsp; ＞ <span>예약신청</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="reserTabList">
			<a href="<c:url value='/valley/reservation/reservation.do'/>" class="on">실시간예약</a>	
			<a href="<c:url value='/valley/reservation/reservationWait.do'/>" class="">대기예약</a>
			<a href="<c:url value='/valley/reservation/reservationGuide.do'/>" class="">예약안내</a>
		</div>

		<!-- The Modal -->
		 <div id='container'>		
			<div id='content'>
				<div id='basic-modal'>

					<input type="button" class="reserEnter basic" id="searchPopupButton" value="" onclick="">
				</div>
				
				<!-- modal content -->
				<div id="basic-modal-content">
						<div class="reserSeachTitle">
							<span>●</span>&nbsp;&nbsp; 예약 검색하기 &nbsp;&nbsp;<span>●</span>
						</div>

					<div class="leftData">
						<!-- <div class="choiceBox">
							<span class="title">예약종류</span>
							<span class="reserSelect">
								<select name="" id="" class="selcetBox">
									<option value="">예약전체</option>
									<option value=""></option>
								</select>
							</span>	
						</div> -->
						<div class="choiceBox">
							<span class="title">일자선택</span>
							<img src="<c:url value='/images/valley/modalcal.png'/>" alt="달력">
							<span>l</span>               
                            <!--미니달력시작-->
							<div class="dayInput" id="show_hideSub"></div>								                
                                <div class="SubMonthBox" id="subMonthBox1">
                                    <div class="monthChoice">
                                    <span><a href="javascript:smPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                                    <span class="month" id="calHeader"></span>
                                    <span><a href="javascript:smNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
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
                                    
                            </div>
                            <!--//미니달력 끝-->
							
							<span>&nbsp; ~ &nbsp;</span>
							<img src="<c:url value='/images/valley/modalcal.png'/>" alt="달력">
							<span>l</span>
							<div class="dayInput" id="show_hideSub1"></div>
                             <!--미니달력시작-->
                            <div class="SubMonthBox1" id="subMonthBox2">
                                <div class="monthChoice">
                                <span><a href="javascript:fmPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                                <span class="month" id="calHeader"></span>
                                <span><a href="javascript:fmNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
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
                        </div>
                        <!--//미니달력 끝-->
						</div>
						<div class="check-list">
							<input type="checkbox" id="poSearchDayWeekday"> 평일&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="poSearchDayWeekend"> 주말/공휴일
						</div>
						<div class="choiceBox">
							<span class="title">코스선택</span>
							<input type="radio" name="poChkSearchCos" value="" checked> 전체&nbsp;&nbsp;&nbsp;
							<input type="radio" name="poChkSearchCos" value="A"> 서원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="poChkSearchCos" value="B"> 밸리
						</div>
						<div class="choiceBox">
							<span class="title">시간대&nbsp;&nbsp;&nbsp;</span>
							<span class="reserTime">
								<select id="poSearchStTime">
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
								<select id="poSearchFnTime">
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
							</span>	
						</div>
						<div class="dotLine"></div>
						<div class="btnBox">
							<input type="button" class="motion" onclick="doPopupSearch()" value="검 색"/>
							<input type="button" class="cancel" onclick="$.modal.close()" value="취 소"  />
						</div>
					</div>

					<!-- right Contents -->
					<div class="rightData">
						<div class="courseTab">
							<a href="javascript:initSearchTable()" id="poSearchTapALL" class="on">전체코스</a>
							<a href="javascript:initSearchTable('A')" id="poSearchTapA" class="">서원코스</a>
							<a href="javascript:initSearchTable('B')" id="poSearchTapB" class="">밸리코스</a>						
						</div>
						<table class="commonTable1" id="time-popup-table">
							<caption>실시간 예약 코스,시간별 가격 안내</caption>
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
							<tr>
								<th>날짜</th>
								<th>시간대</th>
								<th>코스</th>
								<th>홀</th>
								<th>동반자그린피</th>
							</tr>
							</thead>
							<tbody id="time-popup-grid">
							</tbody>
						</table>
						
						<div class="underline"></div>
					</div>
											
					<div style='display:none'>
						<img src="<c:url value='/images/valley/x.png'/>" alt='' />
					</div>
				</div><!-- modal content End-->
			</div>
        <!-- Modal container End -->

		<div class="subTitle">
			<span class="title">예약신청</span>
			<span class="titleDes">실시간 예약을 하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<!-- reserCalBox -->
		<div class="reserCalBox">
			<div class="box" id="calendarBox1">
				  <div class="monthChoice">
					<span><a href="javascript:sPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달"></a></span>
					<span class="month" id="calHeader"></span>
					<span><a href="javascript:sNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달"></a></span>
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

				  <div class="resChoice">
					<img src="<c:url value='/images/valley/dot2_blue.png'/>" alt=""><span> 예약가능</span>
					<%-- <img src="<c:url value='/images/valley/dot2_red.png'/>" alt=""><span> 예약불가능</span> --%>
					<img src="<c:url value='/images/valley/dot2_green.png'/>" alt=""><span> 주말</span>
				  </div>
				</div>
				<!-- Right calendar -->
				<div class="box"  id="calendarBox2">
					  <div class="monthChoice">
						<span><a href="javascript:fPrevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달"></a></span>
						<span class="month" id="calHeader"></span>
						<span><a href="javascript:fNextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달"></a></span>
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

					  <div class="resChoice">
						<img src="<c:url value='/images/valley/dot2_blue.png'/>" alt=""><span> 예약가능</span>
						<%-- <img src="<c:url value='/images/valley/dot2_red.png'/>" alt=""><span> 예약불가능</span> --%>
						<img src="<c:url value='/images/valley/dot2_green.png'/>" alt=""><span> 주말</span>
					  </div>
					</div>
				</div>
			</div><!-- reserCalBox End-->

		<div id="weekdayContainer">
			<div class="midTitleBox" >
				<span class="commonDot"> 예약시간</span>
				<a class="reserGuide" href="<c:url value='/valley/reservation/reservationGuide.do'/>"> <img src="<c:url value='/images/valley/red_arrow.png'/>" alt=""> 예약가이드 자세히보기</a>
			</div>
			<div class="grayCommonBox">
				<ul class="memList">
					<li>● 신청자 : ${sessionScope.msMember.msName}</li>
					<li>● 예약일 : <span id="memDate"></span></li>
				</ul>
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
				<tr>
					<td colspan="6">
						<span class="txt">※ 당일 예약은 전화로만 가능하며 취소팀 발생시 예약 가능합니다. </span>
					</td>
				</tr>
			</table>	
		</div>
		<div id="weekendContainer">
			<div class="midTitleBox">
				<span class="commonDot"> 예약시간</span>
				<a class="reserGuide" href="<c:url value='/valley/reservation/reservationGuide.do'/>"> <img src="<c:url value='/images/valley/red_arrow.png'/>" alt=""> 예약가이드 자세히보기</a>
			</div>
			<table class="waitTable">
				<caption>실시간 예약 코스,시간별 가격 안내</caption>
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<tbody>
					<tr>
						<th>신청자</th>
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
						</select>
						<span class="orangeRed" id="txtPartTime"></span> 
						</td>
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
				<a href="javascript:actionWaitReservation()" class="blueBtn">신 청</a>
			</div>
		</div>		
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/popup/reservationConfirm.jsp" flush="true" />
<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />