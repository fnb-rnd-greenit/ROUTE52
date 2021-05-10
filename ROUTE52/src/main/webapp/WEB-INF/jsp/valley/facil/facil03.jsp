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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>프로샵</span></p>
		</div>
	</div>


<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/facil/facil01.do'/>" class="">밸리하우스</a>
			<a href="<c:url value='/valley/facil/facil02.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/valley/facil/facil03.do'/>" class="on">프로샵</a>
			<a href="<c:url value='/valley/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/valley/facil/facil05.do'/>" class="">대식당</a>					
			<a href="<c:url value='/valley/facil/facil06.do'/>" class="">연회장</a>
		</div>
		
		<div class="subTitle">
			<span class="title">프로샵</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox">
			<div class="facilTab1">
				<ul>
				<li>프로샵</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/03/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/04.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/03/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/03/04.jpg'/>" >
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
						회원님을 위해 다양한 국내외 상품 중 인지도가 높은 용품을 엄선하여 보다 저렴하게
제공하고 있으며 지역의 특산물 및 신상품 등을 계절별로 선보이고 있습니다.<br><br>
서원밸리 프로샵에서 품격 있는 삼품을 이용해 보시기 바랍니다.
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