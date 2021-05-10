<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<!-- <script>
$(document).ready(function() { 
	init();
});

function init() {
	var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
	if(msId == "") {
		$("#a1").show();
	}else{
		$("#a2").show();
	}
}
</script> -->


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
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">싱글인증전</a></li>
		</c:if>
		<c:if test="${type ne '4'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">싱글인증전</a></li>
		</c:if>	
	</ul>
	
	<c:if test="${type eq '1'}">
	<div class="contents">
		<div class="champWrap">
			<div class="champbg"></div>
			<div class="champPopBox">
				<h2>
					<span>"골프장 주최 최대규모의 여성 골프대회"</span><br>
					시상규모 총 4억원 상당
				</h2>				
			</div>
			<div></div>
		</div>
		
		<c:if test="${not empty sessionScope.msMember.msId}">
			<div class="champWrap">
				<div class="champPopBox">
				<h3>
				전국 최대 규모의 여성 아마추어 골프대회  제5회 서원·클럽디 레이디스 골프 챔피언십에 도전하세요.<br>
				참가신청 하신 이후 반드시 스코어등록을 1회이상 필수로 등록하셔야만 예선전 우선시드 실시간 랭킹에 등록되오니 이 점 꼭 숙지바랍니다.<br><br>           
	     ‘예선전 참가 자격 예선전 우선시드 실시간 랭킹 200명’<br><br>
	※예선전 우선시드 실시간 랭킹은 대회요강에서 확인 바랍니다.
				</h3>
				</div>
			</div>
			<ul class="btnBox_1">
				<li class="darkgray"><a href="<c:url value='/m_hills/champion/chamComplete.do?type=${type}'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>
		
		<c:if test="${empty sessionScope.msMember.msId}">
			<div class="champWrap">
				<div class="champPopBox">
				<h3>
					제 5회 서원 · 클럽디 레이디스 골프 챔피언십 대회 참가를 원하시는 고객님께서는
서원힐스 인터넷회원 로그인을 하신 이후 참가 신청해 주시기 바랍니다.<br>
회원가입이 안되신 고객님께서는 인터넷회원 가입을 하셔야만 참가신청이 가능합니다.<br>
참가신청을 하신 후 반드시 스코어등록을 하셔야만 예선전 우선시드 실시간 랭킹에 등록되어니
이 점 꼭 참고 부탁 드립니다.(참가신청 이후 스코어 등록 제출만 유효)<br>
<br>
‘예선전 참가 자격은 우선시드 실시간 랭킹 200명’<br>
<br>
※예선전 우선시드 실시간 랭킹은 대회요강에서 확인 바랍니다.

				</h3>
				</div>
			</div>
			<ul class="btnBox_3">
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/join02.do'/>">회원가입</a></li>
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/login.do'/>">로그인</a></li>
				<li class="darkgray"><a href="<c:url value='/m_hills/member/login.do'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>		
	</div><!-- contents End -->
	</c:if>
	<c:if test="${type eq '2'}">
	<div class="contents">
		<div class="champWrap">
			<div class="champbg2"></div>
			<div class="champPopBox">
				<h2>"최초의 <span> 평화 골프대회</span>"</h2>
			<h3>서원밸리컨트리클럽이 주최하는 <br><strong>제2회 DMZ 평화골프대회</strong> 에지금 참가하세요. <br>
			신페리오 우승 시상 "상금 1,000만원"부터 <br>다양하고 푸짐한 시상품들이준비 되어있습니다. <br>
			골퍼들의 도전을 기다립니다!</h3>
			</div>
			<div></div>
		</div>
	
		<c:if test="${not empty sessionScope.msMember.msId}">
			<ul class="btnBox_1">
				<li class="darkgray"><a href="<c:url value='/m_hills/champion/chamComplete.do?type=${type}'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>
		
		<c:if test="${empty sessionScope.msMember.msId}">
			<ul class="btnBox_3">
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/join02.do'/>">회원가입</a></li>
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/login.do'/>">로그인</a></li>
				<li class="darkgray"><a href="<c:url value='/m_hills/member/login.do'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>
	</div><!-- contents End -->
	</c:if>
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>