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

<!-- FlexSlider -->
<script src="<c:url value='/js/valley/jquery.flexslider.js'/>"></script>
<script type="text/javascript">

	
	$(document).ready(function() { 
		facilTab2("1");
	});

	function facilTab2(gubun) {
		if (gubun == "1") {
			$("#facil1").attr("style", 'display:block');
			$("#facil2").attr("style", 'display:none');

			$('#facil1 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#slider'
			});

			$('#facil1 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#carousel",
				start : function(slider) {
					$('body').removeClass('loading');
				}
			});
		} else if (gubun == "2") {
			$("#facil1").attr("style", 'display:none');
			$("#facil2").attr("style", 'display:block');

			$('#facil2 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#facil2 #slider'
			});

			$('#facil2 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#facil2 #carousel",
				start : function(slider) {
					$('body').removeClass('loading');
				}
			});
		}
	}
</script>

<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>밸리하우스</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/facil/facil01.do'/>" class="on">밸리하우스</a>
			<a href="<c:url value='/valley/facil/facil02.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/valley/facil/facil03.do'/>" class="">프로샵</a>
			<a href="<c:url value='/valley/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/valley/facil/facil05.do'/>" class="">대식당</a>					
			<a href="<c:url value='/valley/facil/facil06.do'/>" class="">연회장</a>
		</div>
		
		<div class="subTitle">
			<span class="title">밸리하우스</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab2">
				<ul>
					<li onclick="javascript:facilTab2(1);">밸리하우스</li>
					<li class="off" onclick="javascript:facilTab2(2);">락카룸</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/01/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/01/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/01/03.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/01/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/01/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/01/03.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
		
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						빨간 지붕이 잘 어울리는 유럽풍의 현대식 건물로 지하1층, 지상 3층 규모에 심플하고 모던한 느낌의 건축물입니다.<br><br>
		편안하고 포근한 쉼터로서 회원님들의 동선을 적절하게 배치하여 이용의 편리를 극대화하였으며 클럽의 품격을 살리고자 노력하였습니다.<br><br>
		창가의 멋을 한껏 살린 레스토랑 및 연회석에서는 회원님들의 건강을 챙길 수 있는 요리들을 사시사철 정성스레 준비하고 있습니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		<div class="facilBox" id="facil2">
			<div class="facilTab2">
				<ul>
					<li class="off" onclick="javascript:facilTab2(1);">밸리하우스</li>
					<li onclick="javascript:facilTab2(2);">락카룸</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/07/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/04.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/05.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/06.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/07/01.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/02.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/03.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/04.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/05.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/07/06.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>
			
		
				<!-- <div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						회원님을 위해 다양한 국내외 상품 중 인지도가 높은 용품을 엄선하여 보다 저렴하게
제공하고 있으며 지역의 특산물 및 신상품 등을 계절별로 선보이고 있습니다.<br><br>
서원밸리 프로샵에서 품격 있는 삼품을 이용해 보시기 바랍니다.
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