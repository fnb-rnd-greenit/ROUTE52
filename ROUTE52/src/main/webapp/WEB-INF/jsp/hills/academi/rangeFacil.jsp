<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".facilTab4").offset();
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
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="">이용요금</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/rangeFacil.do'/>" class="on">시설안내</a>
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
			<div class="facilTab4">
				<ul>
					<li onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">휘트니스 & 프로샵</li>
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
						2004년도에 개장하여 2012년 대대적인 리모델링 공사를 통해 총 1,452평의 규모에 비거리 300야드 전자동 오토티업 시스템을 갖춘 4층 90타석의 매머드급 연습장으로 변모하였습니다.<br>
						또한 연습장 내부 카페테리아와 베이커리가 있어 다양한 먹거리와 음료를 함께 판매하고 있으며, 샤워시설까지 갖춰져 있어 이용에 편리함을 제공 하고 있습니다.
						</li>
					</ul>		
				</div>
			</div>
		</div>
		
		<div class="facilBox" id="facil2">
			<div class="facilTab4">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">휘트니스 & 프로샵</li>
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
						미국 골프 플랜사의 대표설계사 데이비드 데일(David Dale)이 직접 설계한 벙커연습장은 일반용, 상급자용, 프로선수용 구성으로 다양한 어프로치샷이 가능하게끔 설계하였습니다.<br> 
						모든 방향에서 그린표면을 볼 수 있게 설계되어 다양한 샷 운영 연습이 가능합니다.<br>
						 또한 2016년 3월에는 국내최고의 코스설계 회사 송호 디자인의 설계로 러프 언듈레이션, 공간 확장 등 선수들이 조금 더 다양한 어프로치 샷과 아카데미 원생 전용 퍼팅그린에서 연습할 수 있도록 리뉴얼 공사를 마쳐 연습생부터, 투어프로 선수들에게 각광받고 있습니다.
						</li>
					</ul>		
				</div>			
			</div>
		</div>
		
		<div class="facilBox" id="facil3">
			<div class="facilTab4">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li onclick="javascript:facilTab2(3);">카페테리아</li>
					<li class="off1" onclick="javascript:facilTab2(4);">휘트니스 & 프로샵</li>
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
						서원밸리 연습장 내부에 위치한 카페테리아는 무 방부제, 무 화학첨가물, 무 인공색소 재료 사용을 원칙으로 직접 당일 제조하는 신선한 다양한 빵을 맛 볼 수 있습니다.<br>
						또한 고객님들과 원생들의 입맛에 맞는 다양한 먹거리를 판매하여 편안한 휴식공간을 제공하고 있습니다.
						</li>
					</ul>		
				</div>			
			</div>
		</div>
		
		<div class="facilBox" id="facil4">
			<div class="facilTab4">
				<ul>
					<li class="off1" onclick="javascript:facilTab2(1);">드라이빙레인지</li>
					<li class="off1" onclick="javascript:facilTab2(2);">숏게임장</li>
					<li class="off1" onclick="javascript:facilTab2(3);">카페테리아</li>
					<li onclick="javascript:facilTab2(4);">휘트니스 & 프로샵</li>
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
							<li>
							<img src="<c:url value='/images/hills/range/range4.jpg'/>" >
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
						서원밸리 연습장에는 최근 트렌드인 웨이트, 코어훈련이 가능한 휘트니스까지 보유하고 있어, 골프부터 웨이트까지 현장에서 골프에 필요한 다양한 훈련이 가능하도록 설치 운영되고 있습니다.<br>
						또한 프로샵을 운영하여 고급스럽고 실용적인 골프용품을 비치함으로서 부족함 없는 연습이 될 수 있도록 세심하게 준비하였습니다.
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