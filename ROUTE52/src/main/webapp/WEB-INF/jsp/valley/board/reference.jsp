<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList6").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>회원권안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/valley/board/list.do?bbsType=1'/>">공지사항</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=2'/>">뉴스</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=3'/>">포토갤러리</a>
			<a href="<c:url value='/valley/board/refernce.do'/>" class="on">자료실</a>
		</div>
		<div class="subTitle">
			<span class="title">자료실</span>
		</div>
		<div class="subLine"></div>

		<div class="refernceListBox">
			<ul class="referenceBox">
				<li class="referenceTitle"> 회원변경 관련</li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A0%95%ED%9A%8C%EC%9B%90%EB%B3%80%EA%B2%BD.hwp" class="referenceFile"><span>정회원 변경신청 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A4%80%ED%9A%8C%EC%9B%90%EB%93%B1%EB%A1%9D%28%EB%B3%80%EA%B2%BD%29.hwp" class="referenceFile"><span>준회원 등록(변경)</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%83%81%ED%98%B8%EB%B3%80%EA%B2%BD%EC%8B%A0%EC%B2%AD.hwp" class="referenceFile"><span>상호 변경신청 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EA%B8%B0%EB%AA%85%ED%9A%8C%EC%9B%90%EB%93%B1%EB%A1%9D%28%EB%B3%80%EA%B2%BD%29.hwp" class="referenceFile"><span>기명회원등록(변경) </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
			</ul>
			<ul class="referenceBox">
				<li class="referenceTitle"> 명의개서 관련</li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%ED%9A%8C%EC%9B%90%EA%B6%8C%20%EC%96%91%EC%88%98%EB%8F%84%20%EC%8B%A0%EC%B2%AD.hwp" class="referenceFile"><span>회원권 양수도 신청</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%ED%9A%8C%EC%9B%90%EA%B6%8C%EB%B6%84%EC%8B%A4%EA%B0%81%EC%84%9C.hwp" class="referenceFile"><span>회원증 분실각서</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%ED%9A%8C%EC%B9%99.hwp" class="referenceFile"><span>· 회칙 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%97%B0%ED%9A%8C%EC%9B%90%EC%95%BD%EA%B4%80.hwp" class="referenceFile"><span>연회원약관</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80.hwp" class="referenceFile"><span>이용약관 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
			</ul>
			<ul class="referenceBox">
				<li class="referenceTitle"> 주중회원 관련</li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A3%BC%EC%A4%91%ED%9A%8C%EC%9B%90%20%EC%9E%85%ED%9A%8C%EC%8B%A0%EC%B2%AD%EC%84%9C%28%EA%B0%9C%EC%9D%B8%29.hwp" class="referenceFile"><span>주중회원 신청(개인)</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A3%BC%EC%A4%91%ED%9A%8C%EC%9B%90%20%EC%9E%85%ED%9A%8C%EC%8B%A0%EC%B2%AD%EC%84%9C%28%EB%B2%95%EC%9D%B8%29.hwp" class="referenceFile"><span>주중회원 신청(법인)</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A3%BC%EC%A4%91%ED%9A%8C%EC%9B%90%EB%8C%80%EA%B8%B0%EC%8B%A0%EC%B2%AD.hwp" class="referenceFile"><span>주중회원 대기 신청</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
			</ul>
			<ul class="referenceBox">
				<li class="referenceTitle"> 기타 관련</li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%ED%99%9C%EC%9A%A9%EB%8F%99%EC%9D%98%EC%84%9C.hwp" class="referenceFile"><span>개인정보활용 동의서</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A3%BC%EB%A7%90%EC%98%88%EC%95%BD%EC%8B%A0%EC%B2%AD.hwp" class="referenceFile"><span>주말예약 신청</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
				<%-- <li><a href="https://kr.object.ncloudstorage.com/contents/seowon-valley/%EC%A3%BC%EC%A4%91%EC%97%B0%EB%8B%A8%EC%B2%B4%EC%8B%A0%EC%B2%AD%EC%84%9C.hwp" class="referenceFile"><span>주중 연단체 신청서</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li> --%>
			</ul>
		</div>
		
	</div><!-- contents End -->
	
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />