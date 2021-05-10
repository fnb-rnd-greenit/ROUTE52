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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>대식당</span></p>
		</div>
	</div>


<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/facil/facil01.do'/>" class="">밸리하우스</a>
			<a href="<c:url value='/valley/facil/facil02.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/valley/facil/facil03.do'/>" class="">프로샵</a>
			<a href="<c:url value='/valley/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/valley/facil/facil05.do'/>" class="on">대식당</a>					
			<a href="<c:url value='/valley/facil/facil06.do'/>" class="">연회장</a>
		</div>
		
		<div class="subTitle">
			<span class="title">대식당</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab2">
				<ul>
					<li onclick="javascript:facilTab(1);">대식당</li>
					<li class="off" onclick="javascript:facilTab(2);">추천메뉴</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/05/01.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/05/01.jpg'/>" >
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
						밸리하우스의 출입문에서 오른편으로 대식당(Restautant)이 위치하고 있습니다.<br>
대식당은 총 40개(4인기준)의 테이블로 구성되어 있으며 골프장의 풍경을 가득담고 있는<br>
대형 유리창은 여유로운 라운딩을 즐기는 회원님들께 더욱 고즈넉한 편안함을 안겨 드립니다.<br><br>
또한 여러분의 입맛에 맞도록 사계절 다양한 요리들을 준비해 놓았습니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		
		<div class="facilBox" id="facil2">
			<div class="facilTab2">
				<ul>
					<li class="off" onclick="javascript:facilTab(1);">대식당</li>
					<li onclick="javascript:facilTab(2);">추천메뉴</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div style="text-align: center;">
				<img src="<c:url value='/images/valley/facil/05/menu.jpg'/>" >
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />