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
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>회원권안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/board/list.do?bbsType=1'/>">공지사항</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=2'/>">뉴스</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=3'/>">포토갤러리</a>
			<a href="<c:url value='/hills/board/refernce.do'/>" class="on">자료실</a>
		</div>
		<div class="subTitle">
			<span class="title">자료실</span>
		</div>
		<div class="subLine"></div>

		<img src="<c:url value='/images/hills/referIcon.png'/>" alt="" class="referIcon">

		<p class="referTxt">
			<span class="orange">서원 컨트리클럽</span> 이용 시 <span class="orange">필요한 다양한 문서</span>를 다운로드 하실 수 있습니다. <br>
			<span class="smTxt">문서명을 선택하시면 관련 서류를 다운로드 하실 수 있습니다.</span>
		</p>

		<div class="referDownLoadBox">
			<ul class="referDown">
				<li class="txt">연단체 신청서</li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 파일 다운로드</a></li>
			</ul>
			<ul class="referDown">
				<li class="txt">연단체 동의서</li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 파일 다운로드</a></li>
			</ul>
		</div>

		<div class="referDownLoadBox">
			<ul class="referDown">
				<li class="txt">서원밸리 CI</li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 한글CI 다운로드</a></li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 영문CI 다운로드</a></li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 워터마크 다운로드</a></li>
			</ul>
			<ul class="referDown">
				<li class="txt">서원힐스 CI</li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 한글CI 다운로드</a></li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 영문CI 다운로드</a></li>
				<li class="referFile"><a href="" class="referDown"><img src="<c:url value='/images/hills/reDwIcon.png'/>" alt=""> 워터마크 다운로드</a></li>
			</ul>
		</div>

		
	</div><!-- contents End -->
	
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />