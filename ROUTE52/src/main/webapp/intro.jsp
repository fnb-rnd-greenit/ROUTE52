<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
<meta name="title" content="서원밸리, 서원힐스, 대보그룹">
<meta name="author" content="서원밸리, 서원힐스, 대보그룹">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta property="og:type" content="mobile">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<link rel="icon" href="<c:url value='/images/valley/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/valley/favicon.ico'/>">
<title>서원밸리, 서원힐스, 대보그룹</title>
<!--인토로만사용-->    
<link rel="stylesheet" type="text/css" href="<c:url value='/css/intro/intro.css'/>">
<script src="https://code.jquery.com/jquery-2.1.1.js"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>  
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
<script type="text/javascript">

	/*인트로메인중앙배너*/
	$(document).ready(function(){ 
		init();				
	});
	
	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		mAjax(sUrl, sParams, function(data) {			
			if(data.resultCode = "0000") {
				var bucket = "hills"
				
				var rows = data.rows.list3;
				
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
	
	function init() {
		if (mobilecheck()){
			window.location = "m_intro.jsp";
		}
		
		doSearchPopup();
		
		initListener();
	}
	
	window.mobilecheck = function() {
		var check = false;
		(function(a){
			if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
		return check;
	};
	
	function initListener() {
		$(".rightBn").on("mouseenter",function(){ 
			$("#rightBn").attr("src","<c:url value='/images/intro/introBn2_off.png'/>"); 
			$("#leftBn").attr("src","<c:url value='/images/intro/introBn1_on.png'/>");
			$("#rightBn").addClass("bnMotion");
		});     
		
		$(".rightBn").on("mouseleave",function(){ 
			$("#rightBn").attr("src","<c:url value='/images/intro/introBn2_on.png'/>"); 
			$("#leftBn").attr("src","<c:url value='/images/intro/introBn1_on.png'/>"); 
			$("#rightBn").addClass("bnMotion");
		}); 
		$(".leftBn").on("mouseenter",function(){ 
			$("#rightBn").attr("src","<c:url value='/images/intro/introBn2_on.png'/>"); 
			$("#leftBn").attr("src","<c:url value='/images/intro/introBn1_off.png'/>");
			$("#rightBn").addClass("bnMotion");
		});     
		
		$(".leftBn").on("mouseleave",function(){ 
			$("#rightBn").attr("src","<c:url value='/images/intro/introBn2_on.png'/>"); 
			$("#leftBn").attr("src","<c:url value='/images/intro/introBn1_on.png'/>"); 
			$("#rightBn").addClass("bnMotion");
		});

		$(".leftBn").on("mouseenter",function(){ 
			$("#leftBn").addClass("bnMotion");      
		});    
		
		$(".leftBn").on("mouseleave",function(){ 
			$("#leftBn").addClass("bnMotion_none");
		});
		
		$("#rightBn").on('click', function() {
			location.href = "<c:url value='/hills/index.do'/>";
		});
		
		$("#leftBn").on('click', function() {
			location.href = "<c:url value='/valley/index.do'/>";
		});
		
		$('#home').on('click', function() {
	        $('div.panel').animate({
	            'width': 'show'
	        }, 700, function() {
	            $('div.home').fadeIn(300);
	        });
	    });
		
	    $('span.close').on('click', function() {
	        $('div.home').fadeOut(300, function() {
	            $('div.panel').animate({
	                'width': 'hide'
	            }, 700);
	        });
	    });
	}
	
</script>
<!--//인트로만사용-->
</head>
<body>
	<div id="introWrap">
    <!--배경동영상-->
    <div class="opacity"></div>
    <div id="video_bg">
        <video autoplay="" muted="true" loop="loop" id="bgvid" >
        	<%-- <source src="<c:url value='/images/intro/ladyday.webm'/>" type="video/webm"> --%> 
        	<source src="<c:url value='/images/intro/ladyday.mp4'/>" type="video/mp4">                       
        </video>
    </div>
    <%-- <div id="video_bg">
        <video autoplay loop poster="<c:url value='/images/intro/bg.jpg' />" id="bgvid">
            <source src="<c:url value='/images/intro/seowon_movie.webm'/>" type="video/webm">
            <source src="<c:url value='/images/intro/seowon_movie.mp4'/>" type="video/mp4">            
        </video>
    </div> --%>
<!--     <div class="video-background">
        <div class="video-foreground">
            <iframe width="560" height="315" src="https://www.youtube.com/embed/PPHwPRAuh58?controls=0&showinfo=0&rel=0&autoplay=1&loop=1&playlist=PPHwPRAuh58" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div> -->
    
    <!--//배경동영상-->
    
    <!--메뉴버튼-->
    <div class="LM_top_list">
        <a href="#" id="home"><img src="<c:url value='/images/intro/introMenu.png'/>"></a>
    </div>
    <!--sns-->
    <%-- <div class="introTopSNS">
        <a href="https://www.facebook.com/mungyeong.gc.9"><img src="<c:url value='/images/intro/icon_fb.png'/>"></a>
        <a href="#"><img src="<c:url value='/images/intro/icon_twt.png'/>"></a>
        <a href="https://www.instagram.com/mgle2003/"><img src="<c:url value='/images/intro/icon_ist.png'/>"></a>
    </div> --%>
    
    <!--전체메뉴-->
    <div class="LayerMenu">
        <!--레이어메뉴-->
        <div class="panel">
            <div class="home">            
                <div class="LM_top_box">
                    <%-- <p><a href="#"><img src="<c:url value='/images/intro/topLogin.png'/>" alt="로그인/회원가입">로그인/회원가입</a></p> --%>
                    <span class="close"><img src="<c:url value='/images/intro/x.jpg'/>" alt="닫기"></span>
                </div>
                <div class="allMenu">
                    <div class="leftMenu">
                        <h3>서원밸리</h3>
                        <ul>
                        	<a href="<c:url value='/valley/club/intro.do'/>"><li>서원밸리컨트리클럽</li></a>
                        	<a href="<c:url value='/valley/guide/useGuide.do'/>"><li>이용안내</li></a>
                            <a href="<c:url value='/valley/reservation/reservation.do'/>"><li>실시간예약</li></a>
                            <%-- <a href="<c:url value='/valley/reservation/reservationCheck.do'/>"><li>예약확인/취소</li></a> --%>
                            <a href="<c:url value='/valley/facil/facil01.do'/>"><li>시설안내</li></a>
                            <a href="<c:url value='/valley/course/courseIntro.do'/>"><li>코스안내</li></a>
                            <a href="<c:url value='/valley/board/list.do?bbsType=1'/>"><li>정보안내</li></a>
                            <a href="<c:url value='/hills/academi/academi.do'/>"><li>서원아카데미</li></a>
                            <a href="http://seowonatrium.co.kr/" target="_blank"><li>서원아트리움</li></a>
                            <a href="<c:url value='/valley/reservation/reservationCheck.do'/>"><li>고객센터</li></a>
                        </ul>
                    </div>
                    <div class="leftMenu">
                        <h3>서원힐스</h3>
                        <ul>
                        	<a href="<c:url value='/hills/club/intro.do'/>"><li>서원힐스컨트리클럽</li></a>
                            <a href="<c:url value='/hills/guide/useGuide.do'/>"><li>이용안내</li></a>
                            <a href="<c:url value='/hills/reservation/reservation.do'/>"><li>실시간 예약하기</li></a>
                            <%-- <a href="<c:url value='/hills/reservation/reservationCheck.do'/>"><li>예약확인/취소</li></a> --%>
                             <a href="<c:url value='/hills/facil/facil01.do'/>"><li>시설안내</li></a>
                            <a href="<c:url value='/hills/course/courseIntro.do'/>"><li>코스안내</li></a>
                            <a href="<c:url value='/hills/board/list.do?bbsType=1'/>"><li>정보안내</li></a>
                            <a href="<c:url value='/hills/team/yearTeam.do'/>"><li>(연)단체안내</li></a>
                            <a href="<c:url value='/hills/champion/champion.do'/>"><li>대회안내</li></a>
                            <a href="javascript:alert('준비중입니다.');"><li>제휴안내</li></a>
                            <a href="<c:url value='/hills/academi/academi.do'/>"><li>서원아카데미</li></a>
                            <a href="http://seowonatrium.co.kr/"  target="_blank"><li>서원아트리움</li></a>
                            <a href="<c:url value='/hills/reservation/reservationCheck.do'/>"><li>고객센터</li></a>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//전체메뉴-->
            
    
    <!--중앙배너-->
    <div class="introBox">
        <div class="bnBox">
            <div class="leftBn">
                <img src="<c:url value='/images/intro/introBn1_on.png'/>" id="leftBn"/>
            </div>
            <div class="rightBn">                
                <img src="<c:url value='/images/intro/introBn2_on.png'/>" id="rightBn"/>
            </div>
        </div>
		<div class="motionTit">
			<h2>문화나눔 1번지 서원밸리컨트리클럽</h2>
			<h3>손끝에 정성과 혼을 다하는 서비스로 고객가치를 실현합니다.</h3>		
		</div>
		<div class="circleBnBox">
			<ul>
				<li><a href="<c:url value='/valley/club/intro.do'/>"><img src="<c:url value='/images/intro/btn1.png'/>" class="off" ><img src="<c:url value='/images/intro/btn1_on.png'/>" class="on"></a></li>
				<li><a href="<c:url value='/valley/club/history.do'/>"><img src="<c:url value='/images/intro/btn2.png'/>" class="off"><img src="<c:url value='/images/intro/btn2_on.png'/>" class="on"></a></li>
				<li><a href="<c:url value='/valley/club/s_top10.do'/>"><img src="<c:url value='/images/intro/btn3.png'/>" class="off"><img src="<c:url value='/images/intro/btn3_on.png'/>" class="on"></a></li>
				<li><a href="<c:url value='/valley/club/s_greenConcert.do'/>"><img src="<c:url value='/images/intro/btn4.png'/>" class="off"><img src="<c:url value='/images/intro/btn4_on.png'/>" class="on"></a></li>
			</ul>		
		</div>
    </div>
    <!--//중앙배너-->
    
    <!--하단메뉴-->
    <div class="footerWrap">
        <div class="footerBox">
            <div class="fBox">
                <div class="fBoxWrap">
                <img src="<c:url value='/images/intro/F_Bn1_on.png'/>" class="trans_01">
                    <p>서원아카데미는 유명프로선수들도 운동하는 매머드급 규모의 <br>연습장으로서 골프 꿈나무들을 위한 다양한 프로그램을 운영하는<br> 골프 육성 전문 아카데미입니다.
                    <a class="BnBtn" href="<c:url value='/hills/academi/academi.do'/>">아카데미 보기</a>
                    </p>                    
                </div>                
            </div>
        </div>

        <div class="footerBox2">
            <div class="fBox2">
                <div class="fBoxWrap2">
                    <img src="<c:url value='/images/intro/F_Bn2_on.png'/>" class="trans_01">
                    <p>서원아트리움은 '나만의 맞춤 웨딩'이 가능하며,<br> 다른 곳과는 차별화된 웨딩을 할 수  있는 연회장소입니다.
                    <a class="BnBtn2" href="http://seowonatrium.co.kr/" target="_blank">아트리움 보기</a>
                    </p>                    
                </div>
            </div>
        </div>
        
        <div class="footerBox3">
            <div class="fBox3">
                <div class="fBoxWrap3">
                    <img src="<c:url value='/images/intro/F_Bn3_on.png'/>" class="trans_01">
                    <p>그린콘서트는 매년 5월 넷째주 토요일에 열리는<br>글로벌 자선콘서트로 지역사회와 나눔을 실천하고 있습니다.
                    <a class="BnBtn3" href="http://www.greenconcert.co.kr/" target="_blank">그린콘서트 보기</a>
                    </p>
                </div>
            </div>
        </div>

    </div>
    <!--//하단메뉴-->
    
    <div id="popupContainer"></div>
    
</div>
</body>
</html>