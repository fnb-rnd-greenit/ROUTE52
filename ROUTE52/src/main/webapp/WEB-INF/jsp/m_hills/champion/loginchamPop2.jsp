<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">
	if("${sessionScope.msMember.msSex}" == "1") {
		alert("남성은 접속할 수 없습니다.");
		location.href = history.back();
	}
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> Lady's Day <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	
	<div class="contents">
		<div class="champWrap">
			<div class="champPopBox"  style="width:100%" >
				<h2 style= "width:98%; padding:16px 0;">
					골프장 최초 여성의, 여성에 의한, 여성을 위한 BIC 프로모션<br>
					<span>“서원힐스 LADY’S DAY PASSPORT ”</span>
				</h2>
				<h3>
				서원밸리컨트리클럽에 주최하는
최초의 여성만을 위한 BIC 프로모션!<br>
제 1회 LADY’S PASSPORT Itinerary 에 지금 참가하세요.<br>
여성만을 위한 크루즈/골프 여행, 피부미용권 등 푸짐한 시상품과 여자여서 행복한 라운드가 기다립니다.</h3>
			</div>
		</div>
		
		<c:if test="${not empty sessionScope.msMember.msId}">
			<ul class="btnBox_1">
				<li class="darkgray"><a href="<c:url value='/m_hills/champion/chamComplete2.do'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>
		
		<c:if test="${empty sessionScope.msMember.msId}">
			<ul class="btnBox_3">
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/join02.do'/>">회원가입</a></li>
				<li class="darksalmon"><a href="<c:url value='/m_hills/member/login.do'/>">로그인</a></li>
				<li class="darkgray"><a href="<c:url value='/m_hills/member/login.do'/>"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가신청</a></li>
			</ul>
		</c:if>		
	</div><!-- contents End -->
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>