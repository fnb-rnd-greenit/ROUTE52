<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header5.jsp" />

<script type="text/javascript">

	var rows;
	var ctDiv;

	$(document).ready(function() {
		if("${sessionScope.msMember.msId}" == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";
			return;
		}
		
		if(Number("${sessionScope.msMember.msBirth}".substring(0, 4)) >= 1982) {
			ctDiv = "11";
			$("#txtSubject").html("<span>+</span> 2030 예선전 우선시드권 스코어랭킹 리더보드");
		} else {
			ctDiv = "12";
			$("#txtSubject").html("<span>+</span> 4080 예선전 우선시드권 스코어랭킹 리더보드");
		}
		      
		initHeaderTab(6);
		 
		var action = "${action}";
		
		if(action == "I") {
			initPopup(2);
		}
		
		doSearch();
		
		doSearchDetail();
	});
	 
	function doSearch() {
		var sUrl = "<c:url value='/common/getLadyScore2.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", "65");
		sParams += String.format("&ctDiv={0}", ctDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
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
					var birth = getDateFormat(rows[i].MS_BIRTH);
					
					var td1 = $("<td>" + (i + 1) + "위</td>");
					var td2 = $("<td>" + name + "</td>");
					var td3 = $("<td>" + phone + "</td>");
					//var td4 = $(String.format("<td>{0}.{1}.{2}</td>", birth.yyyy(), birth.mm(), birth.dd()));
					var td5 = $("<td>" + rows[i].EN_CNT + "회</td>");
					var td6 = $("<td>" + rows[i].TOT_CNT + "</td>");
					var td7 = $("<td>" + rows[i].MIN_EN_DAY.substring(0, 4) + "-" + rows[i].MIN_EN_DAY.substring(4, 6) + "-" + rows[i].MIN_EN_DAY.substring(6, 8) + "</td>");
					var td8 = $("<td>" + rows[i].CT_REGDAY.substring(0, 4) + "-" + rows[i].CT_REGDAY.substring(4, 6) + "-" + rows[i].CT_REGDAY.substring(6, 8) + "</td>");
					var td9 = $("<td>" + rows[i].OUT_CNT + "</td>");
					/* var td7 = $("<td>" + rows[i].IN_CNT + "</td>");
					var td8 = $("<td>" + rows[i].MIN_CNT + "</td>"); */
					
					tbody.append(tr.append(td1, td2, td3, td5, td6, td7, td8, td9));
					
					if("${sessionScope.msMember.msNum}" == rows[i].MS_NUM) {
						$("#txtMyScore").empty().append(String.format("&bull; <span>{0} </span> 님의 스코어 등록횟수는  <span>{1}회,</span> 평균스코어는 <span>{2}타로</span> 현재 <span>{3}위</span> 입니다."
							, "${sessionScope.msMember.msName}", rows[i].EN_CNT, rows[i].TOT_CNT, (i + 1)
						));
					}
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchDetail() {
		var sUrl = "<c:url value='/common/getLadyScoreDetail2.do'/>";
		var sParams = "";

		var msNum = "${sessionScope.msMember.msNum}"; 
			
		sParams += String.format("coDiv={0}", "65");
		sParams += String.format("&msNum={0}", msNum);
		sParams += String.format("&ctDiv={0}", ctDiv);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode = "0000") {
				var tbody = $("#tbody-score");

				tbody.empty();

				var rows = data.rows;
				
				for(i=0; i<rows.length; i++) {
					var tr = $("<tr></tr>");
					
					var td1 = $("<td>" + (i + 1) + "</td>");
					var td2 = $("<td>" + rows[i].EN_DAY + "</td>");
					var td3 = $("<td>" + rows[i].MS_NAME + "</td>");
					var td4 = $("<td>" + rows[i].COS_NM + "</td>");
					var td5 = $("<td>" + rows[i].EN_TIME + "</td>");
					var td6 = $("<td>" + rows[i].MS_POINT_A1 + "</td>");
					var td7 = $("<td>" + rows[i].MS_POINT_A2 + "</td>");
					var td8 = $("<td>" + rows[i].MS_POINT_A3 + "</td>");
					var td9 = $("<td>" + rows[i].MS_POINT_A4 + "</td>");
					var td10 = $("<td>" + rows[i].MS_POINT_A5 + "</td>");
					var td11 = $("<td>" + rows[i].MS_POINT_A6 + "</td>");
					var td12 = $("<td>" + rows[i].MS_POINT_A7 + "</td>");
					var td13 = $("<td>" + rows[i].MS_POINT_A8 + "</td>");
					var td14 = $("<td>" + rows[i].MS_POINT_A9 + "</td>");
					var td15 = $("<td>" + rows[i].OUT_TOT + "</td>");
					var td16 = $("<td>" + rows[i].MS_POINT_B1 + "</td>");
					var td17 = $("<td>" + rows[i].MS_POINT_B2 + "</td>");
					var td18 = $("<td>" + rows[i].MS_POINT_B3 + "</td>");
					var td19 = $("<td>" + rows[i].MS_POINT_B4 + "</td>");
					var td20 = $("<td>" + rows[i].MS_POINT_B5 + "</td>");
					var td21 = $("<td>" + rows[i].MS_POINT_B6 + "</td>");
					var td22 = $("<td>" + rows[i].MS_POINT_B7 + "</td>");
					var td23 = $("<td>" + rows[i].MS_POINT_B8 + "</td>");
					var td24 = $("<td>" + rows[i].MS_POINT_B9 + "</td>");
					var td25 = $("<td>" + rows[i].IN_TOT + "</td>");
					var td26 = $("<td>" + rows[i].TOT_TOT + "</td>");
					
					tbody.append(tr.append(td1, td2, td3, td4, td5, td6, td7, td8, td9, td10
						, td11, td12, td13, td14, td15, td16, td17, td18, td19, td20
						, td21, td22, td23, td24, td25, td26
					));
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>

<div id="wrap">
	<div class="contents">
		<div class="subTitle">
			<span class="title">제5회 SEOWON&bull;CLUBD LADY’S GOLF CHAMPIONSHIP 1차 예선 스코어 리더보드</span>
			<%-- <span class="titleTextRight"><img src="<c:url value='/images/hills/ladytxt2.png'/>" border="0" /></span> --%>
		</div>
		<div class="subLine"></div>
		
		<div class="ladyList">
			<span>+</span> MY SCORE
		</div>
		<!-- 상세내역버튼 누르면 보여지는 부분 -->
		<div class="ladytitleBox">
			<h2 id="txtMyScore"></h2>
		</div>
		
		<div class="PassportTableWrap">
			<span class="commonDot"> 스코어 상세내역</span>
				
			<table class="passportTable">
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="*">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="3%">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>내장일</th>
						<th>고객명</th>
						<th>코스</th>
						<th>티타임</th>
						<th>1홀</th>
						<th>2홀</th>
						<th>3홀</th>
						<th>4홀</th>
						<th>5홀</th>
						<th>6홀</th>
						<th>7홀</th>
						<th>8홀</th>
						<th>9홀</th>
						<th>OUT</th>
						<th>1홀</th>
						<th>2홀</th>
						<th>3홀</th>
						<th>4홀</th>
						<th>5홀</th>
						<th>6홀</th>
						<th>7홀</th>
						<th>8홀</th>
						<th>9홀</th>
						<th>IN</th>
						<th>TOT</th>
					</tr>
				</thead>
				<tbody id="tbody-score"></tbody>			
			</table>	
		</div>		
		<!-- //상세내역버튼 누르면 보여지는 부분 -->
		<div class="padding50 clearboth"></div>
		
		<div class="ladyList" id="txtSubject">
		</div>
		
		<div class="ladyListTable">
			<p class="ladyTextRight">
				<span>★예선 참가 자격<br>
-스코어등록 1회 이상필수<br>
-1순위: 스코어 2개(최저 스코어)의 평균 랭킹 상위자(2회 스코어등록자 우선 상위 )<br>
-2순위: 스코어 1회 등록의 랭킹 상위자<br>
※자세한 내용은 대회 요강 참고
				</span>
			</p>
			<table class="commonTable3">
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<%-- <col width="*">
					<col width="*"> --%>
				</colgroup>
				<thead>		
					<tr>
						<th>순위</th>
						<th>고객명</th>
						<th>휴대번호</th>
						<th>스코어<br>등록횟수</th>
						<th>평균스코어<br>(TOT)</th>	
						<th>최초<br>등록일</th>
						<th>참가<br>신청일</th>				
						<!-- <th>평균스코어<br>(OUT)</th> -->
						<th>평균스코어<br>(IN)</th>
						<!-- <th>최저<br>스코어</th> -->
					</tr>
				</thead>
				<tbody id="tbody-header">
				</tbody>
			</table>
		</div>
		<div class="padding50"></div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />