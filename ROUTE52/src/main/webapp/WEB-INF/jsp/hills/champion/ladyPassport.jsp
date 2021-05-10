<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header4.jsp" />

<script type="text/javascript">

	var rows;

	$(document).ready(function() {
		if("${sessionScope.msMember.msId}" == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";
			return;
		}
		
		if("${sessionScope.msMember.msSex}" == "1") {
			alert("남성은 접속할 수 없습니다.");
			location.href = "<c:url value='/hills/champion/champion4.do'/>";
			return;
		}
		 
		initHeaderTab(3);
		 
		var action = "${action}";
		
		if(action == "I") {
			initPopup(2);
		}
		
		doSearch();
		
		doSearchDetail();
	});
	 
	function doSearch() {
		var sUrl = "<c:url value='/common/getLadyScore.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode = "0000") {
				var tbody = $("#tbody-header");
				
				tbody.empty();
				
				rows = data.rows;
				
				$(".pointBlock").hide();

				for(i=0; i<rows.length; i++) {
					var tr = $("<tr></tr>");
					var name = rows[i].EN_NAME;
					if(name.length == 3) {
						name = name.substring(0, 1) + "*" + name.substring(2, 3);  
					} else if (name.length == 2) {
						name = name.substring(0, 1) + "*";  
					}
					var phone = rows[i].EN_PHONE;
					if(phone.length == 4) {
						phone = phone.substring(0, 2) + "*" + phone.substring(3, 4);	
					}
					
					var td1 = $("<td>" + (i + 1) + "위</td>");
					var td2 = $("<td>" + name + "</td>");
					var td3 = $("<td>" + phone + "</td>");
					var td5 = $("<td>" + rows[i].EN_CNT + "회</td>");
					var td4 = $("<td>" + rows[i].EN_POINT + "P</td>");
					var td6 = $("<td>" + rows[i].EN_SCORE + "</td>");
					
					if(i == 0) {
						var td7 = $("<td rowspan='10'>주중 그린피 1인 면제권 2매</td>");
						tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7));
					} else if(i == 10) {
						var td7 = $("<td rowspan='10'>주중 그린피 1인 면제권 1매</td>");
						tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7));
					} else if(i == 20) {
						var td7 = $("<td rowspan='10'>주중 그린피 1인 50% 할인권 1매,식음 프리패스 만원권 4매</td>");
						tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7));
					} else if(i == 30) {
						var td7 = $("<td rowspan='30'>1팀 라운드 전 식사권</td>");
						tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7));
					} else {
						tbody.append(tr.append(td1, td2, td3, td4, td5, td6));
					}
					
					if($("#sessionScope.msMember.msNum") == rows[i].MS_NUM) {
						$("#txtMyScore").empty().append("&bull; <span>" + rows[i].EN_NAME + " 님</span> 패스포트 종합 포인트는 <span>" + rows[i].EN_POINT + "</span>으로 현재 <span>" + (i + 1) + "위</span> 입니다.");

						$(".pointBlock").show();
						
						$(".pointBlock").css("top", (i + 1) * 40);
					}
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchDetail() {
		var sUrl = "<c:url value='/common/getLadyScoreDetail.do'/>";
		var sParams = "";

		var msNum = "${sessionScope.msMember.msNum}"; 
			
		sParams += String.format("coDiv={0}", "65");
		sParams += String.format("&msNum={0}", msNum);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode = "0000") {
				var pTbody = $("#tbody-point");
				var sTbody = $("#tbody-score");

				pTbody.empty();
				sTbody.empty();

				var pRows = data.rows.point;
				var sRows = data.rows.score;
				
				for(i=0; i<pRows.length; i++) {
					var tr = $("<tr></tr>");
					
					var td1 = $("<td>" + (i + 1) + "</td>");
					var td2 = $("<td>" + pRows[i].GM_DAY + "</td>");
					var td3 = $("<td>" + pRows[i].GM_YOIL + "</td>");
					var td4 = $("<td>" + pRows[i].GM_REMARK + "</td>");
					var td5 = $("<td>" + pRows[i].GM_POINT + "</td>");
					
					pTbody.append(tr.append(td1, td2, td3, td4, td5));
				}
				
				for(i=0; i<sRows.length; i++) {
					var tr = $("<tr></tr>");
					
					var td1 = $("<td>" + sRows[i].GM_DAY + "</td>");   
					var td2 = $("<td>" + sRows[i].GM_TOT + "</td>");
					var td3 = $("<td>" + sRows[i].GM_09 + "</td>");
					var td4 = $("<td>" + sRows[i].GM_18 + "</td>");
					
					sTbody.append(tr.append(td1, td2, td3, td4));
				}
				
			    var offset = $(".PassportTableWrap").offset();
			    $('html, body').animate({scrollTop : offset.top}, 400);
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>

<div id="wrap">
	<div class="contents">
		<div class="subTitle">
			<span class="title">LADY'S DAY PASSPORT 포인트 리더보드</span>
			<span class="titleTextRight"><img src="<c:url value='/images/hills/ladytxt2.png'/>" border="0" /></span>
		</div>
		<div class="subLine"></div>
		
		<div class="ladyList">
			<span>+</span> MY PASSPORT POINT 상세내역
		</div>
		<!-- 상세내역버튼 누르면 보여지는 부분 -->
		<div class="ladytitleBox">
			<h2 id="txtMyScore">&bull; <span>${sessionScope.msMember.msName} </span> 님의 패스포트 종합 누적 포인트는  <span>0점</span>으로 현재 <span>00위</span> 입니다.</h2>
		</div>
		
		<div class="PassportTableWrap">
			<div class="leftTable">
				<span class="commonDot"> 포인트 상세내역</span>
				
				<table class="passportTable">
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>
					<thead>
						<tr>
						<th>NO</th>
						<th>내장일</th>
						<th>요일</th>
						<th>내용</th>
						<th>포인트</th>
					</tr>	
					</thead>
					<tbody id="tbody-point"></tbody>
				</table>			
			</div>
			
			<div class="rightTable">
				<span class="commonDot"> 스코어 상세내역</span>
				
				<table class="passportTable">
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th>내장일</th>
							<th>스코어</th>
							<th>전반9홀</th>
							<th>후반9홀</th>
						</tr>
					</thead>
					<tbody id="tbody-score"></tbody>			
				</table>			
			</div>		
		</div>		
		<!-- //상세내역버튼 누르면 보여지는 부분 -->
		<div class="padding50 clearboth"></div>
		
		<div class="ladyList">
			<span>+</span> 실시간 패스포트 포인트 순위 현황
		</div>
		
		<div class="ladyListTable">
			<p class="ladyTextRight"><img src="<c:url value='/images/hills/ladytxt1.png'/>" border="0" /></p>
			<table class="commonTable3">
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="16%">
				</colgroup>
				<thead>		
					<tr>
						<th>순위</th>
						<th>성명</th>
						<th>휴대폰번호</th>
						<th>누적포인트</th>
						<th>내장횟수</th>					
						<th>평균스코어</th>
						<th>시상품</th>
					</tr>
				</thead>
				<tbody id="tbody-header">
				</tbody>
			</table>
			<div class="pointBlock"></div>
		</div>
		<div class="padding50"></div>
		
		
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />