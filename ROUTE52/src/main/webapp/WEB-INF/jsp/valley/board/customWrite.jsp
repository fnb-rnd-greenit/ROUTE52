<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 
		init();
		
		initView();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/valley/member/login.do'/>";	
		}
		
		getSelectBox();
	}
	
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
		}
	}
	
	function getSelectBox() {
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "61");
		sParams += String.format("&cdDiv={0}", "014");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#selSubDiv1").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#selSubDiv1").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
				}
				
				if("<c:out value='${actionFlag}'/>" == "update") {
					var subDiv1 = "<c:out value='${subDiv1}'/>";
					$("#selSubDiv1").val(subDiv1);
				}
			} else {
				alert(data.resultMessage);
			}
		});

		sParams = "";

		sParams += String.format("&coDiv={0}", "61");
		sParams += String.format("&cdDiv={0}", "015");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#selSubDiv2").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#selSubDiv2").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
				}
				
				if("<c:out value='${actionFlag}'/>" == "update") {
					var subDiv2 = "<c:out value='${subDiv2}'/>";
					$("#selSubDiv2").val(subDiv2);
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function writeBoard() {
		var sUrl = "<c:url value='/valley/board/writeBoard.do'/>";
		
		var title = $("#title").val();
		var content = $("#content").val();
		var subDiv1 = $("#selSubDiv1").val();
		var subDiv2 = $("#selSubDiv2").val();
		
		if(title == "") {
			alert("제목을 입력하세요.");
			return;
		}		
		
		if(content == "") {
			alert("내용을 입력하세요.");
			return;
		}	
		
		if(subDiv1 != null && subDiv1 != "") {
			$("#subDiv1").val(subDiv1);	
		} else {
			alert("구분을 선택하세요.");
			return;
		}
		
		if(subDiv2 != null && subDiv2 != "") {
			$("#subDiv2").val(subDiv2);	
		} else {
			alert("부문을 선택하세요.");
			return;
		}
		
		var formData = new FormData($("#fileForm")[0]);
		
        mFileAjax(sUrl, formData, function(data) {
        	if(data.resultCode == "0000") {
         		alert("작성한 글이 정상적으로 등록되었습니다.");
         	   
         		location.href = "<c:url value='/valley/board/list.do?bbsType=9'/>";
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>고객의소리</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="/valley/reservation/reservationCheck.do" class="on">예약확인/취소</a>
			<a href="/valley/member/stateVisit.do" class="">내장현황</a>
			<a href="/valley/member/statePenal.do" class="">위약현황</a>
			<a href="/valley/member/stateScore.do" class="">스코어현황</a>
			<a href="/valley/board/list.do?bbsType=9" class="">고객의소리</a>
			<a href="/valley/member/memModify.do" class="">회원정보수정</a>
		</div>

		<div class="subTitle">
			<span class="title">고객의소리</span>
			<span class="titleDes">회원님의 궁금한 사항의 답변을 확인하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<form id="fileForm" action="fileUpload" method="post" enctype="multipart/form-data">

			<div class="grayBgBox writeBox">
				<div class="list">
					<span class="orangeRed">* </span><span class="title"> 제목</span>
					<input type="text" class="titleIp" id="title" name="title">
				</div>
				<div class="list">
					<span class="orangeRed">* </span><span class="title"> 작성자</span>
					<span>&nbsp;${sessionScope.msMember.msName}</span>			
				</div>
				<div class="list">
					<span class="orangeRed">* </span><span class="title"> 구분</span>
					<select id="selSubDiv1" class="select-arrow2 customSelec">
					</select>
				</div>
				<div class="list">
					<span class="orangeRed">* </span><span class="title"> 부문</span>
					<select id="selSubDiv2" class="select-arrow2 customSelec">
					</select>
				</div>
				<div class="dotLine2"></div>
				<textarea id="content" name="content"></textarea>
	
			</div>		
			<div class="btnBox">
				<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="grayBtn">목록보기</a>
				<c:if test="${actionFlag == 'insert'}">
				<a href="javascript:writeBoard()" class="blueBtn">등록</a>
				</c:if>
				<c:if test="${actionFlag == 'update'}">
				<a href="javascript:writeBoard()" class="blueBtn">수정</a>
				</c:if>
			</div>
		
			<input type="hidden" name="bbsType" value="9" />
			<input type="hidden" name="actionFlag" id="actionFlag" value="${actionFlag}" />
			<input type="hidden" name="idx" value="${idx}" />	
			<input type="hidden" id="subDiv1" name="subDiv1" value="" />	
			<input type="hidden" id="subDiv2" name="subDiv2" value="" />		
		</form>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />