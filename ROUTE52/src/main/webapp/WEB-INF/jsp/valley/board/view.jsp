<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 
		initImage();
		
		initAttachFiles();		
	});
	
	function initImage() {
		var imageName = "<c:out value='${upFileName1}'/>";
		var folderName = "<c:out value='${folderName}'/>";
		
		if(imageName != "") {
			$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=valley&folderName=" + folderName + "&fileName=" + imageName + "'/>");
		} else {
			$("#viewMainImage").attr("src", "<c:url value='/images/valley/boardDefaultImage.jpg'/>");
		}
	}
	
	function initAttachFiles() {
		var file1 = "<c:out value='${upOriginFile2}'/>";
		var file2 = "<c:out value='${upOriginFile3}'/>";
		var originFileName1 = "<c:out value='${upFileName2}'/>";
		var originFileName2 = "<c:out value='${upFileName3}'/>";
		var folderName = "<c:out value='${folderName}'/>";

		if(file1 != "" || file2 != "") {
			$("#viewAttach").show();
		}
		
		if(file1 != "") {
			$("#attachFile1 a").append(file1);
			$("#attachFile1 a").click(function() {
				downloadAttachFile(folderName, file1, originFileName1);
			});
		}
		
		if(file2 != "") {
			if(file1 != ""){
				$("#attachFile2").prepend(" ,  ");
			}
			$("#attachFile2 a").append(file2);
			$("#attachFile2 a").click(function() {
				downloadAttachFile(folderName, file2, originFileName2);
			});
		}
	}
	
	function downloadAttachFile(folderName, fileName, originFileName) {
		var sUrl = "<c:url value='/common/downloadFile.do'/>";
		var sParams = "";
		
		sParams += String.format("?fileName={0}", fileName);
		sParams += String.format("&originFileName={0}", originFileName);
		sParams += String.format("&folderName={0}", folderName);
		sParams += String.format("&division={0}", "valley");

		window.open(sUrl + sParams);
	}
	
	function doDelete() {
		var sUrl = "<c:url value='/valley/board/deleteBoard.do'/>";
		var sParams = "";
		
		var idx = "<c:out value='${idx}'/>";
		sParams += String.format("&idx={0}", idx);
		
		var deleteYn = confirm("글을 삭제하시겠습니까?");
		
		if(deleteYn) {
			mAjax(sUrl, sParams, function(data) {
	        	if(data.resultCode == "0000") {
	         		alert("글이 삭제되었습니다.");
	         	   
	         		location.href = "<c:url value='/valley/board/list.do?bbsType=${bbsType}'/>"
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}

</script>
<style>
	#attachFile1 a{ color:#0000ff}
	#attachFile2 a{ color:#0000ff}
	#attachFile1 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
	#attachFile2 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
</style>

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
			<a href="<c:url value='/valley/board/reference.do'/>">">자료실</a>
		</div>
		<div class="subTitle subBottom">
			<c:if test="${bbsType eq '1'}">
				<span class="title">공지사항</span>
				<span class="titleDes"></span>
			</c:if>
			<c:if test="${bbsType eq '2'}">
				<span class="title">뉴스</span>
				<span class="titleDes"></span>
			</c:if>
		</div>
		
		<div class="viewBox grayBgBox">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>		
			<img src="" id="viewMainImage"  class="viewMainImage" alt="">
			<div class="viewTxt">
				${content}	
			</div>
			<div id="viewAttach" style="display: none">
				<img class="attachImg" src="/valley/images/board_file.png"/>
				 <span>첨부파일 : </span>
				 <span id="attachFile1"><a></a></span>
				 <span id="attachFile2"><a></a></span>	 
			</div>
		</div> 
		<div class="btnBox">
			<a href="<c:url value='/valley/board/list.do?bbsType=${bbsType}'/>" class="grayBtn">목록</a>
			<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
				<a href="<c:url value='/valley/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>" class="blueBtn">수정</a>
				<a href="javascript:doDelete()" class="grayBtn">삭제</a>
			</c:if>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />