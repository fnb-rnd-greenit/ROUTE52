<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".facilTab5").offset();
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
			$("#facil4").attr("style", 'display:none');
			$("#facil5").attr("style", 'display:none');

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
			$("#facil4").attr("style", 'display:none');
			$("#facil5").attr("style", 'display:none');

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
			$("#facil4").attr("style", 'display:none');
			$("#facil5").attr("style", 'display:none');

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
		}else if (gubun == "4") {
			$("#facil1").attr("style", 'display:none');
			$("#facil2").attr("style", 'display:none');
			$("#facil3").attr("style", 'display:none');
			$("#facil4").attr("style", 'display:block');
			$("#facil5").attr("style", 'display:none');

			$('#facil4 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#facil4 #slider'
			});

			$('#facil4 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#facil4 #carousel",
				start : function(slider) {
					$('body').removeClass('loading');
				}
			});
		}else if (gubun == "5") {
			$("#facil1").attr("style", 'display:none');
			$("#facil2").attr("style", 'display:none');
			$("#facil3").attr("style", 'display:none');
			$("#facil4").attr("style", 'display:none');
			$("#facil5").attr("style", 'display:block');

			$('#facil5 #carousel').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				itemWidth : 210,
				itemMargin : 5,
				asNavFor : '#facil5 #slider'
			});

			$('#facil5 #slider').flexslider({
				animation : "slide",
				controlNav : false,
				animationLoop : false,
				slideshow : false,
				sync : "#facil5 #carousel",
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
			<p>드라이빙레인지 &nbsp;&nbsp;&nbsp; ＞ <span>시설안내</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="on">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="on">이용요금</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/rangeFacil.do'/>" class="">시설안내</a>
			<!-- <a href="javascript:alert('준비중입니다.');">시설안내</a> -->
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=31'/>">공지사항</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=32'/>">이벤트</a>
		</div>
		
		<div class="subTitle">
			<span class="title">시설안내</span>
		</div>
		<div class="subLine"></div>

		<div class="facilBox" id="facil1">
			<div class="facilTab5">
				<ul>
					<li onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">프로샵</li>
					<li class="off1" onclick="javascript:facilTab2(5);">휘트니스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range1-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range1-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range1-3.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range1-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range1-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range1-3.jpg'/>" >
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
						또한 클럽하우스 내에서는 서원베이커리에서 직접 장일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
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
			<div class="facilTab5">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">프로샵</li>
					<li class="off1" onclick="javascript:facilTab2(5);">휘트니스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range2-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range2-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range2-3.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range2-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range2-2.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range2-3.jpg'/>" >
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
						또한 클럽하우스 내에서는 서원베이커리에서 직접 장일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
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
		
		<div class="facilBox" id="facil3">
			<div class="facilTab5">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">프로샵</li>
					<li class="off1" onclick="javascript:facilTab2(5);">휘트니스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range3-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range3-2.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range3-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range3-2.jpg'/>" >
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
						또한 클럽하우스 내에서는 서원베이커리에서 직접 장일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
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
		
		<div class="facilBox" id="facil4">
			<div class="facilTab5">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li onclick="javascript:facilTab2(4);">프로샵</li>
					<li class="off1" onclick="javascript:facilTab2(5);">휘트니스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range4.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range4.jpg'/>" >
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
						또한 클럽하우스 내에서는 서원베이커리에서 직접 장일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
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
		
		<div class="facilBox" id="facil5">
			<div class="facilTab5">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">프로샵</li>
					<li onclick="javascript:facilTab2(5);">휘트니스</li>
				</ul>
			</div>
			<div class="facilGWarp">
				<div class="slider">
					<div id="slider" class="flexslider">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range5-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range5-2.jpg'/>" >
							</li>
						</ul>
					</div>
					<div id="carousel" class="flexslider1">
						<ul class="slides">
							<li>
							<img src="<c:url value='/images/hills/range/range5-1.jpg'/>" >
							</li>
							<li>
							<img src="<c:url value='/images/hills/range/range5-2.jpg'/>" >
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
						또한 클럽하우스 내에서는 서원베이커리에서 직접 장일 제조한 신선한 빵과 다양한 제과를 즐기실 수 있습니다.<br><br>
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
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />