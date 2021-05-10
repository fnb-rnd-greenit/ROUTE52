<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/fix_pop.css'/>" rel='stylesheet' />
<link type='text/css' href="<c:url value='/css/hills/jquery.range.css'/>" rel='stylesheet' />
<script type='text/javascript' src="<c:url value='/js/hills/jquery.range.js'/>"></script>  
<script type="text/javascript">

	var poTab2Data;
	var poTab1Data;
	var poTab2DataA = new Array();
	var poTab2DataB = new Array();
	var poTab2DataC = new Array();
	var poSmYear, poSmMonth, poFnYear, poFnMonth;
	var poMiniStDate, poMiniFnDate;		
	var poTab1StDate, poTab1EdDate;
	var poTab1DefaultTime, poTab1DefaultCos;

	function reservePopupOpen(idx) {
		initReserve();
	    
	    initRealtimeReserve(poTab1DefaultCos);
		
	    initReservePopup();
	    
	    fixPopTab(idx);
	}
	
	function initReserve() {		
		var date = new Date();
		poSmYear = date.yyyy();
		poSmMonth = date.mm();
		var date2 = addDate(date.yyyymmdd(), 7); 
		poFnYear = date2.yyyy();
		poFnMonth = date2.mm();
		poTab1StDate = date;
		poTab1StDate = addDate(poTab1StDate.yyyymmdd(), 1);
		poTab1EdDate = addDate(poTab1StDate.yyyymmdd(), 6);
		
		poMiniStDate = date.yyyymmdd();
		poMiniFnDate = date2.yyyymmdd();

		$("#show_hideSub").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub1").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));

		poInitSubCalendar("#poSubMonthBox1", poSmYear, poSmMonth);
		poInitSubCalendar("#poSubMonthBox2", poFnYear, poFnMonth);
		
		poTab1DefaultCos = "A";
		
		var curMonth = Number(date.mm());
		
		if(curMonth == 3 || curMonth == 4 || curMonth == 11) {
			$("#t5").hide();
			$("#t9").hide();
			$("#t10").hide();
			$("#t14").hide();
			$("#t15").hide();
		} else if (curMonth >= 5 && curMonth <= 10) {
			$("#t8").hide();
			$("#t9").hide();
			$("#t13").hide();
			$("#t14").hide();
			$("#t15").hide();			
		}
	}
	
	function initReservePopup() {
	    var fW = $(window).width() / 2;
	    var fH = $(window).height() / 2;
	    var cW = Number($("#quick-reserve-popup").css("width").replace("px", "")) / 2;
	    var cH = Number($("#quick-reserve-popup").css("height").replace("px", "")) / 2;
	    var mW = fW - cW;
	    var mH = fH - cH;
	
	    $("#quick-reserve-popup").css("left", mW);
	    $("#quick-reserve-popup").css("top", mH);
	
	    $("#quick-reserve-popup").css("display", "block");
	    $("#quick-overlay").css("display", "block");
		
		$('.slider-input').jRange({
		    from: 60000,
		    to: 220000,
		    step: 10000,
		    scale: [], 
		    format: '%s',
		    width: 350,
		    showLabels: true,
		    isRange : true
		});
		
		$('.slider-input').jRange('setValue', '60000, 220000');
		
		$("#show_hideSub").unbind("click").bind("click", function () {
			$(".SubMonthBox1").slideUp();
			$(".SubMonthBox").slideToggle();
		});
		
		$("#show_hideSub1").unbind("click").bind("click", function () {
			$(".SubMonthBox").slideUp();
			$(".SubMonthBox1").slideToggle();
		});
		
		initTable2();
	}
	
	function initTable2() {
		var $table = $("#time-popup-table");
		var $header = $table.children("thead").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-popup-grid";
			var imgAsc = "<c:url value='/images/hills/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/hills/t_arw1.png'/>";
			
			if(index == 0 || index == 1 || index == 2 || index == 5) {
				var type = index == 5 ? "n" : "s";
				var sLen = $(this)[0].innerText.length;
				var fSize = Number($(this).css("font-size").replace("px", "")) / 2;
				var mid = Number($(this).css("width").replace("px", "")) / 2;
				var left = mid + (sLen * fSize);
				
				$(this).css("background-image", "url(" + imgAsc + "), url(" + imgDesc + ")");
				$(this).css("background-position", String.format("{0}px 50%, {1}px 50%", left + 5, left + 15));
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
	
	function initRealtimeReserve(cos, time) {		
		$("#poRealHeaderText").html(String.format("{0}/{1}({2}) ~ <span>{3}/{4}({5})</span>", poTab1StDate.mm(), poTab1StDate.dd(), poTab1StDate.week(), poTab1EdDate.mm(), poTab1EdDate.dd(), poTab1EdDate.week()));
		
		var sUrl = "<c:url value='/hills/reservation/getRealTimeTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&stDate={0}", poTab1StDate.yyyymmdd());
		sParams += String.format("&fnDate={0}", poTab1EdDate.yyyymmdd());
		
		sParams += String.format("&cos={0}", cos);
		
		if(time == null) {
			sParams += String.format("&sTime={0}", 0);
			sParams += String.format("&eTime={0}", 2399);
		} else {
			sParams += String.format("&sTime={0}", time);
			sParams += String.format("&eTime={0}", Number(time) + 99);
		}
		
		progressStart3("<c:url value='/images/sprites.png'/>");
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {				
				var tBodyHeader = $("#tbody-header");	
				tBodyHeader.empty();

				var row = $("<tr></tr>"); 
				var col1 = $("<td>시간</td>"); 
				var col2 = $("<td>" + String.format("{0}({1})", poTab1StDate.dd(), poTab1StDate.week()) + "</td>"); 	
				var col3 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 1).dd(), addDate(poTab1StDate.yyyymmdd(), 1).week()) + "</td>"); 	
				var col4 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 2).dd(), addDate(poTab1StDate.yyyymmdd(), 2).week()) + "</td>"); 	
				var	col5 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 3).dd(), addDate(poTab1StDate.yyyymmdd(), 3).week()) + "</td>");
				var col6 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 4).dd(), addDate(poTab1StDate.yyyymmdd(), 4).week()) + "</td>"); 	
				var col7 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 5).dd(), addDate(poTab1StDate.yyyymmdd(), 5).week()) + "</td>"); 	
				var col8 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate.yyyymmdd(), 6).dd(), addDate(poTab1StDate.yyyymmdd(), 6).week()) + "</td>"); 			    
				
				switch(poTab1StDate.weeknum()) {
				case 0:
					col8.addClass("sat");
					col2.addClass("sun");
					break;
				case 1: 
					col7.addClass("sat");
					col8.addClass("sun");
					break;
				case 2:
					col6.addClass("sat");
					col7.addClass("sun");
					break;
				case 3: 
					col5.addClass("sat");
					col6.addClass("sun");
					break;
				case 4:
					col4.addClass("sat");
					col5.addClass("sun");
					break;
				case 5:
					col3.addClass("sat");
					col4.addClass("sun");
					break;
				case 6:
					col2.addClass("sat");
					col3.addClass("sun");
					break;
				}				
				
			    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBodyHeader);

				var tBody = $("#tbody-realtime");	
				tBody.empty();
				
				var header = data.rows.header;
				
				if(header == null || header.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<header.length; i++) {
					var row = $("<tr></tr>"); 					

					var time = header[i].BK_TIME;
					
					var col1 = $("<td>" + time.substring(0, 2) + ":" + time.substring(2, 4) + "</td>");
					var col2 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY1 + "'></td>");
					var col3 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY2 + "'></td>");
					var col4 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY3 + "'></td>");
					var col5 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY4 + "'></td>");
					var col6 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY5 + "'></td>");
					var col7 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY6 + "'></td>");
					var col8 = $("<td id='td-" + header[i].BK_TIME + header[i].DAY7 + "'></td>");
					
					row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBody);
				}
				
				poTab1Data = data.rows.data;
				
				if(poTab1Data == null || poTab1Data.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<poTab1Data.length; i++){
					var id = "#td-" + poTab1Data[i].BK_TIME + poTab1Data[i].BK_DAY;
					var charge = poTab1Data[i].BK_CHARGE.split(",")[1];
					var proDcGu = poTab1Data[i].PRO_DC_GU;
					var proDcVal = poTab1Data[i].PRO_DC_VALUE;
					var bkChargeNm = charge;
					var defaultCharge = "X";
					
					var name = poTab1Data[i].BK_NAME;
					var msNum = poTab1Data[i].BK_MSNUM;
					var bkYn = poTab1Data[i].BK_YN;		
					
					if(name != "" || msNum != "" || bkYn != "N") {
						continue;
					}
					
					var tag = "";
					
					if(poTab1Data[i].BK_CHARGE.split(",")[2] == "M") {
						tag = "<span class='event_s'>특가</span> ";
				    } else if(poTab1Data[i].BK_CHARGE.split(",")[2] == "S") {
				    	if(poTab1Data[i].MN_COST_YN != "Y") {
				    		tag = "<span class='event_s'>특가</span> ";
				    	}
				    } else if(poTab1Data[i].BK_CHARGE.split(",")[2] == "R") {
				    	tag = "<span class='event_s'>특가</span> ";
				    }
					
				    var rGu = poTab1Data[i].R_GU;
					if(rGu != "X") {
				    	if(rGu == "1") {
				    		tag = "<span class='event_r'>로얄</span> ";
				    	} else if(rGu == "2") {
				    		tag = "<span class='event_e'>조기</span> ";
				    	} else if(rGu == "3") {
				    		tag = "<span class='event_f'>식사</span> ";
				    	}	
				    	
				    	bkChargeNm = Number(poTab1Data[i].R_GREEN_AMT) + Number(poTab1Data[i].R_CART_AMT) + Number(poTab1Data[i].R_FOOD_AMT) + Number(poTab1Data[i].R_ROUND_B_AMT) + Number(poTab1Data[i].R_ROUND_A_AMT);
				    }
					
					if(proDcGu != "X") {
				    	var basicCharge = poTab1Data[i].BK_BASIC_CHARGE;
				    	var defaultCharge = bkChargeNm;
					    
				    	if(proDcGu == "1") {					    	
						    bkChargeNm = Number(proDcVal) / 4;
					    } else if(proDcGu == "2") {	
						    bkChargeNm = Number(basicCharge) - (Number(basicCharge) * Number(proDcVal) / 100);					    	
					    } else if(proDcGu == "3") {
					    	bkChargeNm = Number(basicCharge) - Number(proDcVal);
					    } 
				    	
			    		var advYn = poTab1Data[i].PRO_ADV_YN;
			    		var foodYn = poTab1Data[i].PRO_FOOD_YN;
			    		var sTag = ""			    		
			    		if(advYn == "Y") {
			    			sTag = "조기맞춤";
			    		} else {
			    			sTag = "맞춤";
			    		}
			    		if(foodYn == "Y") {
			    			sTag += "+식사";
			    		}
			    		tag = "<span class='event_c'>" + sTag + "</span>";
			    		if(sTag.length >= 4) tag += "<br>";
				    }
					
					if(rGu == "X" && defaultCharge != "X" && Number(bkChargeNm) > Number(defaultCharge)) {
						bkChargeNm = defaultCharge;
						tag = "";
			    	}
					
					var amtGu = poTab1Data[i].R_AMT_GU == "1" && rGu == "1" ? "<span class='icon_team'>팀</span>" : "";
					
					$(id).html(tag + amtGu + numberWithCommas(bkChargeNm));
					
					if(name != "" || msNum != "" || bkYn != "N") {
						$(id).css("color", "#dedede");
					} else {
						$(id).data("idx", i);
						$(id).css("cursor", "pointer");
						$(id).on("click", function() {
							onRealTimeClicked($(this).data("idx"));
						});
					}
					
					var weekNum = getDateFormat(poTab1Data[i].BK_DAY).weeknum();
					if(weekNum == 0) {
						$(id).addClass("sun");											
					} else if(weekNum == 6) {
						$(id).addClass("sat");
					}
				}
			}
			
			progressStop();
		});
	}
	
	function onRealTimeClicked(i) {
		// 로얄 타임이면 로얄 예약 확인창 오픈 
		// 그 외 일반 예약 확인창 오픈
		if(poTab1Data[i].R_GU == "1") {
			royalPopupOpen(poTab1Data[i]);	
		} else {
			popupOpen("I", poTab1Data[i], null);	
		}
	}
	
	function poInitSubCalendar(selector, year, month) {
		var sUrl = "<c:url value='/hills/reservation/getCalendar.do'/>";
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
						if(selector == "#poSubMonthBox1"){
							td.data("div", "start");
						} else {
							td.data("div", "finish");							
						}
						td.on('click', function() {
							poOnClickMiniDay($(this).data('div'), $(this).data('date')); 
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
	
	function poOnClickMiniDay(div, sDate) {
		var date = getDateFormat(sDate);
		
		if(div == "start") {
			poMiniStDate = sDate;
			$("#show_hideSub").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox").slideToggle();			
		} else if(div == "finish") {
			poMiniFnDate = sDate;
			$("#show_hideSub1").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox1").slideToggle();			
		} 		
	}
	
	function poSmNextMonth() {
	    if(poSmMonth == "12") {
	        poSmYear += 1;
	        poSmMonth = "01";
	    } else {
	        poSmMonth = Number(poSmMonth) + 1;
	        poSmMonth = (poSmMonth>9 ? '' : '0') + poSmMonth;
	    }

	    poInitSubCalendar("#poSubMonthBox1", poSmYear, poSmMonth);
	}

	function poSmPrevMonth() {
	    if(poSmMonth == "01") {
	        poSmYear -= 1;
	        poSmMonth = "11";
	    } else {
	        poSmMonth = Number(poSmMonth) - 1;
	        poSmMonth = (poSmMonth>9 ? '' : '0') + poSmMonth;
	    }

	    poInitSubCalendar("#poSubMonthBox1", poSmYear, poSmMonth);		
	}

	function poFmNextMonth() {
	    if(poFnMonth == "12") {
	        poFnYear += 1;
	        poFnMonth = "01";
	    } else {
	        poFnMonth = Number(poFnMonth) + 1;
	        poFnMonth = (poFnMonth>9 ? '' : '0') + poFnMonth;
	    }

	    poInitSubCalendar("#poSubMonthBox2", poFnYear, poFnMonth);
	}

	function poFmPrevMonth() {
	    if(poFnMonth == "01") {
	        poFnYear -= 1;
	        poFnMonth = "11";
	    } else {
	        poFnMonth = Number(poFnMonth) - 1;
	        poFnMonth = (poFnMonth>9 ? '' : '0') + poFnMonth;
	    }

	    poInitSubCalendar("#poSubMonthBox2", poFnYear, poFnMonth);
	}
	
	function doPopupSearch() {		
		var sUrl = "<c:url value='/hills/reservation/getSearchTeeList.do'/>";
		var sParams = "";	
		
		if(poMiniStDate == null || poMiniStDate == "") {
			alert("조회 시작일을 선택하세요.");
			return;
		}

		if(poMiniFnDate == null || poMiniFnDate == "") {
			alert("조회 종료일을 선택하세요.");
			return;
		}

		if(poMiniStDate > poMiniFnDate) {
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

		sParams += String.format("&stDate={0}", poMiniStDate);
		sParams += String.format("&fnDate={0}", poMiniFnDate);
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
		
		progressStart3("<c:url value='/images/sprites.png'/>");
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {				
				poTab2Data = data.rows;
				poTab2DataA = new Array();
				poTab2DataB = new Array();
				poTab2DataC = new Array();
								
				if(poTab2Data.length == 0) {
					progressStop();
					
					var tBody = $("#time-popup-grid");	
					
					tBody.empty();
					
					alert("조회 된 데이터가 없습니다.");
					
					return;
				}
				
				for(i=0; i<poTab2Data.length; i++) {
					if(poTab2Data[i].BK_COS == "A") {
						poTab2DataA[poTab2DataA.length] = poTab2Data[i];
					}
										
					if(poTab2Data[i].BK_COS == "B") {
						poTab2DataB[poTab2DataB.length] = poTab2Data[i];						
					}
										
					if(poTab2Data[i].BK_COS == "C") {
						poTab2DataC[poTab2DataC.length] = poTab2Data[i];						
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
			$("#poSearchTapC").removeClass("on");
			data = poTab2Data;
		} else if(cos == 'A') {
			$("#poSearchTapALL").removeClass("on");
			$("#poSearchTapA").addClass("on");
			$("#poSearchTapB").removeClass("on");
			$("#poSearchTapC").removeClass("on");	
			data = poTab2DataA;	
		} else if(cos == 'B') {
			$("#poSearchTapALL").removeClass("on");
			$("#poSearchTapA").removeClass("on");
			$("#poSearchTapB").addClass("on");	
			$("#poSearchTapC").removeClass("on");
			data = poTab2DataB;		
		} else if(cos == 'C') {
			$("#poSearchTapALL").removeClass("on");
			$("#poSearchTapA").removeClass("on");
			$("#poSearchTapB").removeClass("on");	
			$("#poSearchTapC").addClass("on");
			data = poTab2DataC;		
		}
		
		var tBody = $("#time-popup-grid");	
		
		tBody.empty();
		
		var minGreenfee, maxGreenfee;
		var greenRange = $("#rangeGreenfee").val().split(",");
		minGreenfee = greenRange[0];
		maxGreenfee = greenRange[1];
		
		if(data == null) {
			return;
		}
		
		var roundf = $("#holeDiv").val();
		
		for(i=0; i<data.length; i++) {
			var row = $("<tr onclick='onClickSearchRow(" + i + ")'></tr>"); 

			var bkDay = data[i].BK_DAY;
			bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
			var bkTime = data[i].BK_TIME;
			bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
			var bkCharge;
			if(data[i].BK_CHARGE != null && data[i].BK_CHARGE != ""){
				bkCharge = data[i].BK_CHARGE.split(",")	
			}
			
			if(Number(bkCharge[1]) >= Number(minGreenfee) && Number(bkCharge[1]) <= Number(maxGreenfee)) {
			    var col1 = $("<td>" + bkDay + "</td>"); 
			    var col2 = $("<td>" + bkTime + "</td>"); 
			    var col3 = $("<td>" + data[i].BK_COS_NM + "</td>");
			    var col4 = $("<td style='width:40px;'>" + data[i].BK_ROUNDF_NM + "홀</td>");
			    var col5, col6;
			    
			    var bkCharge;
				if(data[i].BK_CHARGE != null && data[i].BK_CHARGE != ""){
					bkCharge = data[i].BK_CHARGE.split(",")	
				}
				var proDcGu = data[i].PRO_DC_GU;
				var proDcVal = data[i].PRO_DC_VALUE;				    
			    var bkChargeNm = bkCharge[1];
			    var rGu = data[i].R_GU;
			    
			    if(roundf == "S") {
			    	if(bkCharge[2] != "M" && bkCharge[2] != "R" && bkCharge[2] != "S") continue;
			    	if(bkCharge[2] == "S" && data[i].MN_COST_YN == "Y") continue;
			    } else if(roundf == "M") {
			    	if(proDcGu == "X") continue;
			    } else if(roundf == "E") {
			    	if(rGu != "2" && rGu != "3") continue;
			    } else if(roundf == "R") {
			    	if(rGu != "1") continue;
			    }
			    
				if(bkCharge[2] == "M") {
			    	col5 = $("<td><span class='event_s'>특가</span></td>");
			    } else if(bkCharge[2] == "S") {
			    	if(data[i].MN_COST_YN == "Y") {
				    	col5 = $("<td></td>");
			    	} else {
				    	col5 = $("<td><span class='event_s'>특가</span></td>");
			    	}
			    } else if(bkCharge[2] == "R") {
			    	col5 = $("<td><span class='event_s'>추천</span></td>");
			    } else {
			    	col5 = $("<td></td>");
			    }
				
				if(rGu != "X") {
				    if(rGu == "1") {
				    	row = $("<tr onclick='onClickRoyalSearchRow(" + i + ")'></tr>");
				    	
				    	col5 = $("<td><span class='event_r'>로얄</span></td>");
			    	} else if(rGu == "2") {
			    		col5 = $("<td><span class='event_e'>조기</span></td>");
			    	} 
			    	else if(rGu == "3") {
			    		col5 = $("<td><span class='event_f'>식사</span></td>");
			    	}				 
				    
				    bkChargeNm = Number(data[i].R_GREEN_AMT) + Number(data[i].R_CART_AMT) + Number(data[i].R_FOOD_AMT) + Number(data[i].R_ROUND_B_AMT) + Number(data[i].R_ROUND_A_AMT);
			    }
				
				var amtGu = data[i].R_AMT_GU == "1" && rGu == "1" ? "<span class='icon_team'>팀</span>" : "";
			    
			    if(proDcGu != "X") {
			    	var basicCharge = data[i].BK_BASIC_CHARGE;
			    	var defaultCharge = bkChargeNm;      
				    
			    	if(proDcGu == "1") {					    	
					    bkChargeNm = Number(proDcVal) / 4;
				    } else if(proDcGu == "2") {	
					    bkChargeNm = Number(basicCharge) - (Number(basicCharge) * Number(proDcVal) / 100);					    	
				    } else if(proDcGu == "3") {
				    	bkChargeNm = Number(basicCharge) - Number(proDcVal);
				    } 
			    	
			    	if(Number(bkChargeNm) <= Number(defaultCharge)) {
			    		var advYn = data[i].PRO_ADV_YN;
			    		var foodYn = data[i].PRO_FOOD_YN;
			    		var sTag = ""			    		
			    		if(advYn == "Y") {
			    			sTag = "조기맞춤";
			    		} else {
			    			sTag = "맞춤";
			    		}
			    		if(foodYn == "Y") {
			    			if(sTag.length > 2) sTag += "<br>+<br>식사";
			    			else sTag += "+식사";
			    		}

			    		col5 = $("<td><span class='event_c'>" +  sTag + "</span></td>");
			    	} else {
			    		bkChargeNm = defaultCharge;
			    	}
			    }
			    
			    var col6 = $("<td>" + amtGu + numberWithCommas(bkChargeNm) + "</td>");		
			    
			    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody); 	
			}			
		}
	}
	
	function onClickSearchRow(i) {	
		if($("#poSearchTapALL").attr("class") == "on") {
			popupOpen("I", poTab2Data[i], null);
		} else if($("#poSearchTapA").attr("class") == "on") {
			popupOpen("I", poTab2DataA[i], null);
		} else if($("#poSearchTapB").attr("class") == "on") {
			popupOpen("I", poTab2DataB[i], null);
		} else if($("#poSearchTapC").attr("class") == "on") {
			popupOpen("I", poTab2DataC[i], null);
		}
	}
	
	function onClickRoyalSearchRow(i) {	
		if($("#poSearchTapALL").attr("class") == "on") {
			royalPopupOpen(poTab2Data[i]);
		} else if($("#poSearchTapA").attr("class") == "on") {
			royalPopupOpen(poTab2DataA[i]);
		} else if($("#poSearchTapB").attr("class") == "on") {
			royalPopupOpen(poTab2DataB[i]);
		} else if($("#poSearchTapC").attr("class") == "on") {
			royalPopupOpen(poTab2DataC[i]);
		}
	}
	
	function closeReservePopup() {
	    $("#quick-reserve-popup").css("display", "none");
	    $("#quick-overlay").css("display", "none");    
	}
	
	function fixPopTab(gubun) {
		if (gubun == "1") {
			$("#fix_tab1").show(); 
			$("#fix_tab2").hide(); 
		} else if (gubun == "2") {
			$("#fix_tab1").hide(); 
			$("#fix_tab2").show(); 
		}
	}
	
	function onClickTime(time) {
		if(time == 0) {
			initRealtimeReserve(poTab1DefaultCos);
		} else {
			for(i=5; i<=18; i++) {
				if(i == time) {
					$("#t" + i).addClass("on");				
				} else {
					$("#t" + i).removeClass("on");				
				}
			}
			
			time = (time > 9 ? '' : '0') + time;
			poTab1DefaultTime = time + "00";
			
			initRealtimeReserve(poTab1DefaultCos, poTab1DefaultTime);
		}
	}
	
	function poOnClickCos(cos) {
		if(cos == "A") {
			$("#rCosA").addClass("on");
			$("#rCosB").removeClass("on");
			$("#rCosC").removeClass("on");
		} else if(cos == "B") {
			$("#rCosA").removeClass("on");
			$("#rCosB").addClass("on");
			$("#rCosC").removeClass("on");
		} else if(cos == "C") {
			$("#rCosA").removeClass("on");
			$("#rCosB").removeClass("on");
			$("#rCosC").addClass("on");
		}
				
		poTab1DefaultCos = cos;
		
		initRealtimeReserve(poTab1DefaultCos, poTab1DefaultTime);
	}
	
	function onRealtimePrevWeek() {
		var tmp = new Date().yyyymmdd();
		
		if(poTab1StDate.yyyymmdd() == addDate(tmp, 1).yyyymmdd()) {
			return;
		}
		
		poTab1StDate = addDate(poTab1StDate.yyyymmdd(), -7);
		poTab1EdDate = addDate(poTab1EdDate.yyyymmdd(), -7);
		
		initRealtimeReserve(poTab1DefaultCos, poTab1DefaultTime);
	}
	
	function onRealtimeNextWeek() {
		poTab1StDate = addDate(poTab1StDate.yyyymmdd(), 7);
		poTab1EdDate = addDate(poTab1EdDate.yyyymmdd(), 7);
		
		initRealtimeReserve(poTab1DefaultCos, poTab1DefaultTime);
	}
	
</script>
	<div id="quick-reserve-popup" class="fix_pop_box1">
	    <div class="fix_pop_wrap">
	        <div class="relative_box" id="fix_tab1">
	            <div class="reserSeachTitle1">
	                <ul>
	                    <li class="on" onclick="javascript:fixPopTab(1);">&#8226; 실시간 예약 &#8226;</li>
	                    <li onclick="javascript:fixPopTab(2);">&#8226; 예약 검색하기 &#8226;</li>
	                </ul>
	            </div>
	            <div class="mReserTWrap">
	                <div class="CarendarTitle">
	                    <div class="monthChoice">
	                        <div class="cLeft" onclick="onRealtimePrevWeek()">이전주</div>
	                        <div class="cCenter" id="poRealHeaderText"></div>
	                        <div class="cRight" onclick="onRealtimeNextWeek()">다음주</div>
					    </div>
	                </div>
	            </div>
	            
	            <div class="fixPopCTab">
                    <ul>
                        <li class="on" id="rCosA" onclick="poOnClickCos('A')">EAST</li>
                        <li id="rCosB" onclick="poOnClickCos('B')">WEST</li>
                        <li id="rCosC" onclick="poOnClickCos('C')">SOUTH</li>
                    </ul>                
                </div>
	            
	            <div class="popupReserWrap">	                
	                <h3><a href="javascript:onClickTime(0)"><img src="<c:url value='/images/hills/bt_s.png'/>" style=" vertical-align: middle;"></a>  * 시간대별  선택이 가능합니다.</h3>
	                <div class="earlyBox">
	                <span class="event_f">식사</span>식사제공 
					<span class="event_e">조기</span>조기예약
					<span class="event_c">맞춤</span>맞춤그린피 
					<span class="event_s">특가</span>특가할인
					<span class="event_r">로얄</span>로얄타임                      
	                </div>
	              	<table class="popReserTable1">
                        <colgroup>
                            <col width="10%">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                        </colgroup>
                         <tr>
                             <th colspan="8">
                                 1부 
                                 <span id="t5" onclick="onClickTime(5)">5시대</span>
                                 <span id="t6" onclick="onClickTime(6)">6시대</span>
                                 <span id="t7" onclick="onClickTime(7)">7시대</span>
                                 <span id="t8" onclick="onClickTime(8)">8시대</span>
                                 <span id="t9" onclick="onClickTime(9)">9시대</span>
                                 2부 
                                 <span id="t10" onclick="onClickTime(10)">10시대</span>
                                 <span id="t11" onclick="onClickTime(11)">11시대</span>
                                 <span id="t12" onclick="onClickTime(12)">12시대</span>
                                 <span id="t13" onclick="onClickTime(13)">13시대</span>
                                 <span id="t14" onclick="onClickTime(14)">14시대</span>
                                 3부 
                                 <span id="t15" onclick="onClickTime(15)">15시대</span>
                                 <span id="t16" onclick="onClickTime(16)">16시대</span>
                                 <span id="t17" onclick="onClickTime(17)">17시대</span>
                                 <span id="t18" onclick="onClickTime(18)">18시대</span>
                             </th>
                         </tr>
                        <tbody id="tbody-header">
                        </tbody>    
                    </table>
                <div class="popReserTableWrap">
                    <table class="popReserTable">
                        <colgroup>
                            <col width="10%">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                        </colgroup>
                        <tbody id="tbody-realtime">
                        </tbody>
                    </table>
                </div>                

                                       
	                <div class="hr"></div>
	            </div>
	            
	        </div>
	        
	        <div class="relative_box1" id="fix_tab2">
	            <div class="reserSeachTitle1">
	                <ul>
	                    <li onclick="javascript:fixPopTab(1);">&#8226; 실시간 예약 &#8226;</li>
	                    <li class="on" onclick="javascript:fixPopTab(2);">&#8226; 예약 검색하기 &#8226;</li>
	                </ul>
	            </div>
	            <div class="leftData">
						<div class="choiceBox">
							<span class="title">예약종류</span>
							<span class="reserSelect">
								<select id="holeDiv" class="selcetBox">
									<option value="">전체</option>
									<c:if test="${sessionScope.msMember.msDivision != '21' || sessionScope.msMember.msClass != '21'}">
									<option value="S">임박타임</option>
									<option value="M">맞춤그린피</option>
									<option value="E">조기예약</option>
									<option value="R">로얄타임</option>
									</c:if>
								</select>
							</span>	
						</div>
						<div class="choiceBox">
							<span class="title">일자선택</span>
							<img src="<c:url value='/images/hills/modalcal.png'/>" alt="달력">
							<span>l</span>               
                            <!--미니달력시작-->
							<div class="dayInput" id="show_hideSub"></div>								                
                                <div class="SubMonthBox" id="poSubMonthBox1">
                                    <div class="monthChoice">
                                    <span><a href="javascript:poSmPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                                    <span class="month" id="calHeader"></span>
                                    <span><a href="javascript:poSmNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
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
							<img src="<c:url value='/images/hills/modalcal.png'/>" alt="달력">
							<span>l</span>
							<div class="dayInput" id="show_hideSub1"></div>
                             <!--미니달력시작-->
                            <div class="SubMonthBox1" id="poSubMonthBox2">
                                <div class="monthChoice">
                                <span><a href="javascript:poFmPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                                <span class="month" id="calHeader"></span>
                                <span><a href="javascript:poFmNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
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
							<input type="radio" name="poChkSearchCos" value="A"> 이스트&nbsp;&nbsp;&nbsp;
							<input type="radio" name="poChkSearchCos" value="B"> 웨스트&nbsp;&nbsp;&nbsp;
							<input type="radio" name="poChkSearchCos" value="C"> 사우스
						</div>
						<div class="choiceBox">
							<span class="title">시간대&nbsp;&nbsp;&nbsp;</span>
							<span class="reserTime">
								<select id="poSearchStTime">
									<option value=''>전체</option>
									<option value='500'>5시</option>
									<option value='600'>6시</option>
									<option value='700'>7시</option>
									<option value='800'>8시</option>
									<option value='900'>9시</option>
									<option value='1000'>10시</option>
									<option value='1100'>11시</option>
									<option value='1200'>12시</option>
									<option value='1300'>13시</option>
									<option value='1400'>14시</option>
									<option value='1500'>15시</option>
									<option value='1600'>16시</option>
									<option value='1700'>17시</option>
									<option value='1800'>18시</option>
								</select>
								<select id="poSearchFnTime">
									<option value=''>전체</option>
									<option value='500'>5시</option>
									<option value='600'>6시</option>
									<option value='700'>7시</option>
									<option value='800'>8시</option>
									<option value='900'>9시</option>
									<option value='1000'>10시</option>
									<option value='1100'>11시</option>
									<option value='1200'>12시</option>
									<option value='1300'>13시</option>
									<option value='1400'>14시</option>
									<option value='1500'>15시</option>
									<option value='1600'>16시</option>
									<option value='1700'>17시</option>
									<option value='1800'>18시</option>
								</select>
							</span>	
						</div>
						<div class="choiceBox">
							<span class="title">그린피&nbsp;&nbsp;&nbsp;</span>
							<span class="greenfee">
								<input type="hidden" class="slider-input" id="rangeGreenfee" value="60000" /> 
							</span>
						</div>
						
						<div class="gFBox">
							<span class="title"></span>
							<div class="greenFeeList">
								<div class="greenFeeText">
									<ul class="feeMinText">
										<li class="img"><img src="<c:url value='/images/hills/fee_Arrow_down.png'/>" alt=""></li>
										<li>최저가</li>
										<li class="fee">60,000</li>
									</ul>
									<ul class="feeMaxText">
										<li class="img"><img src="<c:url value='/images/hills/fee_Arrow_up.png'/>" alt=""></li>
										<li>최고가</li>
										<li class="fee">190,000</li>
									</ul>
								</div>
							</div>
						</div>		
						
						<div class="dotLine"></div>
						<div class="btnBox">
							<input type="button" class="motion" onclick="doPopupSearch()" value="검 색"/>
							<input type="button" class="cancel" onclick="closeReservePopup()" value="취 소"  />
						</div>
					</div>

					<!-- right Contents -->
					<div class="rightData">
						<div class="courseTab">
							<a href="javascript:initSearchTable()" id="poSearchTapALL" class="on">전체코스</a>
							<a href="javascript:initSearchTable('A')" id="poSearchTapA" class="">이스트</a>
							<a href="javascript:initSearchTable('B')" id="poSearchTapB" class="">웨스트</a>	
							<a href="javascript:initSearchTable('C')" id="poSearchTapC" class="">사우스</a>						
						</div>
						<table class="commonTable1" id="time-popup-table">
							<caption>실시간 예약 코스,시간별 가격 안내</caption>
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="30px">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
							<tr>
								<th scope="col">날짜</th>
								<th scope="col">시간대</th>
								<th scope="col">코스</th>
								<th scope="col" style='width:40px;'>홀</th>
								<th scope="col">이벤트</th>
								<th scope="col">그린피</th>
							</tr>
							</thead>
							
							<tbody id="time-popup-grid">							
							
							</tbody>
						</table>
						
						<div class="underline"></div>
					</div>
											
					<div style='display:none'>
						<img src="<c:url value='/images/hills/x.png'/>" alt='' />
					</div>
	        </div>
	    </div>
	    <div class="fix_pop_x" onclick="closeReservePopup()"><img src="<c:url value='/images/hills/x.png'/>" alt="" /></div>
	</div>
	<div id="quick-overlay" class="quick-overlay"></div>
	<jsp:include page="../popup/reservationConfirm.jsp" flush="true" />	
	<jsp:include page="../popup/royalConfirm.jsp" flush="true" />