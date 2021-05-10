<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	var rowData;
	var startPage = 1;
	var endPage = 1;
	var currentPage = 1;
	var oOption = "";
	var oOption1 = "";
	var oText = "";

	$(document).ready(function() { 
		init();

	    var offset = $(".myzoneTabList8").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}
		
		doSearch();
	}

	function doSearch() {
		var tBody = $("#board-grid");
		
		var sUrl = "<c:url value='/hills/board/getBoardData.do'/>";
		var sParams = "";
		
		sParams += String.format("bbsType={0}", "9");

		var nOption = $("#searchOption").val();
		var nOption1 = $("#searchOption1").val();
		var nText = $("#searchText").val();
		
		if(nOption != oOption || nOption1 != oOption1 || nText != oText) {
			startPage = 1;
			currentPage = 1;
			oOption = nOption;
			oOption1 = nOption1;
			oText = nText;
		}
		
		sParams += String.format("&startCnt={0}", (currentPage - 1) * 10);	
		
		if(nOption != "") {
			sParams += String.format("&searchOption={0}", nOption);
		}
		
		if(nOption1 != "") {
			sParams += String.format("&status={0}", nOption1);
		}
		
		if(nText != "") {
			sParams += String.format("&searchText={0}", nText);
			
			if(nOption == "") {
				alert("조회 옵션을 선택해주세요.");
				return;
			}
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					var status = rowData[i].STATUS == 0 ? "접수" : "완료"; 
					
					var row = $("<tr onclick='onClickRow(" + i + ")'></tr>"); 
				    var col1 = $("<td>" + rowData[i].IDX + "</td>"); 
				    var col2 = $("<td>" + rowData[i].TITLE + "</td>"); 
				    var col3 = $("<td>" + rowData[i].USERNAME + "</td>");
				    var col4 = $("<td>" + rowData[i].REGDATE + "</td>");
				    var col5 = $("<td>" + status + "</td>"); 
				    row.append(col1,col2,col3,col4,col5).appendTo(tBody); 
				}
				
				initPaging(rowData[0].TOTAL_CNT);
 
			} else {
				alert(data.resultMessage);	
			}
		});
	}
	
	function doSearchPaging(page) {
		currentPage = page;
		doSearch();
	}
	
	function doSearchPaging10(page) {
		currentPage = page;
		startPage = page;
		doSearch();
	}
	
	function initPaging(totalCnt) {
		var pageContainer = $("#paging ul");
		pageContainer.empty();
		var page = startPage;
		var prevBtn = "<li onclick='doSearchPaging10(" + (startPage - 10) + ")'><img src='<c:url value='/images/hills/prev.png'/>' alt=''></li>";
		var nextBtn = "<li onclick='doSearchPaging10(" + (startPage + 10) + ")'><img src='<c:url value='/images/hills/next.png'/>' alt=''></li>";
		
		if(startPage != 1){
			pageContainer.append(prevBtn);
		}
		
		endPage = Math.floor(totalCnt / 10);
		if(totalCnt % 10 != 0) {
			endPage += 1;
		}
		
		for(i=startPage; i<startPage+10; i++) {
			if(i > endPage) break;
			
			var li;
			
			if(currentPage == page) {
				li = String.format("<li class='on' onclick='doSearchPaging({0})'>{0}</li>", page);
			} else {
				li = String.format("<li onclick='doSearchPaging({0})'>{0}</li>", page);
			}
			
			pageContainer.append(li);
			page += 1;
		}
		
		if(endPage - startPage >= 10) {
			pageContainer.append(nextBtn);
		}
		
	}
	
	function onClickRow(i) {
		var sUrl = "<c:url value='/hills/board/view.do'/>";
		var sParams = "";
		
		sParams += "?idx=" + rowData[i].IDX;
		sParams += "&bbsType=9";
		
		location.href = sUrl + sParams;
	}
</script>

	<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>고객의소리</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/hills/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/hills/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/hills/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/hills/member/coupon.do'/>" class="">쿠폰함</a>
			<!-- <a href="javascript:alert('준비중입니다.')" class="">마이포인트</a> -->
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="on">고객의소리</a>
			<a href="<c:url value='/hills/member/memModify.do'/>" class="">회원정보수정</a>
		</div>
		
		<div class="subTitle">
			<span class="title">고객의소리</span>
			<span class="titleDes">회원님의 궁금한 사항의 답변을 확인하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<div class="grayCommonBox">
			<div class="costomSeach">
				<li>
					<select name="" id="searchOption1" class="select-arrow2">
						<option value="">전체</option>
						<option value="0">접수</option>
						<option value="1">완료</option>
					</select>
				</li>
				<li>
					<select name="" id="searchOption" class="select-arrow2">
						<option value="">전체</option>
						<option value="1">제목</option>
						<option value="2">내용</option>
						<option value="3">작성자</option>
					</select>
				</li>
				<li><input type="text" class="" id="searchText"></li>
				<li><a href="javascript:doSearch()" class="seachBtn">검색</a></li>						
			</div>
		</div>	
		<!-- <div class="midTitleBox">
			<span class="commonDot"> TOTAL: <span class="blue"> 0 </span></span>
		</div> -->
			<table class="commonTable">
				<caption>실시간 예약 코스,시간별 가격 안내</caption>
				<colgroup>
					<col width="5%">
					<col width="55%">
					<col width="15%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>상태</th>
					<th>작성일</th>
				</tr>
				<tbody id="board-grid">
				</tbody>
			</table>
			<div class="paging" id="paging"><ul></ul></div> 
		<div class="btnBox">
			<a href="<c:url value='/hills/board/write.do?bbsType=9'/>" class="orangeBtn">글쓰기</a>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />