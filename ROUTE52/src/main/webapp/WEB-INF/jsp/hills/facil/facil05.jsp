<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList7").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>연회장</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/facil/facil01.do'/>" class="">힐하우스</a>
			<a href="<c:url value='/hills/facil/facil02.do'/>" class="">대식당</a>
			<a href="<c:url value='/hills/facil/facil03.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/hills/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/hills/facil/facil05.do'/>" class="on">연회장</a>					
			<a href="<c:url value='/hills/facil/facil06.do'/>" class="">채플관</a>
			<a href="<c:url value='/hills/facil/facil07.do'/>" class="">프로샵</a>
			<%-- <a href="<c:url value='/hills/facil/facil08.do'/>" class="">베이커리</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">연회장</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox">
			<div class="facilTab1">
				<ul>
					<li>연회장</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/05/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/04.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/05/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/05/04.jpg'/>" >
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
		
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						연회장은 소규모 및 대규모 모임을 위한 공간으로 인원에 따라 맞춤 공간을 제공해 드립니다.<br>( 연회실 9개룸 준비, 룸당 20명 ( 최대 180명 )수용가능 )
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