<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
		alert("2021년 연단체 신청은 신청서 다운로드 후 팩스, 이메일로 가능합니다.홈페이지 공지사항 '2021년 연단체 모집안내' 확인 후 신청 바랍니다.");
		location.href = "<c:url value='/hills/team/yearTeam.do'/>";
		return;
		
	    var offset = $(".myzoneTabList6").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>연단체</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<!-- <a href="javascript:alert('준비중입니다.');" class="">MY연단체</a> -->
			<%-- <a href="<c:url value='/hills/team/myTeam.do'/>" class="">MY연단체</a> --%>
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="on">연단체신청</a>	
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="">공지사항/조편성기입하기</a> --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
			<%-- <a href="<c:url value=''/>" class="">연단체공지사항</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">연단체신청 방법</span>
		</div>
		<div class="subLine"></div>
		
		<p class="teamEtc" style="margin-bottom:30px;"><a href="<c:url value='/hills/board/view.do?bbsType=1&idx=152'/>" class="teamTerms"><img src="<c:url value='/images/hills/teamTerms.png'/>" alt="">2020년 서원힐스 연단체 모집 공고 보기</a></p>

		
		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 연단체 신청 및 확정</div>
			<div class="teamGrayBox requestGrayBox">			
				· 신청방법
				<div class="requestTurnBox">
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request01.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">01.</span>서원힐스 홈페이지</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request02.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">02.</span>로그인</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request03.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">03.</span>(연)단체안내</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request04.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">04.</span>연단체신청</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request05.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">05.</span>온라인 신청 또는<br>신청서 다운로드 후 <br> 오프라인 신청</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="<c:url value='/images/hills/request06.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">06.</span>접수</li>
					</ul>
				</div>	
					
				· 확정절차
				<div class="requestTurnBox">
					<ul class="requestTurn">
						<li class="turnImg turn2"><img src="<c:url value='/images/hills/request04.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">01.</span>신청접수 완료</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg turn2"><img src="<c:url value='/images/hills/request07.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">02.</span>확정가능여부 SMS<br>또는 유선 안내</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg turn2"><img src="<c:url value='/images/hills/request05.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">03.</span>연단체 동의서 다운로드 후 <br>오프라인 등록</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg turn2"><img src="<c:url value='/images/hills/request06.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">04.</span>연단체 회원 명부 온라인 등록<br>또는 오프라인 제출 완료</li>
					</ul>
					<div class="requestArrow"><img src="<c:url value='/images/hills/requestArrow.png'/>" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg turn2"><img src="<c:url value='/images/hills/request08.png'/>" alt=""></li>
						<li class="turnTxt"><span class="bold">05.</span>최종확정</li>
					</ul>
				</div>
				<p class="turnText">· 연단체 접수는 서원힐스에서 정한 양식으로 온라인, 오프라인 접수가 가능합니다. </p>
				<!-- <br>· 접수방법 -->
				<p class="turnText">
				<!-- &nbsp;&nbsp;&nbsp;&nbsp;- 온라인 접수 : 홈페이지 또는 모바일에서 연단체 > 연단체신청 > 내용기입 > 신청하기 버튼 클릭<br> -->
				<!-- &nbsp;&nbsp;&nbsp;&nbsp;- 팩스 접수 : 연단체 신청서 양식 다운로드 후 서면으로 작성하여 031-957-2500 으로 접수<br>
				&nbsp;&nbsp;&nbsp;&nbsp;- 현장 접수 : 서원힐스 프론트에서 신청서를 직접 수령하여 서면 기입 후 접수<br>
				&nbsp;&nbsp;&nbsp;&nbsp;- 이메일 접수 : 연단체 신청서 양식 다운로드 후 서면으로 작성하여 smwk@seowongolf.co.kr 으로 스캔한 신청서 송부<br>-->
				&nbsp;&nbsp;&nbsp;&nbsp;- 문의  : 031-940-9400 (ARS. 2) <br>
				&nbsp;&nbsp;&nbsp;&nbsp; ※ 평일/주말 오전 8시 ~ 18시까지 문의 가능합니다.<br>
				</p>
				<div class="yearAgreeyBoxLis">
					<ul class="yearAgreeyBox1">
						<li>
				 		<a href="<c:url value='/hills/team/yearTeamJoin.do'/>" class="yearAgreey"><img src="/images/hills/whiteFile.png" alt=""><span class="yearText">2020 힐스<br>연단체 신청 바로가기</span></a><br><br>
				 		</li>   
				 	</ul>
				 </div>
				
			</div>			
		</div>

		<%-- <div class="commonDot guideTitle"> 2019 힐스 연단체 서면 신청 바로가기</div>
		<div class="yearAgreeyBoxLis">
			<ul class="yearAgreeyBox">
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/2019%EB%85%84%20%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EC%8B%A0%EC%B2%AD%EC%84%9C.hwp" class="yearAgreey"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 신청서<br>(Dowonload)</span></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/2019%EB%85%84%20%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EB%8F%99%EC%9D%98%EC%84%9C.hwp" class="yearAgreey"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 동의서<br>(Dowonload)</span></a></li>
				<li><a href="" class="yearAgreey"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">19년 연간타임테이블<br>(Dowonload)</span></a></li>
			</ul>
		</div> --%>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />