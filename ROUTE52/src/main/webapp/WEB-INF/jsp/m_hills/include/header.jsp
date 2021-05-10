<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,target-densitydpi=medium-dpi" />
<meta name="apple-mobile-web-app-capable" content="no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no,email=no,address=no">
<meta name="title" content="서원힐스, 대보">
<meta name="author" content="서원힐스">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta property="og:type" content="website">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<link rel="canonical" href="https://www.seowongolf.co.kr/m_hills/index.do">
<link rel="icon" href="<c:url value='/images/hills/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/hills/favicon.ico'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/import.css'/>">  
<title>서원힐스</title>
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
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
	
	function menuOnOff(s, f) {
		for(i=s; i<=f; i++) {
			if($("#menu" + i).css("display") == "none") {
				$("#menu" + i).show();
			} else {   
				$("#menu" + i).hide();
			}
		}
	}
	
	$(document).ready(function() { 
		var date = new Date();
		$("#txtMenuDate").html(String.format("{0}/{1}/{2} &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
	});
</script>
</head>
<body class="drawer drawer--right"> 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>  
    <div class="header">
    	<!-- 0712추가 -->
		<div class="topBn">
			<a href="<c:url value='/m_hills/board/view.do?bbsType=1&idx=218'/>"><img src="<c:url value='/images/m_hills/topBn1.jpg'/>" alt="상단배너"></a>
		</div>	
		<!-- //0712추가 -->
        <div class="top_logo"><a href="<c:url value='/m_hills/index.do'/>"><img src="<c:url value='/images/m_hills/top_logo.jpg'/>"></a></div>
        <!--메뉴버튼-->
        <div class="top_menu"> 
            <button type="button" class="drawer-toggle drawer-hamburger">
              <span class="sr-only"></span>
              <span class="drawer-hamburger-icon"></span>
            </button>
        </div>
        <div class="top_tab">
            <div class="top_reser"><a href="<c:url value='/m_hills/index.do'/>">실시간예약</a></div>
            <div class="top_search" onclick="MpopupOpen(1)">맞춤검색</div>
        </div>
    </div>
    <!--메뉴내용-->
    <div class="drawer-nav" role="navigation">
        <div class="menu_top">
            <p id="txtMenuDate"></p>
            <h3><span>반갑습니다</span><br>${sessionScope.msMember.msName} 고객님</h3>
        </div>
        <div class="menu_center">
        	<c:if test="${empty sessionScope.msMember.msId}">
	            <a class="m_login" href="<c:url value='/m_hills/member/login.do'/>">로그인</a>
	            <a class="m_join" href="<c:url value='/m_hills/member/join02.do'/>">회원가입</a>
			</c:if>
			<c:if test="${!empty sessionScope.msMember.msId}">
	            <a class="m_logout" href="javascript:actionLogout()">로그아웃</a>
	            <a class="m_join" href="<c:url value='/m_hills/member/member.do'/>">회원정보</a>
			</c:if>
        </div>
        <ul class="drawer-menu">
            <li><a href="<c:url value='/m_hills/index.do'/>">+ 실시간예약</a></li>
            <li><a href="<c:url value='/m_hills/myzone/royaltime.do'/>">+ 로얄타임 패키지 우선예약</a></li>
            <li><a href="<c:url value='/m_hills/reservation/reservationCheck.do'/>">+ 예약확인 및 취소</a></li>
            <li><a href="javaScript:menuOnOff(1, 3)">+ FUN&amp;JOY</a></li>
            <li id="menu1" style="display:none"><a href="<c:url value='/m_hills/board/list.do?bbsType=6'/>">- 이벤트갤러리</a></li>   
            <li id="menu2" style="display:none"><a href="<c:url value='/m_hills/champion/ladyDay.do'/>">- 레이디스데이</a></li>   
            <li id="menu3" style="display:none"><a href="<c:url value='/m_hills/board/list.do?bbsType=3'/>">- 포토갤러리</a></li>      
            <li><a href="javaScript:menuOnOff(4, 6)">+ 정보안내</a></li>
            <li id="menu4" style="display:none"><a href="<c:url value='/m_hills/board/list.do?bbsType=1'/>">- 공지사항</a></li>
            <li id="menu5" style="display:none"><a href="<c:url value='/m_hills/champion/chamView.do?type=1'/>">- 대회안내</a></li>
            <li id="menu6" style="display:none"><a href="javascript:alert('제휴종료\n준비중입니다.')">- 제휴사 혜택 </a></li>
            <%-- <li id="menu6" style="display:none"><a href="<c:url value='/m_hills/board/list.do?bbsType=51'/>">- 제휴사 혜택 </a></li> --%>
            <li><a href="<c:url value='/m_hills/reservation/reservationCheck.do'/>">+ MY ZONE</a></li>
            <li><a href="<c:url value='/m_hills/course/courseIntro.do'/>">+ 코스안내</a></li>
            <li><a href="<c:url value='/m_hills/map/map01.do'/>">+ 오시는길</a></li>
            <li><a href="<c:url value='/m_valley/index.do'/>">+ 서원밸리 바로가기</a></li>
      </ul>
    </div>
        
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/iScroll/5.2.0/iscroll.js"></script>
    <script src="<c:url value='/js/m_hills/drawer.js'/>" charset="utf-8"></script>
    <script>
    $(document).ready(function() {
        $('.drawer').drawer();
    });
    </script>    
	<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
	<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
	<script type="text/javascript">
		$(document).ready(function() { 
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
	    		location.href = "<c:url value='/m_hills/member/agree.do'/>";		
	    		return;
			}
			
			if(imsiYn != "" && imsiYn == "Y") {
	        	alert("아이디 변경 후 이용 부탁드립니다.");
	    		location.href = "<c:url value='/m_hills/member/member.do'/>";		
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
	</script>
<jsp:include page="../include/pop_top.jsp" />  
<jsp:include page="../include/pop_royal_confirm.jsp" flush="true" />
<jsp:include page="../include/pop_reser_confirm.jsp" />