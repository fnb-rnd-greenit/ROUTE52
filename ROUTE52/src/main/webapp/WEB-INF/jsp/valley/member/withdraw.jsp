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
			location.href = "<c:url value='/valley/member/login.do'/>";	
		}
	}
	
	function doDeleteMember() {
		var sUrl = "<c:url value='/valley/member/doDeleteMember.do'/>";
		var sParams = "";
		
		if(confirm("정말로 회원탈퇴 하시겠습니까?")) {
			mAjax(sUrl, sParams, function(data) {
				if(data.resultCode == "0000") {
					alert("회원탈퇴 되었습니다.");
					
					location.href = "<c:url value='/valley/index.do'/>";
				} else {
					alert(data.resultMessage);	
				}				
			});
		}
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>회원탈퇴</span></p>
	</div>
</div>


<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/valley/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/valley/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/valley/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/valley/member/memModify.do'/>" class="on">회원정보수정</a>
		</div>
		<div class="subTitle">
			<span class="title">회원탈퇴</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>


		<div class="grayBgBox">
			<p class="withdrawLtxt">
				서원밸리 컨트리클럽 사이트를 이용해주셔서 진심으로 감사 드립니다. <br>
				회원탈퇴를 하시기 전에 아래 유의사항을 읽어주시기 바랍니다.
			</p>
			<p class="withdrawMtxt">
				<span>같은 아이디 사용 불가</span> <br>
				회원 탈퇴 후 재가입시에는 탈퇴 전 사용한 아이디는 다시 사용할 수 없고, 신규 아이디를 생성해야 합니다.
			</p>
			<p class="withdrawMtxt bt-padng">
				<span>탈퇴시 예약관련 안내</span><br>
				진행중인 예약이 있는 경우에는 즉시 탈퇴가 불가능합니다.<br>진행중인 위약이 있는 경우에는 즉시 탈퇴가 불가능합니다.
			</p>
		</div>
		<div class="btnBox">
			<a href="javascript:doDeleteMember()" class="cancel">회원탈퇴</a>
			<a href="<c:url value='/valley/member/memModify.do'/>" class="motion">정보변경</a>
		</div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />