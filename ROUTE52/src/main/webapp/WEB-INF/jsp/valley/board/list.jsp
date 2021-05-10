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
	var oText = "";

	$(document).ready(function() { 
		doSearch();
		
	    var offset = $(".myzoneTabList4").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});

	function doSearch() {
		var tBody = $("#board-grid");
		
		var sUrl = "<c:url value='/valley/board/getBoardData.do'/>";
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
		var prevBtn = "<li onclick='doSearchPaging10(" + (startPage - 10) + ")'><img src='<c:url value='/images/valley/prev.png'/>' alt=''></li>";
		var nextBtn = "<li onclick='doSearchPaging10(" + (startPage + 10) + ")'><img src='<c:url value='/images/valley/next.png'/>' alt=''></li>";
		
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
		var sUrl = "<c:url value='/valley/board/view.do'/>";
		var sParams = "";
		
		sParams += "?bbsType=<c:out value='${bbsType}'/>";
		sParams += "&idx=" + rowData[i].IDX;
		
		location.href = sUrl + sParams;
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<c:if test="${bbsType eq '1'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>공지사항</span></p>
		</c:if>
		<c:if test="${bbsType eq '2'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>뉴스</span></p>
		</c:if>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<c:if test="${bbsType eq '1'}">
				<a href="<c:url value='/valley/board/list.do?bbsType=1'/>" class="on">공지사항</a>
			</c:if>
			<c:if test="${bbsType ne '1'}">
				<a href="<c:url value='/valley/board/list.do?bbsType=1'/>">공지사항</a>
			</c:if>
			<c:if test="${bbsType eq '2'}">
			<a href="<c:url value='/valley/board/list.do?bbsType=2'/>" class="on">뉴스</a>
			</c:if>
			<c:if test="${bbsType ne '2'}">
			<a href="<c:url value='/valley/board/list.do?bbsType=2'/>">뉴스</a>
			</c:if>
			<c:if test="${bbsType eq '3'}">		
			<a href="<c:url value='/valley/board/list.do?bbsType=3'/>" class="on">포토갤러리</a>
			</c:if>
			<c:if test="${bbsType ne '3'}">		
			<a href="<c:url value='/valley/board/list.do?bbsType=3'/>">포토갤러리</a>
			</c:if>				
			<a href="<c:url value='/valley/board/reference.do'/>">자료실</a>
		</div>
		<div class="subTitle subBottom">
			<c:if test="${bbsType eq '1'}">
				<span class="title">공지사항</span>
			</c:if>
			<c:if test="${bbsType eq '2'}">
				<span class="title">뉴스</span>
			</c:if>
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
				<a href="javascript:doSearch()" class="blueBtn">검색</a>
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
				<a href="<c:url value='/valley/board/write.do?bbsType=${bbsType}'/>" class="blueBtn">글쓰기</a>
			</div>
		</c:if>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />