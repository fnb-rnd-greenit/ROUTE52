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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>대식당</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/facil/facil01.do'/>" class="">힐하우스</a>
			<a href="<c:url value='/hills/facil/facil02.do'/>" class="on">대식당</a>
			<a href="<c:url value='/hills/facil/facil03.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/hills/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/hills/facil/facil05.do'/>" class="">연회장</a>					
			<a href="<c:url value='/hills/facil/facil06.do'/>" class="">채플관</a>
			<a href="<c:url value='/hills/facil/facil07.do'/>" class="">프로샵</a>
			<%-- <a href="<c:url value='/hills/facil/facil08.do'/>" class="">베이커리</a> --%>
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
							<img src="<c:url value='/images/hills/facil/02/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/02/02.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/02/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/02/02.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
			
			<!-- FlexSlider -->
			<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
			<script type="text/javascript">
				$(function(){
				 // SyntaxHighlighter.all();
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
						대식당은 200명 동시 수용으로 다양한 행사 개최가 가능하며, 9개의 연회실이 있어 3팀부터~15팀까지<br>
수용이 가능하여 인원에 맞는 최적화된 공간을 제공할 뿐만 아니라 최상의 음식 맛과 서비스를 제공하고 있습니다.
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
				<img src="<c:url value='/images/hills/facil/02/menu.jpg'/>" >
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />