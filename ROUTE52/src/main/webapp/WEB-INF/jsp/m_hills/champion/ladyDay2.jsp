<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> Lady's Day <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="viewBox bgBottom">
			<img src="<c:url value='/images/m_hills/ladyDay2.jpg'/>" class="viewMainImage" alt="">
			<div class="btnBox4">
				<ul>
		        	<li><input type="button" class="motion" onclick="location.href='/m_hills/champion/loginchamPop2.do'" value="참가신청"></li>
		        	<li><input type="button" class="cancel" onclick="location.href='/hills/champion/ladyPassport.do'" value="리더보드보기"></li>
		        </ul>
		    </div>		
		</div>
		
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>