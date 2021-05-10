<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script type="text/javascript">
	$(document).ready(function() { 
		if("${bbsType}" == "1") {
			initImage();
		}
		
		if("${bbsType}" == "6") {
			initAttachFiles();
		}	
		
		doSearchReply();
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
	
		/* if(file2 != "") {
			$("#viewAttach").show();
		} */
		
		if(file1 != "") {
			var extension = getExtensionOfFilename(file1);
			
			if(extension == "jpg" || extension == "jpeg" || extension == "png") {
				$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=valley&folderName=" + folderName + "&fileName=" + originFileName1 + "'/>");
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
	         	   
	         		location.href = "<c:url value='/m_valley/board/list.do?bbsType=${bbsType}'/>"
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}
	
	function doDeleteReply(reIdx) {
		var sUrl = "<c:url value='/valley/board/deleteReply.do'/>";
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
		
		var sUrl = "<c:url value='/valley/board/writeReply.do'/>";
		
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
		var reBody = $("#commentContainer");
		
		var sUrl = "<c:url value='/valley/board/getBoardReplyData.do'/>";
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
	         		reply += "    <img src='<c:url value='/images/valley/rp_arrow.png'/>' alt='' class='img'>									 ";
	         		reply += "    <div class='reply'>                                                        									 ";
	         		reply += "        <span class='new'><img src='<c:url value='/images/valley/rp_new.png'/>' alt='' style='display:{0}'></span> ";
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
	#attachFile1 a{color:#0000ff;}
	#attachFile2 a{color:#0000ff;}
	#attachFile1 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
	#attachFile2 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
</style>
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
		<div class="grayBg viewBox">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>		
			<img src="" id="viewMainImage" class="viewMainImage" alt="">
			<div class="viewTxt">
				${content}	
			</div>
			<div id="viewAttach" style="display: none">
				<img class="attachImg" src="<c:url value='/images/m_valley/board_file.png'/>"/>
				 <span class="attachTxt">첨부파일 : </span>
				 <span id="attachFile1"><a class="attachTxt"></a></span>
				 <span id="attachFile2"><a class="attachTxt"></a></span>	 
			</div>
		</div>
		<c:if test="${bbsType eq '6'}">
		<div class="commentBox">
			<div class="commenTitle">
				<span class="commonDot">나도한마디</span>
				<span class="comentTxt"> 현재까지 총 <span class="orangeRed" id="txtReplyCnt"></span>의 댓글이 있습니다.</span>
			</div>
			<div class="commentTxt" style="height: 20px;">
				<form id="replyForm" method="post">			
					<input type="hidden" name="idx" value="${idx}" />	
					<input type="text" name="reply" id="txtReply"  class="txtReply"/><a href="javascript:writeReply()" class="blueBtn viewInput">입력</a>	
				</form>	
			</div>
			<div class="comment" id="commentContainer">
			
			</div>
		</div>
		</c:if>
		
		
		<c:if test="${empty sessionScope.msMember.msId}">
			<a class="grayBtn closeBtn" href="<c:url value='/m_valley/board/list.do?bbsType=${bbsType}'/>">목록</a>
		</c:if>
		<c:if test="${not empty sessionScope.msMember.msId}">
			<ul class="btnBox_three">
				<li class="grayBtn"><a href="<c:url value='/m_valley/board/list.do?bbsType=${bbsType}'/>">목록</a></li>
				<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
					<li class="blueBtn"><a href="<c:url value='/m_valley/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>">수정</a></li>
					<li class="grayBtn"><a href="javascript:doDelete()">삭제</a></li>
				</c:if>
			</ul>
		</c:if>
		
		
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>