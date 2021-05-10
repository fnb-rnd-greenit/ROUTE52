<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<jsp:include page="popup/pop_player.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
<script type="text/javascript">
	
	var rowData;
	var startPage = 1;
	var endPage = 1;
	var currentPage = 1;
	var oOption = "";
	var oText = "";

	$(document).ready(function() { 
	    var offset = $(".fareTabList").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	    
		doSearch();
	});
	
	function doSearch() {
		var tBody = $("#board-grid");
		
		var sUrl = "<c:url value='/hills/board/getBoardData.do'/>";
		var sParams = "";
		
		var bbsType = "<c:out value='${bbsType}'/>";
		if (bbsType != "") {
			sParams += String.format("bbsType={0}", bbsType);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}	
		
		var nOption = $("#searchOption").val();
		var nText = $("#searchText").val();
		
		if(nOption != oOption || nText != oText) {
			startPage = 1;
			currentPage = 1;
			oOption = nOption;
			oText = nText;
		}
		
		sParams += String.format("&startCnt={0}", (currentPage - 1) * 10);	
		
		if(nOption != "") {
			sParams += String.format("&searchOption={0}", nOption);
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
					var row = $("<tr onclick='onClickRow(" + i + ")'></tr>"); 
				    var col1 = $("<td>" + rowData[i].IDX + "</td>"); 
				    var col2 = $("<td class='title'>" + rowData[i].TITLE + "</td>"); 
				    var col3 = $("<td>" + rowData[i].USERNAME + "</td>");
				    var col4 = $("<td>" + rowData[i].REGDATE + "</td>");
				    var col5 = $("<td>" + rowData[i].VIEWCOUNT + "</td>"); 
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
		
		sParams += "?bbsType=<c:out value='${bbsType}'/>";
		sParams += "&idx=" + rowData[i].IDX;
		
		location.href = sUrl + sParams;
	}
</script>
<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>아카데미 &nbsp;&nbsp;&nbsp; ＞ <span>선수단 소개</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="on">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/academiFare.do'/>" class="">아카데미 요금안내</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="">입점 아카데미</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academiPlayer.do'/>" class="">선수단 소개</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=33'/>" class="on">아카데미 대회성적</a>
		</div>
		
		<div class="subTitle subBottom">
			<span class="title">아카데미 대회성적</span>
			<span class="titleDes"></span>
		</div>
		<div class="listBox">
			<div class="findBox">
				<select name="" id="searchOption" class="select-arrow">
					<option value="">전체</option>
					<option value="1">제목</option>
					<option value="2">내용</option>
					<option value="3">작성자</option>
				</select>
				<input type="text" class="findTxt" id="searchText">
				<a href="javascript:doSearch()" class="orangeBtn">검색</a>
			</div>
			<table class="listTable">
				<caption>실시간 예약 코스,시간별 가격 안내</caption>
				<colgroup>
					<col width="5%">
					<col width="60%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
				<tbody id="board-grid">
				</tbody>
			</table>
			<div class="paging" id="paging"><ul></ul></div>

		</div>
		<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
			<div class="btnBox">
				<a href="<c:url value='/hills/board/write.do?bbsType=${bbsType}'/>" class="orangeBtn">글쓰기</a>
			</div>
		</c:if>
	</div>
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />