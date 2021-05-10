<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
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
			content = replaceAll(content, "[ENTER]", "\r\n");
			
			content = convertSpecialCharacters(content);
			title = convertSpecialCharacters(title);
			 
			$("#title").val(title);
			$("#content").val(content);
			$("#imageFileName").val("<c:out value='${upOriginFile1}'/>");
			$("#attachFileName1").val("<c:out value='${upOriginFile2}'/>");
			$("#attachFileName2").val("<c:out value='${upOriginFile3}'/>");
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
		var sUrl = "<c:url value='/valley/board/writeBoard.do'/>";
		
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
		
		if(( bbsType == "3" || bbsType == "5" || bbsType == "6" ) && $("#imageFileName").val() == "") {
			alert("대표이미지를 등록하세요.");
			return;
		}

        var formData = new FormData($("#fileForm")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("작성한 글이 정상적으로 등록되었습니다.");
         	   
         		location.href = "<c:url value='/m_valley/board/list.do?bbsType=${bbsType}'/>"
            } else {
         	   alert(data.resultMessage);
            }
        });
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
		<form id="fileForm" action="fileUpload" method="post" enctype="multipart/form-data">
		
		<div class="grayBg writeBox">
			<div class="list">
				<span class="title"><span class="orangeRed">* </span> 제목</span>
				<input type="text" id="title" name="title" class="titleIp">
			</div>
			<div class="list">
				<span class="title"><span class="orangeRed">* </span> 대표이미지</span>
				<input type="text" class="fileName" id="imageFileName" readonly="readonly">
				<label for="uploadImage" class="btn_file">이미지찾기</label> 
				<input type="file" id="uploadImage" name="uploadImage" class="uploadBtn">	 			
			</div>
			<div class="liTxt"> * 이미지를 첨부하지 않을시 기본 이미지로 등록 됩니다.</div>
			<div class="list">				
				<span class="title"><span class="orangeRed">* </span> 첨부파일</span>
				<input type="text" class="fileName" id="attachFileName1" style="font-size: 15px" readonly="readonly">
				<label for="uploadBtn1" class="btn_file file2">첨부파일찾기</label>
				<input type="file" id="uploadBtn1" name="uploadFile1" class="uploadBtn">
			</div>
			<div class="list">
				<span class="title"></span>
				<input type="text" class="fileName" id="attachFileName2" style="font-size: 15px" readonly="readonly">
				<label for="uploadbtn" class="btn_file file2">첨부파일찾기</label>
				<input type="file" id="uploadbtn" name="uploadFile2" class="uploadBtn">
			</div>
			<div class="liTxt"> * 첨부파일은 최대 2개까지 등록이 가능합니다.</div>
			<div class="dotLine2"></div>
			
			<textarea id="content" name="content"></textarea>

		</div>
		
		<input type="hidden" name="bbsType" value="${bbsType}" />
		<input type="hidden" name="actionFlag" value="${actionFlag}" />
		<input type="hidden" name="idx" value="${idx}" />
		
		<ul class="btnBox">
			<li class="grayBtn"><a href="<c:url value='/m_valley/board/list.do?bbsType=${bbsType}'/>">목록</a></li>			
			<c:if test="${actionFlag == 'insert'}">
			<li class="blueBtn"><a href="javascript:writeBoard();">등록</a></li>
			</c:if>
			<c:if test="${actionFlag == 'update'}">
			<li class="blueBtn"><a href="javascript:writeBoard();">수정</a></li>
			</c:if>			
		</ul>
		
		</form>
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>