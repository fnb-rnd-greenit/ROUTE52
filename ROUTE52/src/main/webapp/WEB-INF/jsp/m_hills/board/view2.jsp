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
		}
		
		if("${bbsType}" > "50") {
			initAttachFiles();
		}
		
		if("${bbsType}" == "6") {
			initAttachFiles();
		}	
		
		//doSearchReply();
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
	
	function doConsultation() {
		var sUrl = "<c:url value='/hills/board/doConsultation.do'/>";
		var sParams = "";
		
		var agree = $(":input:checkbox[name=chkAgree]:checked").val();
		if(agree == null) {
			alert("약관에 동의하세요.");
			return;
		}
		
		var name, phone, interest;
		name = $("#txtName").val();
		phone = $("#txtPhone1").val() + $("#txtPhone2").val() + $("#txtPhone3").val();
		interest = $("#txtInterest").val();

		if(name == "") {
			alert("이름을 입력하세요.");
			return;
		}
		if(phone == "") {
			alert("핸드폰번호를 입력하세요.");
			return;
		}
		if(interest == "") {
			alert("관심부위를 입력하세요.");
			return;
		}

		sParams += String.format("coDiv={0}", "65");
		sParams += String.format("&name={0}", name);
		sParams += String.format("&phone={0}", phone);
		sParams += String.format("&interest={0}", interest);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("상담신청 완료되었습니다.");
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
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
			<c:if test="${bbsType eq '1000'}">
				제휴안내
			</c:if>
			<c:if test="${bbsType eq '51'}">
				전체
			</c:if>
			<c:if test="${bbsType eq '52'}">
				골프용품(의류)
			</c:if>
			<c:if test="${bbsType eq '53'}">
				호텔/레저/외식
			</c:if>
			<c:if test="${bbsType eq '54'}">
				기타
			</c:if>
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	
	<ul class="myzoneTabList5">		
		<c:if test="${bbsType eq '1000'}">	
			<li class="on" style="width:20%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=1000'/>">제휴안내</a></li>
		</c:if>
		<c:if test="${bbsType ne '1000'}">	
			<li class="" style="width:20%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=1000'/>">제휴안내</a></li>
		</c:if>
		<c:if test="${bbsType eq '51'}">
			<li class="on" style="width:15%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=51'/>">전체</a></li>
		</c:if>
		<c:if test="${bbsType ne '51'}">
			<li class="" style="width:15%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=51'/>">전체</a></li>
		</c:if>	
		<c:if test="${bbsType eq '52'}">
			<li class="on" style="width:25%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=52'/>">골프용품(의류)</a></li>
		</c:if>
		<c:if test="${bbsType ne '52'}">
			<li class="" style="width:25%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=52'/>">골프용품(의류)</a></li>
		</c:if>	
		<c:if test="${bbsType eq '53'}">
			<li class="on" style="width:25%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=53'/>">호텔/레져/외식</a></li>
		</c:if>
		<c:if test="${bbsType ne '53'}">
			<li class="" style="width:25%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=53'/>">호텔/레져/외식</a></li>
		</c:if>	
		<c:if test="${bbsType eq '54'}">
			<li class="on" style="width:15%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=54'/>">기타</a></li>
		</c:if> 
		<c:if test="${bbsType ne '54'}">
			<li class="" style="width:15%;"><a href="<c:url value='/m_hills/board/list.do?bbsType=54'/>">기타</a></li>
		</c:if>	       
	</ul> 
	
	<c:choose>
		<c:when test="${bbsType eq '1000'}">
			<div class="contents">
				<div class="midTitleBox">
				<span class="commonDot"> 제휴안내</span>		
				</div>
				<div>
					<img src="<c:url value='/images/m_hills/jhqna.jpg'/>" alt="" style="width:100%;">
				</div>
			</div>
		</c:when>
		<c:otherwise>
		<div class="contents">
		<div class="grayBg viewBox bgBottom">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>
			<c:choose>
		       	<c:when test="${idx eq '94'}">
		       		<img src="" id="viewMainImage" class="viewMainImage"  alt="">

					<div class="wjBottom">		
						<div class="bottomInfo">
							<div class="w_logoBox">
								<img src="<c:url value='/images/m_hills/icon_mhw.png'/>" alt="" class="w_logo">
							</div>
				
							<div class="wjInputBox">
								<div class="floatInput">
									<ul class="infoBox">
										<li class="title">이름</li>
										<li><input type="text" name="MemName" id="txtName" maxlength="10" class="txtInput"></li>
									</ul>
									<ul class="infoBox">
										<li class="title">연락처</li>
										<li><input type="text" class="phoneInput" maxlength="3" id="txtPhone1"> <input type="text" class="phoneInput" maxlength="4" id="txtPhone2"> <input type="text" class="phoneInput" maxlength="4" id="txtPhone3"></li>
									</ul>
									<ul class="infoBox">
										<li class="title">관심부위</li> 
										<li><input type="text" name="MemName" maxlength="10" class="txtInput" id="txtInterest"></li>
									</ul>
									<p class="agreeyCheck"> 
										<input type="checkbox" class="agCheck" name="chkAgree"> 개인정보 수집 및 사용에 동의합니다.<br> <a href="<c:url value='/m_hills/board/wj.do'/>" target="_blank">[자세히보기]</a> 
									</p>
								</div>
							</div>
				
							<ul class="wjNumberBox">
								<li class="link"><a href="javascript:doConsultation();" class="linkBtn">상담신청</a></li>
								<li class="number">010.5764.3301</li>
								<li class="text">제휴 할인에 대한 문의는<br> 위의 번호로만 가능합니다.</li> 
							</ul>
							
							<div class="w_logoBox">
								<a href="<c:url value='tel:01057643301'/>"><img src="<c:url value='/images/m_hills/icon_mhph.png'/>" alt="" class="w_logo1"></a>
								<a href=""><img src="<c:url value='/images/m_hills/icon_mhka.png'/>" alt="" class="w_logo1"></a>
							</div>
						</div>
					</div>
		       	</c:when>
		       	<c:when test="${idx eq '83'}">
		       		<img src="" id="viewMainImage" class="viewMainImage"  alt="">
					
					<div style="text-align:center; padding-top:20px;">
						<a href="<c:url value='tel:0226609000'/>"><img src="<c:url value='/images/m_hills/mobilePhone.png'/>" alt="" style="height:30px"></a>
					</div>
		       	</c:when>
		       	<c:when test="${idx eq '82'}">
		       		<img src="" id="viewMainImage" class="viewMainImage"  alt="">
					
					<div style="text-align:center; padding-top:20px;">
						<a href="<c:url value='tel:0319254005'/>"><img src="<c:url value='/images/m_hills/mobilePhone.png'/>" alt="" style="height:30px"></a>
					</div>
		       	</c:when>
		       	<c:when test="${idx eq '84'}">
		       		<img src="" id="viewMainImage" class="viewMainImage"  alt="">
		       		<a class="orangeBtn closeBtn" href="https://b2b.onemount.co.kr/seowon.php" style="margin-top:1em;"> 온라인 구매 페이지 이동 </a>
		       	</c:when>
		       	<c:otherwise>
				<img src="" id="viewMainImage" class="viewMainImage"  alt="">
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
		<c:if test="${bbsType eq '6'}">
		<div class="commentBox" style="display:none">
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
		</c:if>
		  
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
		</c:otherwise>
	</c:choose>
	<!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>