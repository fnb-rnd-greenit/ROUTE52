<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<script type="text/javascript">

	$(document).ready(function() {
		function popupOpen(i) {
			kingPopup(i);
		}
	});
	function tournament(idx) {
		for(i=0; i<3; i++) {
			if(i==idx) {
		      $("#tm" + i).addClass("on");
		      $("#tmc" + i).show();
		    } else {
		      $("#tm" + i).removeClass("on");
		      $("#tmc" + i).hide();
		    }
		}
	}
	var openIdx = -1;

	function kingPopup(i) {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number($("#layerPop" + i).css("width").replace("px", "")) / 2;
		var cH = Number($("#layerPop" + i).css("height").replace("px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;

		$("#layerPop" + i).css("left", mW);
		$("#layerPop" + i).css("top", mH);

		$("#layerPop" + i).css("display", "block");
		$("#overlayKing").css("display", "block");

		openIdx = i;
	}

	function popupClose(i) {
		$("#layerPop" + i).css("display", "none");
		$("#overlayKing").css("display", "none");
	}

	function popupOverlayClicked() {
		if(openIdx > 0){
			$("#layerPop" + openIdx).css("display", "none");
			$("#overlayKing").css("display", "none");
		}
	}
	
	function moveBoard() {
		if("${sessionScope.msMember.msId}" == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_hills/member/login.do'/>";
			return;
		}
		
		var birth = "${sessionScope.msMember.msBirth}";
		
		if(birth.length == 8) {
			location.href = "<c:url value='/hills/champion/ladyPassport2.do'/>";
		} else {
			alert("리더보드 확인을 위해서는\n로그인 후 ‘회원정보’란에 생년월일을\n입력하셔야만 확인이 가능합니다.")
			location.href = "<c:url value='/hills/member/memModify.do'/>";
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">
<style>
	.bn{ position:fixed; top:50%; right:0; background-color:#ff8800;padding:6px; color:#fff; line-height:1.5em; font-size: 0.875em;text-align:center;}
</style>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 대회안내 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList4">		
		<c:if test="${type eq '1'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=1'/>">레이디스골프챔피언십</a></li>
		</c:if>
		<c:if test="${type ne '1'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=1'/>">레이디스골프챔피언십</a></li>
		</c:if>	
		<c:if test="${type eq '2'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=2'/>">DMZ평화골프대회</a></li>
		</c:if>
		<c:if test="${type ne '2'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=2'/>">DMZ평화골프대회</a></li>
		</c:if>	
		<c:if test="${type eq '3'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=3'/>">연단체 챔피언십</a></li>
		</c:if>
		<c:if test="${type ne '3'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=3'/>">연단체 챔피언십</a></li>
		</c:if>	
		<c:if test="${type eq '4'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">BIG2대회 리뷰</a></li>
		</c:if>
		<c:if test="${type ne '4'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">BIG2대회 리뷰</a></li>
		</c:if>	
	</ul>
	<div class="contents">
		<div class="viewBox bgBottom">
			<div class="midTitleBox">
			<c:if test="${type eq '1'}">
				<!-- <span class="commonDot"> 레이디스골프챔피언십</span><a href="javascript:openKing()" class="tBtn">왕중왕전</a> -->
				<span class="commonDot"> 레이디스골프챔피언십</span><a href="javascript:void(0)" onclick="alert('결선 종료 후 공지예정입니다');" class="tBtn">왕중왕전</a>
				<script>
					var isOpen=false;
					
					function openKing(){
						if(isOpen){
							$("#tm1").show()
							$("#tm2").hide()
						}else{
							$("#tm1").hide()
							$("#tm2").show()
						}
						isOpen = !isOpen;
					}
				</script>
			</c:if>
			<c:if test="${type eq '2'}">
				<span class="commonDot"> DMZ평화골프대회</span>
			</c:if>
			<c:if test="${type eq '3'}">
				<span class="commonDot"> 연단체 챔피언십</span>
			</c:if>
			<c:if test="${type eq '4'}">
				<span class="commonDot"> BIG2대회 리뷰</span>
			</c:if>
			</div>
			<c:if test="${type eq '1'}">
				<div id="tm1">
					<div style=" position: relative;">
					<%-- <img src="<c:url value='/images/m_hills/champ01.jpg'/>?v=1" class="viewMainImage" alt=""> --%>
					<!-- <img src="<c:url value='/images/m_hills/c1.jpg'/>?v=1" class="viewMainImage" alt="">
					<a href="javascript:alert('참가신청 기간이 끝났습니다.')"><img src="<c:url value='/images/m_hills/c2.jpg'/>?v=1" class="viewMainImage" alt=""></a>
					<img src="<c:url value='/images/m_hills/c3.jpg'/>?v=2" class="viewMainImage" alt="">
					<a href="https://www.clubd.co.kr/m_clubd/championship/woman/about.do" target="_blank"><img src="<c:url value='/images/m_hills/c4.jpg'/>?v=1" class="viewMainImage" alt=""></a>
					<img src="<c:url value='/images/m_hills/c5.jpg'/>?v=1" class="viewMainImage" alt="">
					<img src="<c:url value='/images/m_hills/c6.jpg'/>?v=1" class="viewMainImage" alt="">
					<a href="/m_hills/board/view.do?bbsType=1&idx=264"><img src="<c:url value='/images/m_hills/c7.jpg'/>?v=1" class="viewMainImage" alt=""></a>
					<img src="<c:url value='/images/m_hills/c8.jpg'/>?v=1" class="viewMainImage" alt="">
					<a class="orangeBtn closeBtn" href="<c:url value='/m_hills/champion/loginchamPop.do?type=1'/>" style="margin-top: 10px;">참가신청</a>
					<a class="orangeBtn closeBtn" href="javascript:alert('참가신청 기간이 끝났습니다.')" style="margin-top: 10px;">참가신청</a> -->
						<img src="<c:url value='/images/m_hills/lady/2021/01.jpg'/>" class="viewMainImage" alt="">
						<a href="/m_hills/champion/loginchamPop.do?type=1"><img src="<c:url value='/images/m_hills/lady/2021/02.jpg'/>" class="viewMainImage" alt=""></a>
						<img src="<c:url value='/images/m_hills/lady/2021/03.jpg'/>" class="viewMainImage" alt="">
						<a href="https://www.clubd.com/m_clubd/championship/2021/about.do" target="blank"><img src="<c:url value='/images/m_hills/lady/2021/04.jpg'/>" class="viewMainImage" alt=""></a>
						<img src="<c:url value='/images/m_hills/lady/2021/05.jpg'/>" class="viewMainImage" alt="">
						
						<div class="bn" onclick="moveBoard()">
						예선전<br>우선시드<br>리더보드
						</div>
					</div>
				</div>
				<div id="tm2" class="tmBox" hidden>
					<p><img src="<c:url value='/images/m_hills/tm_01.jpg?=v3'/>" class="tmimg" alt=""></p>
					<ul>
						<li onclick="javascript:kingPopup(1)"><img src="<c:url value='/images/m_hills/tm_02.jpg?=v3'/>" alt=""></li>
						<li onclick="javascript:kingPopup(2)"><img src="<c:url value='/images/m_hills/tm_03.jpg?=v3'/>" alt=""></li>
						<li onclick="location.href='<c:url value="/hills/board/view.do?bbsType=7&idx=294"/>'"><img src="<c:url value='/images/m_hills/tm_04.jpg?v=3'/>" alt=""></li>
					</ul>
				</div>
			</c:if>
			<c:if test="${type eq '2'}">
				<div class="chamPreBox">
					<img src="<c:url value='/images/m_hills/DMZ.jpg'/>?v=1" class="viewMainImage" alt="">
					<%-- <a class="orangeBtn closeBtn" href="<c:url value='/m_hills/champion/loginchamPop.do?type=2'/>" style="margin-top: 10px;">참가신청</a> --%>
					<a class="orangeBtn closeBtn" href="javascript:alert('참가신청 기간이 끝났습니다.')" style="margin-top: 10px;">참가신청</a>
				</div>
			</c:if>
			<c:if test="${type eq '3'}">
				<div class="chamPreBox">
					<img src="<c:url value='/images/m_hills/group1.jpg'/>" class="viewMainImage" alt="">
					<a class="orangeBtn closeBtn" href="<c:url value='https://kr.object.ncloudstorage.com/hills/document/2020_%EC%97%B0%EB%8B%A8%EC%B2%B4_%EC%B1%94%ED%94%BC%EC%96%B8%EC%8B%AD_%EC%B0%B8%EA%B0%80_%EC%8B%A0%EC%B2%AD%EC%84%9C.doc'/>" style="margin-top: 10px;">신청서 다운로드</a>
					<!-- <a class="orangeBtn closeBtn" href="javascript:alert('참가신청 기간이 끝났습니다.')" style="margin-top: 10px;">신청서 다운로드</a> -->
				</div>
			</c:if>
			<c:if test="${type eq '4'}">
				<%-- <div class="chamPreBox">
					<p><img src="<c:url value='/images/m_hills/champ_icon4.png'/>"></p>
					<h2>대회 준비중입니다.</h2>
				</div> --%>
				<div class="contents">
					<div class="b2f_movie">
						<div class="b2f_box">
							<img src="<c:url value='/images/m_hills/b2f_1_01.jpg'/>">
						</div>
						<div class="b2f_btn">
							<ul>
								<li><a href="#b2f1"><img src="<c:url value='/images/m_hills/b2f_1_02.jpg'/>"></a></li>
								<li><a href="#b2f2"><img src="<c:url value='/images/m_hills/b2f_1_03.jpg'/>"></a></li>
							</ul>
						</div>
						<div class="b2f_box1" id="b2f1">
							<ul>
								<li><img src="<c:url value='/images/m_hills/b2f_2.jpg'/>"></li>
							</ul>
							<div class="movie">
								<h2>제 3회 대보·서원힐스 여성아마추어 챔피언십 영상 하이라이트 보기</h2>
								<video muted="true" loop="loop" id="" controls="controls">
									<source src="/video/hills/b2f_191014.webm" type="video/webm">
									<source src="/video/hills/b2f_191014.mp4" type="video/mp4"> 
								</video>				
							</div>
						</div>
						<div class="b2f_box2" id="b2f2">
							<ul>
								<li><img src="<c:url value='/images/m_hills/b2f_3_01.jpg'/>"></li>

								<div class="movie">
									<h2>제 2회 대보·서원힐스 DMZ평화골프대회 FINAL REVIEW</h2>
									<video muted="true" loop="loop" id="" controls="controls">
										<source src="/video/hills/b2f_191014_2.webm" type="video/webm">
										<source src="/video/hills/b2f_191014_2.mp4" type="video/mp4">
									</video>
								</div>

								<li><img src="<c:url value='/images/m_hills/b2f_3_02.jpg"'/>"></li>
							</ul>
							
						</div>
					</div>
				</div><!-- contents End -->
			</c:if>
			
		</div>
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   
<div id="layerPop1" class="kokLayer" style="display: none;">
	<img src="<c:url value='/images/m_hills/tm_way.jpg'/>" border="0" />
	<h4><a href="javascript:popupClose(1)">닫기</a></h4>
</div>
<div id="layerPop2" class="kokLayer" style="display: none;">
	<img src="<c:url value='/images/m_hills/tmtable.jpg'/>" border="0" />
	<h4><a href="javascript:popupClose(2)">닫기</a></h4>
</div>	
<div id="overlayKing" class="overlay1" onclick="popupOverlayClicked()" style="display: none;">	
</div>
</body>
</html>