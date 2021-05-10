<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script type="text/javascript">

	var rowData;
	var currentPage = 1;
	var totalCnt = 0;
	var template1, template2;
	
	$(document).ready(function() { 
		$("#btnMorePage").hide();
		
		var bbsType = "<c:out value='${bbsType}'/>";
		template1 = template2 = "";
		if(bbsType == "1") {
			template1 += "<div class='boardFormBox'>             ";           
			template1 += "	<a href='javascript:onClickRow({0})'>";           
			template1 += "		<div class='boardListBox'>       ";           
			template1 += "			<li class='listNum'>{1}</li> ";           
			template1 += "			<li class='title'>{2}</li>   ";
			template1 += "			<li class='date'>{3}</li>    ";           
			template1 += "		 </div>                          ";           
			template1 += "	 </a>                                ";           
			template1 += "</div>                                 "; 
		} else {
			template2 += "<div class='imgFormBox'>                               	 ";
			template2 += "	<a href='javascript:onClickRow({0})'>                	 ";
			template2 += "		<div class='imgListBox'>                           	 ";
			template2 += "			<div class='listNum'>{1}</div>                   ";
			template2 += "			<div class='listImg'><img src='{2}' alt=''></div>";
			template2 += "			<div class='imgInfoList'>                        ";
			template2 += "				<p class='title'>{3}</p>                     ";
			template2 += "				<p class='date'>{4}</p>                      ";
			template2 += "				<div class='imgBtn'>자세히보기</div>            ";
			template2 += "			</div>					                         ";
			template2 += "		</div>                                             	 ";
			template2 += "	</a>                                                 	 ";
			template2 += "</div>                                                	 ";
		}
		
		doSearch();
	});
	
	function doSearch() {
		var container = $("#board-container");
		
		var sUrl = "<c:url value='/valley/board/getBoardData.do'/>";
		var sParams = "";
		
		var bbsType = "<c:out value='${bbsType}'/>";
		if (bbsType != "") {
			sParams += String.format("bbsType={0}", bbsType);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}	
		
		sParams += String.format("&startCnt={0}", (currentPage - 1) * 10);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();			
			
			if(data.resultCode == "0000") {
				rowData = data.rows;
				
				if(rowData.length == 0) {
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					var tmp;
					if(rowData[i].BBSTYPE == "1") {
						tmp = template1;
						
						tmp = String.format(tmp, i, rowData[i].IDX, rowData[i].TITLE, rowData[i].REGDATE);
					} else {
						tmp = template2;
						
						var imageUrl = rowData[i].UP_FILENAME;
						var folderName = rowData[i].FOLDER_NAME;
						
						if(imageUrl != null && imageUrl != "" && folderName != null && folderName != "") {
							imageUrl = "<c:url value='/common/downloadImage.do?division=valley&folderName=" + folderName + "&fileName=" + imageUrl + "'/>";
						} else {
							imageUrl = "<c:url value='/images/m_valley/no_img.jpg'/>";
						} 
						
						tmp = String.format(tmp, i, rowData[i].IDX, imageUrl, rowData[i].TITLE, rowData[i].REGDATE);   
					}	

					container.append(tmp);
					
					totalCnt += 1;				 
				}
				
				if(totalCnt < rowData[0].TOTAL_CNT) {
					$("#btnMorePage").show();
				} else {
					$("#btnMorePage").hide();
				}
			} else {
				alert(data.resultMessage);	
			}
		});
	}
	
	function doMorePage() {
		currentPage += 1;
		doSearch();
	}
	
	function onClickRow(i) {
		var sUrl = "<c:url value='/m_valley/board/view.do'/>";
		var sParams = "";
		
		sParams += "?bbsType=<c:out value='${bbsType}'/>";
		sParams += "&idx=" + rowData[i].IDX;
		
		location.href = sUrl + sParams;
	}
</script>
<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""></span>
			<c:if test="${bbsType eq '1'}">
				공지사항
			</c:if>
			<c:if test="${bbsType eq '6'}">
				이벤트갤러리
			</c:if>
		<span><img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	
	<div class="contents">
		<div class="borderBg">
			<div id="board-container">		
			</div>
			
			<div class="eventMoreBtn" id="btnMorePage" onclick="doMorePage()">
				<ul class="moreBtn">
					<li>더보기</li>
					<li><img src="<c:url value='/images/m_valley/sc_arrow.png'/>" alt=""></li>						
				</ul>
			</div>		
		</div>
		<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
			<a  class="blueBtn closeBtn"href="<c:url value='/m_valley/board/write.do?bbsType=${bbsType}'/>">글쓰기</a>
		</c:if>		
	</div>
	<!-- contents End -->
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>