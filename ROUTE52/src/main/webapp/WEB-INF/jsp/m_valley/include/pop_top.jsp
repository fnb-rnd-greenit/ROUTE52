<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/pop_top.css'/>">    
<script>
    var MopenIdx = -1;
	var smSPYear, smSPMonth, edSPYear, edSPMonth;
	var stSPDate, edSPDate;	
	var dataOrderType;
	// 1: 날짜별, 2: 타임별
	var mobileSearchPopupOptions;
	var searchPopupLowData;
    
    function MpopupOpen(i) {
    	var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";
			return;
		}
	
        MinitPopup(i);
        
        if(i == 1) {
        	initSearchPopup();
        } else if(i == 2) {
        	initSearchResultPopup();
        }
    }

    function MinitPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#topArea" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#topArea" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#topArea" + i).css("left", mW);
        $("#topArea" + i).css("top", mH);

        $("#topArea" + i).css("display", "block");
        $("#overlay" + i).css("display", "block");

		MopenIdx = i;
    }

    function MpopupClose(i) {
    	$("#topArea" + i).css("display", "none");
		$("#overlay" + i).css("display", "none");     
    }

    function MpopupOverlayClicked(i) {
		$("#topArea" + i).css("display", "none");
		$("#overlay" + i).css("display", "none");
    }

    function MpopupAllClose() {
    	$("#topArea1").css("display", "none");
		$("#overlay1").css("display", "none");
		$("#topArea2").css("display", "none");
		$("#overlay2").css("display", "none");
    }
    
    function initSearchPopup() {
		var date = new Date();
		smSPYear = edSPYear = date.yyyy();
		smSPMonth = edSPMonth = date.mm();
		
		stSPDate = edSPDate = date.yyyymmdd();
		
		$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub6").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		
		initSearchPopupSubCalendar("#subMonthBox3", smSPYear, smSPMonth);
		initSearchPopupSubCalendar("#subMonthBox4", edSPYear, edSPMonth);
		
		$("#show_hideSub5").off();
		$("#show_hideSub6").off();
		
		$("#show_hideSub5").click(function() {
			$(".SubMonthBox5").slideToggle();
			$(".SubMonthBox6").slideUp();
		});
		
		$("#show_hideSub6").click(function() {
			$(".SubMonthBox6").slideToggle();
			$(".SubMonthBox5").slideUp();
		});
    }
	
	function initSearchPopupSubCalendar(selector, year, month) {
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
			if(selector == "#subMonthBox3"){
				td.data("div", "start");
			} else {
				td.data("div", "finish");							
			}
			td.on('click', function() {
				onSearchPopupClickMiniDay($(this).data('div'), $(this).data('date')); 
			});
			
			row.append(td);
								
			if(rows[i].week == 7) {
				row.appendTo(tBody); 
				row = $("<tr></tr>");
			}					
		}			
	
		row.appendTo(tBody);     
	}
	
	function smSearchPopupNextMonth() {
	    if(smSPMonth == "12") {
	        smSPYear += 1;
	        smSPMonth = "01";
	    } else {
	        smSPMonth = Number(smSPMonth) + 1;
	        smSPMonth = (smSPMonth>9 ? '' : '0') + smSPMonth;
	    }
	
	    initSearchPopupSubCalendar("#subMonthBox3", smSPYear, smSPMonth);
	}
	
	function smSearchPopupPrevMonth() {
	    if(smSPMonth == "01") {
	        smSPYear -= 1;
	        smSPMonth = "11";
	    } else {
	        smSPMonth = Number(smSPMonth) - 1;
	        smSPMonth = (smSPMonth>9 ? '' : '0') + smSPMonth;
	    }
	
	    initSearchPopupSubCalendar("#subMonthBox3", smSPYear, smSPMonth);		
	}
	
	function fmSearchPopupNextMonth() {
	    if(edSPMonth == "12") {
	        edSPYear += 1;
	        edSPMonth = "01";
	    } else {
	        edSPMonth = Number(edSPMonth) + 1;
	        edSPMonth = (edSPMonth>9 ? '' : '0') + edSPMonth;
	    }
	
	    initSearchPopupSubCalendar("#subMonthBox4", edSPYear, edSPMonth);
	}
	
	function fmSearchPopupPrevMonth() {
	    if(edSPMonth == "01") {
	        edSPYear -= 1;
	        edSPMonth = "11";
	    } else {
	        edSPMonth = Number(edSPMonth) - 1;
	        edSPMonth = (edSPMonth>9 ? '' : '0') + edSPMonth;
	    }
	
	    initSearchPopupSubCalendar("#subMonthBox4", edSPYear, edSPMonth);
	}
	
	function onSearchPopupClickMiniDay(div, sDate) {
		var date = getDateFormat(sDate);
		
		if(div == "start") {
			stSPDate = sDate;
			$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox5").slideToggle();			
		} else if(div == "finish") {
			edSPDate = sDate;
			$("#show_hideSub6").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox6").slideToggle();			
		} 		
	}
	
	function doOpenSearchResultPopup() {
		var stTime, edTime;
		if($("#sp_sel_st_time").val() == "") {
			stTime = 0;
		} else {
			stTime = $("#sp_sel_st_time").val();
		}
		
		if($("#sp_sel_ed_time").val() == "") {
			edTime = 2400;
		} else {
			edTime = $("#sp_sel_ed_time").val() - 1;
		}
		
		if(stSPDate > edSPDate) {
			alert("조회기간을 확인하세요.");
			return;
		}
		
		var addDate = addMonth2(stSPDate, 1).yyyymmdd();
		if(addDate < edSPDate) {
			alert("조회기간은 최대 1달까지 설정 가능합니다.");
			return;
		}
		
		mobileSearchPopupOptions = {
			"stDate" : stSPDate,
			"edDate" : edSPDate,
			"stTime" : stTime,
			"edTime" : edTime
		}
		
		MpopupOpen(2);
	}
	
	function initSearchResultPopup() {
		dataOrderType = 1;
		
		doSearchResultPopup();
	}
	
	function doSearchResultPopup() {
		var sUrl = "<c:url value='/m_valley/reservation/getMobileSearchTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&orderType={0}", dataOrderType);
		sParams += String.format("&stDate={0}", mobileSearchPopupOptions.stDate);
		sParams += String.format("&edDate={0}", mobileSearchPopupOptions.edDate);
		sParams += String.format("&sTime={0}", mobileSearchPopupOptions.stTime);
		sParams += String.format("&eTime={0}", mobileSearchPopupOptions.edTime);
		
		progressStart3("<c:url value='/images/sprites.png'/>");	
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				searchPopupLowData = data.rows;
				
				if(searchPopupLowData.length == 0) {
					progressStop();					
					alert("조회 된 데이터가 없습니다.")
					return;
				}
				
				var container = $("#searchPopupResultContainer");
				
				container.empty();
				
				var minFee = Number(mobileSearchPopupOptions.minFee);
				var maxFee = Number(mobileSearchPopupOptions.maxFee);
				minFee = 0;
				maxFee = 250000;
				
				if(dataOrderType == 1) {
					var tmpDate = searchPopupLowData[0].BK_DAY;
					var cnt = 0;
					
					var div = $("<div class='tLList'></div>");
					
					for(i=0; i<searchPopupLowData.length; i++) {
						var bkTime = searchPopupLowData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + " : " + bkTime.substring(2, 4);
						var bkCharge;
						if(searchPopupLowData[i].BK_CHARGE != null && searchPopupLowData[i].BK_CHARGE != ""){
							bkCharge = Number(searchPopupLowData[i].BK_CHARGE.split(",")[1]);	
						}
						
						if(bkCharge >= minFee && bkCharge <= maxFee) {
							var p = $(String.format("<p class='time' onclick='onClickSearchPopupRow(" + i + ")'>{0}({1})<span class='price'>{2}원</span></p>", searchPopupLowData[i].BK_COS_NM, bkTime, numberWithCommas(Number(bkCharge))));
							
							div.append(p);
							
							cnt += 1;
						}
						
						if(searchPopupLowData.length -1 == i) {
							var date = getDateFormat(tmpDate);
							var header = $(String.format("<p class='day'>{0}.{1}.{2}({3})<span class='all'><strong>{4}</strong>건</span></p>", date.yyyy(), date.mm(), date.dd(), date.week(), cnt));
							div.prepend(header);
							container.append(div);
							continue;
						}
						
						if(searchPopupLowData[i + 1].BK_DAY != tmpDate) {
							var date = getDateFormat(tmpDate);
							var header = $(String.format("<p class='day'>{0}.{1}.{2}({3})<span class='all'><strong>{4}</strong>건</span></p>", date.yyyy(), date.mm(), date.dd(), date.week(), cnt));
							div.prepend(header);
							container.append(div);
							
							tmpDate = searchPopupLowData[i + 1].BK_DAY;		
							cnt = 0;
							div = $("<div class='tLList'></div>");
						}
					}
					
					container.append(div);
				} else if(dataOrderType == 2) {
					var tmpPart = searchPopupLowData[0].BK_PART;
					var cnt = 0;
					var sTime = searchPopupLowData[0].BK_TIME;
					var eTime = "";
					
					var div = $("<div class='tLList'></div>");
					
					for(i=0; i<searchPopupLowData.length; i++) {
						var bkDay = getDateFormat(searchPopupLowData[i].BK_DAY);
						var bkTime = searchPopupLowData[i].BK_TIME;
						bkTime = bkTime.substring(0, 2) + " : " + bkTime.substring(2, 4);
						var bkCharge;
						if(searchPopupLowData[i].BK_CHARGE != null && searchPopupLowData[i].BK_CHARGE != ""){
							bkCharge = Number(searchPopupLowData[i].BK_CHARGE.split(",")[1]);		
						}

						if(bkCharge >= minFee && bkCharge <= maxFee) {
							var p = $(String.format("<p class='time' onclick='onClickSearchPopupRow(" + i + ")'>{0}.{1}.{2}({3}) {4} ({5})<span class='price'>{6}원</span></p>"
									, bkDay.yyyy(), bkDay.mm(), bkDay.dd(), bkDay.week(), searchPopupLowData[i].BK_COS_NM, bkTime, numberWithCommas(Number(bkCharge))));
							
							div.append(p);
							
							cnt += 1;
						}
						
						if(searchPopupLowData.length -1 == i) {
							sTime = sTime.substring(0, 2) + " : " + sTime.substring(2, 4);
							eTime = searchPopupLowData[i].BK_TIME;
							eTime = eTime.substring(0, 2) + " : " + eTime.substring(2, 4);
							var header = $(String.format("<p class='day'>{0} ~ {1}<span class='all'><strong>{2}</strong>건</span></p>", sTime, eTime, cnt));
							div.prepend(header);
							container.append(div);
							continue;
						}
						
						if(searchPopupLowData[i + 1].BK_PART != tmpPart) {
							sTime = sTime.substring(0, 2) + " : " + sTime.substring(2, 4);
							eTime = searchPopupLowData[i].BK_TIME;
							eTime = eTime.substring(0, 2) + " : " + eTime.substring(2, 4);
							var header = $(String.format("<p class='day'>{0} ~ {1}<span class='all'><strong>{2}</strong>건</span></p>", sTime, eTime, cnt));
							div.prepend(header);
							container.append(div);
							
							sTime = searchPopupLowData[i + 1].BK_TIME;
							tmpPart = searchPopupLowData[i + 1].BK_PART;
							cnt = 0;
							div = $("<div class='tLList'></div>");
						}
					}
					
					container.append(div);
				}							
			} else {
				alert(data.resultMessage);
			}
			
			progressStop();
		});
	}
	
	function onClickSearchPopupRow(i) {		
		confirmPopupOpen("I", searchPopupLowData[i], null);
	}
	
	function doSearchResultTabChagne(type) {
		if(type == '1') {
			$("#poOrderDate").addClass("on");
			$("#poOrderTime").removeClass("on");
		} else if(type == '2') {
			$("#poOrderDate").removeClass("on");
			$("#poOrderTime").addClass("on");
		} 
		
		dataOrderType = type;
		
		doSearchResultPopup();
	}
    
</script>

<div id="topArea1" class="searchBox1">
    <div class="choiceBox">
        <span class="title">날짜</span>
        <img src="<c:url value='/images/m_valley/modalcal.jpg'/>" alt="달력" class="small_cal">
        <!--미니달력시작-->
        <div class="dayInput" id="show_hideSub5"></div>					
        <div class="SubMonthBox5" id="subMonthBox3">
                 <div class="monthChoice1">
                    <span class="arw"><a href="javascript:smSearchPopupPrevMonth()"><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" ></a></span>
					<span class="month" id="calHeader"></span>
                    <span class="arw"><a href="javascript:smSearchPopupNextMonth()"><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달"></a></span>
                 </div>

                 <table class="mainCalendar1" summary="실시간 예약" cellspacing="5">
                    <caption>실시간 예약</caption>
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
        <span>&nbsp; ~ &nbsp;</span>
        <img src="<c:url value='/images/m_valley/modalcal.jpg'/>" alt="달력" class="small_cal">
        <!--미니달력시작-->
        <div class="dayInput" id="show_hideSub6"></div>					
        <div class="SubMonthBox6" id="subMonthBox4">
                 <div class="monthChoice1">
                    <span class="arw"><a href="javascript:fmSearchPopupPrevMonth()"><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" ></a></span>
					<span class="month" id="calHeader"></span>
                    <span class="arw"><a href="javascript:fmSearchPopupNextMonth()"><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달"></a></span>
                 </div>

                 <table class="mainCalendar1" summary="실시간 예약" cellspacing="5">
                    <caption>실시간 예약</caption>
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
    </div>
    <div class="choiceBox">
        <span class="title">시간</span>
        <span class="reserTime">
            <select id="sp_sel_st_time">
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
            <select id="sp_sel_ed_time">
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
     
    <div class="dotLine2"></div>
    <div class="btnBox2">
        <li><input type="button" class="motion" onclick="doOpenSearchResultPopup()" value="검 색"/> </li>
        <li><input type="button" class="cancel" onclick="javascript:MpopupClose(1)" value="취 소"  /></li>
    </div>
</div>

<div id="topArea2" class="searchBox2">
    <h2> &bull; 검색결과 &bull;</h2>
    <div class="searchWrap">
        <!--결과탭-->
        <div class="tLTab">
            <ul>
                <li class="on" onclick="javascript:doSearchResultTabChagne(1)" id="poOrderDate">날짜별</li>
                <li onclick="javascript:doSearchResultTabChagne(2)" id="poOrderTime">시간별</li>
            </ul>
        </div>
        <!--날짜별내용-->
        <div class="tLContents" id="Tab1">
            <div class="tLWrap" id="searchPopupResultContainer">
                <!--리스트반복-->
                
            </div>
            <!--버튼-->
            <div class="btnBox3">
                <li><input type="button" class="motion" onclick="javascript:MpopupClose(2)" value="전단계"/> </li>
                <li><input type="button" class="cancel" onclick="javascript:MpopupAllClose()" value="닫기"  /></li>
            </div>
            <!--//버튼-->
        </div>
        <!--//날짜별내용-->
    </div>
</div>
<div id="overlay1" class="overlay" onclick="MpopupOverlayClicked(1)"></div>
<div id="overlay2" class="overlay" onclick="MpopupOverlayClicked(2)"></div>