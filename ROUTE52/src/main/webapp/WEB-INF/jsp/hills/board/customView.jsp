<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}
		
		if("${sessionScope.msMember.webAdmin}" == 'Y' && "${status}" == 0) {
			var sUrl = "<c:url value='/common/getCommonCode.do'/>";
			var sParams = String.format("&coDiv={0}", "65");
			sParams += String.format("&cdDiv={0}", "015");
			
			mAjax(sUrl, sParams, function(data) {
				if(data.resultCode == "0000") {
					$("#selSubDiv3").append("<option value=''>선택</option>");
					for(i=0; i<data.rows.length; i++) {
						$("#selSubDiv3").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
					}
				} else {
					alert(data.resultMessage);
				}
			});
		}
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
	
	function writeReply() {
		var sUrl = "<c:url value='/hills/board/writeCustomReply.do'/>";

		var reply = $("#txtReply").val();
		var subDiv3 = $("#selSubDiv3").val();
		
		if(reply == null || reply == "") {
			alert("답변을 작성하세요.");
			return;
		}
		
		if(subDiv3 == null || subDiv3 == "") {
			alert("조치부서를 선택하세요.");
			return;
		}
		
		$("#subDiv3").val(subDiv3)
		
		if(confirm("답변을 등록 하시겠습니까?")) {
			var formData = new FormData($("#replyForm")[0]);
			
			mPostAjax(sUrl, formData, function(data) {
	        	if(data.resultCode == "0000") {
	         		alert("등록 되었습니다.");
	         	   
	         		window.location.reload();
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>고객의소리</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/hills/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/hills/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/hills/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/hills/member/coupon.do'/>" class="">쿠폰함</a>
			<!-- <a href="javascript:alert('준비중입니다.')" class="">마이포인트</a> -->
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="on">고객의소리</a>
			<a href="<c:url value='/hills/member/memModify.do'/>" class="">회원정보수정</a>
		</div>

		<div class="subTitle">
			<span class="title">고객의소리</span>
			<span class="titleDes">회원님의 궁금한 사항의 답변을 확인하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<div class="midTitleBox">
			<span class="commonDot"> 고객의소리</span>
		</div>
			<table class="costomTable">
			<caption> 실시간예약 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tbody>
			<tr>
				<th colspan="4">${title}</th>
			</tr>
			<tr>
				<th>구분</th>
				<td>${subDiv1Nm}</td>
				<th>부문</th>
				<td>${subDiv2Nm}</td>
			</tr>
			<tr>
				<th>질문</th>
				<td colspan="3">
					<div class="contHeight1">${content}</div>
				</td>
			</tr>
			<tr>
				<th>요청일자</th>
				<td>${regDate}</td>
				<th>상태</th>
				<td>${statusNm}</td>
			</tr>
			<tr>
				<th>조치부서</th>
				<td>
					<c:choose>
						<c:when test="${sessionScope.msMember.webAdmin == 'Y' && status == 0}">
							<select id="selSubDiv3" class="select-arrow2 customSelec" style="width:120px; height:28px">
							</select>
					    </c:when>
					    <c:otherwise>
							${subDiv3Nm}	
					    </c:otherwise>
					</c:choose>
				</td>
				<th>작성자</th>
				<td>${userName}</td>
			</tr>
			</tbody>
		</table>
		<table class="costomTable" style="margin-top:20px">
			<caption> 실시간예약 현황</caption>
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>답변</th> 
					<td colspan="3">
						<c:choose>
							<c:when test="${sessionScope.msMember.webAdmin == 'Y' && status == 0}">
								<form id="replyForm" method="post">			
									<input type="hidden" name="idx" value="${idx}" />	
									<input type="hidden" id="subDiv3" name="subDiv3" value=""/>	
									<div class="contHeight3">
										<textarea id="txtReply" name="reply"></textarea>
									</div>
								</form>
						    </c:when>
						    <c:otherwise>
								<div class="contHeight2">
									${cusReply}
								</div>	
						    </c:otherwise>
						</c:choose>
					</td>
				</tr>					
			</tbody>
		</table>
		<div class="btnBox">	
			<c:if test="${sessionScope.msMember.webAdmin == 'Y' && status == 0}">
				<a href="javascript:writeReply()" class="orangeBtn">답변 등록</a>		
			</c:if>	
			<c:if test="${sessionScope.msMember.msNum == userNum && status == 0}">
				<a href="<c:url value='/hills/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>" class="orangeBtn">수정</a>		
				<a href="javascript:doDelete()" class="grayBtn">삭제</a>
			</c:if>
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="grayBtn">목록보기</a>
		</div>
				
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />