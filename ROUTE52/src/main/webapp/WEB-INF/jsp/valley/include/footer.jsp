<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
	<div id="footerWrap">
		<div class="termsBox">
			<div class="terms">
					<a href="javascript:alert('준비중입니다.');">사이트 이용약관</a><span> l </span>
					<a href="javascript:alert('준비중입니다.');">개인정보처리방침</a><span> l </span>
					<a href="javascript:alert('준비중입니다.');">사이트맵</a>
					<div class="fmSelect">
						<select name="" id="">
							<option value="">family Site</option>
							<option onclick="location.href='<c:url value='/hills/index.do'/>'" target="_blank">서원힐스</option>
						</select>
					</div>
			</div>
		</div>
		<div class="footerBox">
			<div class="footer">
				<img src="<c:url value='/images/valley/ftLogo.png'/>" alt="서원밸리 로고" class="footerLogo">
				<div class="infoBox">					
					<p>
					상호 : 서원레저(주)   대표자명 : 이석호   사업장소재지 : 경기도 파주시 광탄면 서원길 333   연락처 : 031-940-9400 <br>
					사업자등록번호 : 110-81-34204   통신판매번호 : 2009-경기파주-1997</p>
					<p>COPYRIGHT ⓒ 서원레저(주) ALL RIGHT RESERVED.</p>
				</div>
				<div class="adminBox">
					<a href="<c:url value='/admin/index.do'/>"><img src="<c:url value='/images/valley/ic_admin.png'/>" alt="관리자페이지"></a>
				</div>	
				<!-- <div class="snsBox">
					<a href=""><img src="<c:url value='/images/valley/ft_ic_face.png'/>" alt="페이스북 연결"></a>
					<a href=""><img src="<c:url value='/images/valley/ft_ic_twt.png'/>" alt="트위터 연결"></a>
					<a href=""><img src="<c:url value='/images/valley/ft_ic_insta.png'/>" alt="인스타그램 연결"></a>
				</div>-->	
			</div>
			<p id="topArrow" style="margin: auto; width: 50px; display: block;"><a href="#top"><span></span></a></p>
		</div>
	</div>
</body>
</html>