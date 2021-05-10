<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">
<script type="text/javascript">
	$(document).ready(function() { 
		var content = "${content}";
		
		content = convertSpecialCharacters(content);
		
		$("#txtContent").append(content);
		
		if("${bbsType}" == "1") {
			initImage();
		} else {
			initAttachFiles();
		}	
		
		if("<c:out value='${replyYn}'/>" == "1" && "<c:out value='${bbsType}'/>" == "6") {
			doSearchReply();
		}
	});
	
	function initImage() {
		var imageName = "<c:out value='${upFileName1}'/>";
		var folderName = "<c:out value='${folderName}'/>";
		
		if(imageName != "") {
			$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=hills&folderName=" + folderName + "&fileName=" + imageName + "'/>");
		} else {
			$("#viewMainImage").attr("src", "<c:url value='/images/hills/boardDefaultImage.jpg'/>");
		}
	}
	
	function initAttachFiles() {
		var file1 = "<c:out value='${upOriginFile2}'/>";
		var file2 = "<c:out value='${upOriginFile3}'/>";
		var originFileName1 = "<c:out value='${upFileName2}'/>";
		var originFileName2 = "<c:out value='${upFileName3}'/>";
		var folderName = "<c:out value='${folderName}'/>";
	
		/* if(file2 != "") {
			$("#viewAttach").show();
		} */
		
		if(file1 != "") {
			var extension = getExtensionOfFilename(file1);
			
			if(extension == "jpg" || extension == "jpeg" || extension == "png") {
				$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=hills&folderName=" + folderName + "&fileName=" + originFileName1 + "'/>");
			} else {
				/* $("#attachFile1 a").append(file1);
				$("#attachFile1 a").click(function() {
					downloadAttachFile(folderName, file1, originFileName1);
				}); */
			}
		}
		
		/* if(file2 != "") {
			$("#attachFile2 a").append(file2);
			$("#attachFile2 a").click(function() {
				downloadAttachFile(folderName, file2, originFileName2);
			});
		} */
	}
	
	function downloadAttachFile(folderName, fileName, originFileName) {
		var sUrl = "<c:url value='/common/downloadFile.do'/>";
		var sParams = "";
		
		sParams += String.format("?fileName={0}", fileName);
		sParams += String.format("&originFileName={0}", originFileName);
		sParams += String.format("&folderName={0}", folderName);
		sParams += String.format("&division={0}", "hills");

		window.open(sUrl + sParams);
	}
	
	function doDelete() {
		var sUrl = "<c:url value='/hills/board/deleteBoard.do'/>";
		var sParams = "";
		
		var idx = "<c:out value='${idx}'/>";
		sParams += String.format("&idx={0}", idx);
		
		var deleteYn = confirm("글을 삭제하시겠습니까?");
		
		if(deleteYn) {
			mAjax(sUrl, sParams, function(data) {
	        	if(data.resultCode == "0000") {
	         		alert("글이 삭제되었습니다.");
	         	   
	         		location.href = "<c:url value='/m_hills/board/list.do?bbsType=${bbsType}'/>"
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}
	
	function doDeleteReply(reIdx) {
		var sUrl = "<c:url value='/hills/board/deleteReply.do'/>";
		var sParams = "";
		
		var idx = "<c:out value='${idx}'/>";
		sParams += String.format("&idx={0}", idx);
		sParams += String.format("&replyIdx={0}", reIdx);
		
		var deleteYn = confirm("댓글을 삭제하시겠습니까?");
		
		if(deleteYn) {
			mAjax(sUrl, sParams, function(data) {
	        	if(data.resultCode == "0000") {
	        		doSearchReply();
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}
	
	function writeReply() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			return;
		}
		
		var sUrl = "<c:url value='/hills/board/writeReply.do'/>";
		
		var reply = $("#txtReply").val();
		
		if(reply == null || reply == "") {
			alert("댓글을 작성하세요.");
			return;
		}
		
		var formData = new FormData($("#replyForm")[0]);
		
		progressStart();
		
		mPostAjax(sUrl, formData, function(data) {
     		progressStop();
     		
        	if(data.resultCode == "0000") {
        		$("#txtReply").val("");
        		
         		alert("등록 되었습니다.");
         		         		
         		doSearchReply();
            } else {
         	   alert(data.resultMessage);
            }
        });	
	}
	
	function doSearchReply() {
		$("#reply-body").show();
		
		var reBody = $("#commentContainer");
		
		var sUrl = "<c:url value='/hills/board/getBoardReplyData.do'/>";
		var sParams = "";
		
		sParams += String.format("idx={0}", "${idx}");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				reBody.empty();
				
				var rows = data.rows;
				
				$("#txtReplyCnt").html(rows.length);
				
				for(i=0; i<rows.length; i++) {
					var reply = "";
					reply += "<div class='replyBox'>                                                                                             ";
	         		reply += "    <img src='<c:url value='/images/hills/rp_arrow.png'/>' alt='' class='img'>									 ";
	         		reply += "    <div class='reply'>                                                        									 ";
	         		reply += "        <span class='new'><img src='<c:url value='/images/hills/rp_new.png'/>' alt='' style='display:{0}'></span> ";
	         		reply += "        <span class='name'>{1}</span>                                         									 ";
	        		reply += "        <span class='replyCont'>{2}</span>                                     									 ";
	         		reply += "        <span class='date'>{3}</span>                                           									 ";
	        		reply += "        <a href='javascript:doDeleteReply({4})' class='delete' style='display:{5};'>삭제</a>    					 ";
	         		reply += "    </div>                                                                     									 ";
	         		reply += "</div>                                                                         									 ";
	         		
	         		var regDate = rows[i].REGDATE;
	         		var curDate = new Date().yyyymmdd();
	         		var name = rows[i].USERNAME;
	         		var content = rows[i].CONTENT;
	         		var replyIdx = rows[i].REPLY_IDX;
	         		var userNum = rows[i].USERNUM;
	         		var newDisplay = regDate == curDate ? "inline" : "none";
	         		var delDisplay = userNum == "${sessionScope.msMember.msNum}" ? "inline" : "none";
	         		regDate = regDate.substring(0, 4) + "/" + regDate.substring(4, 6) + "/" + regDate.substring(6, 8);
	         		
	         		reply = String.format(reply, newDisplay, name, content, regDate, replyIdx, delDisplay);
	         		
	         		reBody.append(reply);
				}
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
</script>
<style>
	#attachFile1 a{ color:#0000ff}
	#attachFile2 a{ color:#0000ff}
	#attachFile1 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
	#attachFile2 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
</style>
<div id="wrap">
<div class="mainTitle">
	<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""></span> 
		<c:if test="${bbsType eq '1'}">
			공지사항
		</c:if>
		<c:if test="${bbsType eq '3'}">
			포토갤러리
		</c:if>
		<c:if test="${bbsType eq '6'}">
			이벤트갤러리
		</c:if>
	<span><img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""></span>
</div>
	<div class="contents">
		<div class="grayBg viewBox bgBottom">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>	
			<c:choose>
				<c:when test="${idx eq '152' && bbsType eq '1'}">		
				<img src="<c:url value='/images/m_hills/191028_1.jpg'/>" style="width:100%;"/>
				<a href="javascript:void(0)" onclick="alert('연단체 온라인신청은 PC홈페이지에서만 가능합니다.');return false;"><img src="<c:url value='/images/m_hills/191028_2.jpg'/>" style="width:100%;"/></a>
				</c:when>
				<c:when test="${idx eq '290' && bbsType eq '1'}">		
				<img src="<c:url value='/images/m_hills/200922_1.jpg'/>" style="width:100%;"/>
				<a href="/m_hills/myzone/royaltime.do"><img src="<c:url value='/images/m_hills/200922_2.jpg'/>" style="width:100%;"/></a>
				<img src="<c:url value='/images/m_hills/200922_3.jpg'/>" style="width:100%;"/>
				</c:when>
				<c:when test="${idx eq '249' && bbsType eq '6'}">		
				<img src="<c:url value='/images/m_hills/200604_01.jpg'/>" style="width:100%;"/>
				<a href="https://youtu.be/fBpttNKK4Wg" target="_blank"><img src="<c:url value='/images/m_hills/200604_02.jpg'/>" style="width:100%;"/></a>
				<img src="<c:url value='/images/m_hills/200604_03.jpg'/>" style="width:100%;"/>
				</c:when>
				<%-- <c:when test="${idx eq '319' && bbsType eq '1'}">		
				<img src="<c:url value='/images/m_hills/201222_01.jpg'/>" style="width:100%;"/>
				<a href="https://kr.object.ncloudstorage.com/hills/document/21%EB%85%84%20%EC%96%BC%EB%A6%AC%EB%B2%84%EB%93%9C%20%EB%A9%A4%EB%B2%84%EC%8A%A4%28%EC%9D%BC%EB%B0%98%EB%8B%A8%EC%B2%B4%29%20%EC%8B%A0%EC%B2%AD%EC%84%9C%28%EC%B5%9C%EC%A2%85%29.pdf"><img src="<c:url value='/images/m_hills/201222_02.jpg'/>" style="width:100%;"/></a>
				</c:when> --%>
				<c:when test="${idx eq '295' && bbsType eq '1'}">		
				<img src="<c:url value='/images/m_hills/201020_01.jpg'/>" style="width:100%;"/>
				<a href="https://kr.object.ncloudstorage.com/contents/seowon-member/2021_%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4_%EC%97%B0%EB%8B%A8%EC%B2%B4_%EC%9A%B4%EC%98%81%EA%B7%9C%EC%A0%95.pdf" target="_blank"><img src="<c:url value='/images/m_hills/201020_02.jpg'/>" style="width:50%; float:left;"/></a>
				<%-- <a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%202021%EB%85%84%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EC%8B%A0%EC%B2%AD%EC%84%9C.pdf" target="_blank"><img src="<c:url value='/images/m_hills/201020_03.jpg'/>" style="width:50%; float:left;"/></a> --%>
				<img src="<c:url value='/images/m_hills/201020_03.jpg'/>" style="width:50%; float:left;"/>
				</c:when>
				
				<c:when test="${idx eq '343' && bbsType eq '1'}">		
				<img src="<c:url value='/images/m_hills/210329_01.jpg'/>" style="width:100%;"/>
				<a href="https://www.seowongolf.co.kr/hills/team/generalRequest.do" target="_blank"><img src="<c:url value='/images/m_hills/210329_02.jpg'/>" style="width:100%;"/></a>
				<img src="<c:url value='/images/m_hills/210329_03.jpg'/>" style="width:100%;"/>
				</c:when>
								
				<c:otherwise>
				<img src="" id="viewMainImage" class="viewMainImage" alt="">
				</c:otherwise>
			</c:choose>
			<div class="viewTxt" id="txtContent">
			</div>
			<div id="viewAttach" style="display: none">
				<img class="attachImg" src="<c:url value='/images/m_hills/board_file.png'/>"/>
				 <span class="attachTxt">첨부파일 : </span>
				 <span id="attachFile1" class="attachTxt"><a></a></span>
				 <span id="attachFile2" class="attachTxt"><a></a></span>	 
			</div>
		</div>
		<div class="commentBox" style="display:none" id="reply-body">
			<div class="commenTitle">
				<span class="commonDot">나도한마디</span>
				<span class="comentTxt"> 현재까지 총 <span class="orangeRed" id="txtReplyCnt"></span>의 댓글이 있습니다.</span>
			</div>
			<div class="commentTxt">
				<form id="replyForm" method="post">			
					<input type="hidden" name="idx" value="${idx}" />	
					<input type="text" name="reply" id="txtReply" class="txtReply"/><a href="javascript:writeReply()" class="orangeBtn viewInput">입력</a>	
				</form>	
			</div>
			<div class="comment" id="commentContainer">
			
			</div>
		</div>
		  
		<!-- 목록한개일때-->
		<c:if test="${empty sessionScope.msMember.msId}">
			<a class="grayBtn closeBtn" href="<c:url value='/m_hills/board/list.do?bbsType=${bbsType}'/>">목록</a>
		</c:if>
		<c:if test="${not empty sessionScope.msMember.msId}">
			<ul class="btnBox_three">
				<li class="grayBtn"><a href="<c:url value='/m_hills/board/list.do?bbsType=${bbsType}'/>">목록</a></li>
				<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
					<li class="orangeBtn"><a href="<c:url value='/m_hills/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>">수정</a></li>
					<li class="grayBtn"><a href="javascript:doDelete()">삭제</a></li>
				</c:if>
			</ul>
		</c:if>
		
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>