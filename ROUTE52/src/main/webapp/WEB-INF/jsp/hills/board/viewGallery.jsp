<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 		
		var content = "${content}";
		
		content = convertSpecialCharacters(content);
		
		$("#txtContent").append(content);
		
		//initImage();
		
		initAttachFiles();	
		
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
	
		if(file2 != "") {
			$("#viewAttach").show();
		}
		
		if(file1 != "") {
			var extension = getExtensionOfFilename(file1);
			
			if(extension == "jpg" || extension == "jpeg" || extension == "png") {
				$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=hills&folderName=" + folderName + "&fileName=" + originFileName1 + "'/>");
			} else {
				$("#attachFile1 a").append(file1);
				$("#attachFile1 a").click(function() {
					downloadAttachFile(folderName, file1, originFileName1);
				});
			}
		}
		
		if(file2 != "") {
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
	         	   
	         		location.href = "<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>"
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

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<c:if test="${bbsType eq '3'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>포토갤러리</span></p>
		</c:if>
		<c:if test="${bbsType eq '5'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>홀인원갤러리</span></p>
		</c:if>
		<c:if test="${bbsType eq '6'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>이벤트갤러리</span></p>
		</c:if>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList3">
			<c:if test="${bbsType eq '1'}">
				<a href="<c:url value='/hills/board/list.do?bbsType=1'/>" class="on">공지사항</a>
			</c:if>
			<c:if test="${bbsType ne '1'}">
				<a href="<c:url value='/hills/board/list.do?bbsType=1'/>">공지사항</a>
			</c:if>
			<c:if test="${bbsType eq '6'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=6'/>" class="on">이벤트</a>
			</c:if>
			<c:if test="${bbsType ne '6'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=6'/>">이벤트</a>
			</c:if>
		<%-- 	<c:if test="${bbsType eq '2'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=2'/>" class="on">뉴스</a>
			</c:if>
			<c:if test="${bbsType ne '2'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=2'/>">뉴스</a>
			</c:if> --%>
			<c:if test="${bbsType eq '3'}">		
			<a href="<c:url value='/hills/board/list.do?bbsType=3'/>" class="on">포토갤러리</a>
			</c:if>
			<c:if test="${bbsType ne '3'}">		
			<a href="<c:url value='/hills/board/list.do?bbsType=3'/>">포토갤러리</a>
			</c:if>				
			<!-- <a href="javascript:alert('준비중입니다.');">자료실</a>	 -->
		</div>
		<div class="subTitle subBottom">
			<c:if test="${bbsType eq '3'}">
				<span class="title">포토갤러리</span>
			</c:if>
			<c:if test="${bbsType eq '5'}">
				<span class="title">홀인원갤러리</span>
			</c:if>
			<c:if test="${bbsType eq '6'}">
				<span class="title">이벤트갤러리</span>
			</c:if>			
			<span class="titleDes"></span>
		</div>
		
		<div class="viewBox">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>		
			<c:choose>
		       	<c:when test="${idx eq '67'}">
		        	<img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
					<map name="Map" id="Map">
				  		<area shape="rect" coords="208,3143,540,3238" href="<c:url value='/hills/champion/ladyPassport.do?action=I'/>" />
				  		<area shape="rect" coords="638,3136,977,3239" href="<c:url value='/hills/champion/ladyPassport.do'/>" />
					</map>
		       	</c:when>		       	
		       	<c:when test="${idx eq '149'}">      
			  	<img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  	<map name="Map" id="Map">
			  	<area shape="rect" coords="249,1451,490,1489" href="<c:url value='/hills/board/list.do?bbsType=3'/>" />
			  	</map>
				</c:when>
				<c:when test="${idx eq '249'}">      
			  	<img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  	<map name="Map">
				  <area shape="rect" coords="277,1621,524,1692" href="https://youtu.be/fBpttNKK4Wg" target="_blank">
				</map>
				</c:when>
		       	<c:when test="${idx eq '76'}">
		           	<img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
					<map name="Map" id="Map">
				  		<area shape="rect" coords="614,1072,742,1124" href="<c:url value='/hills/champion/champion4.do'/>" />
	  					<area shape="rect" coords="471,1075,595,1124" href="<c:url value='/hills/champion/ladyPassport.do?action=I'/>" />
				  	</map>
		       	</c:when>
		       	<c:otherwise>
				<img src="" id="viewMainImage" class="viewMainImage"  alt="">
		       	</c:otherwise>
		   	</c:choose>
			
			<div class="viewTxt" id="txtContent">
			</div>
			<div id="viewAttach" style="display: none">
				 <span>첨부파일 : </span>
				 <span id="attachFile1"><a></a></span>
				 <span id="attachFile2"><a></a></span>	 
			</div>
		</div>
		<div class="commentBox" id="reply-body" style="display:none;">		  	
			<div class="commenTitle">
				<span class="commonDot">나도한마디</span>
				<span class="comentTxt"> 현재까지 총 <span class="orangeRed" id="txtReplyCnt"></span>의 댓글이 있습니다.</span>
			</div>
			<div class="commentTxt">
				<form id="replyForm" method="post">			
					<input type="hidden" name="idx" value="${idx}" />	
					<input type="text" name="reply" id="txtReply" /><a href="javascript:writeReply()" class="orangeBtn">입력</a>	
				</form>			
			</div>
			<div class="comment" id="commentContainer">
				
			</div>
		</div>
		<div class="btnBox">
			<a href="<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>" class="grayBtn">목록</a>
			<c:if test="${sessionScope.msMember.msNum == userNum}">
				<a href="<c:url value='/hills/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>" class="orangeBtn">수정</a>
				<a href="javascript:doDelete()" class="grayBtn">삭제</a>
			</c:if>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />