<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,target-densitydpi=medium-dpi" />
<meta name="apple-mobile-web-app-capable" content="no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no,email=no,address=no">
<meta name="title" content="서원밸리, 서원힐스, 대보그룹">
<meta name="author" content="서원밸리, 서원힐스, 대보그룹">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta property="og:type" content="website">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<link rel="icon" href="<c:url value='/images/valley/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/valley/favicon.ico'/>">
<link rel="canonical" href="">  
<link rel="stylesheet" type="text/css" href="<c:url value='/css/intro/m_intro.css?v=1'/>">
<link href="https://fonts.googleapis.com/css?family=Kalam:300" rel="stylesheet"> 
<script src="https://code.jquery.com/jquery-2.1.1.js"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>      
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="application/ld+json">
{
 "@context": "http://schema.org",
 "@type": "Person",
 "name": "Seowon",
 "url": "https://www.seowongolf.co.kr",
 "sameAs": [
   "https://www.youtube.com/channel/UCB1rhha4WhKF8g97q0vDRsQ",
   "https://tv.naver.com/seowongolf",
   "https://blog.naver.com/seowon_cc",
   "https://www.instagram.com/seowonhills"
 ]
}
</script>
<title>서원밸리, 서원힐스, 대보그룹</title>
<style>
.introPop1{ position:absolute; top:0; left:0; right:0; z-index:999; width:100%;}
.introPopClose{ width:100%; background-color:#444; color:#fff; text-align:right; padding:6px 10px;}
 /** 갤러리
===================================*/
.bx-wrapper {
  position: relative;
  padding: 0;
  *zoom: 1;
  -ms-touch-action: pan-y;
  touch-action: pan-y;
}
.bx-wrapper img {
  min-width: 320px;
  width: 100%;
  display: block;
}
.bxslider {
  margin: 0;
  padding: 0;
}
ul.bxslider {
  list-style: none;
}
.bx-viewport {
  -webkit-transform: translatez(0);
}
/** THEME
===================================*/
.bx-wrapper {}
.bx-wrapper .bx-pager,
.bx-wrapper .bx-controls-auto {
  position: absolute;
  bottom: -70px;
  width: 100%;
}
/* PAGER */
.bx-wrapper .bx-pager {
  text-align: center;
  padding-top: 20px;
}
.bx-wrapper .bx-pager.bx-default-pager a {
  background: #666;
  text-indent: -9999px;
  display: block;
  width: 14px;
  height: 14px;
  margin: 0 5px;
  outline: 0;
}
.bx-wrapper .bx-pager.bx-default-pager a:hover,
.bx-wrapper .bx-pager.bx-default-pager a.active,
.bx-wrapper .bx-pager.bx-default-pager a:focus {
  background: #000;
}
.bx-wrapper .bx-pager-item,
.bx-wrapper .bx-controls-auto .bx-controls-auto-item {
  display: inline-block;
  vertical-align: bottom;
  *zoom: 1;
  *display: inline;
}
.bx-wrapper .bx-pager-item {
  font-size: 0;
  line-height: 0;
}
/* DIRECTION CONTROLS (NEXT / PREV) */
.bx-wrapper .bx-prev:hover,
.bx-wrapper .bx-prev:focus {
  background-position: 0 0;
}
.bx-wrapper .bx-controls-direction a {
	position: absolute;
	top: 50%;
	outline: 0;
	margin-top:-25px;
	width: 30px;
	height:49px;
	text-indent: -9999px;
	z-index: 70; 
}
.bx-wrapper .bx-prev {
	left:5px;
	background:url(../images/m_hills/controls_l.png) no-repeat;
} 
.bx-wrapper .bx-next {
	right:5px;
	background:url(../images/m_hills/controls_r.png) no-repeat;
}
.bx-wrapper .bx-controls-direction a.disabled {
  display: none;
}
</style>
<script>
	
	$(document).ready(function() {
		doSearchPopup();
	});

	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		mAjax(sUrl, sParams, function(data) {	     		
			if(data.resultCode = "0000") {
				$(".slider").empty();
				
				var rows = data.rows.list4;
				
				if(rows.length > 0) {
					$("#pop1").show();
					
					var bucket = "hills"
					var template = "<li><a href='{0}'><img src='{1}'></a></li>";
				    
					for(i=0; i<rows.length; i++) {
						var fileName = rows[i].HP_FILE_NAME;    
						var originName = rows[i].HP_ORIGIN_FILE_NAME;					
						var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName) ;
						var link = rows[i].HP_LINK;
						
						$(".slider").append(String.format(template, link, image));
					}
					
					$('.slider').bxSlider({
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
</script>
</head>

<body>

    <!--모바일갤러리-->
    <div class="introPop1" id="pop1" hidden>
      <div class="bx-wrapper">
        <ul class="slider">
        </ul>
      </div>
      <div class="introPopClose" onclick="$('#pop1').hide()">닫기</div>
    </div>
    
    <div id="intro_wrap">
        <div class="intro_top">
            <p><a href=""><img src="<c:url value='/images/intro/logo.jpg'/>" title="로고"></a></p>
        </div>

        <div class="intro_cont">
        	<div class="intro_tit">
                <h4>THE SEOWON <span>CHARITY</span></h4>
                <h2>문화 나눔코드 1번지</h2>
            </div> 
        	<div class="intro_btnWrap">
                <div class="intro_btn1">
                    <a href="<c:url value='/m_valley/index.do'/>"><img src="<c:url value='/images/intro/intro_btn1.png'/>"></a>
                </div>
                <div class="intro_btn2">
                    <a href="<c:url value='/m_hills/index.do'/>"><img src="<c:url value='/images/intro/intro_btn2.png'/>"></a>
                </div>
                <div class="intro_btn3">
                	<a href="http://seowonatrium.co.kr/" target="_blank"><img src="<c:url value='/images/intro/introBn3.png'/>"></a>
                </div>
            </div>
        </div>
		
		<div class="movie">
			<video muted="true" loop="loop" id="bgvid" controls="controls" autoplay="autoplay">
				<source src="<c:url value='/images/intro/ladyday.webm'/>" type="video/webm">
				<source src="<c:url value='/images/intro/ladyday.mp4'/>" type="video/mp4">  
			</video>
		</div>

        <div class="intro_bottom">
            <h2>경기도 파주시 광탄면 서원길 333</h2>
            <p>COPYRIGHTⓒ 2012 SEOWON VALLEY  ALL RIGHTS RESERVED.</p>
        </div>    
    </div>
</body>
</html>