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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>스타트하우스</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/facil/facil01.do'/>" class="">밸리하우스</a>
			<a href="<c:url value='/valley/facil/facil02.do'/>" class="on">스타트하우스</a>
			<a href="<c:url value='/valley/facil/facil03.do'/>" class="">프로샵</a>
			<a href="<c:url value='/valley/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/valley/facil/facil05.do'/>" class="">대식당</a>					
			<a href="<c:url value='/valley/facil/facil06.do'/>" class="">연회장</a>
		</div>
		
		<div class="subTitle">
			<span class="title">스타트하우스</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox">
			<div class="facilTab1">
				<ul>
				<li>스타트하우스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/02/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/02/02.jpg'/>" >
							</li>
							<li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/02/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/02/02.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>
			
			
			
			<!-- FlexSlider -->
			<script src="<c:url value='/js/valley/jquery.flexslider.js'/>"></script>
			<script type="text/javascript">
				$(function(){
				  SyntaxHighlighter.all();
				});
				$(window).load(function(){
				  $('#carousel').flexslider({
					animation: "slide",
					controlNav: false,
					animationLoop: false,
					slideshow: false,
					itemWidth: 210,
					itemMargin: 5,
					asNavFor: '#slider'
				  });

				  $('#slider').flexslider({
					animation: "slide",
					controlNav: false,
					animationLoop: false,
					slideshow: false,
					sync: "#carousel",
					start: function(slider){
					  $('body').removeClass('loading');
					}
				  });
				});
			</script>
		
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						클럽하우스 1층 로비 우측에 위치한 사계절 조성되는 원형화단의 아름다움과 새로운 출발과 9홀의 아쉬움을 달래는 쉼터 공간입니다.<br><br>
특히 봄, 가을 테라스 파라솔에 앉아 맛보는 웰빙주스의 미각을 따라로운 햇살과 산들바람이 더해줍니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />