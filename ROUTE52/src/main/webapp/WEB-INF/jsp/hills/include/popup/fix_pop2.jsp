<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/fix_pop2.css'/>" rel='stylesheet' />
<script type="text/javascript">

	var poTab1Data2;
	var poTab1StDate2, poTab1EdDate2;
	var poTab1DefaultTime2, poTab1DefaultCos2;

	function reservePopupOpen2() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
			
			return;
		}
		
		initReserve2();
	    
		initRealtimeReserve2(poTab1DefaultCos2);
		
	    initReservePopup2();
	}
	
	function initReserve2() {		
		var date = new Date();
		var date2 = addMonth(date.yyyymmdd(), 1); 
		poTab1StDate2 = date;
		poTab1StDate2 = addDate(poTab1StDate2.yyyymmdd(), 1);
		poTab1EdDate2 = addDate(poTab1StDate2.yyyymmdd(), 6);

		poTab1DefaultCos2 = "A";
		
		var curMonth = Number(date.mm());
		
		if(curMonth == 3 || curMonth == 4 || curMonth == 11) {
			$("#t25").hide();
			$("#t29").hide();
			$("#t210").hide();
			$("#t214").hide();
			$("#t215").hide();
		} else if (curMonth >= 5 && curMonth <= 10) {
			$("#t28").hide();
			$("#t29").hide();
			$("#t213").hide();
			$("#t214").hide();
			$("#t215").hide();			
		}
	}
	
	function initReservePopup2() {
	    var fW = $(window).width() / 2;
	    var fH = $(window).height() / 2;
	    var cW = Number($("#quick-reserve-popup2").css("width").replace("px", "")) / 2;
	    var cH = Number($("#quick-reserve-popup2").css("height").replace("px", "")) / 2;
	    var mW = fW - cW;
	    var mH = fH - cH;
	
	    $("#quick-reserve-popup2").css("left", mW);
	    $("#quick-reserve-popup2").css("top", mH);
	
	    $("#quick-reserve-popup2").css("display", "block");
	    $("#quick-overlay2").css("display", "block");
	}
	
	function initRealtimeReserve2(cos, time) {		
		$("#poRealHeaderText2").html(String.format("{0}/{1}({2}) ~ <span>{3}/{4}({5})</span>", poTab1StDate2.mm(), poTab1StDate2.dd(), poTab1StDate2.week(), poTab1EdDate2.mm(), poTab1EdDate2.dd(), poTab1EdDate2.week()));
		
		var sUrl = "<c:url value='/hills/reservation/getMatchTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&stDate={0}", poTab1StDate2.yyyymmdd());
		sParams += String.format("&fnDate={0}", poTab1EdDate2.yyyymmdd());
		
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
				var tBodyHeader = $("#tbody-header2");	
				tBodyHeader.empty();

				var row = $("<tr></tr>"); 
				var col1 = $("<td>시간</td>"); 
				var col2 = $("<td>" + String.format("{0}({1})", poTab1StDate2.dd(), poTab1StDate2.week()) + "</td>"); 	
				var col3 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 1).dd(), addDate(poTab1StDate2.yyyymmdd(), 1).week()) + "</td>"); 	
				var col4 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 2).dd(), addDate(poTab1StDate2.yyyymmdd(), 2).week()) + "</td>"); 	
				var	col5 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 3).dd(), addDate(poTab1StDate2.yyyymmdd(), 3).week()) + "</td>");
				var col6 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 4).dd(), addDate(poTab1StDate2.yyyymmdd(), 4).week()) + "</td>"); 	
				var col7 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 5).dd(), addDate(poTab1StDate2.yyyymmdd(), 5).week()) + "</td>"); 	
				var col8 = $("<td>" + String.format("{0}({1})", addDate(poTab1StDate2.yyyymmdd(), 6).dd(), addDate(poTab1StDate2.yyyymmdd(), 6).week()) + "</td>"); 			    
				
				switch(poTab1StDate2.weeknum()) {
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

				var tBody = $("#tbody-realtime2");	
				tBody.empty();
				
				var header = data.rows.header;
				
				if(header == null || header.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<header.length; i++) {
					var row = $("<tr id='_tr" + i + "'></tr>"); 					

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
				
				poTab1Data2 = data.rows.data;
				
				for(i=0; poTab1Data2 != null && i<poTab1Data2.length; i++){
					var id = "#td-" + poTab1Data2[i].BK_TIME + poTab1Data2[i].BK_DAY;
					var charge = poTab1Data2[i].BK_BASIC_CHARGE;
					var proDcGu = poTab1Data2[i].PRO_DC_GU;
					var proDcVal = poTab1Data2[i].PRO_DC_VALUE;
					var bkChargeNm = charge;
					
					var name = poTab1Data2[i].BK_NAME;
					var msNum = poTab1Data2[i].BK_MSNUM;
					var bkYn = poTab1Data2[i].BK_YN;
					var tag = "";
					
					if(proDcGu != "X") {
				    	if(proDcGu == "1") {					    	
						    bkChargeNm = Number(proDcVal) / 4;
					    } else if(proDcGu == "2") {	
						    bkChargeNm = Number(bkChargeNm) - (Number(bkChargeNm) * Number(proDcVal) / 100);					    	
					    } else if(proDcGu == "3") {
					    	bkChargeNm = Number(bkChargeNm) - Number(proDcVal);
					    } 
				    	
				    	var advYn = poTab1Data2[i].PRO_ADV_YN;
			    		var foodYn = poTab1Data2[i].PRO_FOOD_YN;
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
					
					$(id).html(tag + numberWithCommas(bkChargeNm));
					
					if(name != "" || msNum != "" || bkYn != "N") {
						$(id).css("color", "#dedede");
					} else {
						$(id).data("idx", i);
						$(id).css("cursor", "pointer");
						$(id).on("click", function() {
							onRealTimeClicked2($(this).data("idx"));
						});
					}
					
					var weekNum = getDateFormat(poTab1Data2[i].BK_DAY).weeknum();
					if(weekNum == 0) {
						$(id).addClass("sun");											
					} else if(weekNum == 6) {
						$(id).addClass("sat");
					}
				}
				
				tBody.children().each(function(i,tr) {
					var delYn = true;
					
					$(tr).children().each(function(j, td) {
						if(j != 0) {
							if($(td).html() != "") {
								delYn = false;
							}
						}
					});
					
					if(delYn) {
						$("#_tr" + i).remove();
					}
				});
			}
			
			progressStop();
		});
	}
	
	function onRealTimeClicked2(i) {
		popupOpen("I", poTab1Data2[i], null);
	}
	
	function closeReservePopup2() {
	    $("#quick-reserve-popup2").css("display", "none");
	    $("#quick-overlay2").css("display", "none");    
	}
	
	function onClickTime2(time) {
		if(time == 0) {
			initRealtimeReserve2(poTab1DefaultCos2);
		} else {
			for(i=5; i<=18; i++) {
				if(i == time) {
					$("#t2" + i).addClass("on");				
				} else {
					$("#t2" + i).removeClass("on");				
				}
			}
			
			time = (time > 9 ? '' : '0') + time;
			poTab1DefaultTime2 = time + "00";
			
			initRealtimeReserve2(poTab1DefaultCos2, poTab1DefaultTime2);
		}
	}
	
	function poOnClickCos2(cos) {
		if(cos == "A") {
			$("#rCosA2").addClass("on");
			$("#rCosB2").removeClass("on");
			$("#rCosC2").removeClass("on");
		} else if(cos == "B") {
			$("#rCosA2").removeClass("on");
			$("#rCosB2").addClass("on");
			$("#rCosC2").removeClass("on");
		} else if(cos == "C") {
			$("#rCosA2").removeClass("on");
			$("#rCosB2").removeClass("on");
			$("#rCosC2").addClass("on");
		}
				
		poTab1DefaultCos2 = cos;
		
		initRealtimeReserve2(poTab1DefaultCos2, poTab1DefaultTime2);
	}
	
	function onRealtimePrevWeek2() {
		var tmp = new Date().yyyymmdd();
		
		if(poTab1StDate2.yyyymmdd() == addDate(tmp, 1).yyyymmdd()) {
			return;
		}
		
		poTab1StDate2 = addDate(poTab1StDate2.yyyymmdd(), -7);
		poTab1EdDate2 = addDate(poTab1EdDate2.yyyymmdd(), -7);
		
		initRealtimeReserve2(poTab1DefaultCos2, poTab1DefaultTime2);
	}
	
	function onRealtimeNextWeek2() {
		poTab1StDate2 = addDate(poTab1StDate2.yyyymmdd(), 7);
		poTab1EdDate2 = addDate(poTab1EdDate2.yyyymmdd(), 7);
		
		initRealtimeReserve2(poTab1DefaultCos2, poTab1DefaultTime2);
	}
	
</script>
	<div id="quick-reserve-popup2" class="fix_pop_box1">
	    <div class="fix_pop_wrap">
	        <div class="relative_box" id="fix2_tab1">
	            <div class="reserSeachTitle2">
	                <ul>
	                    <li>&#8226; 맞춤 그린피 &#8226;</li>
	                </ul>
	            </div>
	            <div class="mReserTWrap">
	                <div class="CarendarTitle">
	                    <div class="monthChoice">
	                        <div class="cLeft" onclick="onRealtimePrevWeek2()">이전주</div>
	                        <div class="cCenter" id="poRealHeaderText2"></div>
	                        <div class="cRight" onclick="onRealtimeNextWeek2()">다음주</div>
					    </div>
	                </div>
	            </div>
	            
	            <div class="fixPopCTab">
                    <ul>
                        <li class="on" id="rCosA2" onclick="poOnClickCos2('A')">EAST</li>
                        <li id="rCosB2" onclick="poOnClickCos2('B')">WEST</li>
                        <li id="rCosC2" onclick="poOnClickCos2('C')">SOUTH</li>
                    </ul>                
                </div>
	            
	            <div class="popupReserWrap">	                
	                <h3><a href="javascript:onClickTime2(0)"><img src="<c:url value='/images/hills/bt_s.png'/>" style=" vertical-align: middle;"></a>  * 시간대별  선택이 가능합니다.</h3>
	              	<table class="popReserTable2">
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
                                 <span id="t25" onclick="onClickTime2(5)">5시대</span>
                                 <span id="t26" onclick="onClickTime2(6)">6시대</span>
                                 <span id="t27" onclick="onClickTime2(7)">7시대</span>
                                 <span id="t28" onclick="onClickTime2(8)">8시대</span>
                                 <span id="t29" onclick="onClickTime2(9)">9시대</span>
                                 2부 
                                 <span id="t210" onclick="onClickTime2(10)">10시대</span>
                                 <span id="t211" onclick="onClickTime2(11)">11시대</span>
                                 <span id="t212" onclick="onClickTime2(12)">12시대</span>
                                 <span id="t213" onclick="onClickTime2(13)">13시대</span>
                                 <span id="t214" onclick="onClickTime2(14)">14시대</span>
                                 3부 
                                 <span id="t215" onclick="onClickTime2(15)">15시대</span>
                                 <span id="t216" onclick="onClickTime2(16)">16시대</span>
                                 <span id="t217" onclick="onClickTime2(17)">17시대</span>
                                 <span id="t218" onclick="onClickTime2(18)">18시대</span>
                             </th>
                         </tr>
                        <tbody id="tbody-header2">
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
                        <tbody id="tbody-realtime2">
                        </tbody>
                    </table>
                </div>                

                                       
	                <div class="hr"></div>
	            </div>
	            
	        </div>
	        
	    </div>
	    <div class="fix_pop_x" onclick="closeReservePopup2()"><img src="<c:url value='/images/hills/x.png'/>" alt="" /></div>
	</div>
	<div id="quick-overlay2" class="quick-overlay2"></div>