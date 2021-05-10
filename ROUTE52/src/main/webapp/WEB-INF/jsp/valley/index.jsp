<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
<meta name="format-detection" content="telephone=no, address=no, email=no"/>
<meta name="title" content="서원밸리">
<meta name="author" content="서원밸리">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents Copyright©seowonvalley">
<meta property="og:type" content="mobile">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<title>서원밸리</title>
<link rel="icon" href="<c:url value='/images/valley/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/valley/favicon.ico'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/import.css'/>">
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.3.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/valley/common.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>  
<script type="text/javascript">

	$(document).ready(function() { 
		initWeather();
		
		var bUri = window.location.pathname.split("/");
		var exception = bUri[bUri.length - 1];
		
		for(i=0; i<exceptionViewList.length; i++) {
			if(exception == exceptionViewList[i]){
				return;
			}
		}
		
		var imsiYn = "${sessionScope.msMember.imsiYn}";
		var agreeYn = "${sessionScope.msMember.agreeYn}";
		
		if(agreeYn != "" && agreeYn == "N") {
	    	alert("이용약관 동의 후 이용 부탁드립니다.");
			location.href = "<c:url value='/valley/member/agree.do'/>";		
			return;
		}
		
		if(imsiYn != "" && imsiYn == "Y") {
	    	alert("아이디 변경 후 이용 부탁드립니다.");
			location.href = "<c:url value='/valley/member/memModify.do'/>";		
			return;			
		}
		
		var mainCodiv = "${sessionScope.msMember.msMainCoDiv}";
		
		if(mainCodiv != "" && mainCodiv == "65") {
			var logoutUrl = "<c:url value='/common/changeAccout.do'/>";
			var logoutParams = String.format("coDiv={0}", "61");
			
			mAjax(logoutUrl, logoutParams, function(data){
				if(data.resultCode == "0000") {
					alert("밸리계정으로 변경되었습니다.");
				} else {
					alert("밸리에서 사용할 수 없는 계정입니다.");
				}
				location.reload();
			});	
			
			return;
		}
		
		doSearchPopup();
		
		/* popup 팝업 */
		/* var url="<c:url value='/popup/20190319.do'/>";
        window.open(url, "", "width=515,height=480"); */
	});
	
	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "61");
		
		mAjax(sUrl, sParams, function(data) { 
			if(data.resultCode = "0000") {    
				var bucket = "valley"
				
				var rows = data.rows.list1;
				
				var template = "";
				template += "<div id='main_popup{0}' class='main_popup' style='position: fixed; z-index:10000000; top:{2}px; left:{1}px; display: none;'>";
				template += "	<a href='{3}'><img src='{4}'></a>";
				template += "	<div class='popup_bottom'>";
				template += "		<a href='javascript:closeMainPopupToday(\"main_popup{0}\")'>오늘하루 그만보기</a>";
				template += "		<a class='pull-right' href='javascript:closeMainPopup(\"main_popup{0}\");'>닫기</a>";
				template += "	</div>";
				template += "</div>";
				    
				for(i=0; i<rows.length; i++) {
					var idx = rows[i].HP_IDX;
					var fileName = rows[i].HP_FILE_NAME;    
					var originName = rows[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName) ;
					var pointX = rows[i].HP_POINT_X;
					var pointY = rows[i].HP_POINT_Y;
					var link = rows[i].HP_LINK;
					
					$("#popupContainer").append(String.format(template, idx, pointX, pointY, link, image));
					
					openMainPopup("main_popup" + idx);
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function openMainPopup(id) {
		if(getCookie(id) != "Y"){
			$("#" + id).show('fade');
		}
	}
	
	function closeMainPopupToday(id){	             
 		setCookie(id, 'Y', 1);
 		$("#" + id).hide('fade');
 	}
	
	function closeMainPopup(id){	      
 		$("#" + id).hide('fade');
 	}
	
	function onPopupClicked() {
		location.href="<c:url value='/valley/board/list.do?bbsType=1'/>";
	}

	var mDate;
	var mYear;
	var mMonth;
	var mDay;
	var selDate;
	var selCos;
	var selType;

	function onLoadPage() {
		mDate = new Date();
		mYear = mDate.yyyy();
		mMonth = mDate.mm();
		
		$("#show_hide").empty();
		$("#show_hide").append(String.format("{0}년 {1}월 {2}일 &#40;{3}&#41;", mDate.yyyy(), mDate.mm(), mDate.dd(), mDate.week()));
		 
		if("${sessionScope.msMember.msNum}" == "") {
			$("#show_hide").unbind("click");
		} else {
			initCalendar(mYear, mMonth);			
		}
		
		onLoadBoard();
	}

	function actionLogout() {
		var sUrl = "<c:url value='/valley/member/actionLogout.do'/>";
		
		mAjax(sUrl, null, function(data){
			if(data.resultCode == "0000") {
				alert("로그아웃 되었습니다."); 
				location.reload();				
			} else {
				alert(data.resultMessage);
			}
		})
	}
	
	function onLoadBoard() {
		var sUrl = "<c:url value='/common/getMainNewsData.do'/>";
		var sParams = String.format("coDiv={0}", "61");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var rows = data.rows;
				
				for(i=0; i<rows.length; i++) {
					var idx = rows[i].IDX;
					var bbsType = rows[i].BBSTYPE;
					var title = rows[i].TITLE;
					var content = rows[i].CONTENT;
					var regDate = rows[i].REGDATE;
					var upFileName = rows[i].UP_FILENAME;
					var link = String.format("<c:url value='/valley/board/view.do?bbsType={0}&idx={1}'/>", bbsType, idx);
					var link2 = String.format("<c:url value='/valley/board/list.do?bbsType={0}'/>", bbsType);
					
					if(upFileName != null && upFileName != "") { 
						upFileName = "<c:url value='/common/downloadImage.do?division=valley&folderName=" + regDate + "&fileName=" + upFileName + "'/>";
					} else {
						upFileName = "<c:url value='/images/valley/defaultImage.jpg'/>";
					}
					
					regDate = regDate.substring(0, 4) + "-" + regDate.substring(4, 6) + "-" + regDate.substring(6, 8);
					
					if(rows[i].DIVISION == "1") {
						var container = $("#boardRightContainer");
						
						container.empty();
						
						var tmp = "";
						tmp += "<h2>NEWS<span><a href='{0}'><img src='<c:url value='/images/valley/main/plus.jpg'/>'></a></span></h2>";
						tmp += "<strong>공지사항</strong>";
						tmp += "<h3><a href='{1}'>{2}</a></h3>";
						tmp += "<hr>";
						tmp += "<h4><a href='{3}'>{4}</a></h4>";
						tmp += "<h5>{5}</h5>";
						tmp += "<div class='vline_l'>라인</div>";

						if(content.length > 105) {
							content = content.substring(0, 105) + "...";
						}
						
						tmp = String.format(tmp, link2, link, title, link, content, regDate);
						
						container.append(tmp);
					}
					
					if(rows[i].DIVISION == "2") {
						var container = $("#boardLeftContainer");
						
						container.empty();
						
						var tmp = "";
						tmp += "<div class='vline_r'>라인</div>";
						tmp += "<p><img src='{0}'></p>";
						tmp += "<h2><a href='{1}'>{2}</a></h2>";
						tmp += "<h3><a href='{3}'>{4}</a></h3>";
						tmp += "<h4>{5}<span><a href='{6}'>More &gt;</a></span></h4>";

						if(content.length > 60) {
							content = content.substring(0, 60) + "...";
						}
						
						tmp = String.format(tmp, upFileName, link, title, link, content, regDate, link2);
						
						container.append(tmp);
					}
				}
			}
		});
	}
	
	function initCalendar(year, month) {
		var selector = "#monthBox";
		
		var sUrl = "<c:url value='/valley/reservation/getCalendar.do'/>";
		var sParams = "";
		
		sParams += String.format("&selYM={0}", year + month);	
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$(selector + " #calHeader").html(year + " / " + month);
				
				var currentDay = mDate.yyyymmdd();
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
						if(rows[i].BK_TEAM > 0 || rows[i].CL_WAIT_START_DAY != null || rows[i].CL_WAIT_START_DAY2 != null) {
							if(rows[i].CL_WAIT_START_DAY != null || rows[i].CL_WAIT_START_DAY2 != null) {
								var regular = "${sessionScope.msMember.msRegular}"
								var current = Number(new Date().yyyymmddhhmm());
								
								if(regular == "Y") {
									if(rows[i].CL_WAIT_START_DAY != "" || rows[i].CL_WAIT_END_DAY != "") {
										var start = Number(rows[i].CL_WAIT_START_DAY);
										var end = Number(rows[i].CL_WAIT_END_DAY);
										
										if(current >= start && current <= end) {
											td.addClass('weekend');
											td.on('click', function() {
												mDay = $(this.innerHTML).html().trim();
												onClickDay("weekend", mYear + "-" + mMonth + "-"  + mDay);
											});	
										} else if(current > end && rows[i].BK_TEAM > 0) {
											td.addClass('possible');
											td.on('click', function() {
												mDay = $(this.innerHTML).html().trim();
												onClickDay("weekday", mYear + "-" + mMonth + "-"  + mDay);
											});	
										} else {
											td.addClass('impossible');	
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
												mDay = $(this.innerHTML).html().trim();
												onClickDay("weekend", mYear + "-" + mMonth + "-"  + mDay);
											});	
										} else if(current > end2 && rows[i].BK_TEAM > 0) {
											td.addClass('possible');
											td.on('click', function() {
												mDay = $(this.innerHTML).html().trim();
												onClickDay("weekday", mYear + "-" + mMonth + "-"  + mDay);
											});	
										} else {
											td.addClass('impossible');	
										}								
									} else {
										td.addClass('possible');	
									}
								}
							} else {
								if(rows[i].BK_TEAM > 0) {
									td.addClass('possible');
									td.on('click', function() {
										mDay = $(this.innerHTML).html().trim();
										onClickDay("weekday", mYear + "-" + mMonth + "-"  + mDay);
									});
								} else {
									td.addClass('impossible');		
								}
							}
						} else {
							td.addClass('impossible');							
						}
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
	
	function nextMonth() {
		if(mMonth == "12") {
			mYear += 1;
			mMonth = "01";
		} else {
			mMonth = Number(mMonth) + 1;
			mMonth = (mMonth>9 ? '' : '0') + mMonth;
		}
		
		initCalendar(mYear, mMonth);
	}
	
	function prevMonth() {
		if(mMonth == "01") {
			mYear -= 1;
			mMonth = "11";
		} else {
			mMonth = Number(mMonth) - 1;
			mMonth = (mMonth>9 ? '' : '0') + mMonth;
		}
		
		initCalendar(mYear, mMonth);		
	}
	
	function onClickDay(type, day) {
		var tomorrow = addDate(new Date().yyyymmdd(), 1).yyyymmdd();
		var hour = Number(new Date().hh());
		
		if(new Date(day).yyyymmdd() == tomorrow && hour >= 17) {
			alert("인터넷 예약이 불가능한 날짜입니다.\n예약실로 문의 바랍니다.");
			return;
		}
		
		$(".monthBox").slideToggle();
		
		selDate = new Date(day);
		selType = type;
		
		$("#show_hide").empty();
		$("#show_hide").append(String.format("{0}년 {1}월 {2}일 &#40;{3}&#41;", selDate.yyyy(), selDate.mm(), selDate.dd(), selDate.week()));
	}
	
	function doSearch() {		
		if("${sessionScope.msMember.msId}" == "") {
			alert("로그인 후 이용 가능합니다.");
			
			location.href = "<c:url value='/valley/member/login.do'/>";
			return;
		}
		
		if(selDate == null) {
			alert("날짜를 선택하세요.");	
			return;
		}
		
		var sUrl = "<c:url value='/valley/reservation/reservation.do'/>";
		var sParams = "";
		
		sParams += "?action=search";
		sParams += "&date=" + selDate.yyyymmdd();
		sParams += "&type=" + selType;
		
		if(selCos != null && selCos != "") {
			sParams += "&cos=" + selCos;
		}
		
		location.href = sUrl + sParams;
	}
	
	function onSelectCos(cos) {
		selCos = cos;
		$("#txtSelCos").empty();
		$("#txtSelCos").append(String.format("{0}코스가 선택되었습니다.", cos == "" ? "전체" : cos == "A" ? "서원" : "밸리"));
	}
	
	function locationMyZone() {
		var sUrl = "<c:url value='/valley/reservation/reservationCheck.do'/>";
		
		location.href = sUrl;
	}
	
	function initWeather() {
		var sUrl = "<c:url value='/common/getWeather.do'/>";
		
		mAjax2(sUrl, null, function(data) {
			if(data.resultCode == "0000") {
				var temp = data.rows.temp;
				var wfKor = data.rows.wfKor;
				var wfEn = data.rows.wfEn;
				 
				var img = "<c:url value='/images/valley/wt_b.png'/>";
				
				$("#txtWeather").html(String.format("{0}˚ {1}", temp, wfKor)); 
				
				if(wfEn == "Clear") {
					img = "<c:url value='/images/valley/wt_s.png'/>";
				} else if(wfEn == "Partly Cloudy") {
					img = "<c:url value='/images/valley/wt_pc.png'/>";
				} else if(wfEn == "Mostly Cloudy") {
					img = "<c:url value='/images/valley/wt_mc.png'/>";
				} else if(wfEn == "Cloudy") {
					img = "<c:url value='/images/valley/wt_c.png'/>";
				} else if(wfEn == "Rain") {
					img = "<c:url value='/images/valley/wt_r.png'/>";
				} else if(wfEn == "Snow/Rain") {
					img = "<c:url value='/images/valley/wt_ras.png'/>";
				} else if(wfEn == "Snow") {
					img = "<c:url value='/images/valley/wt_sn.png'/>";
				}
				
				$("#imgWeather").attr("src", img);
			}
		});
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="onLoadPage()">

	<div id="popupContainer"></div>

	<div id="Mheader">

	    <div class="tobBox" id="home">
	        <div class="top">
				<a href="<c:url value='/valley/board/list.do?bbsType=1'/>">공지사항</a>
				<a href="<c:url value='/hills/champion/champion.do'/>">대회안내</a>
				<a href="<c:url value='/hills/academi/rangeFare.do'/>">드라이빙레인지</a>
				<a href="http://seowonatrium.co.kr/" target="_blank">서원아트리움</a>
				<a href="<c:url value='/hills/index.do'/>">서원힐스</a>
	        </div>
	    </div>
	
	    <div class="headerBox">
	        <a href="javascript:void(0)" class="gnbBtn gnbBox" id="gnb"><img src="<c:url value='/images/valley/gnbBtn.png'/>" alt="gnb메뉴"></a>
	        <div class="logoBox">
	            <a href="<c:url value='/valley/index.do'/>"><img src="<c:url value='/images/valley/logo.png'/>" alt="서원힐스 로고"></a>
	        </div>
	        
	        <c:if test="${empty sessionScope.msMember.msId}">
				<a href="<c:url value='/valley/member/login.do'/>" class="topLogin"> <img src="<c:url value='/images/valley/topLogin.png'/>" alt="로그인"><span>로그인 / 회원가입</span></a>
			</c:if>
			
			<a href="<c:url value='/valley/map/map.do'/>" class="topLocation"><img src="<c:url value='/images/valley/topLocation.png'/>" alt="오시는길"><span>오시는길</span></a>
			
			<div class="topWheather" onclick="location.href='<c:url value='/valley/contents/weather.do'/>'">
				<img src="<c:url value='/images/valley/wt_b.png'/>" id="imgWeather" alt="날씨">
				<span>오늘의 날씨 </span><span id="txtWeather"></span>
			</div>
			
			<c:if test="${!empty sessionScope.msMember.msId}">
				<a href="javascript:actionLogout()" class="topLogin" style="margin-right: 78px"> <img src="<c:url value='/images/valley/logout.png'/>" alt="로그아웃"><span>로그아웃</span></a>
				<a href="javascript:locationMyZone()" class="topLogin"> <img src="<c:url value='/images/valley/topLogin.png'/>" alt="마이페이지"><span>마이존</span></a>
			</c:if>
			
	    </div>
	    <div class="headerLine"></div>	 
	
	   	<jsp:include page="../valley/include/topmenu.jsp" flush="true" />
		    
	</div>
    
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/main.css?v=1'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/motion.css'/>">
<!-- 메인 배경 줌아웃 zoomOut -->   
<link href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css" rel="stylesheet"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js"></script>
    
<div id="main_wrap">
    <!--sector_1-->
    <div class="mVisual" >
        <script type="text/javascript">
        $(document).ready(function() {
            $('.hero-slider').slick({
                dots: true,
                infinite: true,
                speed: 3000,
                dots: false,
                arrows: false,
                autoplay: true,
                autoplaySpeed: 8000,
                fade: true,
                pauseOnHover: false,
                pauseOnFocus: false
            });
        });
        </script>    

        <div class="hero-slider">
            <div class="columns">
                <div class="hero-image hero-bg">
                    <img src="<c:url value='/images/valley/main/1.jpg'/>" alt="">
                </div>
            </div>
            <div class="columns">
                <div class="hero-image hero-bg">
                    <img src="<c:url value='/images/valley/main/2.jpg'/>" alt="">
                </div>
            </div>
            <div class="columns">
                <div class="hero-image hero-bg">
                    <img src="<c:url value='/images/valley/main/3.jpg'/>" alt="">
                </div>
            </div>
        </div>
		<div class="mVisualText">
            <h2>서원밸리는 故鄕입니다</h2>            
        </div>
        
        <!--실시간예약-->
        <div class="mainTopReser">
            <div class="reserBg"></div>
            <div class="topReserBox">
                <div class="topReseWrap">
                    <h3><strong>서원밸리 실시간 예약</strong>코스예약날짜 시간을 꼭 다시한번 확인해주세요.</h3>
                    <div class="topReser">
                    <span><img src="<c:url value='/images/valley/main/maincal.jpg'/>"></span>
                    <div class="SelectWrap">
                        <!--달력선택-->
                        <div class="monthSelect" id="show_hide"></div>
                            <!--미니달력시작-->
                            <div class="monthBox" id="monthBox">
                                  <div class="monthChoice">
                                    <span class="monthBtn"><a href="javascript:prevMonth()"><img src="<c:url value='/images/valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                                    <span class="month" id="calHeader"></span>
                                    <span class="monthBtn"><a href="javascript:nextMonth()"><img src="<c:url value='/images/valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
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
                                    <tbody>
                                    	<tr>
		                                    <th scope="col" class="sun">SUN</th>
		                                    <th scope="col">MON</th>
		                                    <th scope="col">TUE</th>
		                                    <th scope="col">WEN</th>
		                                    <th scope="col">THU</th>
		                                    <th scope="col">FRI</th>
		                                    <th scope="col">SAT</th>
	                                    </tr>
                                    </tbody>
                                    <tbody id="calendar-body">                                      
                                      	<tr><td colspan="7"><div></div></td></tr>
										<tr><td colspan="7"><div></div></td></tr>
										<tr><td colspan="7"><div></div></td></tr>
										<tr><td colspan="7"><div></div></td></tr>
										<tr><td colspan="7"><div></div></td></tr> 
										<tr><td colspan="7"><div></div></td></tr>
                                    </tbody>
                                  </table>

                                  <div class="resChoice">
                                    <span> <img src="<c:url value='/images/valley/dot2_blue.png'/>" alt=""> 예약가능</span>
                                    <span> <img src="<c:url value='/images/valley/dot2_red.png'/>" alt=""> 예약불가능</span>
                                    <span> <img src="<c:url value='/images/valley/dot2_green.png'/>" alt=""> 주말예약</span>
                                  </div>
                            </div>
                            <!--//미니달력 끝-->
                        
                        <!--코스선택-->
                        <div class="divSelectWrap">
                            <div class="divSelectText" id="txtSelCos">전체코스가 선택되었습니다.</div>
                            <ul class="selectboxUl">
                            	<li onclick="onSelectCos('')">전체코스</li>
                                <li onclick="onSelectCos('A')">서원코스</li>
                                <li onclick="onSelectCos('B')">밸리코스</li>
                            </ul>
                        </div>
                    </div>
                    <a href="javascript:doSearch()" class="mReserbtn btnBlue" id="home1">검색하기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//sector_1-->

    <!--sector_2-->
    <!--middle_menu-->
    <div class="floating_menu">
        <div class="MainMenu">
                <div class="navbar-wrapper">
                    <div class="navbarBox">
                        <ul class="nav navbar-nav">
                            <li class="menuItem active"><a href="#UserGuide" class="f_scroll">이용안내</a></li>
                            <li class="menuItem"><a href="#FacilityGuide" class="f_scroll">시설안내</a></li>
                            <li class="menuItem"><a href="#CourseGuide" class="f_scroll">코스안내</a></li>
                            <li class="menuItem"><a href="#GreenConsert" class="f_scroll">그린콘서트</a></li>
                            <li class="menuItem"><a href="#InfoGuide" class="f_scroll">정보안내</a></li>
                        </ul>
                    </div>
                </div>
            
                <!--이용안내-->
                <div id="UserGuide">
                    <div class="GuideText">
                        <h2 data-scroll="toggle(.fromTopIn, .fromTopOut)"><span>VALLEY</span> Country Club<br>이용안내</h2>
                        <h3 data-scroll="toggle(.fromBottomIn, .fromBottomOut)">고향의 정이 느껴지는 명문 회원제 서원밸리</h3>
                    </div>
                    
                    <div class="GuideBox">
                        
                        <div class="ugimg1" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/valley/main/ugimg1_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <p>예약이 어려우신가요?<br>가이드로 보다 쉽게 알려드립니다</p>
                                        </div>
                                        <a href="<c:url value='/valley/reservation/reservationGuide.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>
                            <div class="ugimgTitle">예약 가이드</div>
                            <div class="ugIcon"><img src="<c:url value='/images/valley/main/icon1.png'/>"></div>
                        </div>
                        
                        <div class="ugimg2" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/valley/main/ugimg2_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <p>서원밸리 이용요금<br>정책을 확인하실 수 있습니다</p>
                                        </div>
                                        <a href="<c:url value='/valley/guide/charge.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>
                            <div class="ugimgTitle">이용요금</div>
                            <div class="ugIcon"><img src="<c:url value='/images/valley/main/icon1.png'/>"></div>
                        </div>
                        
                        <div class="ugimg3" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/valley/main/ugimg3_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <p>즐거운 라운딩을<br>위한 꼭! 지켜야할 에티켓</p>
                                        </div>
                                        <a href="<c:url value='/valley/guide/etiquette.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>
                            <div class="ugimgTitle">골프 에티켓</div>
                            <div class="ugIcon"><img src="<c:url value='/images/valley/main/icon3.png'/>"></div>
                        </div>
                        
                        <div class="ugimg4" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/valley/main/ugimg4_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <p>즐거운 라운딩을<br>위한 꼭! 지켜야할 에티켓</p>
                                        </div>
                                        <a href="<c:url value='/valley/guide/localRule.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>
                            <div class="ugimgTitle">로컬룰</div>
                            <div class="ugIcon"><img src="<c:url value='/images/valley/main/icon4.png'/>"></div>
                        </div>
                    </div>
                </div>           
                <!--//이용안내-->
            
                <!--시설안내-->
                <div id="FacilityGuide">
                    <div class="FacilityBox">
                        <div class="leftText"></div>
                        <div class="rightGuide">
                            <div class="article" onclick="location.href='<c:url value='/valley/facil/facil05.do'/>'">
                                <span><img src="<c:url value='/images/valley/main/icon5.png'/>"></span>
                                <h2>밸리대식당</h2>
                                <h4>특별한 식사가 가능한 레스토랑</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/valley/facil/facil02.do'/>'">
                                <span><img src="<c:url value='/images/valley/main/icon6.png'/>"></span>
                                <h2>스타트하우스</h2>
                                <h4>회원님들의 행복쉼터</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/valley/facil/facil04.do'/>'">
                                <span><img src="<c:url value='/images/valley/main/icon8.png'/>"></span>
                                <h2>그늘집</h2>
                                <h4>잠깐의 풍경 감상과 추억만들기</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/valley/facil/facil06.do'/>'">
                                <span><img src="<c:url value='/images/valley/main/icon9.png'/>"></span>
                                <h2>연회장</h2>
                                <h4>특별한 고객과 함께 특별한 식사를</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/valley/facil/facil03.do'/>'">
                                <span><img src="<c:url value='/images/valley/main/icon7.png'/>"></span>
                                <h2>프로샵</h2>
                                <h4>골프 브랜드의 다양함을 입어라</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="articleText"></div>
                        </div>
                    </div>
                </div>
                <!--//시설안내-->
            
                <!--코스안내-->
                <div id="CourseGuide" >                    
                    <div class="accordion">
                        <ul>
                            <li>
                                <div class="overBtn"><img src="<c:url value='/images/valley/main/overBtn1.png'/>" id="swcImg" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"></div>
                                <div class="acd">
                                    <div class="link">
                                    <h2><img src="<c:url value='/images/valley/main/overImg1.png'/>"></h2>
                                    </div>
                                </div>
                                <div class="Cbutton">
                                    <div class="Ceffect"></div>
                                    <a href="<c:url value='/valley/course/course_seowon.do'/>"> 코스공략보기 &lt; </a>
                                </div>
                            </li>
                            <li>
                                <div class="overBtn2"><img src="<c:url value='/images/valley/main/overBtn2.png'/>" id="swcImg2" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"></div>
                                <div class="acd">
                                    <div class="link">
                                    <h2><img src="<c:url value='/images/valley/main/overImg2.png'/>"></h2>
                                    </div>
                                </div>
                                <div class="Cbutton2">
                                    <div class="Ceffect2"></div>
                                    <a href="<c:url value='/valley/course/course_valley.do'/>"> 코스공략보기 &lt; </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--//코스안내-->
                
                <!--그린콘서트-->
                <div id="GreenConsert">
                    <div class="ConsertText">
                        <h4 data-scroll="toggle(.fromLeftIn, .fromLeftOut)">'문화코드 1번지' </h4>
                        <h2 data-scroll="toggle(.fromLeftIn, .fromLeftOut)">골프장에서 열리는<br>최초의 최대 규모의 <br><span>'글로벌 자선 콘서트'</span></h2>
                        <div class="movieConsert">
                        	<video autoplay="autoplay" muted="true" loop="loop" id="green" width="480" height="300">
								<source src="<c:url value='/images/valley/main/greenconsert.webm'/>" type="video/webm">
						        <source src="<c:url value='/images/valley/main/greenconsert.mp4'/>" type="video/mp4">               
						    </video>						                            
                        </div>  
                        <div class="Cbutton3" data-scroll="toggle(.fromRightIn, .fromRightOut)">
                            <div class="Ceffect3"> </div>
                            <a href="http://www.greenconcert.co.kr/" target="_blank"> 자세히보기 </a>
                        </div>
                    </div>
                </div>
                <!--//그린콘서트-->
            
                <!--정보안내-->
                <div id="InfoGuide">
                    <div class="IFGWrap">
                        <h2 class="title" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">course capture<span>언제나 고객이 최우선</span></h2>
                        <div class="IFGBox">
                            <div class="bar"></div>
                            <!--언론보도-->
                            <div class="info_left" id="boardLeftContainer">
                                <p><img src=""></p>
                                <h2><a href="javascript:void(0)"></a></h2>
                                <h3><a href="javascript:void(0)"></a></h3>
                                <h4><span><a href="javascript:void(0)">More &gt;</a></span></h4>
                            </div>
                            <!--아이콘링크-->
                            <div class="info_center">
                                <ul>
                                    <li><a href="<c:url value='/valley/course/courseIntro.do'/>"><p><img src="<c:url value='/images/valley/main/icon10.png'/>"></p>코스소개</a></li>
                                    <li><a href="<c:url value='/valley/reservation/reservationCheck.do'/>"><p><img src="<c:url value='/images/valley/main/icon11.png'/>"></p>예약확인</a></li>
                                    <li><a href="<c:url value='/valley/guide/charge.do'/>"><p><img src="<c:url value='/images/valley/main/icon12.png'/>"></p>요금안내</a></li>
                                    <li><a href="javascript:alert('준비중입니다.');"><p><img src="<c:url value='/images/valley/main/icon13.png'/>"></p>고객의소리</a></li>
                                    <li><a href="javascript:alert('준비중입니다.');"><p><img src="<c:url value='/images/valley/main/icon14.png'/>"></p>제휴안내</a></li>
                                    <li><a href="<c:url value='/valley/map/map.do'/>"><p><img src="<c:url value='/images/valley/main/icon15.png'/>"></p>오시는길</a></li>
                                </ul>
                            </div>
                            <!--공지사항-->
                            <div class="info_right" id="boardRightContainer">
                                <h2>NEWS<span><a href="javascript:alert('준비중입니다.');"><img src="<c:url value='/images/valley/main/plus.jpg'/>"></a></span></h2>
                                <strong>공지사항</strong>
                                <h3><a href="javascript:void(0)"></a></h3>
                                <hr>
                                <h4><a href="javascript:void(0)"></a></h4>
                                <h5></h5>
                            </div>
                        </div>
                        <!--전화안내-->
                        <div class="IFGBox2">
                            <div class="IFG_left">
                                <h3>customer center</h3>
                                <h4>문의하신 내용을 친절히 상담해 드립니다.</h4>
                            </div>
                            <div class="IFG_right">
                                <h3>Tel. 031-940-9400</h3>
                                <h4>문의하신 내용을 친절히 상담해 드립니다.<span>전화</span></h4>
                                
                            </div>
                        </div>                      
                    </div>            
                </div>
                <!--//정보안내-->
                

<!--팝업-->
<!-- 코로나 공지
<div id="main_popup" class="main_popup" style="position: fixed; z-index:10000000; top:0px; left:0; display: none;">
	<a href="/valley/board/view.do?bbsType=1&idx=19">
		 <img src="<c:url value='/images/valley/200305_v.jpg'/>">  
	</a> 
	<div class="popup_bottom">
		<a href="javascript:closePopupNotToday()">오늘하루 그만보기</a>
		<a class="pull-right" href="javascript:closeMainPopup();">닫기</a>
	</div>
</div>
-->
 
<%-- <div id="main_popup" class="main_popup" style="position: fixed; z-index:10000000; top:0px; left:0; display: none;">
	<img src="<c:url value='/images/intro/kr_400.jpg'/>">
	<div class="popup_bottom">
		<a href="javascript:closePopupNotToday()">오늘하루 그만보기</a>
		<a class="pull-right" href="javascript:closeMainPopup();">닫기</a>
	</div>
</div> --%>
 

<%-- <div id="main_popup1" class="main_popup1" style="position: fixed; z-index:1000; top:0px; left:500px; display: none;">
	<img src="<c:url value='/images/valley/191231_v.jpg'/>">    
	<div class="popup_bottom">
		<a href="javascript:closePopupNotToday1()">오늘하루 그만보기</a>
		<a class="pull-right" href="javascript:closeMainPopup1();">닫기</a>
	</div>
</div> --%>
 <script>
 /*팝업쿠키생성*/
 /* if(getCookie("notToday2")!="Y"){
 	$("#main_popup").show('fade');
 }if(getCookie("notToday3")!="Y"){
 	$("#main_popup1").show('fade');
 }

 function closePopupNotToday(){	             
 		setCookie('notToday2','Y', 1);
 		$("#main_popup").hide('fade');
 }
 function closePopupNotToday1(){	             
		setCookie('notToday3','Y', 1);
		$("#main_popup1").hide('fade');
}
 function setCookie(name, value, expiredays) {
 	var today = new Date();
 		today.setDate(today.getDate() + expiredays);

 		document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
 }

 function getCookie(name) 
 { 
 	var cName = name + "="; 
 	var x = 0; 
 	while ( x <= document.cookie.length ) 
 	{ 
 		var y = (x+cName.length); 
 		if ( document.cookie.substring( x, y ) == cName ) 
 		{ 
 			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
 				endOfCookie = document.cookie.length;
 			return unescape( document.cookie.substring( y, endOfCookie ) ); 
 		} 
 		x = document.cookie.indexOf( " ", x ) + 1; 
 		if ( x == 0 ) 
 			break; 
 	} 
 	return ""; 
 }
 function closeMainPopup(){
 	$("#main_popup").hide('fade');
 }
 function closeMainPopup1(){
	$("#main_popup1").hide('fade');
} */
  
 </script>           
                <script src="<c:url value='/js/valley/stickUp.js'/>"></script>
                <script type="text/javascript">
                  jQuery(function($) {
                    $(document).ready( function() {
                      $('.navbar-wrapper').stickUp({
                                    parts: {
                                        0:'UserGuide',
                                        1:'FacilityGuide',
                                        2:'CourseGuide',
                                        3:'GreenConsert',
                                        4:'InfoGuide'
                                    },
                                    itemClass: 'menuItem',
                                    itemHover: 'active',
                                    topMargin: 'auto'
                                  });
                    });
                  });
                </script>
                <!--textmotion-->
                <script src="<c:url value='/js/valley/ScrollTrigger.js'/>"></script>
                <script>
                    window.counter = function() {
                        // this refers to the html element with the data-scroll-showCallback tag
                        var span = this.querySelector('span');
                        var current = parseInt(span.textContent);

                        span.textContent = current + 1;
                    };

                    document.addEventListener('DOMContentLoaded', function(){
                      var trigger = new ScrollTrigger({
                          addHeight: true
                      });
                    });
                </script>
                
	        </div>  
	    </div>
	    
	    <!--family_site-->
	    <div id="sidebar-menu">
	        <div class="fixPannel">
	            <div class="pannelBtn" onclick="openNav()">
	            	<h1><img src="<c:url value='/images/valley/main/arw1.jpg'/>" ></h1>
	                <p><img src="<c:url value='/images/valley/main/imgPannel.jpg'/>" ></p>
	                <strong>Family SITE</strong>
	                <h4>서원 관련 사이트 이동</h4>
	            </div>
	        </div>
	        <div class="sidenav_wrap">
	            <div id="mySidenav" class="sidenav">
	                <%-- <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><img src="<c:url value='/images/valley/main/x.jpg'/>"></a> --%>
	                <h1><a href="javascript:void(0)" class="" onclick="closeNav()"><img src="<c:url value='/images/valley/main/arw1.jpg'/>" ></a></h1>
	                <strong>Family SITE</strong>
	                <div class="sideList">
	                    <ul>
	                    	<li class="sideBn_home"><a href="<c:url value='../'/>" target="_blank"><span>홈</span>HOME</a></li>
	                        <li>
	                            <div class="fmlbn"> 
	                                <a href="<c:url value='/hills/index.do'/>" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle_over.jpg'/>" class="first_bn">
	                                <img src="<c:url value='/images/valley/main/sideTitle.jpg'/>" class="second_bn"></a>
	                            </div>
	                        </li>
	                        <li>
	                        	<div class="fmlbn">
	                                <a href="http://seowonatrium.co.kr/" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle1_over.jpg'/>" class="first_bn">
	                                <img src="<c:url value='/images/valley/main/sideTitle1.jpg'/>" class="second_bn"></a>
	                            </div>
	                        </li>
	                        <li>
	                        	<div class="fmlbn">
	                                <a href="<c:url value='/hills/academi/academi.do'/>" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle2_over.jpg'/>" class="first_bn">
	                                <img src="<c:url value='/images/valley/main/sideTitle2.jpg'/>" class="second_bn"></a>
	                            </div>
	                      	</li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	</div>
	
<jsp:include page="../valley/include/footer-quick.jsp" flush="true" />
<jsp:include page="../valley/include/footer.jsp" flush="true" />
</body>
</html>