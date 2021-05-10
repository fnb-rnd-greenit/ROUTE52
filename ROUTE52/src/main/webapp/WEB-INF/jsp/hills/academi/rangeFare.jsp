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
<script type="text/javascript">
	function FareTab(gubun) {
		if (gubun == "1") {
			$("#fareTab1").attr("style", 'display:block');
			$("#fareTab2").attr("style", 'display:none');
			$("#fareTab3").attr("style", 'display:none');
		}
		else if (gubun == "2") {
			$("#fareTab1").attr("style", 'display:none');
			$("#fareTab2").attr("style", 'display:block');
			$("#fareTab3").attr("style", 'display:none');
		}
		else if (gubun == "3") {
			$("#fareTab1").attr("style", 'display:none');
			$("#fareTab2").attr("style", 'display:none');
			$("#fareTab3").attr("style", 'display:block');
		}
	}
</script>

<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>드라이빙레인지 &nbsp;&nbsp;&nbsp; ＞ <span>이용요금</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="on">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="on">이용요금</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/rangeFacil.do'/>" class="">시설안내</a>
			<!-- <a href="javascript:alert('준비중입니다.');">시설안내</a> -->
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=31'/>">공지사항</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=32'/>">이벤트</a>
		</div>
		
		<div class="subTitle">
			<span class="title">이용요금</span>
		</div>
		<div class="subLine"></div>

		<div class="fareBox" id="fareTab1">
			<div class="fareTab3">
				<ul>
					<li class="on" onClick="javascript:FareTab(1);">기간제 상품</li>
					<li class="" onClick="javascript:FareTab(2);">일일 및 쿠폰 상품</li>
					<li class="" onClick="javascript:FareTab(3);">셀프 9홀 상품</li>
				</ul>
			</div>
			<div class="fareLine"></div>
			<div class="fareContent">
				<div class="commonDot guideTitle"> 월회원 상품</div>
				<table class="OrangeTable">
				<caption>쿠폰상품</caption>
					<colgroup>
					<col width="15%">
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">1개월</th>
							<th scope="col">3개월</th>
							<th scope="col">6개월</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<th>이용요금</th>
							<td>130,000</td>
							<td>350,000</td>
							<td>650,000</td>
						</tr>
						<tr>
							<th>배정시간</th>
							<td colspan="3">70분 배정</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3">주중/주말 동일 샤워실 및 휘트니스 이용</td>
						</tr>											
					</tbody>					
				</table>
				
				<div class="commonDot guideTitle"> 연회원 상품</div>
				<table class="blackTable">
				<caption>쿠폰상품</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">GOLD</th>
							<th scope="col">SILVER</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<th>이용요금</th>
							<td>120만원</td>
							<td>90만원</td>
						</tr>
						<tr>
							<th>연습장 이용</th>
							<td>12개월(90분)</td>
							<td>12개월(70분)</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>- 숏게임장(60분) 이용쿠폰 10매 <br>
                            	- 원포인트 레슨 쿠폰 5매 <br>
                                - 노캐디 야간 9홀 쿠폰 2매 <br>
                                - 힐스 주중 1,3부 1인 그린피 면제 10회
                            </td>
							<td>- 숏게임장(60분) 이용쿠폰 5매</td>
						</tr>											
					</tbody>					
				</table>
			</div>
		</div>
		
		<div class="fareBox" id="fareTab2">
			<div class="fareTab3">
				<ul>
					<li class="" onClick="javascript:FareTab(1);">기간제 상품</li>
					<li class="on" onClick="javascript:FareTab(2);">일일 및 쿠폰 상품</li>
					<li class="" onClick="javascript:FareTab(3);">셀프 9홀 상품</li>
				</ul>
			</div>
			<div class="fareLine"></div>
			<div class="fareContent">
				<div class="commonDot guideTitle"> 일일 상품</div>
				<table class="OrangeTable">
				<caption>일일 상품</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" colspan="2">구분</th>
							<th scope="col">주중</th>
                            <th scope="col">주말/공휴일</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td rowspan="3">자동 타석</td>
							<td>30분</td>
							<td>10,000</td>
							<td>12,000</td>
						</tr>
						<tr>
							<td>60분</td>
							<td>16,000</td>
							<td>18,000</td>
						</tr>
						<tr>
							<td>90분</td>
							<td>20,000</td>
							<td>22,000</td>
						</tr>
						<tr>
							<td rowspan="3">숏 게임</td>
							<td>30분</td>
							<td>10,000</td>
							<td>12,000</td>
						</tr>
						<tr>
							<td>60분</td>
							<td>18,000</td>
							<td>20,000</td>
						</tr>
						<tr>
							<td>90분</td>
							<td>24,000</td>
							<td>26,000</td>
						</tr>
																		
					</tbody>					
				</table>
				
				<div class="commonDot guideTitle"> 일일 패키지 상품</div>
				<table class="OrangeTable">
				<caption>일일 상품</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="40%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" colspan="2" rowspan="2">구분</th>
							<th scope="col" colspan="2">이용요금</th>
							<th scope="col" rowspan="2">이용조건</th>
						</tr>
						<tr>
							<th scope="col">주중</th>
                            <th scope="col">주말/공휴일</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td rowspan="3">BASIC PACKAGE</td>
							<td>S</td>
							<td>24,000</td>
							<td>26,000</td>
							<td>자동타석 30분+숏게임 60분</td>
						</tr>
						<tr>
							<td>E</td>
							<td>22,000</td>
							<td>24,000</td>
							<td>자동타석 60분+숏게임 30분</td>
						</tr>
						<tr>
							<td>O</td>
							<td>30,000</td>
							<td>32,000</td>
							<td>자동타석 60분+숏게임 60분</td>
						</tr>
						<tr>
							<td rowspan="3">PREMIUM PACKAGE</td>
							<td>W</td>
							<td>39,000</td>
							<td>41,000</td>
							<td>자동타석 60분 + 숏게임 120분</td>
						</tr>
						<tr>
							<td>O</td>
							<td>36,000</td>
							<td>38,000</td>
							<td>자동타석 120분 + 숏게임 60분</td>
						</tr>
						<tr>
							<td>N</td>
							<td>47,000</td>
							<td>49,000</td>
							<td>자동타석 120분 + 숏게임 120분</td>
						</tr>
																		
					</tbody>					
				</table>
				
				<div class="commonDot guideTitle"> 쿠폰 상품</div>
				<table class="blackTable">
				<caption>쿠폰상품</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">10회</th>
							<th scope="col">20회</th>
							<th scope="col">비고</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>타석(60분)</td>
							<td>130,000</td>
							<td>240,000</td>
							<td rowspan="4">주중/주말 동일<br><br>샤워실 및 휘트니스 이용
							</td>
						</tr>
						<tr>
							<td>타석(90분)</td>
							<td>170,000</td>
							<td>320,000</td>
						</tr>
						<tr>
							<td>숏 게임(60분)</td>
							<td>150,000</td>
							<td>280,000</td>
						</tr>
						<tr>
							<td>사용 기간</td>
							<td>3개월</td>
							<td>6개월</td>
						</tr>											
					</tbody>					
				</table>
			</div>
		</div>
		<div class="fareBox" id="fareTab3">
			<div class="fareTab3">
				<ul>
					<li class="" onClick="javascript:FareTab(1);">기간제 상품</li>
					<li class="" onClick="javascript:FareTab(2);">일일 및 쿠폰 상품</li>
					<li class="on" onClick="javascript:FareTab(3);">셀프 9홀 상품</li>
				</ul>
			</div>
			<div class="fareLine"></div>
			<div class="fareContent">
				<div class="commonDot guideTitle"> 이용요금</div>
				<table class="OrangeTable">
				<caption>쿠폰상품</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구 분</th>
							<th scope="col">회원</th>
							<th scope="col">비회원</th>
							<th scope="col">비고</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>주중</td>
							<td>50,000</td>
							<td>55,000</td>
							<td rowspan="2">노캐디, 카트비 포함</td>
						</tr>
						<tr>
							<td>주말(공휴일)</td>
							<td>55,000</td>
							<td>60,000</td>
						</tr>
					</tbody>					
				</table>
				<!-- <h3>※ 비회원이 회원쿠폰으로 주말에 이용 시 5,000원 추가금액이 발생합니다.</h3> -->
				<h3>※ 셀프9홀 라운드 티업시간 -> 시즌 21시 / 비시즌(동절기) 15시 출발</h3>
			</div>
		</div>
		
		
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />