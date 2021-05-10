<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${bbsType eq '7' || bbsType eq '8'}">
<jsp:include page="../include/ct_header5.jsp" />
</c:if>
<c:if test="${bbsType eq '41' || bbsType eq '42'}">
<jsp:include page="../include/ct_header2.jsp" />
</c:if>
<c:if test="${bbsType eq '43' || bbsType eq '44'}">
<jsp:include page="../include/ct_header3.jsp" />
</c:if>
<c:if test="${bbsType eq '45' || bbsType eq '46'}">
<jsp:include page="../include/ct_header4.jsp" />
</c:if>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/animate.css'/>">
<script src="<c:url value='/js/hills/wow.js'/>"></script>

<script type="text/javascript">

	var rowData;
	var startPage = 1;
	var endPage = 1;
	var currentPage = 1;
	var oOption = "";
	var oText = "";
	
	$(document).ready(function() {
		initHeaderTab(4);
	
		doSearch(); 
	});
	
	function doSearch() {
		var gBody = $("#gBody");
		
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
		
		sParams += String.format("&startCnt={0}", (currentPage - 1) * 12);	
		
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
				gBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					return;
				}
				
				for(i=0; i<rowData.length; i++) {					
					var content = "";
					content += "<div class='galleryBox fadeBox fadeInUp'>                      ";
					content += "    <div class='gallBoxCont'>                                  ";
					content += "        <a href='{0}' class='galImg'><img src='{1}' alt=''></a>";
					content += "        <a href='{0}'> 										   ";
					content += "            <div class='gallery'>							   ";
					content += "                <div class='gallTitle'>{2}                     ";
					content += "                <span class='orangeRed'>{3}</span>             ";
					content += "                </div>                                         ";
					content += "                <p class='gallDate'>{4}</p>                    ";
					content += "                <span class='gallBtn'>자세히보기</span>           ";
					content += "            </div>                                             ";
					content += "        </a>                                                   ";
					content += "    </div>                                                     ";
					content += "</div>                                                         ";

					var href = "javascript:onClickRow(" + i + ")";
					var imageUrl = rowData[i].UP_FILENAME;
					var title = rowData[i].TITLE;
					var replyCnt = rowData[i].REPLY_CNT;
					var regDate = rowData[i].REGDATE;
					var folderName = rowData[i].FOLDER_NAME;
					
					if(imageUrl != "") {
						imageUrl = "<c:url value='/common/downloadImage.do?division=hills&folderName=" + folderName + "&fileName=" + imageUrl + "'/>";
					} else {
						imageUrl = "<c:url value='/images/hills/boardDefaultImage.jpg'/>";
					}
					
					replyCnt = replyCnt == "0" ? "" : String.format("({0})", replyCnt);
					
					content = String.format(content, href, imageUrl, title, replyCnt, regDate);

					gBody.append(content);
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
		
		endPage = Math.floor(totalCnt / 12);
		if(totalCnt % 12 != 0) {
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

	/* 컨텐츠 fade in */
	wow = new WOW(
	{
		boxClass: 'fadeBox',
		animateClass: 'animated',
		offset: 100,
		callback: function(box) {
			//console.log("WOW: animating <" + box.tagName.toLowerCase() + ">")
		}
	});
	wow.init();
	/*//컨텐츠 fade in */
</script>
<style>
.movie{ width: 1200px; float: left;text-align: center; display: block; margin: 0  0 50px 0; padding: 0; background-color: #000;}
.movie video{ margin: 0; padding: 0; width: 100%;}
</style>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">			
			<span class="title">대회소개</span>
		</div>
		<div style="font-size:16px; line-height:26px; color:#8c8c8c">제5회 서원·클럽디 레이디스 골프 챔피언십은 총 시상규모 4억원 상당의 골프장에서 주관·주최하는 
전국 최대 규모의 여성골프대회입니다.<br> 이번 대회는 지난 대회를 거쳐오면서 부족했던 점들을 더욱 보완하여, 대회를 더욱 품격있게 격상시키기 위해 만반의 준비를 하고 있습니다. 여성 골퍼분들의 도전을 기다리고 있으니 많은 관심 부탁드립니다.<br><br>
		</div>    
	
		<div class="movie">
			<video muted="true" loop="loop" id="bgvid" controls="controls" autoplay="autoplay">
				<source src="<c:url value='/images/intro/ladyday.mp4'/>" type="video/mp4">  
				<source src="<c:url value='/images/intro/ladyday.webm'/>" type="video/webm">				
			</video>
		</div>
		
		
		<div class="subTitle subBottom">			
			<span class="title">대회스케치</span>
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

			<div class="galleryListBox" id="gBody"></div>
		</div>	
						
		<div class="paging" id="paging"><ul></ul></div>		
		
		<c:if test="${!empty sessionScope.msMember.msId}">
			<div class="btnBox">
				<a href="<c:url value='/hills/board/write.do?bbsType=${bbsType}'/>" class="orangeBtn">글쓰기</a>
			</div>
		</c:if>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer.jsp" flush="true" />