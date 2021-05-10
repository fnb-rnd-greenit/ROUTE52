<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".fareTabList").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>
<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>아카데미 &nbsp;&nbsp;&nbsp; ＞ <span>이용요금</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="on">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/academiFare.do'/>" class="on">아카데미 요금안내</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="">입점 아카데미</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academiPlayer.do'/>" class="">선수단 소개</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=33'/>" class="">아카데미 대회성적</a>
		</div>
		
		<div class="subTitle">
			<span class="title">이용요금</span>
		</div>
		<div class="subLine"></div>

		<div class="fareBox">
			<div class="fareContent">
				<div class="commonDot guideTitle"> 아카데미 패키지 요금</div>
				<table class="OrangeTable">
				<caption>아카데미 패키지 요금</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">패키지 1</th>
							<th scope="col">패키지 2</th>
							<th scope="col">개별타석 패키지</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>이용금액</td>
							<td>110만원</td>
							<td>100만원</td>
							<td>70만원</td>
						</tr>
						<tr>
							<td>타석 + 숏게임</td>
							<td colspan="3">자유 이용</td>
						</tr>
						<tr>
							<td>라운드 이용</td>
							<td>정규 18H 8회 이용</td>
							<td>정규 18H 6회 이용</td>
							<td>라운드 별도</td>
						</tr>										
					</tbody>					
				</table>
				
				<div class="commonDot guideTitle"> 일반인 레슨 요금</div>
				<table class="blackTable">
				<caption>일반인 레슨 요금</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">이용요금</th>
							<th scope="col">비고</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>일반 레슨</td>
							<td>250,000</td>
							<td>주 4회 레슨</td>
						</tr>
						<tr>
							<td>프리미엄 레슨</td>
							<td>300,000</td>
							<td>주 4회 레슨<br>(스윙분석 2회, 숏게임 2회 포함)</td>
						</tr>
						<tr>
							<td>원포인트 레슨 숏게임 레슨</td>
							<td>50,000</td>
							<td>30분</td>
						</tr>	
						<tr>
							<td>필드 레슨</td>
							<td>1人 100,000</td>
							<td>최소 3인 라운드에 한 함</td>
						</tr>										
					</tbody>					
				</table>
			</div>
		</div>
	</div>
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />