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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>그늘집</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/facil/facil01.do'/>" class="">밸리하우스</a>
			<a href="<c:url value='/valley/facil/facil02.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/valley/facil/facil03.do'/>" class="">프로샵</a>
			<a href="<c:url value='/valley/facil/facil04.do'/>" class="on">그늘집</a>
			<a href="<c:url value='/valley/facil/facil05.do'/>" class="">대식당</a>					
			<a href="<c:url value='/valley/facil/facil06.do'/>" class="">연회장</a>
		</div>
		
		<div class="subTitle">
			<span class="title">그늘집</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab2">
				<ul>
					<li onclick="javascript:facilTab2(1);">서원코스</li>
					<li class="off" onclick="javascript:facilTab2(2);">밸리코스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-3.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/02-3.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>
			
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						서원그늘집은 서원코스 6번홀 오른쪽 평지에 볕이 가장 잘 드는 곳에 위치하고 있습니다.<br>
따뜻한 차 한잔의 여유르 즐기며 뒤를 되돌아보고 앞으로의 남은 라운딩을 계획하며<br> 흩어진 마음을 가다듬을 수 있도록 하였습니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		
		<div class="facilBox" id="facil2">
			<div class="facilTab2">
				<ul>
					<li class="off" onclick="javascript:facilTab2(1);">서원코스</li>
					<li onclick="javascript:facilTab2(2);">밸리코스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-3.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/valley/facil/04/01-3.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>
			
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						밸리코스 5번홀에 위치한 밸리 그늘집은 클럽하우스를 포함한 서원코스 및 밸리코스의 전 그린을 한눈에 관망할 수 있으며<br> 섬세하고 아기자기한 아웃 코스의 라운드를 즐기며 잃어버린 미각을 살릴 수 있도록<br> 토속 음식 및 건강음료 등을 준비하고 있습니다. <br>계절별로 시시각각 변화하는 그린에서 동반자와 추억을 남겨보세요.
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