<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_coupon.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script>
$(document).ready(function() {
	  royalPopupOpen
	});
	$(document).ready(function() {
		/* var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/m_hills/member/login.do'/>";
    		return;
		} */
		
		doSearch();
	});
	
	function doSearch() {
		var sUrl = "<c:url value='/hills/reservation/getRoyalList.do'/>";
		var sParams = "";
		
		var date = "<c:out value='${date}'/>";
		if(date != "") {
			sParams += "date=" + date;
		}
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {
				var tBody = $("#royal-grid");				
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<rowData.length; i++) {					
					var tr = $("<tr></tr>");
					var bkDay = getDateFormat(rowData[i].BK_DAY);
					var bkTime = rowData[i].BK_TIME;
					bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
					var amtGu = rowData[i].R_AMT_GU == "1" ? "<span class='icon_team'>팀</span>" : "";
					var green = Number(rowData[i].R_GREEN_AMT);
					var cart = Number(rowData[i].R_CART_AMT);
					var food = Number(rowData[i].R_FOOD_AMT);
					var roundB = Number(rowData[i].R_ROUND_B_AMT);
					var roundA = Number(rowData[i].R_ROUND_A_AMT);
					var amt = green + cart + food + roundB + roundA;
						 
					var td1 = $(String.format("<td>{0}/{1}/{2}</td>", bkDay.yyyy(), bkDay.mm(), bkDay.dd()));
					var td2 = $("<td>" + rowData[i].BK_COS_NM + "코스</td>");
					var td3 = $("<td>" + bkTime + "</td>");
					var td4 = $("<td>" + amtGu + numberWithCommas(amt) + "</td>");
					var td5 = $("<td><a href='javascript:royalPopupOpen(rowData[" + i + "])' class='royalBtn motion'>접수</a></td>");    					
					        
					tBody.append(tr.append(td1, td2, td3, td4, td5));
				}
			}
			
			progressStop();
		});
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 로얄타임 패키지 우선예약 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<p class="commonDot"> 로얄타임패키지 우선예약 안내</p>
		<div class="royalText">
• 로얄타임 패키지 우선 예약은 해당일로부터 4~6주 전 타임이 우선적으로 오픈됩니다. <br>
 • 로얄타임 패키지 우선 예약은 식사비가 포함된 패키지 상품으로 선 오픈된 이후 상황에 따라 0~3주 전 일반 타임 예약으로 전환됩니다. <br>
 • 로얄타임 패키지 우선 예약은 신청 접수 후 총 금액의 10% 예약금을 예치하셔야만 예약이 확정됩니다. <br>
 • 예약 확정 이후 라운드 9~4일 전 취소 시 예약금의 50% 환불, 라운드 3~0일 전 취소 시 예약금 소멸(환불X)됩니다.<br>
<span class="red">• 로얄타임패키지 우선예약은 예약이 확정되신 이후에는 예약타임 변경 및 이동이 불가합니다.</span>
		</div>
		
		<p class="commonDot"> 로얄타임패키지 우선예약 금액 안내</p> 
		<div class="royalText">
패키지 금액은 1팀 4인 전체 금액으로 표기되며, 1팀 그린피+1팀 카트비+1팀 식사비가 포함되어 있습니다.
 ※ 패키지 식사비는 실제 이용 금액이 미달될 경우 자동으로 정산 내역에 포함됩니다.
 ※ 신청 접수 버튼 클릭 시 예약창에 안내되는 패키지 포함 내역을 필히 확인 바랍니다.
		</div>
		
		<p class="commonDot"> 로얄타임패키지 우선예약 접수 절차</p>
		<div class="royalText">
			※ 주말 로얄타임 예약신청 -> 예약 안내 문자 전달 -> 예약 확정대기-> 예약금 예치 완료 -> 예약 최종 확정 ->라운드 이용
		</div>
		
		<table class="commonTable bgBottom">
			<caption>실시간 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<thead>
				<tr>
					<th>일자</th>
					<th>코스</th>
					<th>타임</th>
					<th>패키지 금액</th>
					<th>예약</th>
				</tr>
			</thead>
			<tbody id="royal-grid"> 
			</tbody>
		</table>
	</div>		
	<!-- contents End -->
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>