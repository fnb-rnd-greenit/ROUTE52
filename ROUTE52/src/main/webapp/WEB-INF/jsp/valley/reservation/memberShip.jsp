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
		
		var result = "<c:out value='${result}'/>";
		
		if(result != null && result == "fail") {
			alert("회원권 번호를 확인하세요.");
		}

		$("#txtHyupNum").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doCertification();
	        }
	    });
	} 
	
	function doCertification() {
		var sUrl = "<c:url value='${url}'/>";
		var sParams = "";
		var hyupNum = $("#txtHyupNum").val();
		
		if(hyupNum == null || hyupNum == "") {
			alert("회원권 번호를 입력하세요.");
			return;
		}

		sParams += String.format("?hyupNum={0}", hyupNum);

		if("${action}" != "") {
			sParams += String.format("&action={0}", "${action}");
		}
		if("${date}" != "") {
			sParams += String.format("&date={0}", "${date}");
		}
		if("${cos}" != "") {
			sParams += String.format("&cos={0}", "${cos}");
		}
		
		location.href = sUrl + sParams;
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>예약서비스 &nbsp;&nbsp;&nbsp; ＞ <span>회원권 확인</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="reserTabList">
			<a href="<c:url value='/valley/reservation/reservation.do'/>" class="">실시간예약</a>	
			<a href="<c:url value='/valley/reservation/reservationWait.do'/>" class="">대기예약</a>
			<a href="<c:url value='/valley/reservation/reservationGuide.do'/>" class="">예약안내</a>
		</div>

		<div class="subTitle">
			<span class="title">예약신청</span>
			<span class="titleDes">실시간 예약을 하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		
		<div class="midTitleBox membershipTitle">
				<span class="commonDot"> 회원권 번호입력</span>
			</div>
		<div class="membershipBox">			
			<img src="<c:url value='/images/valley/memberTopLine.png'/>" alt="">
			<ul class="membershipList">
				<li class="m_icon"><img src="<c:url value='/images/valley/mem_icon.png'/>" alt=""></li>
				<li class="m_title">회원권 번호 입력</li>
				<li><input type="text" id="txtHyupNum"></li>
				<li class="m_txt">부여 받으신 회원권 번호를 입력해 주세요</li>
				<li class="m_txt2 blue">회원권 번호 분실시 고객센터로 문의 주시기 바랍니다.</li>
			</ul>
			<div class="btnBox">
				<a href="javascript:doCertification()" class="blueBtn">확인</a>
			</div>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />