<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 
		initView();
		
		initListener();
	});
	
	function initView() {
		var actionFlag = "<c:out value='${actionFlag}'/>";
		
		if(actionFlag == "update") {
			var title = "<c:out value='${title}'/>";
			var content = "<c:out value='${content}'/>";
			var hiddenYn = "<c:out value='${hiddenYn}'/>";
			var replyYn = "<c:out value='${replyYn}'/>"
			content = replaceAll(content, "[ENTER]", "\r\n");
			
			content = convertSpecialCharacters(content);
			title = convertSpecialCharacters(title);
			 
			$("#title").val(title);
			$("#content").val(content);
			$("#imageFileName").val("<c:out value='${upOriginFile1}'/>");
			$("#attachFileName1").val("<c:out value='${upOriginFile2}'/>");
			$("#attachFileName2").val("<c:out value='${upOriginFile3}'/>");

			if(hiddenYn == "1") {
				$("#chkHidden").prop("checked", true);
			}
			
			if(replyYn == "1") {
				$("#chkReply").prop("checked", true);
			}
		}
		
		if("${bbsType}" == "3") {
			$("#mainImageContainer").hide();
			$("#hideContainer").hide();
		}
		
		if("${bbsType}" != "6") {
			$("#replyContainer").hide();
		}
	}
	
	function initListener() {		
		$('#uploadImage').change(function (event) {
			var fileValue = $("#uploadImage").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; 
			
			$("#imageFileName").val(fileName);	
		});
		
		$('#uploadBtn1').change(function () {
			var fileValue = $("#uploadBtn1").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; 
			
			$("#attachFileName1").val(fileName);
		});
		
		$('#uploadbtn').change(function () {
			var fileValue = $("#uploadbtn").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; 
			
			$("#attachFileName2").val(fileName);
		});
	}

	function writeBoard() {
		var sUrl = "<c:url value='/hills/board/writeBoard.do'/>";
		
		var title = $("#title").val();
		var content = $("#content").val();
		var bbsType = "<c:out value='${bbsType}'/>";
		
		if(title == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		if( bbsType != "3" && bbsType != "5" && bbsType != "6"  && content == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		if(( bbsType == "5" || bbsType == "6" ) && $("#imageFileName").val() == "") {
			alert("대표이미지를 등록하세요.");
			return;
		}
		
		if(bbsType == "3" && $("#attachFileName1").val() == "") {
			alert("이미지를 등록하세요.");
			return;
		}

        var formData = new FormData($("#fileForm")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("작성한 글이 정상적으로 등록되었습니다.");
         	   
         		location.href = "<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>"
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<c:if test="${bbsType eq '1'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>공지사항</span></p>
		</c:if>
		<%-- <c:if test="${bbsType eq '2'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>뉴스</span></p>
		</c:if> --%>
		<c:if test="${bbsType eq '3'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>포토갤러리</span></p>
		</c:if>
		<c:if test="${bbsType eq '4'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>이벤트</span></p>
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
			<c:if test="${bbsType eq '1'}">
				<span class="title">공지사항</span>
				<span class="titleDes"></span>
			</c:if>
			<c:if test="${bbsType eq '2'}">
				<span class="title">뉴스</span>
				<span class="titleDes"></span>
			</c:if>	
			<c:if test="${bbsType eq '3'}">
				<span class="title">포토갤러리</span>
				<span class="titleDes"></span>
			</c:if>		
			<c:if test="${bbsType eq '4'}">
				<span class="title">이벤트</span>
				<span class="titleDes"></span>
			</c:if>		
			<c:if test="${bbsType eq '5'}">
				<span class="title">홀인원갤러리</span>
				<span class="titleDes"></span>
			</c:if>		
			<c:if test="${bbsType eq '6'}">
				<span class="title">이벤트갤러리</span>
				<span class="titleDes"></span>
			</c:if>			
		</div>
		
		<form id="fileForm" action="fileUpload" method="post" enctype="multipart/form-data">
		
		<div class="writeBox grayBgBox">
			<div class="list">
				<span class="orangeRed">* </span><span class="title"> 제목</span>
				<input type="text" class="titleIp" id="title" name="title" style="font-size: 15px; padding-left: 10px">
			</div>
			<div class="list" id="mainImageContainer">
				<span class="orangeRed">* </span><span class="title"> 대표이미지</span>
				<input type="text" class="fileName" id="imageFileName" style="font-size: 15px" readonly="readonly">
				<label for="uploadImage" class="btn_file">이미지찾기</label>
				<input type="file" id="uploadImage" name="uploadImage" class="uploadBtn">
				<span class="liTxt"> * 이미지를 첨부하지 않을시 기본 이미지로 등록 됩니다.</span>
			</div>	  
			<div class="list">
				<span class="orangeRed">* </span><span class="title"> 첨부파일</span>
				<input type="text" class="fileName" id="attachFileName1" style="font-size: 15px" readonly="readonly">
				<label for="uploadBtn1" class="btn_file file2">첨부파일찾기</label>
				<input type="file" id="uploadBtn1" name="uploadFile1" class="uploadBtn">
				<span class="liTxt"> * 첨부파일은 최대 2개까지 등록이 가능합니다.</span>
			</div>
			<div class="list">
				<span class="orangeRed">&nbsp;&nbsp;&nbsp;</span><span class="title"></span>
				<input type="text" class="fileName" id="attachFileName2" style="font-size: 15px" readonly="readonly">
				<label for="uploadbtn" class="btn_file file2">첨부파일찾기</label>
				<input type="file" id="uploadbtn" name="uploadFile2" class="uploadBtn">
			</div>
			<div class="list" id="hideContainer">
				<span class="orangeRed">* </span><span class="title"> 숨기기</span>
				<input type="checkbox" class="titleIp" id="chkHidden" name="hide" style="font-size: 15px; padding-left: 10px">
			</div>
			<div class="list" id="replyContainer">
				<span class="orangeRed">* </span><span class="title"> 댓글허용</span>
				<input type="checkbox" class="titleIp" id="chkReply" name="reply" style="font-size: 15px; padding-left: 10px">
			</div>
			<div class="dotLine2"></div>
			<textarea id="content" name="content" style="font-size: 15px; padding-left: 10px"></textarea>
		</div>	

		<div class="btnBox">
			<a href="<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>" class="grayBtn">목록</a>
			<c:if test="${actionFlag == 'insert'}"> 
			<a href="javascript:writeBoard();" id="abc" class="orangeBtn">등록</a>
			</c:if>
			<c:if test="${actionFlag == 'update'}">
			<a href="javascript:writeBoard();" id="abc" class="orangeBtn">수정</a>
			</c:if>
		</div>	
		
		<input type="hidden" name="bbsType" value="${bbsType}" />
		<input type="hidden" name="actionFlag" value="${actionFlag}" />
		<input type="hidden" name="idx" value="${idx}" />
		
		</form>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />