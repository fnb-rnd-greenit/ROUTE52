<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../m_valley/include/header.jsp" />

<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script type="text/javascript">
	var rowData;
	var mDate;
	var mCos, mPart;
	
	$(document).ready(function() { 
		init();
		
		if(getCookie("mobileMainPopup1") != "Y"){
			doSearchPopup();
		}
		
		$("#reservationContainer").hide(); 
		$("#waitContainer").hide();
		
		doSearchBenner(); 
		
		initTable();
	});

	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "61");
		
		mAjax(sUrl, sParams, function(data) {	     		
			if(data.resultCode = "0000") {
				$(".slider1").empty();
				
				var rows = data.rows.list2;
				
				if(rows.length > 0) {
					$("#pop1").show();
					
					var bucket = "valley"
					var template = "<li><a href='{0}'><img src='{1}'></a></li>";
				    
					for(i=0; i<rows.length; i++) {
						var fileName = rows[i].HP_FILE_NAME;    
						var originName = rows[i].HP_ORIGIN_FILE_NAME;					
						var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName) ;
						var link = rows[i].HP_LINK;
						
						$(".slider1").append(String.format(template, link, image));
					}
					
					$('.slider1').bxSlider({
					    mode:'horizontal',
					    speed : 300,
					    pause : 3000,
					    auto: true,
					    controls: true,
					    pager:false
					});
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchBenner() {
		var sUrl = "<c:url value='/admin/getBenner.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "61");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") { 
				var bucket = "valley";
				 
				var mBenner = data.rows.mobile;
				
				var slideContainer = $("#slideContainer");
				
				slideContainer.empty();
				
				var wrapper = $("<div class='bx-wrapper'></div>")
				
				var slider = $("<ul class='slider'></ul>");
				
				for(i=0; i<mBenner.length; i++) {
					var fileName = mBenner[i].HP_FILE_NAME;
					var fileLink = mBenner[i].HP_LINK; 
					
					fileLink = fileLink == "" ? "javascript:void(0)" : fileLink;
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					slider.append(String.format("<li><a href='{0}'><img src='{1}'/></a></li>", fileLink, image));
				}
				
				wrapper.append(slider).appendTo(slideContainer);
				
				if(mBenner.length > 0) {
					$('.slider').bxSlider({
                        mode:'horizontal',
                        speed : 300,
                        pause : 3000,
                        auto: true,
                        controls: false,
                        pager:false,
                        touchEnabled :false
                    });
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function initTable() {
		var $table = $("#time-table");
		var $header = $table.children("tbody").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-grid";
			var imgAsc = "<c:url value='/images/m_valley/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/m_valley/t_arw1.png'/>";
			
			if(index == 0 || index == 3) {
				var type = index == 3 ? "n" : "s";
				
				$(this).css("background-image", "url(" + imgAsc + "), url(" + imgDesc + ")");
				$(this).css("background-position", "50% 10%, 50% 90%");
				$(this).css("background-size", "12px 7px, 12px 7px");
				$(this).css("background-repeat", "no-repeat");
				
				$(this).data("order", "asc");
				
				$(this).on("click", function() {
					sortTable(selector, type, $(this).data("order"), index);
					if($(this).data("order") == "asc") {
						$(this).css("background-image", "url(" + imgAsc + ")");
						$(this).css("background-position", "50% 10%");
						$(this).data("order", "desc");
					} else {
						$(this).css("background-image", "url(" + imgDesc + ")");
						$(this).css("background-position", "50% 90%");
						$(this).data("order", "asc");
					}
					$(this).css("background-size", "12px 7px");
				});
			}
		});
	}
	
	function init() {
		var date = new Date();
		var date2 = addMonth(date.yyyymmdd(), 1);

		initCalendar("#mainCalendar1", date.yyyy(), date.mm());
		initCalendar("#mainCalendar2", date2.yyyy(), date2.mm());
	}
	
	function initCalendar(selector, year, month) {
		var sUrl = "<c:url value='/valley/reservation/getCalendar.do'/>";
		var sParams = "";

		sParams += String.format("&selYM={0}", year + month);	
		
		mAjax(sUrl, sParams, function(data) {			
			if(data.resultCode == "0000") {
				$(selector + " #calHeader").html(String.format("{0}년 {1}월", year, month));
				
				var currentDay = new Date().yyyymmdd();
				var tBody = $(selector + " #calendar-body");				
				tBody.empty();
				
				var rows = data.rows;
				var row = $("<tr></tr>");
				
				var fWeek = rows[0].CL_DAYDIV - 1;
				
				for(i=0; i<fWeek; i++) {
					row.append($("<td></td>"));
				}		
				
				var blank = 0;
				var blankFlag = true;
				
				for(i=0; i<rows.length; i++) {
					var td;
					
					if(rows[i].CL_BUSINESS != 5) {
						if(rows[i].CL_SOLAR <= currentDay) {
							td = $("<td class='block'><a>" + rows[i].DAYNUM + "<span>마감</span></a></td>");
						} else if(rows[i].CL_SOLAR > currentDay) {
							blankFlag = false;
							if(rows[i].BK_TEAM > 0 || rows[i].CL_WAIT_START_DAY != null || rows[i].CL_WAIT_START_DAY2 != null) {
								if(rows[i].CL_WAIT_START_DAY == null && rows[i].CL_WAIT_START_DAY2 == null) {
									if(rows[i].BK_TEAM > 0) {
										td = $("<td style='background-color:#b1daff;'><a href='javascript:onClickDay(" + rows[i].CL_SOLAR + ")' class='MReser'>" + rows[i].DAYNUM + "<span>" + rows[i].BK_TEAM + "팀</span></a></td>");	
									} else {
										if(rows[i].BK_TOTAL > 0) {
											td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:red'>마감</span></a></td>");        
										} else {
											td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:#D5D5D5'>오픈전</span></a></td>");
										}
									}
								} else {
									var regular = "${sessionScope.msMember.msRegular}"
									var current = Number(new Date().yyyymmddhhmm());
									
									if(regular == "Y") {
										if(rows[i].CL_WAIT_START_DAY != "" || rows[i].CL_WAIT_END_DAY != "") {
											var start = Number(rows[i].CL_WAIT_START_DAY);
											var end = Number(rows[i].CL_WAIT_END_DAY);
											
											if(current >= start && current <= end) {
												td = $("<td style='background-color:#c9f29a;' onclick='onClickWeekendDay(" + rows[i].CL_SOLAR + ")'><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span>예약접수</span></a></td>");
											} else if(current > end && rows[i].BK_TEAM > 0) {
												td = $("<td style='background-color:#b1daff;'><a href='javascript:onClickDay(" + rows[i].CL_SOLAR + ")' class='MReser'>" + rows[i].DAYNUM + "<span>" + rows[i].BK_TEAM + "팀</span></a></td>");
											} else {
												if(rows[i].BK_TOTAL > 0) {
													td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:red'>마감</span></a></td>");        
												} else {
													td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:#D5D5D5'>오픈전</span></a></td>");
												}
											}
										} else {
											td = $("<td style='background-color:#b1daff;'><a href='javascript:onClickDay(" + rows[i].CL_SOLAR + ")' class='MReser'>" + rows[i].DAYNUM + "<span>" + rows[i].BK_TEAM + "팀</span></a></td>");	
										}
									} else {
										if(rows[i].CL_WAIT_START_DAY2 != "" || rows[i].CL_WAIT_END_DAY2 != "") {
											var start2 = Number(rows[i].CL_WAIT_START_DAY2);
											var end2 = Number(rows[i].CL_WAIT_END_DAY2);

											if(current >= start2 && current <= end2) {
												td = $("<td style='background-color:#c9f29a;' onclick='onClickWeekendDay(" + rows[i].CL_SOLAR + ")'><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span>예약접수</span></a></td>");
											} else if(current > end2 && rows[i].BK_TEAM > 0) {
												td = $("<td style='background-color:#b1daff;'><a href='javascript:onClickDay(" + rows[i].CL_SOLAR + ")' class='MReser'>" + rows[i].DAYNUM + "<span>" + rows[i].BK_TEAM + "팀</span></a></td>");
											} else {
												if(rows[i].BK_TOTAL > 0) {
													td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:red'>마감</span></a></td>");        
												} else {
													td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:#D5D5D5'>오픈전</span></a></td>");
												}
											}								
										} else {
											td = $("<td style='background-color:#b1daff;'><a href='javascript:onClickDay(" + rows[i].CL_SOLAR + ")' class='MReser'>" + rows[i].DAYNUM + "<span>" + rows[i].BK_TEAM + "팀</span></a></td>");
										}
									}
								}
							} else {
								if(rows[i].BK_TOTAL > 0) {
									td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:red'>마감</span></a></td>");        
								} else {
									td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:#D5D5D5'>오픈전</span></a></td>");
								}							
							}
						} 
					} else {
						td = $("<td><a href='javascript:void(0)' class='MReser'>" + rows[i].DAYNUM + "<span style='color:#D5D5D5'>휴장</span></a></td>");
					}
					
					if(rows[i].CL_BUSINESS == 2) {
						td.children('a').addClass('blue');
					} else if(rows[i].CL_BUSINESS == 3 || rows[i].CL_BUSINESS == 4) {
						td.children('a').addClass('red');
					}
					
					row.append(td);
					
					blank += 1;
										
					if(rows[i].CL_DAYDIV == 7) {
						if(!blankFlag) {
							row.appendTo(tBody); 
							blankFlag = true;							
						}
						row = $("<tr></tr>");
						blank = 0;
					}					
				}	
				
				for(i=0; i<7-blank; i++) {
					row.append($("<td></td>"));
				}	
				
				if(currentDay == rows[rows.length - 1].CL_SOLAR) {
					blankFlag = false;
				}

				if(!blankFlag) {
					row.appendTo(tBody); 
				}
			} else {
				alert(data.resultMessage);	
			}
		});	
	}
	
	function onClickDay(date) {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/m_valley/member/login.do'/>";
    		return;
		}
		
		var tomorrow = addDate(new Date().yyyymmdd(), 1).yyyymmdd();
		var hour = Number(new Date().hh());
		
		if(date.toString() == tomorrow && hour >= 17) {
			alert("인터넷 예약이 불가능한 날짜입니다.\n예약실로 문의 바랍니다.");
			return;
		}
		
		mDate = date.toString();
		 
		$("#reservationContainer").show();
		$("#waitContainer").hide();
		
		doSearch();
	}
	
	function onClickWeekendDay(date) {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/m_valley/member/login.do'/>";
    		return;
		}
		
		mDate = date.toString();
		
		var date2 = getDateFormat(mDate);
		$("#txtSelectedDate").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date2.yyyy(), date2.mm(), date2.dd(), date2.week()));

		$("#reservationContainer").hide();
		$("#waitContainer").show();
		
		doSearchWait();
		
	}
	
	function onCosTapChange(cos) {
		if(cos == '') {
			$(".MCourse_Tab #cosAll").addClass("on");
			$(".MCourse_Tab #cosA").removeClass("on");
			$(".MCourse_Tab #cosB").removeClass("on");
		} else if(cos == 'A') {
			$(".MCourse_Tab #cosAll").removeClass("on");
			$(".MCourse_Tab #cosA").addClass("on");
			$(".MCourse_Tab #cosB").removeClass("on");		
		} else if(cos == 'B') {
			$(".MCourse_Tab #cosAll").removeClass("on");
			$(".MCourse_Tab #cosA").removeClass("on");
			$(".MCourse_Tab #cosB").addClass("on");
		}
		
		mCos = cos;
		doSearch(); 
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
				
				var offset = $(".Rright_arw").offset();
		        $('html, body').animate({scrollTop : offset.top}, 400);
			}
			
			progressStop();
		});
	}
	
	function onPartTapChange(part) {
		if(part == '') {
			$(".Mtable_Tab #partAll").addClass("on1");
			$(".Mtable_Tab #part1").removeClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		} else if(part == '1') {
			$(".Mtable_Tab #partAll").removeClass("on1");
			$(".Mtable_Tab #part1").addClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		} else if(part == '2') {
			$(".Mtable_Tab #partAll").removeClass("on1");
			$(".Mtable_Tab #part1").addClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		}
		
		mPart = part;              
		doSearch(); 
	}
	
	function doSearch() {			
		if(mDate == null || mDate == '') {
			alert("날짜를 선택하세요.");
			return;
		}
		
		var date = new Date(mDate.substring(0, 4) + "-" + mDate.substring(4, 6) + "-" + mDate.substring(6, 8));
		$("#mainReserveDate").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		var sUrl = "<c:url value='/valley/reservation/getTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", mDate);
		
		if(mCos != null && mCos != "") {
			sParams += String.format("&cos={0}", mCos);
		}
		
		if(mPart != null && mPart != "") {
			sParams += String.format("&part={0}", mPart);
		}
		
		progressStart2();
		
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
					var row = $("<tr onclick='onClickReservationRow(" + i + ")'></tr>"); 

					var bkTime = rowData[i].BK_TIME;
					bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
					var bkCharge;
					if(rowData[i].BK_CHARGE != null && rowData[i].BK_CHARGE != ""){
						bkCharge = rowData[i].BK_CHARGE.split(",")	
					}
					
				    var col1 = $("<td>" + bkTime + "<br>" + rowData[i].BK_COS_NM + "</td>");
				    var col2 = $("<td>" + rowData[i].BK_ROUNDF_NM + "</td>");				    
				    var col3 = $("<td>" + globals.personCd.codeNm(rowData[i].BK_PERSON_CD) + "</td>");
				    var col4 = $("<td>" + numberWithCommas(bkCharge[1]) + "</td>");				    
				    
				    row.append(col1,col2,col3,col4).appendTo(tBody); 
				}
				
				var offset = $(".Mtable_Tab").offset();
		        $('html, body').animate({scrollTop : offset.top}, 400);
			}
			
			progressStop();
		});
	}
	
	function onClickReservationRow(i) {
		confirmPopupOpen("I", rowData[i], null);
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
				location.href = "<c:url value='/m_valley/reservation/reservationCheck.do'/>";
			}				
		});	
	}
	
</script>  

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/main.css'/>">

<div class="introPop1" id="pop1" hidden>
   <div class="bx-wrapper1">
     <ul class="slider1">
     </ul>
   </div>
   <div class="closeBox">
      	<div class="todayClose" onclick="setCookie('mobileMainPopup1', 'Y', 1); $('#pop1').hide();">오늘하루 안보기 </div>
      	<div class="introPopClose" onclick="$('#pop1').hide()">닫기</div>
   </div>
 </div>

<div id="mWrap">
    <div class="Mcontent">
        <!--모바일갤러리-->
        <div class="photoSlider" id="slideContainer">
        </div>
        <!--//모바일갤러리-->
        
        <!--달력리스트-->
        <div class="mCalendar" style="margin-top:30px;">
            <!--첫번째달력-->
            <div class="CalendarBox" id="mainCalendar1">
            <h2 id="calHeader"></h2>
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
                        <th scope="col">SUN</th>
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
						<tr><td colspan="7"><div></div></td></tr>
                    </tbody>
                </table>
                <div class="reserTBinfo"><span class="gray">■</span> 마감 <span class="skyblue">■</span> 예약  <span class="green">■</span> 주말 </div>
            </div>            
            <!--두번째달력-->
            <div class="CalendarBox" id="mainCalendar2">
            <h2 id="calHeader"></h2>
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
                        <th scope="col">SUN</th>
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
						<tr><td colspan="7"><div></div></td></tr>
					</tbody>
                </table>
                 <div class="reserTBinfo"><span class="gray">■</span> 마감 <span class="skyblue">■</span> 예약  <span class="green">■</span> 주말</div>
            </div>
        </div>
        <!--//달력리스트-->

        <!--예약contents-->
        <div class="MReser_Wrap">   
        	<div id="waitContainer">
	        	<h2><span class="Rright_arw"></span> 주말예약</h2>
	        	<table class="main_table">
	        		<caption>주말예약</caption>
						<colgroup> 
							<col width="*">
							<col width="*">
						</colgroup>
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
	        			<td class="red" id="txtSelectedDate"></td>
	        		</tr>
	        		<tr>
	        			<th>희망시간1</th>
	        			<td>
	        				<select id="selLikeTime1">
	        				</select><br>
	        				<span id="txtPartTime"></span>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>희망시간2</th>
	        			<td>
	        				<select id="selLikeTime2">
	        				</select>
	        			
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>코멘트</th>
	        			<td>
	        				<textarea wrap="hard" id="txtComment"></textarea>
	        			</td>
	        		</tr>
	        	</table>
	        	<div class="motion closeBtn" onclick="actionWaitReservation()">신청</div>
	        </div>    
	        <!--회원권 번호입력-->
	        <%-- <div id="membershipContainer">
	        	<h2><span class="Rright_arw"></span> 회원권 번호입력</h2>
			
				<div class="member_enter">
					<div class="gradLine">그라데이션바</div>
					<h1><span><img src="<c:url value='/images/m_valley/main/icon.jpg'/>"></span>회원권 번호 입력</h1>
					<input type="text" maxlength="" name="회원권번호입력" id="txtMembership">
					<h3>부여받으신 회원권 번호를 입력해 주세요.<br><strong>회원권 번호 분실시 고객센터로 문의 주시기 바랍니다.</strong></h3>
					<div class="motion closeBtn" onclick="doCheckMembership()">확 인</div>
				</div> 
	        </div> --%>			
            
	        <div id="reservationContainer">
	            <h2><span class="Rright_arw"></span> 예약시간</h2>
	            <p>&bull; 예약일자 : <span id="mainReserveDate"></span></p>
	            
	            <!--전체코스-->
				<div class="CTab1">
					<div class="MCourse_Tab">
						<ul>
							<li class="on" onclick="onCosTapChange('')" id="cosAll">전체코스</li>
							<li onclick="onCosTapChange('A')" id="cosA">서원코스</li>
							<li onclick="onCosTapChange('B')" id="cosB">밸리코스</li>
						</ul>
						<div class="TTab1">
							<div class="Mtable_Tab">
								<ul>
									<li class="on1" onclick="onPartTapChange('')" id="partAll">전체</li>
									<li onclick="onPartTapChange('1')" id="part1">1부</li>
									<li onclick="onPartTapChange('2')" id="part2">2부</li>
								</ul>
								<div>
									<table class="MainTable" id="time-table">
										<caption>전체코스</caption>
										<colgroup> 
											<col width="*">
											<col width="*">
											<col width="*">
											<col width="*">
										</colgroup>
										<tr>
											<th scope="col">시간</th>
											<th scope="col">홀</th>
											<th scope="col">인원</th>
											<th scope="col">동반자그린피</th>
										</tr>
										<tbody id="time-grid">
										</tbody>
										<tr>
											<td colspan="4" class="td_merge"><span>※ 당일 예약은 전화로만 가능하며 취소팀 발생시 예약 가능합니다.</span></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>	        
	        </div>
		</div>
        <!--//예약contents-->
    </div>
   <!--팝업-->
<%--     <div class="introPop">
        <a href="javascript:void(0)" onclick="$('.introPop').hide()">
        <img src="<c:url value='/images/m_valley/191231_mv.jpg'/>">
        </a>
    </div> --%>
<jsp:include page="../m_valley/include/footer.jsp" flush="true" />
</div>   

</body>
</html>