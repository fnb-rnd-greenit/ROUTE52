<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList8").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>베이커리</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList8">
			<a href="<c:url value='/hills/facil/facil01.do'/>" class="">힐하우스</a>
			<a href="<c:url value='/hills/facil/facil02.do'/>" class="">대식당</a>
			<a href="<c:url value='/hills/facil/facil03.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/hills/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/hills/facil/facil05.do'/>" class="">연회장</a>					
			<a href="<c:url value='/hills/facil/facil06.do'/>" class="">채플관</a>
			<a href="<c:url value='/hills/facil/facil07.do'/>" class="">프로샵</a>
			<a href="<c:url value='/hills/facil/facil08.do'/>" class="on">베이커리</a>
		</div>
		
		<div class="subTitle">
			<span class="title">베이커리</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox">
			<div class="facilTab1">
				<ul>
					<li>베이커리</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/08/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/08/02.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/08/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/08/02.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
			
			<!-- FlexSlider -->
			<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
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
		
				<!-- <div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						고급스럽고 실용적인 골프용품을 비치하여 부족함없는 즐거운 라운드가 될 수 있도록 세심하게 준비하였습니다.
						</li>
					</ul>		
				</div> -->
			</div>
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />