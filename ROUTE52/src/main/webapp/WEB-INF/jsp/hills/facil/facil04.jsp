<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList7").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<script type="text/javascript">

	
	$(document).ready(function() { 
		facilTab2("1");
	});

	function facilTab2(gubun) {
		if (gubun == "1") {
			$("#facil1").attr("style", 'display:block');
			$("#facil2").attr("style", 'display:none');
			$("#facil3").attr("style", 'display:none');

			$('#facil1 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#facil1 #slider'
			});

			$('#facil1 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#facil1 #carousel",
				start : function(slider) {
					$('body').removeClass('loading');
				}
			});
		} else if (gubun == "2") {
			$("#facil1").attr("style", 'display:none');
			$("#facil2").attr("style", 'display:block');
			$("#facil3").attr("style", 'display:none');

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
		} else if (gubun == "3") {
			$("#facil1").attr("style", 'display:none');
			$("#facil2").attr("style", 'display:none');
			$("#facil3").attr("style", 'display:block');

			$('#facil3 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#facil3 #slider'
			});

			$('#facil3 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#facil3 #carousel",
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
			<p>시설안내 &nbsp;&nbsp;&nbsp; ＞ <span>그늘집</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/facil/facil01.do'/>" class="">힐하우스</a>
			<a href="<c:url value='/hills/facil/facil02.do'/>" class="">대식당</a>
			<a href="<c:url value='/hills/facil/facil03.do'/>" class="">스타트하우스</a>
			<a href="<c:url value='/hills/facil/facil04.do'/>" class="on">그늘집</a>
			<a href="<c:url value='/hills/facil/facil05.do'/>" class="">연회장</a>					
			<a href="<c:url value='/hills/facil/facil06.do'/>" class="">채플관</a>
			<a href="<c:url value='/hills/facil/facil07.do'/>" class="">프로샵</a>
			<%-- <a href="<c:url value='/hills/facil/facil08.do'/>" class="">베이커리</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">그늘집</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab3">
				<ul>
					<li onclick="javascript:facilTab2(1);">이스트코스</li>
					<li class="off1" onclick="javascript:facilTab2(2);">웨스트코스</li>
					<li class="off1" onclick="javascript:facilTab2(3);">사우스코스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/01-2.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/01-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/01-2.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
					
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						스타트하우스와 함께 사용되어 더욱 넓은 공간에서 편안한 휴식과 간단하 식사를 즐기실 수 있는 공간입니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		<div class="facilBox" id="facil2">
			<div class="facilTab3">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">이스트코스</li>
					<li onclick="javascript:facilTab2(2);">웨스트코스</li>
					<li class="off1" onclick="javascript:facilTab2(3);">사우스코스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-3.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/02-3.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
			
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						라운드 중 잠시나마 편안한 휴식과 여유를 즐기실 수 있도록 마련한 화려한 풍경을 자랑하는 공간입니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		<div class="facilBox" id="facil3">
			<div class="facilTab3">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">이스트코스</li>
					<li class="off1" onclick="javascript:facilTab2(2);">웨스트코스</li>
					<li onclick="javascript:facilTab2(3);">사우스코스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/03-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/03-2.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/facil/04/03-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/facil/04/03-2.jpg'/>" >
							</li>
						</ul>
					</div>
				</div>			
			
				<div class="facilInfo">
					<div class="icon">아이콘</div>
					<ul>
						<li>						
						아름다운 경치와 아늑한 분위기 속에서 휴식과 함께 골프장의 별미를 즐기실 수 있는 공간입니다.
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