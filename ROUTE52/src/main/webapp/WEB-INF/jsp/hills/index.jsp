<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
<meta name="title" content="서원힐스">
<meta name="author" content="서원힐스">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents CopyrightⓒseowonHills">
<meta name="format-detection" content="telephone=no, address=no, email=no"/>
<meta property="og:type" content="mobile">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<title>서원힐스</title>
<link rel="icon" href="<c:url value='/images/hills/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/hills/favicon.ico'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/import.css?v=4'/>">
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.3.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/hills/common.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/hills/jquery.eislideshow.js'/>"></script>
<script type="text/javascript">

	$(document).ready(function() { 
		initWeather();
		
		doSearchBenner();
		
		doSearchFunAndJoy();
		
		doSearchPopup();
		
		doSearchYoutube();
		
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
			location.href = "<c:url value='/hills/member/agree.do'/>";		
			return;
		}
		
		if(imsiYn != "" && imsiYn == "Y") {
	    	alert("아이디 변경 후 이용 부탁드립니다.");
			location.href = "<c:url value='/hills/member/memModify.do'/>";		
			return;			
		}
		
		var mainCodiv = "${sessionScope.msMember.msMainCoDiv}";
		
		if(mainCodiv != "" && mainCodiv == "61") {
			var logoutUrl = "<c:url value='/common/changeAccout.do'/>";
			var logoutParams = String.format("coDiv={0}", "65");
			
			mAjax(logoutUrl, logoutParams, function(data){
				if(data.resultCode == "0000") {
					alert("힐스계정으로 변경되었습니다.");
				} else {
					alert("힐스에서 사용할 수 없는 계정입니다.");
				}
				location.reload();
			});	
			
			return;
		}
	});
	
	function onLoadPage() {
		onLoadBoard();
	}
	
	function doSearchYoutube() {
		var sUrl = "<c:url value='/admin/getYoutube.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = "hills";
				
				var rows = data.rows.list1;
				var rows2 = data.rows.list0;
				
				$("#youtubeContainer").empty();
				
				var template = "<li onclick='location.href=\"{0}\"'><p><img src='{1}'></p><h2>{2}</h2></li>";
								    
				for(i=0; i<rows.length && i < 3; i++) {
					var fileName = rows[i].HP_FILE_NAME;    
					var originName = rows[i].HP_ORIGIN_FILE_NAME;			
					var link = rows[i].HP_LINK;			
					var title = rows[i].HP_TITLE;
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName);
					
					$("#youtubeContainer").append(String.format(template, link, image, title));
				}
				
				if(rows2.length > 0){
					var template = "";
					template += "<a href='{0}' target='_blank'>";
					template += "<h2> <img src='<c:url value='/images/hills/youtube.png'/>' alt='유투브'> channel: 서원밸리컨트리클럽</h2>";
					template += "<div class='movie'>";
					template += "	<video muted='true' id='bgvid' controls='controls' autoplay='autoplay'>";
					template += "		<source src='<c:url value='/video/hills/index/mainMovie.mp4'/>' type='video/mp4'>";
					template += "	</video>";
					template += "</div>";
					template += "</a>";
					template += "<a href='javascript:void(0)' onclick='$(\".mainMoviePop\").hide()' class='closeMovieBtn'>X</a>";

					var link = rows2[0].HP_LINK;		
					
					$(".mainMoviePop").append(String.format(template, link));
					$(".mainMoviePop").show();
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = "hills"
				
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
	
	function doSearchBenner() {
		var sUrl = "<c:url value='/admin/getBenner.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = "hills";
				
				var hBenner = data.rows.homepage;
				
				var slideContainer = $("#slideContainer");
				
				slideContainer.empty();
				
				var slide1 = $("<div id='ei-slider' class='ei-slider'></div>")
				
				var h_slider_large = $("<ul class='ei-slider-large' id='ei-slider-large'></ul>");
				var h_slider_thumbs = $("<ul class='ei-slider-thumbs' id='ei-slider-thumbs'></ul>");		
				
				h_slider_thumbs.append("<li class='ei-slider-element'>Current</li>");
				
				for(i=0; i<hBenner.length; i++) {
					var fileName = hBenner[i].HP_FILE_NAME;
					var fileLink = hBenner[i].HP_LINK; 
					
					fileLink = fileLink == "" ? "javascript:void(0)" : fileLink;
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					h_slider_large.append(String.format("<li><a href='{0}'><img src='{1}'/></a></li>", fileLink, image));
					h_slider_thumbs.append(String.format("<li><a href='#'>Slide {0}</a><img src='{1}' alt='' /></li>", (i + 1), image));
				}
				
				h_slider_large.append(String.format("<div class='mainGbtnL'><a href='javascript:onMoveMainBennerPage({0}, {1})'><img src='<c:url value='/images/hills/main/g_arw_l.png'/>' alt='' /></a></div>", "-1", hBenner.length));
				h_slider_large.append(String.format("<div class='mainGbtnR'><a href='javascript:onMoveMainBennerPage({0}, {1})'><img src='<c:url value='/images/hills/main/g_arw_r.png'/>' alt='' /></a></div>", "1", hBenner.length));
				
				slide1.append(h_slider_large, h_slider_thumbs).appendTo(slideContainer);
				
				if(hBenner.length > 0) {
					$('#ei-slider').eislideshow({
						slideshow_interval : 4000,
						titlesFactor : 0
					});
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchFunAndJoy() {
		var sUrl = "<c:url value='/admin/getFunAndJoy.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = "hills";
				
				var mFunAndJoyEvent = data.rows.list1;
				var mFunAndJoyAd = data.rows.list2;
				var mFunAndJoyHole = data.rows.list3;
				
				var eventContainer = $("#funandjoyEventSlider");
				
				eventContainer.empty();
				    
				for(i=0; i<mFunAndJoyEvent.length; i++) {
					var fileName = mFunAndJoyEvent[i].HP_FILE_NAME;
					var fileLink = mFunAndJoyEvent[i].HP_LINK; 
					
					fileLink = fileLink == "" ? "javascript:void(0)" : fileLink;
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					eventContainer.append(String.format("<li><a href='{0}'><img src='{1}' title=''></a></li>", fileLink, image));
				}
				
				$('#funandjoyEventSlider').bxSlider({
					mode:'horizontal',
					speed : 300,
					pause : 6000,
					auto: true,
					captions: true,
					controls: false,
					autoHover: false,
					touchEnabled: false,
					slideWidth: 438
				});
				
				var adContainer = $("#funandjoyAdSlider");
				
				adContainer.empty();
				
				for(i=0; i<mFunAndJoyAd.length; i++) {
					var fileName = mFunAndJoyAd[i].HP_FILE_NAME;
					var fileLink = mFunAndJoyAd[i].HP_LINK; 
					
					fileLink = fileLink == "" ? "javascript:void(0)" : fileLink;
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					adContainer.append(String.format("<div><a href='{0}'><img  src='{1}'></a></div>", fileLink, image));        
				}
				
				$('#funandjoyAdSlider').slick({
				  slidesToShow: 4,
				  slidesToScroll: 1,
				  autoplay: true,
				  autoplaySpeed: 2000,
				});
				
				for(i=0; i<mFunAndJoyHole.length; i++) {
					var fileName = mFunAndJoyHole[i].HP_FILE_NAME;
					var fileLink = mFunAndJoyHole[i].HP_LINK; 
					var contents = mFunAndJoyHole[i].HP_CONTENTS;
					var cos = mFunAndJoyHole[i].HP_COS;
					var hole = mFunAndJoyHole[i].HP_HOLE;
					
					fileLink = fileLink == "" ? "javascript:void(0)" : fileLink;
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					$("#funandjoyHole" + cos + hole).append(String.format("<a href='{0}'> ( <img src='{1}'> ) {2} </a>", fileLink, image, contents));
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function onMoveMainBennerPage(add, length) {
		var current = $('#ei-slider').data().eislideshow.current;
		
		current += add;
		
		if(current == -1) {
			current = 2;
		} else if(current == length) {
			current = 0;
		}
		
		$('#ei-slider').data().eislideshow._slideTo(current);
	}
	
	function initWeather() {
		var sUrl = "<c:url value='/common/getWeather.do'/>";
		
		mAjax2(sUrl, null, function(data) {
			if(data.resultCode == "0000") {
				var temp = data.rows.temp;
				var wfKor = data.rows.wfKor;
				var wfEn = data.rows.wfEn;
				 
				var img = "<c:url value='/images/hills/wt_b.png'/>";
				
				$("#txtWeather").html(String.format("{0}˚ {1}", temp, wfKor)); 
				
				if(wfEn == "Clear") {
					img = "<c:url value='/images/hills/wt_s.png'/>";
				} else if(wfEn == "Partly Cloudy") {
					img = "<c:url value='/images/hills/wt_pc.png'/>";
				} else if(wfEn == "Mostly Cloudy") {
					img = "<c:url value='/images/hills/wt_mc.png'/>";
				} else if(wfEn == "Cloudy") {
					img = "<c:url value='/images/hills/wt_c.png'/>";
				} else if(wfEn == "Rain") {
					img = "<c:url value='/images/hills/wt_r.png'/>";
				} else if(wfEn == "Snow/Rain") {
					img = "<c:url value='/images/hills/wt_ras.png'/>";
				} else if(wfEn == "Snow") {
					img = "<c:url value='/images/hills/wt_sn.png'/>";
				}
				
				$("#imgWeather").attr("src", img);
			}
		});
	}
	
	function actionLogout() {
		var sUrl = "<c:url value='/hills/member/actionLogout.do'/>";
		
		mAjax(sUrl, null, function(data){
			if(data.resultCode == "0000") {
				alert("로그아웃 되었습니다.");
				location.reload();				
			} else {
				alert(data.resultMessage);
			}
		})
	}
	
	function locationMyZone() {
		var sUrl = "<c:url value='/hills/reservation/reservationCheck.do'/>";
		
		location.href = sUrl;
	}
	
	function onLoadBoard() {
		var sUrl = "<c:url value='/common/getMainNewsData.do'/>";
		var sParams = String.format("coDiv={0}", "65");
		
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
					var link = String.format("<c:url value='/hills/board/view.do?bbsType={0}&idx={1}'/>", bbsType, idx);
					var link2 = String.format("<c:url value='/hills/board/list.do?bbsType={0}'/>", bbsType);
					
					if(upFileName != null && upFileName != "") { 
						upFileName = "<c:url value='/common/downloadImage.do?division=hills&folderName=" + regDate + "&fileName=" + upFileName + "'/>";
					} else {
						upFileName = "<c:url value='/images/hills/defaultImage.jpg'/>";
					}
					
					regDate = regDate.substring(0, 4) + "-" + regDate.substring(4, 6) + "-" + regDate.substring(6, 8);
					
					if(rows[i].DIVISION == "1") {
						var container = $("#boardRightContainer");
						
						container.empty();
						
						var tmp = "";
						tmp += "<h2>NEWS<span><a href='{0}'><img src='<c:url value='/images/hills/main/plus.jpg'/>'></a></span></h2>";
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

</script>
<style>
.mainMoviePop{ position:fixed; top:calc(50% - 14em); right:9vw; z-index:999; width:500px; border:2px solid #ff8800;}
.mainMoviePop h2{ background-color:#444; color:#fff; width:100%; padding:5px;}
.mainMoviePop h2 img{ height:20px;vertical-align: middle;}
.mainMoviePop video{ margin: 0; padding: 0; width: 100%;}
.closeMovieBtn{position:absolute; background-color:#ff6600; color:#fff; text-align:right; padding:6px 10px; border-radius:50%; top:-15px; right:-15px;}
</style>

</head>
<body onload="onLoadPage()">

<div id="wrap">

	<div class="mainMoviePop" hidden>
		
    </div>
        
    <div id="Mheader">
    	
    	<!-- 0712추가 -->
		<div class="topBn">
			<a href="<c:url value='/hills/board/view.do?bbsType=1&idx=218'/>"><img src="<c:url value='/images/hills/topBn1.jpg'/>" alt="상단배너"></a>
		</div>	
		<!-- //0712추가 -->		
		<div class="tobBox">
			<div class="top">
				<a href="<c:url value='/hills/board/list.do?bbsType=1'/>">공지사항</a>
				<a href="<c:url value='#CountryClub'/>">대회안내</a> 
				<a href="<c:url value='/hills/academi/rangeFare.do'/>">드라이빙레인지</a>
				<a href="http://seowonatrium.co.kr/" target="_blank">웨딩/연회</a>
				<a href="<c:url value='/valley/index.do'/>">서원밸리</a>
			</div>
		</div>
		<div class="headerBox">
			<a href="javascript:void(0)" class="gnbBtn gnbBox" id="gnb"><img src="<c:url value='/images/hills/gnbBtn.png'/>" alt="gnb메뉴"></a>
			<div class="logoBox">
				<a href="<c:url value='/hills/index.do'/>"><img src="<c:url value='/images/hills/logo.png'/>" alt="서원힐스 로고"></a>
			</div>
			
			<c:if test="${empty sessionScope.msMember.msId}">
				<a href="<c:url value='/hills/member/login.do'/>" class="topLogin"> <img src="<c:url value='/images/hills/topLogin.png'/>" alt="로그인"><span>로그인 / 회원가입</span></a>
			</c:if>
			
				<a href="<c:url value='/hills/map/map.do'/>" class="topLocation"><img src="<c:url value='/images/hills/topLocation.png'/>" alt="오시는길"><span>오시는길</span></a>
				
				<div class="topWheather" onclick="location.href='<c:url value='/hills/contents/weather.do'/>'">
					<img src="<c:url value='/images/hills/wt_b.png'/>" id="imgWeather" alt="날씨">
					<span>오늘의 날씨 </span><span id="txtWeather"></span>
				</div>
				<div class="youtubeLogo">        
					<a href="<c:url value='#youtubeWrap'/>"><img src="<c:url value='/images/hills/youtube.png'/>" alt="유투브"></a>
				</div>			
			<c:if test="${!empty sessionScope.msMember.msId}">
				<a href="javascript:actionLogout()" class="topLogin" style="margin-right: 78px"> <img src="<c:url value='/images/hills/logout.png'/>" alt="로그아웃"><span>로그아웃</span></a>
				<a href="javascript:locationMyZone()" class="topLogin"> <img src="<c:url value='/images/hills/topLogin.png'/>" alt="마이존"><span>마이존</span></a>
			</c:if>
		</div>
		<div class="headerLine"></div>
                <!--메뉴-->				
                <jsp:include page="../hills/include/topmenu.jsp" flush="true" />
    </div>
    
<!-- <script src="//code.jquery.com/jquery-3.3.1.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/main.css?v=1'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/motion.css'/>">
    
<div id="main_wrap">
    <!--sector_1-->
    <div class="mVisual" >
    	<div id="slideContainer">
		</div>
        
        
        <%-- <div id="ei-slider" class="ei-slider">
            <ul class="ei-slider-large">
            	<li><a href="<c:url value='/hills/board/view.do?bbsType=6&idx=11'/>"><img src="<c:url value='/images/hills/main/4.jpg'/>" alt=""/></a></li>
            	<li><a href="<c:url value='/hills/board/view.do?bbsType=1&idx=7'/>"><img src="<c:url value='/images/hills/main/5.jpg'/>" alt=""/></a></li>
                <li><a href="<c:url value='/hills/board/view.do?bbsType=6&idx=10'/>"><img src="<c:url value='/images/hills/main/1.jpg'/>" alt=""/></a></li>
                
                <div class="mainGbtnL"><a href="javascript:onMoveMainBennerPage(-1)"><img src="<c:url value='/images/hills/main/g_arw_l.png'/>" alt="" /></a></div>
            	<div class="mainGbtnR"><a href="javascript:onMoveMainBennerPage(1)"><img src="<c:url value='/images/hills/main/g_arw_r.png'/>" alt="" /></a></div>
            </ul>
            <ul class="ei-slider-thumbs">
                <li class="ei-slider-element">Current</li>
                <li><a href="#">Slide 4</a><img src="<c:url value='/images/hills/main/4.jpg'/>" alt="" /></li>
                <li><a href="#">Slide 5</a><img src="<c:url value='/images/hills/main/5.jpg'/>" alt="" /></li>
                <li><a href="#">Slide 1</a><img src="<c:url value='/images/hills/main/1.jpg'/>" alt="" /></li>
                
            </ul>
            
            
        </div>
        <script type="text/javascript">
            $(function($) {
                $('#ei-slider').eislideshow({
					slideshow_interval	: 4000,
                    titlesFactor		: 0
                });
            });    
        	
        	function onMoveMainBennerPage(add) {
        		var current = $('#ei-slider').data().eislideshow.current;
        		
        		current += add;
        		
        		if(current == -1) {
        			current = 2;
        		} else if(current == 3) {
        			current = 0;
        		}
        		
        		$('#ei-slider').data().eislideshow._slideTo(current);
        		
        	}        
        </script> --%>
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
                            <li class="menuItem"><a href="#hidden1" class="f_scroll" onclick="location.href='<c:url value='/hills/reservation/reservation.do'/>'">실시간 예약</a></li>
                            <li class="menuItem"><a href="#GroupGuide" class="f_scroll">(연)단체안내</a></li>
                            <li class="menuItem"><a href="#FacilityGuide" class="f_scroll">시설안내</a></li>
                            <li class="menuItem"><a href="#CourseGuide" class="f_scroll">코스안내</a></li>
                            <%-- <li class="menuItem" onclick="location.href='<c:url value='/hills/board/list.do?bbsType=1'/>'"><a href="#hidden2" class="f_scroll">정보안내</a></li> --%>
                            <li class="menuItem"><a href="#funjoy" class="f_scroll">정보안내</a></li>
                            <li class="menuItem"><a href="#CountryClub" class="f_scroll">대회안내</a></li>
                            <li class="menuItem"><a href="#Atrium" class="f_scroll">웨딩/연회</a></li>
                            <li class="menuItem"><a href="#Academi" class="f_scroll">서원 아카데미</a></li>
                            
                        </ul>
                    </div>
                </div>
            
                <!--이용안내-->
                <div id="UserGuide">
                    <div class="GuideText">
                        <h2 data-scroll="toggle(.fromTopIn, .fromTopOut)">이용안내</h2>
                        <h3 data-scroll="toggle(.fromBottomIn, .fromBottomOut)">FUN & JOY 명품 퍼블릭 서원힐스</h3>
                    </div>
                    
                    <div class="GuideBox">                        
                        <div class="ugimg" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="bar"></div>
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/hills/main/ugimg1_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <div class="ugimgTitle">
                                                <h3>예약 가이드
                                                <span>MORE &gt;</span>
                                                </h3>
                                            </div>
                                            <p>예약이 어려우신가요?<br>가이드로 보다 쉽게 알려드립니다</p>
                                        </div>
                                        <a href="<c:url value='/hills/reservation/reservationGuide.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>                            
                            <div class="ugIcon"><img src="<c:url value='/images/hills/main/icon1.png'/>"></div>
                        </div>
                        
                        <div class="ugimg" data-scroll="toggle(.fromLeftIn, .fromLeftOut)" >
                            <div class="grid">
                                <div class="bar"></div>
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/hills/main/ugimg2_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <div class="ugimgTitle">
                                                <h3>이용요금
                                                <span>MORE &gt;</span>
                                                </h3>
                                            </div>
                                            <p>서원힐스 이용요금<br>정책을 확인하실 수 있습니다</p>
                                        </div>
                                        <a href="<c:url value='/hills/guide/charge.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>                            
                            <div class="ugIcon"><img src="<c:url value='/images/hills/main/icon2.png'/>"></div>
                        </div>
                        
                        <div class="ugimg" data-scroll="toggle(.fromLeftIn, .fromLeftOut)" >
                            <div class="grid">
                                <div class="bar"></div>
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/hills/main/ugimg3_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <div class="ugimgTitle">
                                                <h3>골프 에티켓
                                                <span>MORE &gt;</span>
                                                </h3>
                                            </div>
                                            <p>즐거운 라운딩을<br>위한 꼭! 지켜야할 에티켓</p>
                                        </div>
                                        <a href="<c:url value='/hills/guide/etiquette.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>                            
                            <div class="ugIcon"><img src="<c:url value='/images/hills/main/icon3.png'/>"></div>
                        </div>
                        
                        <div class="ugimg" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="grid">
                                <div class="bar"></div>
                                <div class="effect-lily">
                                    <img src="<c:url value='/images/hills/main/ugimg4_bg.gif'/>" alt=""/>
                                    <div class="caption">
                                        <div>
                                            <div class="ugimgTitle">
                                                <h3>로컬룰
                                                <span>MORE &gt;</span>
                                                </h3>
                                            </div>
                                            <p>즐거운 라운딩을<br>위한 꼭! 지켜야할 로컬룰</p>
                                        </div>
                                        <a href="<c:url value='/hills/guide/localRule.do'/>">링크</a>
                                    </div>                                    			
                                </div>                               
                            </div>                            
                            <div class="ugIcon"><img src="<c:url value='/images/hills/main/icon4.png'/>"></div>
                        </div>
                    </div>
                </div>           
                <!--//이용안내-->
            
                <div id="hidden1"></div> 

				<!--단체안내-->
                <div id="GroupGuide">
                    <div class="GGtitle" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">GROUP</div>
                    <div class="GGaccordion">
                        <ul>
                            <li onclick="location.href='<c:url value='/hills/team/yearTeam.do'/>'">
                                <div class="GGoverBtn" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <p><img src="<c:url value='/images/hills/main/icon24.png'/>"></p>
                                    <h1>연단체</h1>
                                    <h4>한 번의 선택으로 연간 다양한 혜택을<br>누릴 있는 연단체 정보 안내</h4>
                                    <a href="">more</a>
                                </div>                         
                            </li>
                            <li onclick="location.href='<c:url value='/hills/team/generalTeam.do'/>'">
                                <div class="GGoverBtn" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <p><img src="<c:url value='/images/hills/main/icon25.png'/>"></p>
                                    <h1>일반단체</h1>
                                    <h4>특별한 날, 특별한 분들과의 모임을<br>원하는 분들을 위한 일반 단체 정보 안내</h4>
                                    <a href="">more</a>
                                </div>
                            </li>
                            <li onclick="location.href='<c:url value='/hills/team/lease.do'/>'">
                                <div class="GGoverBtn" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <p><img src="<c:url value='/images/hills/main/icon26.png'/>"></p>
                                    <h1>대관문의</h1>
                                    <h4>VIP초청, 기업행사 및 대회까지<br>서원힐스의 공간을 대여해드립니다. </h4>
                                    <a href="">more</a>
                                </div>
                            </li>
                        </ul>
                    </div>                    
                </div>
                <!--//단체안내-->
                
                <!--시설안내-->
                <div id="FacilityGuide">
                    <div class="FacilityBox">
                        <div class="leftText"></div>
                        <div class="rightGuide">
                            <div class="articleText1"></div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil02.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon5.png'/>"></span>
                                <h2>힐스 대식당</h2>
                                <h4>고객 맞춤형의<br>전국 골프장 TOP10 레스토랑</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil03.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon6.png'/>"></span>
                                <h2>스타트하우스</h2>
                                <h4>순간의 행복쉼터</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil04.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon7.png'/>"></span>
                                <h2>그늘집</h2>
                                <h4>한폭의 그림이 그려지는 공간</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil05.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon8.png'/>"></span>
                                <h2>연회장</h2>
                                <h4>뷰가 아름다운 맞춤 연회장소</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil06.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon9.png'/>"></span>
                                <h2>채플관</h2>
                                <h4>기업형 대형 세미나 공간</h4>
                                <p>MORE &gt;</p>
                            </div>
                            <div class="article" onclick="location.href='<c:url value='/hills/facil/facil07.do'/>'">
                                <span><img src="<c:url value='/images/hills/main/icon10.png'/>"></span>
                                <h2>프로샵</h2>
                                <h4>최신 패션 트렌드</h4>                                
                                <p>MORE &gt;</p>
                            </div>
                            <div class="articleText"></div>
                        </div>
                    </div>
                </div>
                <!--//시설안내-->
            
                <!--코스안내-->
                <div id="CourseGuide" >                    
                    <h2 class="course_title" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">COURSE CAPTURE</h2>
                    <div class="courseWrap" data-scroll="toggle(.fromBottomIn, .fromBottomOut)" >
                        <div class="courseBox">
                            <a href="<c:url value='/hills/course/course_east.do'/>"><img src="<c:url value='/images/hills/main/img_blank.png'/>"></a>
                            <div class="CGtext">
                                <h2>EAST</h2>
                                <h3>course</h3>
                                <h4>아늑하고 포근한<br>고향의 느낌이 나는 코스</h4>
                                <span>&gt;</span>
                            </div>
                            <p><img src="<c:url value='/images/hills/main/c_img4.jpg'/>"></p>                            
                        </div>
                        <div class="courseBox">
                            <a href="<c:url value='/hills/course/course_west.do'/>"><img src="<c:url value='/images/hills/main/img_blank.png'/>"></a>
                            <div class="CGtext">
                                <h2>WEST</h2>
                                <h3>course</h3>
                                <h4>난이도가 높고 전체적으로 <br>시원하게 트여있는 남성적인 코스</h4>
                                <span>&gt;</span>
                            </div>
                            <p><img src="<c:url value='/images/hills/main/c_img3.jpg'/>"></p>
                        </div>
                        <div class="courseBox">
                            <a href="<c:url value='/hills/course/course_south.do'/>"><img src="<c:url value='/images/hills/main/img_blank.png'/>"></a>
                            <div class="CGtext">
                                <h2>SOUTH</h2>
                                <h3>course</h3>
                                <h4>온그린이 되어도 안심할 수 없는<br>산악지형의 도전적인 코스</h4>
                                <span>&gt;</span>
                            </div>
                            <p><img src="<c:url value='/images/hills/main/c_img5.jpg'/>"></p>
                        </div>
                    </div>
                    
                </div>
                <!--//코스안내-->
                
                <!-- fun&joy -->
				<div id="funjoy">
					<div class="funjoy_title"  data-scroll="toggle(.scaleDownIn, .scaleDownOut)">FUN &amp; JOY</div>
					<div class="fjBox"  id="youtubeWrap">
						<div class="fjBox_left">
							<h2>진행중인 이벤트 및 공지</h2>
								<div class="bx-wrapper1">
								<ul class="slider1" id="funandjoyEventSlider">
								</ul>
								</div>
						
						</div>
						<div class="fjBox_right">
							<div class="fjBox_right_l fjBox_bg" >
								<h2>COURSE MISSON EVENT</h2>
								<div class="fjBox_bg_fix">
								<div class="rbg_none"><img src="<c:url value='/images/hills/main/red2.gif'/>"></div>
								<div class="red2"><img id="dotHoleA2" src="<c:url value='/images/hills/main/none_hole2.png'/>"></div>
								<div class="red8"><img id="dotHoleA8" src="<c:url value='/images/hills/main/none_hole8.png'/>"></div>
								<div class="blue4"><img id="dotHoleB2" src="<c:url value='/images/hills/main/none_hole4.png'/>"></div>
								<div class="blue7"><img id="dotHoleB8" src="<c:url value='/images/hills/main/none_hole7.png'/>"></div>
								<div class="green5"><img id="dotHoleC2" src="<c:url value='/images/hills/main/none_hole5.png'/>"></div>
								<div class="green8"><img id="dotHoleC8" src="<c:url value='/images/hills/main/none_hole8.png'/>"></div>								
									<script>
										$(document).ready(function() {
											$("#dotHoleA2").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/red2.gif'/>");});
											$("#dotHoleA2").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole2.png'/>");});
											$("#dotHoleA8").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/red8.gif'/>");});
											$("#dotHoleA8").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole8.png'/>");});
											$("#dotHoleB2").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/blue4.gif'/>");});
											$("#dotHoleB2").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole4.png'/>");});
											$("#dotHoleB8").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/blue7.gif'/>");});
											$("#dotHoleB8").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole7.png'/>");});
											$("#dotHoleC2").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/green5.gif'/>");});
											$("#dotHoleC2").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole5.png'/>");});
											$("#dotHoleC8").mouseover(function(){$(this).prop("src", "<c:url value='/images/hills/main/green8.gif'/>");});
											$("#dotHoleC8").mouseleave(function(){$(this).prop("src", "<c:url value='/images/hills/main/none_hole8.png'/>");});
										});
									</script>								
								</div>
							</div>
							
							<div class="fjBox_right_r">
								<dl>
									<p>east</p>
									<dt>2번홀 : <span id="funandjoyHoleA2"></span></dt>
									<dd>8번홀 : <span id="funandjoyHoleA8"></span></dd>
								</dl>
								<dl>
									<p>west</p>
									<dt class="blue">4번홀 : <span id="funandjoyHoleB4"></span></dt>
									<dd>7번홀 : <span id="funandjoyHoleB7"></span></dd>
								</dl>
								<dl>
									<p>south</p>
									<dt class="green">5번홀 : <span id="funandjoyHoleC5"></span></dt>
									<dd>8번홀 : <span id="funandjoyHoleC8"></span></dd>
								</dl>
							</div>			
						</div>
					</div>
					<div class="fjBox1">
						<div class="youtubeList">
							<ul id="youtubeContainer">
								<!-- <li>
									<p><img src="http://localhost:8080/common/downloadImage.do?division=hills&folderName=20200520&fileName=1589961813974.jpg"></p>
									<h2>동영상 제목들어가는 부분</h2>
								</li> -->
							</ul>
						</div>
						
						<h2>MEMBER SHIP 제휴안내</h2>
						<h3>서원힐스 인터넷 회원가입만 하셔도 기본 제휴혜택을 드리며,  VIP 고객님이 되시면 더 다양하고 특별한 제휴혜택을 드립니다.</h3>
						
						<div class="slideG">
							<div class="autoplay slider10" id="funandjoyAdSlider">
						    </div>						
						</div>
					</div>
				</div>
            
                <!--대회안내-->
                <div id="CountryClub">
                    <div class="CCWrap">
                        <div class="CCtit">
                            <h2 data-scroll="toggle(.fromTopIn, .fromTopOut)"><span>HILLS </span>COUNTRY CLUB</h2>
                            <h1 data-scroll="toggle(.fromBottomIn, .fromBottomOut)">대회안내<span> 회원님의 실력을 뽐내실수 있는 각종 대회가 준비되어 있습니다</span></h1>
                        </div>
                        <div class="champBnBox" style="top:325px">
                        	<img src="<c:url value='/images/hills/main/champBn3.png'/>" data-scroll="toggle(.fromBottomIn, .fromBottomOut)">
                        </div>
                        <div class="ccBox_Wrap" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                            <div class="ccBox">
                                <div class="bg"></div>
                                <div class="num">1</div>
                                <div class="ccContent">
                                    <p><img src="<c:url value='/images/hills/main/champ_icon1_1.png'/>"></p> 
                                    <h2>레이디스 골프 챔피언십</h2>
                                    <h3>골프장 주최 최대규모 여성골프대회</h3>                                  
                                    <div class="ccbutton">
                                        <div class="ccEffect"></div>
                                        <%-- <a href="<c:url value='/hills/champion/champion.do'/>"> 대회개요보기</a> --%>
                                        <a href="<c:url value='/hills/champion/champion5.do'/>"> 대회개요보기</a>
                                        <!-- <a href="javascript:alert('준비중입니다.');"> 참가신청하기</a> -->
                                    </div>                                
                                </div>
                            </div>
                            <div class="ccBox">
                                <div class="bg"></div>  
                                <div class="num">2</div>
                                <div class="ccContent">
                                    <p><img src="<c:url value='/images/hills/main/champ_icon2.png'/>"></p>
                                    <h2>DMZ평화골프대회</h2>
                                    <h3>남·북 평화를 기원하는 평화기원자선 골프대회</h3>
                                    <div class="ccbutton">
                                        <div class="ccEffect"></div>
                                        <%-- <a href="<c:url value='/hills/champion/champion2.do'/>"> 대회개요보기</a> --%>
                                        <a href="javascript:alert('준비중입니다');">준비중</a>
                                    </div>                                
                                </div>
                            </div>
                            <div class="ccBox">
                                <div class="bg"></div>
                                <div class="num">3</div>
                                <div class="ccContent">
                                    <p><img src="<c:url value='/images/hills/main/champ_icon3.png'/>"></p>
                                    <h2>연단체 챔피언십</h2>
                                    <h3>연단체팀의 최강자를 가리는 대회</h3>      
                                    <div class="ccbutton">
                                        <div class="ccEffect"></div>
                                        <%-- <a href="<c:url value='/hills/champion/champion3.do'/>">2021년 예정</a> --%>
                                         <a href="javascript:alert('준비중입니다');">준비중</a>
                                    </div>                                
                                </div>
                            </div>
                            <div class="ccBox">
                                <div class="bg"></div>
                                <div class="num">4</div>
                                <div class="ccContent none">
                                    <p><img src="<c:url value='/images/hills/main/champ_icon4.png'/>"></p>
                                    <h2>싱글인증전</h2>
                                    <h3>본인과의 도전! 싱글인증에 도전!</h3>
                                    <div class="ccbutton">
                                        <div class="ccEffect"></div>
                                        <a href="javascript:alert('준비중입니다');">준비중</a>
                                    </div>                                
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                <!--//대회안내-->
            
                <!--아트리움-->
                <div id="Atrium">
                    <div class="atr_title"  data-scroll="toggle(.scaleDownIn, .scaleDownOut)">SEOWON ATRIUM</div>
                    <div class="accordion">
                        <ul>
                            <li>
                                <div class="overBtn" id="atrText1"  data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <h1>WEDDING</h1>
                                    <h4>웨딩</h4>
                                    <div class="hr"></div>
                                </div>
                                <div class="atr">
                                    <div class="link1">
                                        <div class="link_bg"></div>
                                        <div class="link_box">
                                            <p class="wedding">웨딩아이콘</p>
                                            <h1>WEDDING</h1>
                                            <h3>완벽해야만 하는 그날을 위해<br>서원 아트리움에서 디자인해드립니다.</h3>
                                            <div class="atrbutton">
                                                <div class="atrEffect"></div>
                                                <a href="http://seowonatrium.co.kr/atriumgarden" target="_blank"> 자세히보기</a>
                                            </div> 
                                        </div>
                                    </div>
                                </div>                                
                            </li>
                            <li>
                                <div class="overBtn" id="atrText2"  data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <h1>FIRST BIRTHDAY</h1>
                                    <h4>첫생일</h4>
                                    <div class="hr_long"></div>
                                </div>
                                <div class="atr">
                                    <div class="link2">
                                        <div class="link_bg"></div>
                                        <div class="link_box">
                                            <p class="crown">왕관아이콘</p>
                                            <h1>FIRST<br>BIRTHDAY</h1>
                                            <h3>우리 아이의 첫 기념일을 서원 아트리움에서<br>행복한 시간을 만들어 드립니다</h3>
                                            <div class="atrbutton">
                                                <div class="atrEffect"></div>
                                                <a href="http://seowonatrium.co.kr/45" target="_blank"> 자세히보기</a>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="overBtn" id="atrText3"  data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                                    <h1>BANQUET</h1>
                                    <h4>연회</h4>
                                    <div class="hr_long"></div>
                                </div>
                                <div class="atr">
                                    <div class="link3">
                                        <div class="link_bg"></div>
                                        <div class="link_box">
                                            <p class="banquet">연회아이콘</p>
                                            <h1>BANQUET</h1>
                                            <h3>고급스럽고 품격있는 공간,<br>소규모 및 대규모 모임을 위한 공간을<br>서원 아트리움에서 제공합니다.</h3>
                                            <div class="atrbutton">
                                                <div class="atrEffect"></div>
                                                <a href="http://seowonatrium.co.kr/45" target="_blank"> 자세히보기</a>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--//아트리움-->
				
                <!--아카데미-->
                <div id="Academi">
                    <div class="acdm_title"  data-scroll="toggle(.scaleDownIn, .scaleDownOut)">MAJOR FACILITY</div>
                    <div class="academiWrap">
                    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
                        <div class="bx-wrapper">
                            <ul class="slider">
                                <li><a href="<c:url value='/hills/academi/rangeFare.do'/>"><img src="<c:url value='/images/hills/main/img_g1.png'/>" title=""></a></li>
                                <li><a href="<c:url value='/hills/academi/academi.do'/>"><img src="<c:url value='/images/hills/main/img_g2.png'/>"  title=""></a></li>
                            </ul>

                            <script>
                                $('.slider').bxSlider({
                                    mode:'fade',
                                    speed : 300,
                                    pause : 6000,
                                    auto: true,
                                    captions: false,
                                    autoHover: false,
                                    touchEnabled: false,
                                    slideWidth: 1197
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <!--//아카데미-->
            
                <!--정보안내-->
                <div id="InfoGuide">
                    <div class="IFGWrap">
                        <h2 class="title" data-scroll="toggle(.fromTopIn, .fromTopOut)">course capture<span data-scroll="toggle(.fromBottomIn, .fromBottomOut)">언제나 고객이 최우선</span></h2>
                        <div class="IFGBox">
                            <div class="bar1"></div>
                            <!--언론보도-->
                            <div class="info_left" id="boardLeftContainer">
                                <p><img src=""></p>
                                <h2><a href="javascript:void(0)"></a></h2>
                                <h3><a href="javascript:void(0)"></a></h3>
                                <h4><span><a href="javascript:void(0)">More &gt;</a></span></h4>
                                <div class="vline_r">라인</div>
                            </div>
                            <!--아이콘링크-->
                            <div class="info_center">
                                <ul>
                                    <li><a href="<c:url value='/hills/course/courseIntro.do'/>"><p><img src="<c:url value='/images/hills/main/icon18.png'/>"></p>코스소개</a></li>
                                    <li><a href="<c:url value='/hills/reservation/reservationCheck.do'/>"><p><img src="<c:url value='/images/hills/main/icon19.png'/>"></p>예약확인</a></li>
                                    <li><a href="<c:url value='/hills/guide/charge.do'/>"><p><img src="<c:url value='/images/hills/main/icon20.png'/>"></p>요금안내</a></li>
                                    <li><a href="javascript:alert('준비중입니다.');"><p><img src="<c:url value='/images/hills/main/icon21.png'/>"></p>고객의소리</a></li>
                                    <li><a href="javascript:alert('준비중입니다.');"><p><img src="<c:url value='/images/hills/main/icon22.png'/>"></p>제휴안내</a></li>
                                    <li><a href="<c:url value='/hills/map/map.do'/>"><p><img src="<c:url value='/images/hills/main/icon23.png'/>"></p>오시는길</a></li>
                                </ul>
                            </div>
                            <!--공지사항-->
                            <div class="info_right" id="boardRightContainer">
                            	<div class="vline_l">라인</div>
                                <h2>NEWS<span><a href="javascript:alert('준비중입니다.');"><img src="<c:url value='/images/hills/main/plus.jpg'/>"></a></span></h2>
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
            
                <!--textmotion-->
                <script src="<c:url value='/js/hills/ScrollTrigger.js'/>"></script>
                <script>
                    window.counter = function($) {
                        // this refers to the html element with the data-scroll-showCallback tag
                        var span = this.querySelector('span');
                        var current = parseInt(span.textContent);

                        span.textContent = current + 1;
                    };

                    document.addEventListener('DOMContentLoaded', function($){
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
            	<h1><img src="<c:url value='/images/hills/main/arw1.jpg'/>" ></h1>
                <p><img src="<c:url value='/images/hills/main/imgPannel.jpg'/>" ></p>
                <strong>Family SITE</strong>
                <h4>서원 관련 사이트 이동</h4>
            </div>
        </div>
        <div class="sidenav_wrap">
            <div id="mySidenav" class="sidenav">
                <%-- <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><img src="<c:url value='/images/hills/main/x.jpg'/>"></a> --%>
                <h1><a href="javascript:void(0)" class="" onclick="closeNav()"><img src="<c:url value='/images/hills/main/arw1.jpg'/>" ></a></h1>
                <strong>Family SITE</strong>
                <div class="sideList">
                    <ul>
                    	<li class="sideBn_home"><a href="<c:url value='../'/>" target="_blank"><span>홈</span>HOME</a></li>
                        <li>
                            <div class="fmlbn">
                                <a href="<c:url value='/valley/index.do'/>" target="_blank"><img src="<c:url value='/images/hills/main/sideTitle_over.jpg'/>" class="first_bn">
                                <img src="<c:url value='/images/hills/main/sideTitle.jpg'/>" class="second_bn"></a>
                            </div>
                        </li>
                        <li>
	                       	<div class="fmlbn">
	                            <a href="http://seowonatrium.co.kr/" target="_blank"><img src="<c:url value='/images/hills/main/sideTitle1_over.jpg'/>" class="first_bn">
	                            <img src="<c:url value='/images/hills/main/sideTitle1.jpg'/>" class="second_bn"></a>
	                        </div>
	                    </li>
	                    <li>
	                      	<div class="fmlbn">
	                            <a href="<c:url value='/hills/academi/academi.do'/>"><img src="<c:url value='/images/hills/main/sideTitle2_over.jpg'/>" class="first_bn">
	                            <img src="<c:url value='/images/hills/main/sideTitle2.jpg'/>" class="second_bn"></a>
	                        </div>
	                  	</li>
                    </ul>
                </div>
            </div>
        </div>    
    </div>
    
    <!--제휴업체-->
    <div id="sidebar-menu1">
        <div class="fixPannel1">
            <div class="pannelBtn1" onclick="LopenNav()">
                <h2><img src="<c:url value='/images/hills/main/arw.gif'/>" ></h2>
                <p>ALLIANCE</p>
                <h4>제휴업체</h4>
            </div>
        </div>
        <div class="sidenav_wrap1">
            <div id="mySidenav1" class="sidenav1">
                <%-- <a href="javascript:void(0)" class="closebtn" onclick="LcloseNav()"><img src="<c:url value='/images/hills/main/lb_x.gif'/>"></a> --%>
                <a href="javascript:void(0)" class="closebtn1" onclick="LcloseNav()"><img src="<c:url value='/images/hills/main/arw.gif'/>" ></a>
                <div class="sideList1">
                    <strong>제휴업체</strong>
                    <hr>
                    <ul>
                    	<li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance1.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance2.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance3.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance4.jpg'/>"></a></li>
                        <%-- <li><a href="<c:url value='/hills/board/view.do?bbsType=51&idx=94'/>"><img src="<c:url value='/images/hills/main/alliance1.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=53&idx=83'/>"><img src="<c:url value='/images/hills/main/alliance2.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=54&idx=82'/>"><img src="<c:url value='/images/hills/main/alliance3.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=53&idx=84'/>"><img src="<c:url value='/images/hills/main/alliance4.jpg'/>"></a></li> --%>
                    </ul>
                </div>
            </div>
        </div>    
    </div>
    
    <!--퀵예약-->
    <div id="sidebar-menu2">
    <div id="quickReser">
        <a href="javascript:reservePopupOpen(1)">
        <div class="fixquickReser">
        	<h1><img src="<c:url value='/images/hills/main/arw.gif'/>" ></h1>
            <p><img src="<c:url value='/images/hills/main/clock.png'/>" ></p>
            <h2>퀵예약</h2>
        </div>
        </a>
    </div>
    </div>
    
    <!--추천그린피-->
    <div id="sidebar-menu3">
    <div id="recommendGP">
        <a href="javascript:reservePopupOpen2()">
        <div class="fixquickReser">
        	<h1><img src="<c:url value='/images/hills/main/arw2.jpg'/>" ></h1>
            <p><img src="<c:url value='/images/hills/main/clock1.png'/>" ></p>
            <h2>맞춤그린피</h2>
        </div>
        </a>
    </div>
    </div>
</div>
</div> 

<div id="popupContainer"></div>

<script type="text/javascript" src="<c:url value='/js/hills/slick.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/hills/stickUp.js'/>"></script>

<script type="text/javascript">
jQuery(function($) {
    $(document).ready( function($) {
        if($('.navbar-wrapper') !=null) {
            $('.navbar-wrapper').stickUp({
                parts: {
                    0:'UserGuide',
                    1:'hidden1',
                    2:'GroupGuide',
                    3:'FacilityGuide',
                    4:'CourseGuide',
                    5:'funjoy',                    
                    6:'CountryClub',
                    7:'Atrium',
                    8:'Academi'
                },
                itemClass: 'menuItem',
                itemHover: 'active',
                topMargin: 'auto'
            });
        }        
    });
});

</script>

<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<jsp:include page="../hills/include/popup/fix_pop.jsp" flush="true" />
<jsp:include page="../hills/include/popup/fix_pop2.jsp" flush="true" />
<jsp:include page="../hills/include/footer-quick.jsp" flush="true"/>
<jsp:include page="../hills/include/footer.jsp" flush="true" />
</body>
</html>