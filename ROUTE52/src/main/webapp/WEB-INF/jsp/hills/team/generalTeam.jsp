<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList6").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>일반단체</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<!-- <a href="javascript:alert('준비중입니다.');" class="">MY연단체</a> -->
			<%-- <a href="<c:url value='/hills/team/myTeam.do'/>" class="">MY연단체</a> --%>
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="">연단체신청</a>
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="">공지사항/조편성기입하기</a> --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="on">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
			<%-- <a href="<c:url value=''/>" class="">연단체공지사항</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">일반단체안내</span>
		</div>
		<div class="subLine"></div>
		
		<div class="teamGuideBox">
			<img src="<c:url value='/images/hills/ealryImg.png'/>" alt="">
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 얼리버드 멤버스 모집 신청</div>
			<div class="teamGrayBox">			
				· 모집기간: 20년12월14일(월) ~150단체 선착순 조기 마감까지_마감 완료 <a href="https://www.seowongolf.co.kr/hills/board/view.do?bbsType=1&idx=319
				" class="btn_round"><span class="orange">▶</span> 모집 안내 자세히 보기</a><br>
				※ 추가 접수는 유선 문의 바랍니다.(031-940-9400 / ARS.2번)				
			</div>
		</div>
		
		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 얼리버드 멤버스 운영 안내</div>
			<div class="">
				<table class="chargeTable w100">
					<colgroup>
						<col width="*">
						<col width="10%">
						<col width="10%">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>
					<tr>
						<th>구분</th>
						<th colspan="2">시간대</th>
						<th>대상</th>
						<th>팀수</th> 
						<th>그린피</th>
						<th>단체 예약 신청</th>
					</tr>
					<tr>
						<td rowspan="5">2021년 03~12월 주중</td>
						<td rowspan="2">1부</td>
						<td>5~6시대</td>
						<td rowspan="5">얼리버드 멤버스<br>가입 단체</td>
						<td rowspan="5">3~5팀</td>
						<td rowspan="5">예약 확정 시점<br>정상 실시간 그린피 적용<br>(1팀 4인 필수, 팀요금 적용)</td> 
						<td rowspan="5">매월 5주전 월요일<br>단체 예약 신청</td>
					</tr>
					<tr>
						<td>7시대</td>
					</tr>
					<tr>
						<td rowspan="3">2부</td>
						<td>10시대</td>
					</tr>
					<tr>
						<td>11시대</td>
					</tr>
					<tr>
						<td>12시대</td>
					</tr>
				</table>
			</div>
			<p class="contents">			
1. 얼리버드 멤버스 전용 계정으로 로그인 후 예약 일정을 확인하세요.<br>
   &nbsp;&nbsp;&nbsp;&nbsp;(5주전 월요일 오전 10시, 1개월 예약 신청 동시 오픈)<br>
2. 단체 예약 신청 시 식음 이용 구성을 필수로 미리 선택하게 되어 있습니다.<br>
3. 예약은 추첨을 통해 진행됩니다.<br>
<span class="orange">★ 매월 실적 (이용금액, 에티켓 등) 50% 상위 단체에게는 5~12월 단체 예약 신청 시 우선순위 혜택 적용<br>
★ 일별, 시간대별 배정 가능한 팀 수는 한정되어 있으며, 골프장 운영상의 사유로 예약이 불가할 수 있습니다.<br>
★ 연간 실적 (이용금액, 에티켓 등) 상위 단체에게는 차년도 연단체 모집 신청 시 우선순위 혜택 적용<br></span>
4. 매달 신청 가능 타임은 기본적으로 6~7시대, 10~12시대로 운영되며, 동절기를 제외한 간절기 3월, 4월, 11월의 경우 타임 테이블에 따라 운영되는 시간대가 변경될 수 있습니다.<br><br>
			</p>
			
			<div class="teamGrayBox requestGrayBox max">			
				<div class="requestTurnBox">
					<ul class="requestTurn">
						<li class="turnImg"><img src="/images/hills/request04.png" alt=""></li>
						<li class="turnTxt"><span class="bold">01.</span>(전용 계정 로그인)</li>
					</ul>
					<div class="requestArrow"><img src="/images/hills/requestArrow.png" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="/images/hills/request02.png" alt=""></li>
						<li class="turnTxt"><span class="bold">02.</span>(타임 오픈 시점 배정 신청)</li>
					</ul>
					<div class="requestArrow"><img src="/images/hills/requestArrow.png" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="/images/hills/request09.png" alt=""></li>
						<li class="turnTxt"><span class="bold">03.</span>추첨 및 우선 혜택 기준을 통해 예약<br>대상 단체 선정</li>
					</ul>
					<div class="requestArrow"><img src="/images/hills/requestArrow.png" alt=""></div>
					<ul class="requestTurn">
						<li class="turnImg"><img src="/images/hills/request03.png" alt=""></li>
						<li class="turnTxt"><span class="bold">04.</span>(예약 진행)</li>
					</ul>
				</div>	
			</div>
			
			<p><br>
			※ 매월 단체 예약 신청 시 3, 4월의 경우 팩스 신청으로 대체될 수 있습니다. 매월 안내 메시지를 참고해 주세요.<br>
			※ 추후 예약 진행 시 총 이용 예정 금액의 10%를 보증금 예치 후 예약 확정되는 방식으로 변경 예정입니다.<br><br><br><br></p>
			
			<p>* 예약 신청 오픈 예정일 (예정일은 당 클럽의 사정에 따라 변동될 수 있습니다.)<br><br></p>
			<table class="chargeTable w100">
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tr>
				<th>구분</th>
				<th>3월</th>
				<th>4월</th>
				<th>5월</th> 
				<th>6월</th>
				<th>7월</th>
				<th>8월</th>
				<th>9월</th>
				<th>10월</th>
				<th>11월</th>
				<th>12월</th>
			</tr>
			<tr>
				<td>오픈예정일</td>
				<td>1/25(월)</td>
				<td>2월 4주차</td>
				<td>3월 5주차</td>
				<td>4월 4주차</td>
				<td>5월 4주차</td>
				<td>6월 4주차</td>
				<td>7월 4주차</td>
				<td>8월 5주차</td>
				<td>9월 4주차</td>
				<td>10월 4주차</td>
			</tr>
		</table>
		
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 예약관리</div>
			<div class="teamGrayBox">			
				· 행사 시 회장 또는 총무 내장 필수입니다.<br>
· 단체 소속의 모든 회원들은 당 클럽 홈페이지에 회원 가입을 해주셔야 합니다.<br>
· 예약 완료 후 행사 전체 취소는 14일 전까지, 팀 수 변경 등의 기타 요청은 7일 전까지 유선 요청해야 불이익이 발생되지 않습니다.<br>
· 코스는 특정 코스 지정 불가합니다.<br>
· 예약을 불이행하는 경우에는 당 클럽에서 정한 규정에 따라 특정 기간의 예약 정지나 이용제한, 위약금 부과 등의 조치를 취할 수 있습니다.<br>
			</div>
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 위약관리</div>
			<div class="teamGrayBox">			
				· 사전 팀 수 조정 없이 임박 취소(행사일 7일전~당일 취소 및 미내장) 시 당사 위약 규정에 의거하여 위약금을 지불해야 합니다.<br>
· 예약 완료 후 행사 전체 취소는 14일 전까지 유선 요청해야만 보증금 100% 환불 가능하며, 13일전~4일전 50%환불, 3일전~0일전 환불X(소멸) 적용됩니다.<br>
· 당 클럽의 얼리버드 멤버스 이용 약관을 위반할 시 얼리버드 멤버스에서 탈퇴 또는 일정 기간 단체 예약 신청 제한 처리될 수 있습니다.<br>
			</div>
		</div>
		<p>
		※ 모든 얼리버드 멤버스 운영 및 규정은 서원힐스 얼리버드 멤버스 이용 약관 (운영규정)에 의거하여 적용됩니다.<br> 		
		<br> </p>
		<p><a href="https://kr.object.ncloudstorage.com/hills/document/21%EB%85%84%20%EC%96%BC%EB%A6%AC%EB%B2%84%EB%93%9C%20%EB%A9%A4%EB%B2%84%EC%8A%A4%28%EC%9D%BC%EB%B0%98%EB%8B%A8%EC%B2%B4%29%20%EC%9A%B4%EC%98%81%EA%B7%9C%EC%A0%95%28%EC%B5%9C%EC%A2%85%29.pdf" class="btn_round" target="_blank"><span class="orange">▶</span> 이용약관 파일 별도 첨부</a></p>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />