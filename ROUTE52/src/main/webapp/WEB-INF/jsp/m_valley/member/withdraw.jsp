<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script type="text/javascript">
	
	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		}
	}
	
	function doDeleteMember() {
		var sUrl = "<c:url value='/valley/member/doDeleteMember.do'/>";
		var sParams = "";
		
		if(confirm("정말로 회원탈퇴 하시겠습니까?")) {
			mAjax(sUrl, sParams, function(data) {
				if(data.resultCode == "0000") {
					alert("회원탈퇴 되었습니다.");
					
					location.href = "<c:url value='/m_valley/index.do'/>";
				} else {
					alert(data.resultMessage);	
				}				
			});
		}
	}
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> 회원탈퇴 <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<div class="contents">	
		<div class="midTitleBox">
			<span class="commonDot"> 회원탈퇴</span>		
		</div>
		<div class="grayBg bt-padng">
			<ul class="withdrawLtxt title">
				<li>서원힐스 컨트리클럽 사이트를 <br> 이용해주셔서 진심으로 감사 드립니다.</li>
				<li>회원탈퇴를 하시기 전에 <br>아래 유의사항을 읽어주시기 바랍니다.</li>
			</ul>
			<p class="withdrawMtxt">
				<span>같은 아이디 사용 불가</span>
				회원 탈퇴 후 재가입시에는<br> 탈퇴 전 사용한 아이디는 다시 사용할 수 없고, <br>신규 아이디를 생성해야 합니다.
			</p>
			<p class="withdrawMtxt bt-padng">
				<span>탈퇴시 예약관련 안내</span>
				진행중인 예약이 있는 경우에는 즉시 탈퇴가 불가능합니다.<br>진행중인 위약이 있는 경우에는 즉시 탈퇴가 불가능합니다.
			</p>
		</div>
		<ul class="btnBox">
			<li class="grayBtn"><a href="<c:url value='/m_valley/member/member.do'/>">이전단계</a></li>
			<li class="blueBtn"><a href="javascript:doDeleteMember()">회원탈퇴</a></li>
			
		</ul>
	</div><!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>