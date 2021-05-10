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
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>이용안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/valley/guide/useGuide.do'/>" class="on">이용안내</a>
			<a href="<c:url value='/valley/guide/charge.do'/>" class="">이용요금</a>
			<%-- <a href="<c:url value='/valley/guide/membership.do'/>" class="">회원권안내</a> --%>
			<a href="<c:url value='/valley/guide/etiquette.do'/>" class="">골프에티켓</a>
			<a href="<c:url value='/valley/guide/localRule.do'/>" class="">로컬룰</a>			
		</div>
		
		<div class="subTitle">
			<span class="title">이용안내</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 예약안내/취소</li>
			<li>
				<table class="chargeTable">
				<caption>예약안내/취소</caption>
				<colgroup>
					<col width="16%">
					<col width="28%">
					<col width="28%">
					<col width="28%">
				</colgroup>
				<tbody>
					<tr>
						<th class="title">구 분</th>
						<th class="title">정회원</th>
						<th class="title">주중/준회원</th>
						<th class="title">예약취소</th>
					</tr>
					<tr>
						<td>주중</td>
						<td>3주전 월요일 9시부터</td>
						<td>3주전 화요일 9시부터</td>
						<td>해당요일 제외한 4일전 17시까지</td>
					</tr>
					<tr>
						<td>주말</td>
						<td>2주전 화요일 8시~16시 까지접수<br>수요일 13시 통보</td>
						<td></td>
						<td>해당요일 제외한 5일전 17시까지</td>
					</tr>
				</tbody>
			</table>
			</li>
			<li class="chargeContent">
			· 주중예약은 전화와 인터넷으로 예약이 가능합니다. <br>
			· 주말/공휴일예약은 팩스와 인터넷으로 접수 후 다음날 확정 문자 발송해 드립니다.
			</li>
		</ul>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 예약위약자 벌칙규정</li>
			<li class="chargeContent" style="margin:10px 0;">
			· 골프 예약문화의 정착과 공정한 예약기회 제공을 위하여 위약관련 규정을 안내하오니 많은 협조 부탁드립니다.
			</li>
			<li>
				<table class="chargeTable">
				<caption>예약위약자 벌칙규정</caption>
				<colgroup>
					<col width="10%">
					<col width="13%">
					<col width="13%">
					<col width="13%">
					<col width="13%">
					<col width="13%">
					<col width="25%">
				</colgroup>
				<tbody>
					<tr>
						<th class="title" colspan="2">위약구분</th>
						<th class="title">당일미내장/<br>당일취소</th>
						<th class="title">1일전 취소</th>
						<th class="title">2,3일전 취소</th>
						<th class="title">4일전 취소</th>
						<th class="title">협의 없이 비회원내장</th>
					</tr>
					<tr>
						<td rowspan="2">위약금</td>
						<td>주중</td>
						<td>400,000원</td>
						<td>300,000원</td>
						<td>100,000원</td>
						<td></td>
						<td>라운딩불가, 위약금적용</td>						
					</tr>
					<tr>
						<td>주말</td>
						<td>500,000원</td>
						<td>500,000원</td>
						<td>300,000원</td>
						<td>100,000원</td>
						<td>라운딩불가, 위약금적용</td>						
					</tr>
					<tr>
						<td colspan="2">예약정지기간</td>
						<td>1개월정지</td>
						<td>1개월정지</td>
						<td>3주간정지</td>
						<td>2주간정지</td>
						<td>1개월정지</td>
					</tr>
					<tr>
						<td colspan="2">비고 </td>
						<td colspan="5">1. 예약취소는 회원만 가능함&nbsp;&nbsp;&nbsp;&nbsp;2. 단체팀은 위약금 *팀수적용</td>
					</tr>
				</tbody>
			</table>
			</li>		
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 복장안내</li>
			<li class="chargeContent">
			· 품격있는 클럽분위기 유지를 위하여 내장및 플레이 복장 규정을 운영하오니 많은 협조 바랍니다. <br><br>
			&nbsp;&nbsp;- &nbsp;내장시 남성은 재킷을 착용해 주시기 바랍니다.<br>
			&nbsp;&nbsp;&nbsp;&nbsp;찢어진 청바지, 반바지 착용시 입장을 제한할수 있습니다.<br>
			&nbsp;&nbsp;&nbsp;&nbsp;신발은 샌들 슬리퍼 착용을 금지하고 있습니다.<br>
			<br>
			&nbsp;&nbsp;- &nbsp;플레이시 칼라 있는 셔츠를 착용해 주시기 바랍니다.<br>
			&nbsp;&nbsp;&nbsp;&nbsp;여성 : 민소매, 짧은치마, 핫팬츠 등<br>
			&nbsp;&nbsp;&nbsp;&nbsp;타인에게 혐오감을 줄수있는 복장을 규제하고 있습니다.<br>
			&nbsp;&nbsp;&nbsp;&nbsp;남성 : 반바지 착용 및 칼라 없는 셔츠(통칭 라운드티)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;타인에게 혐오감을 줄수있는 복장을 규제하고 있습니다.<br>
			</li>
		</ul>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 위약자 벌칙규정</li>
			<li>
				<table class="chargeTable leftText">
					<caption>위약자 벌칙규정</caption>
					<colgroup>
						<col width="65%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th class="title">위약구분</th>
							<th class="title">위약관리</th>
						</tr>
						<tr>
							<td>예약 시간보다 늦게 도착한 경우 (상습적)</td>
							<td class="center">상황별 홀 JUMP/라운드불가</td>
						</tr>
						<tr>
							<td>고의적인 경기진행 지연</td>
							<td rowspan="5" class="center">2회 경고후 퇴장조치</td>
						</tr>
						<tr>
							<td>상습적인 도박행위</td>
						</tr>
						<tr>
							<td>캐디농락(희롱), 과도한 음담패설, 욕설</td>
						</tr>
						<tr>
							<td>경기능력이 현저히 부족하여 다른 이용자에게 방해가 되는경우</td>
						</tr>
						<tr>
							<td>금연 지역 내에서의 흡연</td>
						</tr>
						<tr>
							<td>고의로 그린 훼손시</td>
							<td rowspan="2" class="center">변상조치및 퇴장</td>
						</tr>
						<tr>
							<td>기물파손</td>
						</tr>
						<tr>
							<td>기타 클럽의 품위를 손상시키는 행위</td>
							<td rowspan="3" class="center">사안별 예약제한</td>
						</tr>
						<tr>
							<td>음주, 방뇨, 고성방가</td>
						</tr>
						<tr>
							<td>지정티마크이외 임의티 사용자</td>
						</tr>
						<tr>
							<td>복장불량자</td>
							<td class="center">복장 교환 후 라운드</td>
						</tr>
					</tbody>
				</table>
			</li>		
		</ul>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 이용방법</li>
			<li>
				<table class="chargeTable leftText">
					<caption>이용방법</caption>
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tbody>
						<tr>
							<th class="title" class="center">현관</th>
							<td>내장하시는 회원님과 고객님께서는 현관에서 클럽을 내리신 후 차량을 직접 주차(전면주차)하여 주시고, <br>
							차량키는 담당 캐디에게 맡겨 주시면 됩니다.</td>
						</tr>
						<tr>
							<th class="title" class="center">프론트</th>
							<td><br>- 예약시간과 예약자명을 말씀하시고 방명록을 작성 후, 티오프 시간과 코스를 재확인하고 락카키를<br> 수령하시면 됩니다. <br>
							- 그린피, 식대, 캐디피(현금결재)등 모든 요금은 플레이를 마치신 후 일괄 계산하시면 되며, <br>이때 락카키를 반납해 주시기 바랍니다. <br>
							- 단체팀의 경우 전일까지 조편성 명단을 제출해 주시기 바랍니다. <br><br></td>
						</tr>
						<tr>
							<th class="title" class="center">욕실</th>
							<td>문신자는 입욕을 금하고 있습니다.</td>
						</tr>
						<tr>
							<th>경기진행</th>
							<td>티오프 10분전에 스타트에 나오시어 스트레칭 체조로 라운드를 준비하여 주십시오.</td>
						</tr>
					</tbody>
				</table>
			</li>		
		</ul>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 이용에티켓</li>
			<li>
				<table class="chargeTable leftText">
					<caption>이용에티켓</caption>
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tbody>
						<tr>
							<th class="title" class="center">해당사항</th>
							<td style="padding:10px 0 10px 30px;">- 티오프 1시간전에 클럽하우스에 도착하여 여유롭게 라운드를 준비하여 주십시오. <br>
							- 귀중품은 프론트에 보관하시고, 프론트에 보관하지 않은 모든 귀중품은 분실시 책임지지 않습니다. <br>
							- 입장시 복장은 정장 차림으로 단정하게 착용하여 타고객에게 불편을 끼치는 일이 없도록 부탁드립니다. <br>
							- 초심자를 동반하거나, 내기 골프 등으로 진행에 차질을 주는 일이 없도록 합니다. <br>
							- 라운드 중 코스 내에서의 흡연은 금지하오니, 반드시 지정된 장소를 이용해 주십시오. <br>
							- 벙커샷 후에는 반드시 고무래로 벙커를 정리해 주시기 바랍니다. <br>
							- 그린 보호를 위하여 반드시 고무징 골프화를 착용하시기 바랍니다. <br>
							- 스윙으로 생긴 잔디 뗏장은 반드시 디봇 위치에 되돌려 놓고 발로 힘있게 눌러 주십시오. <br>
							 <br>
							<span class="bold">휴대전화 사용 에티켓</span> <br>
							- 실내에서는 휴대전화를 진동으로 바꿔주시고, 경기시에는 휴대전화를 잠시 꺼주시어 동반자에 대한 예를 <br> 갖추는 매너있는 골퍼의 모습을 보여주시기 바랍니다.
							</td>
						</tr>
					</tbody>
				</table>
			</li>		
		</ul>
		

		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />