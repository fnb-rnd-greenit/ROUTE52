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
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>이용요금</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/valley/guide/useGuide.do'/>" class="">이용안내</a>
			<a href="<c:url value='/valley/guide/charge.do'/>" class="on">이용요금</a>
			<%-- <a href="<c:url value='/valley/guide/membership.do'/>" class="">회원권안내</a> --%>
			<a href="<c:url value='/valley/guide/etiquette.do'/>" class="">골프에티켓</a>
			<a href="<c:url value='/valley/guide/localRule.do'/>" class="">로컬룰</a>			
		</div>
		
		<div class="subTitle">
			<span class="title">이용요금</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 이용요금</li>
			<li>
				<table class="chargeTable">
					<caption>이용요금</caption>
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th class="title" rowspan="2"></th>
							<th class="title" colspan="2">정회원</th>
							<th class="title" colspan="2">준회원</th>
							<th class="title" colspan="2">주중회원</th>
							<th class="title" colspan="2" style="border-bottom:1px solid #dbdada;">비회원</th>
						</tr>
						<tr>
							<th class="title">분양가<br>1.8억~4.2억</th>
							<th class="title">분양가<br>1.3억~1.7억</th>
							<th class="title">분양가<br>1.8억~4.2억</th>
							<th class="title">분양가<br>1.3억~1.7억 </th>
							<th class="title">1부</th>
							<th class="title">2부</th>
							<th class="title">1부</th> 
							<th class="title">2부</th>
						</tr>
						<tr>
							<th class="title">주중</th>
							<td>33,000</td>
							<td>55,000</td>
							<td>80,000</td>
							<td>80,000</td>
							<td>80,000</td>
							<td>80,000</td>
							<td>210,000</td>
							<td>210,000</td>
						</tr>
						<tr>
							<th class="title" style="line-height:18px;">토요일<br>(공휴일)</th>
							<td>33,000</td>
							<td>55,000</td>
							<td>90,000</td>
							<td>150,000</td>
							<td>270,000</td>
							<td>270,000</td>
							<td>270,000</td>
							<td>270,000</td>
						</tr>
						<tr>
							<th class="title">일요일</th>
							<td>33,000</td>
							<td>55,000</td>
							<td>90,000</td>
							<td>150,000</td>
							<td>270,000</td>
							<td>260,000</td>
							<td>270,000</td>
							<td>260,000</td>
						</tr>
					</tbody>
				</table>

			</li>
			<li class="chargeContent">
				· 주중예약은 전화와 인터넷으로 실시간 예약이 가능합니다. <br>
				· 주말/공휴일 예약은 팩스와 인터넷 접수 후 다음날 문자메시지 통보드립니다. <br>
				<!-- · 주중회원과 준회원은 일요일 오후 12시 이후 내장시 주중요금(70,000)을 적용합니다. <br> -->
				· 5월 1일 ‘근로자의 날’ 은 공휴일 요금이 적용 됩니다. <br>
				· 휴일의 경우 토요일 요금이 적용됩니다.
			</li>
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 부대비용</li>
			<li>
				<table class="chargeTable">
				<caption>부대비용</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th class="title">캐디피</th>
						<th class="title">카트이용료</th>
						<th class="title" colspan="2">클럽대여</th>
						<th class="title" rowspan="2">단품대여</th>
					</tr>
					<tr>
						<th class="title" style="height:25px;line-height:25px;">1캐디 4백</th>
						<th class="title" style="height:25px;line-height:25px;">(5인승 전동카)</th>
						<th class="title" style="height:25px;line-height:25px;">FULL SET (남)</th>
						<th class="title" style="height:25px;line-height:25px;">FULL SET (여)</th>
					</tr>
					<tr>
						<td>130,000</td>
						<td>90,000</td>
						<td>70,000</td>
						<td>50,000</td>
						<td>10,000</td>
					</tr>
				</tbody>
			</table>
			</li>
			<li class="chargeContent">
			· 1팀당 1명의 캐디가 배치되며, 2인 이상의 캐디 요청시 예약사항을 고려하여 배정됩니다. 
			</li>
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 임시휴장을 결정했을 경우 <span style="font-size:13px">(악천후 등)</span></li>
			<li>
				<table class="chargeTable">
				<caption>임시휴장을 결정했을 경우 (악천후 등)</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th class="title" rowspan="2">기준</th>
						<th class="title" colspan="2">그린피</th>
						<th class="title" rowspan="2">카트료</th>
						<th class="title" rowspan="2">캐디피</th>
					</tr>
					<tr>
						<th>회원</th>
						<th>비회원</th>
					</tr>
					<tr>
						<td>1홀~9홀</td>
						<td rowspan="2" colspan="2">홀별정산</td>
						<td>45,000</td>
						<td>70,000</td>
					</tr>
					<tr>
						<td>10홀~18홀</td>
						<td>90,000</td>
						<td>130,000</td>
					</tr>
				</tbody>
			</table>
			</li>
			<li class="chargeContent">
			※ 홀별정산 기준 : 시간대별 그린피에서 이용한 홀만큼의 코스 사용료 부과(18홀 그린피 ÷ 18홀)X 라운드홀 수<br>
			※ 본인 과실로 인한 사고 또는 개인사정으로 인한 홀아웃은 홀별정산이 불가 합니다. (18홀 그린피 정상결제)
			</li>
		</ul>

		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />