<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="scrollmenuwrap">
	<div id="scrollmenu">
		<div class="menu">
			<ul class="subMenu ul1">
				<li><a href="<c:url value='/hills/club/intro.do'/>">인사말</a></li>
				<li><a href="<c:url value='/hills/club/cibi.do'/>">CI/BI소개</a></li>
				<li><a href="<c:url value='/hills/club/history.do'/>">연혁</a></li>
				<!-- <li><a href="javascript:alert('준비중입니다.');">글로벌멤버쉽</a></li> -->
				<%-- <li><a href="<c:url value='/hills/club/global.do'/>">글로벌멤버쉽</a></li> --%>
				<li><a href="<c:url value='/hills/club/s_greenConcert.do'/>">서원알리기</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul2">
				<li><a href="<c:url value='/hills/guide/useGuide.do'/>">이용안내</a></li>
				<!-- <li><a href="javascript:alert('준비중입니다.');">예약가이드</a></li> -->
				<%-- <li><a href="<c:url value='/hills/guide/reservation.do'/>">예약가이드</a></li> --%>
				<li><a href="<c:url value='/hills/guide/charge.do'/>">이용요금</a></li>
				<li><a href="<c:url value='/hills/guide/etiquette.do'/>">골프에티켓</a></li>
				<li><a href="<c:url value='/hills/guide/localRule.do'/>">로컬룰</a></li>
			</ul>
		</div>
		
		<div class="menu">
			<ul class="subMenu ul3">
				<li><a href="<c:url value='/hills/reservation/reservation.do'/>">실시간예약</a></li>
				<li><a href="<c:url value='/hills/reservation/reservationWait.do'/>">대기예약</a></li>
				<li><a href="<c:url value='/hills/reservation/reservationCheck.do'/>">예약확인/취소</a></li>				
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul4">
				<li><a href="<c:url value='/hills/team/yearTeam.do'/>">연단체</a></li>
				<li><a href="<c:url value='/hills/team/generalTeam.do'/>">일반단체</a></li>
				<li><a href="<c:url value='/hills/team/lease.do'/>">대관안내</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul5">
				<li><a href="<c:url value='/hills/facil/facil01.do'/>">힐하우스</a></li>
				<li><a href="<c:url value='/hills/facil/facil02.do'/>">대식당</a></li>
				<li><a href="<c:url value='/hills/facil/facil03.do'/>">스타트하우스</a></li>
				<li><a href="<c:url value='/hills/facil/facil04.do'/>">그늘집</a></li>
				<li><a href="<c:url value='/hills/facil/facil05.do'/>">연회장</a></li>
				<li><a href="<c:url value='/hills/facil/facil06.do'/>">채플관</a></li>
				<li><a href="<c:url value='/hills/facil/facil07.do'/>">프로샵</a></li>
				<%-- <li><a href="<c:url value='/hills/facil/facil08.do'/>">베이커리</a></li> --%>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul6">
				<li><a href="<c:url value='/hills/course/courseIntro.do'/>">코스안내</a></li>
				<li><a href="<c:url value='/hills/course/course_east.do'/>">코스공략도</a></li>
<%-- 				<li><a href="<c:url value='/hills/board/list.do?bbsType=36'/>">코스갤러리</a></li> --%>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul7">
				<li><a href="<c:url value='/hills/board/list.do?bbsType=1'/>">공지사항</a></li>
				<li><a href="<c:url value='/hills/board/list.do?bbsType=6'/>">이벤트</a></li>			
				<li><a href="<c:url value='/hills/board/list.do?bbsType=3'/>">포토갤러리</a></li>
				<li><a href="javascript:alert('제휴종료\n준비중입니다.');">제휴안내</a></li>
				<%-- <li><a href="<c:url value='/hills/board/list.do?bbsType=51'/>">제휴안내</a></li> --%>
				<!-- <li><a href="javascript:alert('준비중입니다.');">자료실</a></li> -->
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul8">
				<li><a href="<c:url value='/hills/champion/champion5.do'/>">여성아마추어대회</a></li>
				<li><a href="<c:url value='/hills/champion/champion2.do'/>">DMZ평화골프대회</a></li>			
				<li><a href="<c:url value='/hills/champion/champion3.do'/>">연단체 챔피언십</a></li>
				<li><a href="javascript:alert('준비중입니다.');">싱글인증전</a></li>
			</ul>
		</div>		
		<div class="menu">
			<ul class="subMenu ul9">
				<li><a href="<c:url value='/hills/reservation/reservationCheck.do'/>">마이존</a></li>
				<li><a href="<c:url value='/hills/contents/qna.do'/>">Q&A</a></li>
<!-- 				<li><a href="javascript:alert('준비중입니다.');">자료실</a></li> -->
				<li><a href="<c:url value='/hills/contents/weather.do'/>">날씨정보</a></li>
				<li><a href="<c:url value='/hills/map/map.do'/>">오시는길</a></li>
				<li><a href="<c:url value='/hills/contents/employ.do'/>">채용정보</a></li>
			</ul>
		</div>

	</div>
</div>