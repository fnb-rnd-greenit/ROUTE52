<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" flush="true" />
<jsp:include page="../include/subTop.jsp" flush="true" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>예약서비스 &nbsp;&nbsp;&nbsp; ＞ <span>예약확인</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="reserTabList">
			<a href="<c:url value='/valley/reservation/reservation.do'/>" class="">실시간예약</a>	
			<a href="<c:url value='/valley/reservation/reservationWait.do'/>" class="">대기예약</a>
			<a href="<c:url value='/valley/reservation/reservationGuide.do'/>" class="on">예약안내</a>
		</div>
		
		<div class="subTitle">
			<span class="title">예약안내</span>
			<span class="titleDes">예약시 꼭 알아둬야할 점들을 알려드립니다.</span>
		</div>
		<div class="subLine"></div>
		
		<div class="reserGuideBox">
			<span class="commonDot"></span><span class="orangeRed">주중예약 (예약 취소는 해당요일 제외한 4일전 17:00까지 가능)</span>
			<ul class="guideTxt">
				<li>1. 정회원 : 예약일로부터 3주전 월요일 09:00부터 : 전화 또는 인터넷 예약</li>
				<li>2. 주중/준회원 : 예약일로부터 3주전 화요일 09:00부터 : 전화 또는 인터넷 예약</li>
			</ul>
			<span class="commonDot"></span><span class="orangeRed">주말 및 공휴일예약 (예약 취소는 해당요일 제외한 5일전 17:00까지 가능)</span>
			<ul class="guideTxt">
				<li>1. 정회원 : 예약하는 주를 제외한 2주전 화요일(08:00 ~ 16:00) : 팩스 또는 인터넷접수 선착순 예약이 아니라 08:00 ~ 16:00까지 </li>				
				<li class="et">접수한 회원의 예약 횟수에 따른 배정 (월2회 보장, 시간대까지 보장은 아님)</li>
				<li class="et"><img src="<c:url value='/images/valley/r_a.png'/>" alt=""> 16:00 이후 연락 시 대기접수(잔여타임에 한하여 예약가능)</li>
				<li class="et"><img src="<c:url value='/images/valley/r_a.png'/>" alt=""> 주말예약 배정 시간, 준회원 또는 비회원 위임 불가(위약 발생)</li>				
				<li>&nbsp;</li>
				<li>2. 주중/준회원 : 주말부킹 불가(정회원 배정 후 잔여타임에 한하여 단독 부킹 가능)</li>
                <li class="et"><img src="<c:url value='/images/valley/r_a.png'/>" alt=""> 주말예약의 경우 정회원 예약신청 후 준회원으로 변경 불가</li>
				<li>&nbsp;</li>
				<li>3. 주말 및 공휴일 예약(예시)</li>
				<li>
					<ul class="weekTxt">
						<!-- <li>예약안내 - 주말및 공휴일예약</li> -->
						<li>예약일 : 2021년 06월 19일 (토)</li>
						<li>예약 신청일 : 2021년 06월 01일(화)</li>
						<li>예약 통보일 : 2021년 06월 02일(수) 13시 이후</li>
						<li class="line">예약 배정방법 :<br>
						1) 횟수 체크 기준:<br>&nbsp;예약일 직전 한달 [05월19일(수,공)~06월18일(금)]사이 주말 및 공휴일에 예약이 되어있는 횟수를 체크<br>
						2) 예약이 적으신 분부터 전산에 자동 배정됨 (주말예약 횟수가 많은경우 배정이 되지 않을수 있음)<br>
						3) 횟수보장: 주말부킹 건은 정회원에 한하여 직전한달 2회[05월 19일(수,공)~ 06월 18일(금) 예약기준]보장 <br>
						 &nbsp;시간대 보장은 아니며, 잔여타임 사용도 횟수 사용으로 포함<br>
						 &nbsp;※ 우천취소 , 눈취소 도 횟수에 포함
						 </li>
						
					</ul>
				</li>
			</ul>

		</div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />