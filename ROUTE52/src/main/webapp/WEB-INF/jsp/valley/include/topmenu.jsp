<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div id="scrollmenuwrap">
	<div id="scrollmenu">
		<div class="menu">
			<ul class="subMenu ul1">
				<li><a href="<c:url value='/valley/club/intro.do'/>">인사말</a></li>
				<li><a href="<c:url value='/valley/club/cibi.do'/>">CI/BI소개</a></li>
				<li><a href="<c:url value='/valley/club/history.do'/>">연혁</a></li>		
				<!-- <li><a href="javascript:alert('준비중입니다.');">글로벌멤버쉽</a></li> -->
				<li><a href="<c:url value='/valley/club/s_greenConcert.do'/>">서원알리기</a></li>		
				<%-- <li><a href="<c:url value='/valley/club/global.do'/>">글로벌멤버쉽</a></li> --%>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul2">
				<li><a href="<c:url value='/valley/guide/useGuide.do'/>">이용안내</a></li>
				<li><a href="<c:url value='/valley/guide/charge.do'/>">이용요금</a></li>
				<%-- <li><a href="<c:url value='/valley/guide/membership.do'/>">회원권안내</a></li> --%>  
				<li><a href="<c:url value='/valley/guide/etiquette.do'/>">골프에티켓</a></li>
				<li><a href="<c:url value='/valley/guide/localRule.do'/>">로컬룰</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul3">
				<li><a href="<c:url value='/valley/reservation/reservation.do'/>">실시간예약</a></li>
				<li><a href="<c:url value='/valley/reservation/reservationWait.do'/>">대기예약</a></li>
				<li><a href="<c:url value='/valley/reservation/reservationGuide.do'/>">예약방법안내</a></li>
				<li><a href="<c:url value='/valley/reservation/reservationCheck.do'/>">예약확인/취소</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul4">
				<li><a href="<c:url value='/valley/facil/facil01.do'/>">밸리하우스</a></li>
				<li><a href="<c:url value='/valley/facil/facil02.do'/>">스타트하우스</a></li>
				<li><a href="<c:url value='/valley/facil/facil03.do'/>">프로샵</a></li>
				<li><a href="<c:url value='/valley/facil/facil04.do'/>">그늘집</a></li>
				<li><a href="<c:url value='/valley/facil/facil05.do'/>">대식당</a></li>
				<li><a href="<c:url value='/valley/facil/facil06.do'/>">연회장</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul5">
				<li><a href="<c:url value='/valley/course/courseIntro.do'/>">코스안내</a></li>
				<li><a href="<c:url value='/valley/course/course_seowon.do'/>">코스공략도</a></li>
				<li><a href="<c:url value='/valley/board/list.do?bbsType=36'/>">코스갤러리</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul6">
				<li><a href="<c:url value='/valley/board/list.do?bbsType=1'/>">공지사항</a></li>
				<li><a href="<c:url value='/valley/board/list.do?bbsType=2'/>">뉴스</a></li>
				<li><a href="<c:url value='/valley/board/list.do?bbsType=3'/>">포토갤러리</a></li>
				<li><a href="<c:url value='/valley/board/reference.do'/>">자료실</a></li>
			</ul>
		</div>
		<div class="menu">
			<ul class="subMenu ul7">
				<li><a href="<c:url value='/valley/contents/qna.do'/>">Q&A</a></li>
				<li><a href="<c:url value='/valley/contents/weather.do'/>">날씨정보</a></li>
				<li><a href="<c:url value='/valley/map/map.do'/>">오시는길</a></li>
				<li><a href="<c:url value='/valley/contents/employ.do'/>">채용정보</a></li>
			</ul>
		</div>
	</div>
</div>