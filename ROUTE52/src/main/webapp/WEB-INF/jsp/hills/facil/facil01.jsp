<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
<script type="text/javascript">

	$(document).ready(function() { 
		facilTab2("1");

	    var offset = $(".myzoneTabList7").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
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
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>힐하우스</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/facil/facil01.do'/>" class="on">힐하우스</a>
			<a href="<c:url value='/hills/facil/facil02.do'/>" class="">대식당</a>
			<a href="<c:url value='/hills/facil/facil03.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/hills/facil/facil04.do'/>" class="">그늘집</a>
			<a href="<c:url value='/hills/facil/facil05.do'/>" class="">연회장</a>					
			<a href="<c:url value='/hills/facil/facil06.do'/>" class="">채플관</a>
			<a href="<c:url value='/hills/facil/facil07.do'/>" class="">프로샵</a>
			<%-- <a href="<c:url value='/hills/facil/facil08.do'/>" class="">베이커리</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">힐하우스</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab2">
				<ul>
					<li onclick="javascript:facilTab2(1);">힐하우스</li>
					<li class="off" onclick="javascript:facilTab2(2);">락카룸</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-3.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-4.jpg'/>" >
							</li>
							<li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-5.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-6.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-3.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-4.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-5.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/01-6.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
		
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						서원힐스 클럽하우스는 일본 건축의 거장 이타미준의 유작으로 고풍스러운 멋과 현대적인 감성이 어우러져 자연속에서 멋을 느낄 수 있도록 설계되었습니다.<br>
						클럽하우스에서는 200명 동시 수용으로 다양한행사 개최가 가능하며, 9개의 연회실이 준비되어 있어 소규모부터 대규모 모임까지 인원에 맞는 맞춤 공간을 제공합니다.<br>
						또한 클럽하우스 내에서는 서원베이커리에서 직접 당일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
						**부대시설 제원 **<br>
						1.클럽하우스 - 2,400평 / 지하1층, 지상2층<br>
						2.대식당 - 행사 시 최대 200명<br>
						3.단체실 - 9실(3~15팀까지 수용가능)<br>
						4.세미나실 - 150명 동시 운영 가능<br>
						5.락카 - 총 566개(남 305개, 여 209개, 가변 52개)<br>
						6.주차가능 대수 - 908대
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		<div class="facilBox" id="facil2">
			<div class="facilTab2">
				<ul>
					<li class="off" onclick="javascript:facilTab2(1);">힐하우스</li>
					<li onclick="javascript:facilTab2(2);">락카룸</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-3.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-4.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-5.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-6.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-7.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-3.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-4.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-5.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-6.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/01/02-7.jpg'/>" >
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