<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">

	var rows;

	$(document).ready(function() {
		doSearch();
	});
	
	function doSearch() {
		var sUrl = "<c:url value='/common/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", globals.coDiv.valley);
		sParams += String.format("&hpDiv={0}", "4");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var container = $("#qnaContainer");
				container.empty();
				
				rows = data.rows;
				
				for(i=0; i<rows.length; i++) {
					var template = "";
					
					template += "<div class='qnaList' id='n{0}' onclick='onTapChange({0})'>";
					template += "	<span>{1}</span> {2}";
					template += "</div>";
					template += "<ul id='s{0}'>";
					template += "	<li>{3}</li>";
					template += "</ul>";
					
					var num = (i + 1);
					num = num < 10 ? "0" + num : num;
					var title = rows[i].HP_TITLE;
					var contents = rows[i].HP_CONTENTS;
					contents = replaceAll(contents, "\n", "<br>");
					
					container.append(String.format(template, i, num, title, contents));
				}
				
				onTapChange(0);
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
	
	function onTapChange(idx) {
		for(i=0; i<=rows.length; i++){
			if(i==idx) {
				$("#n" + i + " span").addClass("on");
				$("#s" + i).slideToggle(300);
			} else {
				$("#n" + i + " span").removeClass("on");
				$("#s" + i).slideUp(300);
			}
		}
	}

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>고객센터 &nbsp;&nbsp;&nbsp; ＞ <span>Q&amp;A</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">Q&amp;A</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>	
		
		<%-- <div class="qnaBox">
			<div class="commonDot guideTitle"> 자주하는 질문 </div>
			<div class="textboxWrap">
				<input type="text" placeholder="질문 키워드 검색">
				<img src="<c:url value='/images/valley/icon_Search.png'/>" alt="">
			</div>
			<h4>
			*키워드 검색을 이용하시면 조금 더 쉽게 원하시는 답변을 찾으실 수 있습니다.<br>
			*문의전화: 031-940-9400(ARS. 2번)
			</h4>	
		</div> --%>
		
		<div class="qnaMenu" id="qnaContainer">
			
		</div>	
		
		<%-- <div class="qnaMenu">
			<div class="qnaList" id="n1" onclick="onTapChange(1)">
				<span class="on">01</span> 비회원도 예약이 가능한가요?
			</div>
			<ul id="s1">
				<li>회원권을 분양 또는 구입하신 회원님만 예약이 가능합니다.</li>
			</ul>
		
			<div class="qnaList" id="n2" onclick="onTapChange(2)">
				<span>02</span> 비회원 그린피는 얼마인가요?
			</div>
			<ul id="s2">
				<li>
				- 주중 : 20만원<br>
				- 주말 : 토요일(공휴일) 1부 26만원  / 2부 25만원<br>
				- 일요일 : 1부 25만원  / 2부 26만원<br>
				- 카트비 : 90,000원, 캐디피 : 130,000원
				</li>
			</ul>
		
			<div class="qnaList" id="n3" onclick="onTapChange(3)">
				<span>03</span> 주말예약 횟수는 어떻게 계산하나요?
			</div>
			<ul id="s3">
				<li>
				-예약일 직전 한 달 사이 주말 및 공휴일에  예약되어 있는 횟수를 체크하여 예약이 적으신 분부터 전산에서 
 자동 배정(주말예약 횟수가 많을 경우 배정이 되지 않을 수 있습니다.)<br>
* 예시) 예약일:2019년 06월08일(토)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 예약일 직전 한달[05월07일(화)~06월07(금)] 사이 주말 및 공휴일에 예약되어 있는 횟수 체크
				</li>
			</ul>
			
			<div class="qnaList" id="n4" onclick="onTapChange(4)">
				<span>04</span> 주말예약신청이 아니라 잔여시간 예약한건도 횟수로 포함되나요?
			</div>
			<ul id="s4">
				<li>
				- 주말예약은 잔여시간예약건도 모두 횟수에 포함됩니다.
				</li>
			</ul>
			
			<div class="qnaList" id="n5" onclick="onTapChange(5)">
				<span>05</span> 타임이 언제오픈되나요?
			</div>
			<ul id="s5">
				<li>
				* 주중(전화 또는 인터넷 예약)<br>
				- 정회원 : 3주전 월요일 9시 오픈<br>
				- 준회원,주중회원 : 3주전 화요일 9시오픈<br>
				* 주말(팩스 또는 인터넷 접수)<br>
				- 정회원: 예약하는 주를 제외한 2주전 화요일 희망시간대 접수(08:00~16:00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;다음날 수요일 13시 이후 예약통보<br>
				- 준회원,주중회원: 정회원 배정 후 잔여타임에 한하여 단독부킹가능
				</li>
			</ul>
			
			<div class="qnaList" id="n6" onclick="onTapChange(6)">
				<span>06</span> 예약 취소는 언제 까지 가능한가요?
			</div>
			<ul id="s6">
				<li>
				주중: 예약일 제외한 4일전 17:00 전까지<br>
				주말: 예약일 제외한 5일전 17:00 전까지
				</li>
			</ul>
			
			<div class="qnaList" id="n7" onclick="onTapChange(7)">
				<span>07</span> 위약규정은 어떻게 되나요?
			</div>
			<ul id="s7">
				<li>
					<table class="commonTable">
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">위약구분</th>
								<th>NO-SHOW/당일취소</th>
								<th>1일전 취소</th>
								<th>2,3일전 취소</th>
								<th>4일전 취소</th>
								<th>협의없이 비회원 내장</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th rowspan="2">위약금</th>
								<th>주중</th>
								<td>400,000원</td>
								<td>300,000원</td>
								<td>100,000원</td>
								<td></td>
								<td>라운딩불가, 위약금적용</td>
							</tr>
							<tr>
								<th>주말</th>
								<td>500,000원</td>
								<td>500,000원</td>
								<td>300,000원</td>
								<td>100,000원</td>
								<td>라운딩불가, 위약금적용</td>
							</tr>
							<tr>
								<th colspan="2">예약정지기간</th>
								<td>1개월 정지</td>
								<td>1개월 정지</td>
								<td>3주간 정지</td>
								<td>2주간 정지</td>
								<td>1개월 정지</td>
							</tr>
							<tr>
								<td colspan="2" style="font-weight:bold;">비고</td>
								<td colspan="5">1.예약취소는회원만가능함,  2.단체팀은 위약금*팀수적용</td>
							</tr>
						</tbody>
					</table>
					<h4>- 위약시 위약금 또는 예약정지기간 중 선택하시면 됩니다.</h4>
				</li>
			</ul>
			
			<div class="qnaList" id="n8" onclick="onTapChange(8)">
				<span>08</span> 레스토랑 이용가능 시간은 어떻게 되나요?
			</div>
			<ul id="s8">
				<li>
				- OPEN: 1부 첫티오프 1시간 전 오픈<br>
				- CLOSE: 2부고객 라운드 후 체크아웃 까지 
				</li>
			</ul>
			
			<div class="qnaList" id="n9" onclick="onTapChange(9)">
				<span>09</span> 서원밸리 모바일앱은 어떻게 설치 하나요?
			</div>
			<ul id="s9">
				<li>
				-안드로이드 스마트폰의 경우 <br>
				구글 플레이 앱을 실행 → '서원밸리' 검색 → 서원밸리 앱 선택 → [설치] 선택<br> 
				-아이폰일 경우<br>
				앱스토어 앱을 실행 → '서원밸리' 검색 → 서원밸리 앱 선택 → [설치] 선택<br>   
				</li>
			</ul>
			
			<div class="qnaList" id="n10" onclick="onTapChange(10)">
				<span>10</span> 예약방법 알려주세요!
			</div>
			<ul id="s10">
				<li>
				- 1팀예약: 서원밸리 홈페이지→서원밸리→실시간예약 and 모바일 앱 or 웹 실시간 예약 가능<br>
				- 2팀이상: 전화로 예약가능(예약문의: 031-940-9400, ARS 1번) 
				</li>
			</ul>
			
			<div class="qnaList" id="n11" onclick="onTapChange(11)">
				<span>11</span> 복장규정
			</div>
			<ul id="s11">
				<li>
				- 남성 : 내장시 남성은 재킷을 착용해 주시기 바랍니다.<br>
     &nbsp;&nbsp;&nbsp;&nbsp;찢어진 청바지, 반바지 착용 시 입장을 제한 할 수 있습니다.<br>
     &nbsp;&nbsp;&nbsp;&nbsp;신발은 샌들 슬리퍼 착용을 금지하고 있습니다.<br>
     &nbsp;&nbsp;&nbsp;&nbsp;플레이시 칼라 있는 셔츠를 착용해 주시기 바랍니다.<br>
				- 여성 : 민소매, 짧은치마, 핫팬츠 등<br>
     &nbsp;&nbsp;&nbsp;&nbsp;타인에게 혐오감을 줄 수 있는 복장을 규제하고 있습니다.
				</li>
			</ul>
			
			<div class="qnaList" id="n12" onclick="onTapChange(12)">
				<span>12</span> 3인플레이 가능 한가요?
			</div>
			<ul id="s12">
				<li>
				- 3인플레이 가능합니다. (카트비와 캐디피는 팀요금적용)
				</li>
			</ul>
			
			<div class="qnaList" id="n13" onclick="onTapChange(13)">
				<span>13</span> 5인플레이 가능 한가요?
			</div>
			<ul id="s13">
				<li>
				- 5인플레이는 불가능합니다.
				</li>
			</ul>
		</div> --%>		
			
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />