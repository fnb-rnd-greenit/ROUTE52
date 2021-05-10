<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	$( document ).ready( function() {
		$( '.teamTerms' ).click( function() {
	    	$(".termsWrap").slideToggle();
		});
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
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="on">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="">연단체신청</a>
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="">공지사항/조편성기입하기</a> --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
			<%-- <a href="<c:url value=''/>" class="">연단체공지사항</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">연단체안내</span>
		</div>
		<div class="subLine"></div>
		
		<div class="teamGuideBox">
			<!-- <div class="commonDot guideTitle"> 연단체 기본안내</div>
			<div class="teamGrayBox">			
				· 운영기간 : 2월 ~ 12월 (8회 이용) <br>
				· 운영요일 : 월요일 ~ 금요일 (주중), 주말은 유선 문의만 가능<br>
				· 운영시간 : 1부 / 2부 / 3부
				· 신청조건 : 3팀 이상
			</div> -->
			<img src="<c:url value='/images/hills/image_yteam_v2.jpg'/>" alt="">
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 팀의 구성</div>
			<div class="teamGrayBox">			
				· 팀 구성은 3팀 이상 5팀 이내로 합니다.(1팀 4인 기준)<br>
· 연단체로서 연간 8회 이상 내장을 기본으로 운영합니다.<br>
· 연단체 행사 시 회장 또는 총무 내장 필수이며, 고정 인원으로 구성되어야 합니다.<br>
· 연단체 소속의 모든 회원들은 당 클럽 홈페이지에 회원 가입을 한 후, 회원 명부를 제출하여야 합니다.
			</div>
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 연단체 혜택</div>
			<div class="teamGrayBox">			
				· 시간대별 차등 그린피 할인 상시 적용<br>
				· 연단체 모든 혜택은 팀당 4인 전제일 때만 가능합니다.	
				
				<table class="commonTable" style="margin:20px 0; width:95%; background-color:#f6f6f6;">
					<caption>연단체혜택</caption>
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>
					
					<tr>
						<th rowspan="2" colspan="2">연단체 운영타임</th>
                        <th rowspan="2">적용그린피</th>
						<th colspan="3">전제조건</th>
						
					</tr>
                    <tr>
                    	<th>대식당 이용 횟수조건</th>
                        <th>매달 약정 객단가 조건<br>(식음+프로샵/인당기준)</th>
                        <th>연단체 유지 최소 객단가 (반기)</th>
                    </tr>
					<tr>
						<th rowspan="3">1부</th>
						<td>06시30분 이전</td>
						<td>12만원</td>
					 	<td rowspan="4" style="border-bottom:1px solid #45454f;"> 매달 행사시 라운드 전or후 대식당 1회 필수이용</td>
					  	<td>3만원 이상</td>
						<td style="border-bottom:1px solid #45454f;">2.5만원 이상</td>
					</tr>
					<tr>
						<td>06시30분 이후</td>
						<td>13만원</td>
						<td>3만원 이상</td>
						<td style="border-bottom:1px solid #45454f;">2.5만원 이상</td>
					</tr>
					<tr>
						<td>07시대</td>
						<td>15만원</td>
						<td>4만원 이상</td>
						<td style="border-bottom:1px solid #45454f;">3.5만원 이상</td>
					</tr>
                    <tr>
						<th style="border-bottom:1px solid #45454f;">2부</th>
						<td>10~12시대</td>
						<td>16만원</td>
						<td>4만원 이상</td>
						<td style="border-bottom:1px solid #45454f;">3.5만원 이상</td>
					</tr>
				</table>
				· 연단체 혜택 및 이용 전제조건은 아래 '서원힐스 연단체 이용약관 보기'의 [제 5조 혜택]에서 자세한 내용을 참고 바랍니다.<br>
			</div>
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 예약관리</div>
			<div class="teamGrayBox">		
				· 행사일이 공휴일(대체공휴일포함), 대회개최, 클럽의 특별한 요청이 있을 경우 행사일자를 변경해야 합니다.<br> 
· 배정 완료 후 행사 전체취소는 14일 전까지, 팀 수 변경 및 시간대 조정은 경기일 7일 전까지 유선 요청해야 위약금이 발생되지 않습니다.<br>
· 매월 배정 신청 시간대에서 약 1시간 내외로 유동적일 수 있습니다.<br>
· 코스 배정은 이스트, 웨스트, 사우스 총 3개 코스를 로테이션으로 합니다.(특정코스 지정불가)<br>
· 연단체 운영 시 계약 및 이용약관에 관한 내용이 지켜지지 않을 경우 연단체 유지가 어려울 수 있습니다.
			</div>
		</div>

		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 위약관리</div>
			<div class="teamGrayBox">			
				· 3인 내장시 3.5인 요금으로 정산됩니다.<br>
				· 사전 팀 수 조정 없이 임박취소[행사일 6일전 ~ 당일 취소 및 미내장(No Show)]시에는 당사 위약 규정에 의거하여 위약금을 지불하여야 합니다.<br>
				· 클럽의 연단체 이용 약관을 위반할 시는 연단체 등록을 취소할 수 있습니다.
			</div>			
		</div>
		
		<p>※ 모든 연단체 운영 및 규정은 서원힐스 연단체 이용 약관(운영규정)에 의거하여 적용됩니다.<br><br></p>
		<p class="teamTerms"><img src="<c:url value='/images/hills/teamTerms.png'/>" alt=""> 서원힐스 연단체 이용약관 보기</p>
		
		<div class="termsWrap" style="display: none;">
			<h2>서원힐스 연단체 이용 약관(운영규정)</h2>
			<h3>제 1 조 【 목적 】</h3>
			<p>본 약관은 서원밸리컨트리클럽(이하 “당 클럽”)을 이용하려는 서원힐스 연부킹 단체팀(이하 “연단체”)의 클럽 시설물 이용 및 이에 따른 책임에 관한 사항을 규정함을 목적으로 한다.</p>
			<h3>제 2 조 【 구성 】</h3>
			<p>
			1.연단체 팀 구성은 3팀 이상 5팀 이내로 한다.(1팀 4인 기준)  <br>
			2. 연단체로서 연간 8회 이상 내장을 기본으로 운영한다.  <br>
			3. 연단체 행사 시 회장 또는 총무 내장 필수이며, 고정 인원으로 단체가 구성되어야 한다.  <br>
			4. 연단체 소속의 모든 회원들은 당 클럽 홈페이지(www.seowongolf.co.kr) 에 회원 가입을 한
			후, 회원 명부를 제출하여야 한다.
			</p>
			<h3>제 3 조 【 신청 】</h3>
			<p>
			1. 매년 10월 ~ 11월 중에 차년도 연단체를 신청한다. <br>
			2. 신청은 당 클럽 홈페이지에서 서원힐스 연단체 신청서 양식을 다운받아 FAX(031-957-2500) 또는 홈페이지에 게시된 이메일로 접수한다. <br>
			3. 기존 연단체도 해마다 재 신청 하여야 한다. <br>
			4. 확정 통보는 당 해년도 당 클럽이 정한 기간에 연단체 대표에게 유선 및 SMS 등으로 개별 통보하여 확정한다. <br>
			5. 선정된 연단체는 클럽 규정을 준수한다.
			</p>
			<h3>제 4 조 【 예약관리 】</h3>
			<p>
			1.연단체 확정시 해당 주차, 요일, 시간대를 결정하여 이를 기준으로 매월 배정한다. <br>
			단, 당 클럽의 영업 상황에 따라 매월 신청 시간대에서 약 1시간 내외로 유동적일 수 있다. <br>
			2. 예약 확정일자, 시간대는 매월 행사 예정일 기준 3주전까지 회장 또는 총무에게 유선(SMS)으로 통보한다. <br>
			3. 코스 배정은 이스트, 웨스트, 사우스 총 3개 코스를 로테이션으로 한다.(특정코스 지정불가) <br>
			4. 배정 완료 후 행사 전체취소는 14일 전까지, 팀 수 변경 및 시간대 조정은 경기일 7일 전까지유선 요청하여야 한다. <br>
			5. 연단체의 조편성은 경기일 최소 3일전까지 당 클럽에 FAX, 이메일, SMS 등으로 확정 통보하여야 한다. <br>
			6. 사전 통보 없이 예약 팀 수 보다 적게 내장하는 경우 제 8조 위약 관리 조항에 해당된다. <br>
			7. 연단체는 시간대별 최소 약정객단가 및 대식당 이용 조건이 있으며 성실히 이행하여야 한다. <br>
			8. 클럽 이용 실적(행사횟수, 약정객단가, 매너이슈 등)이 연단체 이용 및 차년도 재신청에 영향을 미칠 수 있다. <br>
			9. 예약을 불이행하는 경우에는 당 클럽에서 정한 규정에 따라 일정기간의 예약 정지나 이용제한, 위약금 부과 등의 조치를 취할 수 있다.
			</p>
			<h3>제 5 조 【 혜택 】</h3>
			<p>
			1. 연단체 그린피는 아래 표와같이 전제조건 하에 시간대별 확정 그린피가 적용된다.단, 연단체 소속 회원 전원이 서원 힐스 홈페이지 인터넷회원으로 가입 한 후, 회장/총무가 단체의 회원 명부를 클럽에 제출 및 등록하는 조건으로 매월 행사시 연단체 요금이 적용 된다.
			</p><br>
			<table class="commonTable" style="width:95%;">
                <caption>연단체 운영타임</caption>
				<colgroup>
				<col width="*">
				<col width="*">
                <col width="*">
				</colgroup>
                	<tr>
                        <th scope="col" rowspan="2" colspan="2">연단체 운영타임</th>
                        <th scope="col" rowspan="2">적용그린피</th>
						<th scope="col" colspan="3">전제조건</th>
					</tr>
                    <tr>
						<th>대식당 이용 횟수조건</th>
						<th>매달 약정 객단가 조건<br>(식음+프로샵/인당기준)</th>
                        <th>연단체 유지 최소 객단가(반기)</th>
                    </tr>
					<tr>
						<th rowspan="3">1부</th>
						<td>06시30분 이전</td>
						<td>12만원</td>
                        <td rowspan="4">매달 행사시 라운드 전or후<br>대식당 1회 필수이용</td>
                        <td>3만원 이상</td>
                        <td>2.5만원 이상</td>
					</tr>
					<tr>
						<td>06시30분 이후</td>
						<td>13만원</td>
                        <td>3만원 이상</td>
                        <td>2.5만원 이상</td>
					</tr>                    
					<tr>
						<td>07시대</td>
						<td>15만원</td>
  						<td>4만원 이상</td>
                        <td>3.5만원 이상</td>
					</tr>
					<tr>
						<th>2부</th>
						<td>10~12시대</td>
						<td>16만원</td>
                        <td>4만원 이상</td>
                        <td>3.5만원 이상</td>
					</tr>
				</table><br>
				<p>
1. 상반기(1~6월) 식음+프로샵 각 시간대별 연단체 유지 최소 객단가 미달 단체는 하반기(7~12월) 연단체 탈퇴 처리가 될 수 있다. <br>
&nbsp;&nbsp;&nbsp;&nbsp; 상기 할인 금액과 아래 상시 혜택 및 추가 베네핏은 당 클럽의 사정에 따라 변경 될 수 있 으며, 변경시 고지 후 시행 한다. <br>
2. 연단체 행사시에만 적용 가능한 상시 혜택으로 회장, 총무 본인 그린피 50% 할인(양도불가)과 라운드 후 대식당 만찬시 세트메뉴 20% 할인이 적용된다. <br>
3. 부가 혜택으로는 웨딩, 돌잔치등 각종행사 10% 할인이 적용된다. <br>
4. 연단체 모든 혜택은 팀당 4인 전제일 때만 가능하다.<br>
5. 정부지침에 따른 행정명령에 의한 단체 모임 미진행 시에는 해당 월 객단가 점수를 책정하지 않으며 연간 실적에 미반영 된다.
			</p>
			<h3>제 6 조 【 수용 】</h3>
			<p>
1. 운영기간은 1월부터 12월까지 12개월로 하며, 행사는 주중(월요일부터 금요일)에 한하여 진행한다. 단, 연중 12, 1, 2월의 3개월간은 일조시간 단축에 따라 경기를 제한할 수 있다. <br>
2. 연단체 행사는 월 1회로 제한한다. 단, 5주차에 한하여 실시간 그린피로 허용한다. <br>
3. 연단체의 약정된 팀 수 이상으로 행사시 추가된 팀은 실시간 그린피 요금 정책에 따른다. <br>
4. 특정 사유로 기존 3~5팀 연단체가 2팀 행사를 진행 하게된 경우 실시간 그린피 요금 정책에따른다.(1팀은 연단체로서 사전 배정 불가) <br>
5. 경기일이 공휴일인 경우 당 클럽과의 협의를 통해 해당 주 다른 요일 및 다른 주 해당 요일로 조정하여야 하며, 주말 또는 공휴일(임시 공휴일 포함)에 행사를 진행할 경우 실시간 그린피가 적용된다. <br>
6. 상반기 실적(행사횟수, 약정객단가, 포인트, 매너이슈 등)에 따라 하반기 이용에 제한이 있을수 있으며, 연간 실적에 따라 기존 연단체의 차년도 재신청에 제한을 두거나 티타임을 우선 배정할 수 있다. <br>
7. 당 클럽의 상황과 일조량에 따라 2부제 또는 3부제로 운영을 하며 신청 시간대는 3부제 기준이므로 2부제로 운영하는 경우 신청 시간대가 아닌 다른 시간대로 조정이 불가피하며 조정시 시간대별 연단체 요금 정책에 따른다. <br>
8. 골프장 이용과 관련된 규정 및 이용 요금은 경기 당일 기준에 준하여 적용 한다. <br>
9. 단체 행사 시상품의 외부 반입은 지양 한다. <br>
10. 골프장 운영상 특정 사유가 있거나 자체 클럽 행사가 있을 경우 연단체 배정일이 변경될 수 있다. <br>
11. 실시간 그린피는 클럽 정책에 따라 상시 변동될 수 있다.
			</p>
			<h3>제 7 조 【 이용의 거절 】</h3>
			<p>
당 클럽은 다음의 경우에는 클럽의 이용을 거절하거나 퇴장을 요구할 수 있다.<br>
1. 예약된 티타임 시간을 지키지 않는 때<br>
2. 본 약관을 위반하였을 때<br>
3. 경기능력이 현저히 부족하여 다른 이용자의 경기에 큰 방해가 될 때<br>
4. 도박성 내기를 하는 등 미풍양속에 어긋나는 행동을 할 때<br>
5. 대한골프협회 규칙, 기타 이용자 에티켓과 관련하여 클럽이 미리 고지한 준수사항을 위반할 때<br>
6. 골프장에 근무하는 직원, 캐디들에 대한 폭언 및 성희롱을 할 때<br>
(발생 즉시 강제 퇴장 요청, 연단체 취소 및 영구 내장 정지)<br>
※ 남녀고용평등법 제 2조 [별표1] 직장내 성희롱을 판단하기 위한 기준의 예시 기준<br>
7. 기타 사유로 당 클럽 이용에 적합하지 않다고 객관적으로 판단될 때
			</p>
			<h3>제 8 조 【 위약규정 】</h3>
			<p>
			1. 연단체의 운영은 해당 회장이 모든 책임을 진다.
2. 해당 월 라운드 취소는 경기일 14일 전까지, 팀 수를 축소 운영할 경우 경기일 7일 전까지 힐스 예약실의 주차별 배정 담당자에게 유선으로 통보하여야 한다. <br>
3. 7일 전 일부 취소되어 1팀만 운영하게 되는 경우 실시간 그린피를 적용 한다. <br>
4. 3인 내장시 3.5인 요금으로 정산 한다. <br>
5. 예약일 6~4일 전 전면, 일부 취소 <br>
- 위약금(취소 팀 수 * 1팀 4인기준 그린피 25%) 및 객단가 차감 <br>
6. 예약일 3~1일 전 전면, 일부 취소 <br>
- 위약금(취소 팀 수 * 1팀 4인기준 그린피 50%) 및 객단가 차감 <br>
7. No-Show, 당일취소 <br>
- 위약금(취소 팀 수 * 1팀 4인기준 그린피 100%) 및 객단가 차감 <br>
8. 객단가 차감에 관련된 세부사항은 본 이용 약관의 ‘제 10 조‘에 따른다. <br>
9. 위약금 미납 시 잔여 연 부킹 취소 및 해당 연단체 회원 모두를 영구 내장 정지한다. <br>
10. 연단체 중도 탈퇴시, 연단체로 적용받았던 모든 혜택(이익)에 상응하여 산출된 금액을 위약금으로 클럽에 지급하여야 한다.
			</p>
			<h3>제 9 조 【 경기진행 】</h3>
			<p>
1. 모든 이용자는 클럽내에서 항상 신사적 에티켓과 매너를 유지하고 질서를 지켜 다른 이용자 또는 경기 진행에 지장을 주지 말아야 한다. <br>
2. 원활한 경기진행을 위해 최소 40분전에 입장 등록을 마치고, Tee-Off 20분전까지 스타트광장에서 경기 준비를 완료하여야 한다. <br>
3. Tee-Off 20분 전 이후 내장 시 홀 합류, 홀 점프 등 당 클럽의 현장 경기 진행에 적극 협조하여야 한다. <br>
4. 당 클럽은 경우에 따라 경기 시간에 제한을 둘 수 있으며, 경기 진행 비협조 및 비매너 시 경고 조치하고 1회 이상의 경고에도 불구하고 적절한 속도를 유지하지 못하거나 개선되지 않을 경우 해당 경기자에게 퇴장 요청을 할 수 있다. <br>
5. 코스내 지정된 장소 이외에서의 흡연은 절대 불가하며, 경기 중 쓰레기를 적당한 용기에 처리함으로써 코스를 청결하게 유지하는데 협조하여야 한다. <br>
6. 강설, 폭우, 안개, 기타 천재지변 등 불가항력적인 사유로 플레이를 할 수 없을 경우 경기를 취소할 수 있다.
			</p>
			<h3>제 10 조【 객단가 차감 제도 】</h3>
			<p>
			1. 아래의 표에 명시된 항목에 따라 프로샵+식음 평균 객단가에서 해당 금액이 차감되며 차 후년도 재연장 신청 시 반영되어 불이익이 발생 될 수 있다.</p><br>
				<table class="commonTable" style="width:95%;">
                <caption>객단가 차감 제도</caption>
				<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				</colgroup>
                	<tr>
                        <th scope="col" rowspan="2">구분</th>
                        <th scope="col" rowspan="2">내용</th>
						<th scope="col"colspan="2">포인트</th>
					</tr>
                    <tr>
						<th>전면</th>
                        <th>일부</th>
                    </tr>
					<tr>
						<th rowspan="2">에티켓</th>
						<td>폭언 및 성희롱</td>
						<td colspan="2">발생 즉시 클럽 이용 거절<br>[약관 제 7 조 참조]</td>
					</tr>
					<tr>
						<td>진행, 예약협조 및 매너 불량</td>
						<td colspan="2">-2,000원</td>
					</tr>
					<tr>
						<th rowspan="5">위약 및 취소</th>
						<td>당일 미내장 및 당일 전면, 일부 취소</td>
						<td colspan="2">-30,000원</td>
					</tr>
					<tr>
						<td>1일전 전면, 일부 취소</td>
						<td>-20,000원</td>
						<td>-10,000원</td>
					</tr>
					<tr>
						<td>2일전 전면, 일부 취소</td>
						<td>-15,000원</td>
						<td>-5,000원</td>
					</tr>
					<tr>
						<td>3일전 전면, 일부 취소</td>
						<td>-10,000원</td>
						<td>-3,000원</td>
					</tr>
					<tr>
						<td>6~4일전 전면, 일부 취소</td>
						<td>-5,000원</td>
						<td>-1,000원</td>
					</tr>
					<tr>
                      <th rowspan="2">내장</th>
						<td>Tee-Off 임박 내장 및 이후 내장</td>
						<td colspan="2">-2,000원</td>
					</tr>
					<tr>
						<td>연간 행사 횟수 8회 미만(회당)</td>
						<td colspan="2">-10,000원</td>
					</tr>
					<tr>
						<th>내부규정</th>
						<td>외부 식음 반입 시(팀당)</td>
						<td colspan="2">-2,000원</td>
					</tr>				
				</table><br>
			<p>※ 매너 불량(비매너) 예시
1) 아래 예시에 대하여 무리하게 요청하거나 반복적이고 집요한 요구 및 강압적인 태도, 요청 사항이 받아들여지지 않을 시 지속적인 은근한 괴롭힘 등 <br>
예시) 추가할인, 밸리(회원제) 배정, 식사/커피서비스, 프로모션(이벤트)과 할인 중복 적용, 특정 코스 배정, 할인 쿠폰 추가 요청, 쿠폰 유효기간 연장 또는 재발급 등 <br>
2) 직원 및 캐디의 자존감 하락의 요인이 되는 태도 및 언행, 고성, 욕설, 폭언 등 <br>
3) 경기 진행 비협조, 취식물 반입 등 <br>
4) 기타 통상적인 비매너를 모두 포함한다.
			</p>
			<h3>제 11 조【 외부반입 취식물 관련 】</h3>
			<p>건강과 위생을 위하여 취식물 외부 반입을 제한한다 (특히 여름철 식중독 예방 차원)</p>
			<h3>제 12 조【 기타 】</h3>
			<p>본 약관에 명시되지 아니한 사항 또는 해석상 다툼이 있는 사항에 대해서는 일반 관례에 따라 합의하여 결정하되, 합의가 이루어지지 아니한 경우에는 민사소송법상의 관할 법원에 제기한다.</p>
			<h3>부칙</h3>
			<p>본 약관은 2021년 1월  1일부터 시행한다.</p>
		</div>
		</div>

		
	</div><!-- contents End -->


<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />