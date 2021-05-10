<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.aca_overlay{display: none;position: fixed;top: 0%;left: 0%;width: 100%;height: 100%;background:#000;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}
.aca_content{display: none;position: fixed;width:545px;height:548px;background:#fff;z-index:1005;margin:0 auto; border:5px solid #ff6600; padding:20px 30px;}
.t_info1{ width:100%; float:left; padding:0; margin:0; position:relative; }
.t_info1 p{ float:left; width:100%; padding:0; text-align:left; margin-right:14px;border:1px solid #aeaeae;}
.t_info1 h2{ float:left; width:100%; color:#ff9900; font-size:16px; font-weight:700; border-bottom:1px dashed #ddd; padding: 20px 0 10px;}
.t_info1 h3{float:left; width:270px; font-weight:500; padding-top:10px; line-height:20px; color:#939393;}
.t_info2{ width:100%; float:left; padding-top:5px; margin:0;}
.t_info2 h2{ padding:24px 0 8px;}
.t_info2 div.textArea{overflow-y:auto; background-color:#f7f7f7; width:100%; height:100px; font-size:14px; color:#939393; line-height:20px;}
.playerClose{ position:absolute;text-align:center; right:-21px; top:-21px; cursor:pointer;}
</style>
<script>
	var currentPage;

    function aca_popupOpen(i) {
        initAcaPopup(i);
    }

    function initAcaPopup(i) {
    	currentPage = i;
    	
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#aca_popup" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#aca_popup" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#aca_popup" + i).css("left", mW);
        $("#aca_popup" + i).css("top", mH);

        $("#aca_popup" + i).css("display", "block");
        $("#aca_overlay").css("display", "block");
    }

    function aca_popupClose(i) {
        $("#aca_popup" + i).css("display", "none");
        $("#aca_overlay").css("display", "none");
    }

    function overlayPopupClose() {
        $("#aca_popup" + currentPage).css("display", "none");
        $("#aca_overlay").css("display", "none");
    }
</script>
<div id="aca_popup1" class="aca_content">
<div class="playerClose" onclick="aca_popupClose(1)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt1.jpg'/>" alt=""></p>
		<h2>최민철 프로</h2>		
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 1988년 11월 7일 / 입회년도 2009년 					
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
17년 KPGA 카이도 시리즈 제주오픈 – 2위<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KPGA 최경주 초청 INVITATIONAL 대회 – 2위<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KPGA 카이도 시리즈 챔피언십 – 2위<br>
18년 KPGA 제61회 코오롱 한국오픈 – 우승<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;& The open 챔피언십 출전
		</div>
	</div>
</div>
<div id="aca_popup2" class="aca_content">
<div class="playerClose" onclick="aca_popupClose(2)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt2.jpg'/>" alt=""></p>
		<h2>이상엽 프로</h2>
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 1994년 12월 17일 / 입회년도 2014년				
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
16년 KPGA 데상트 코리아 먼싱웨어 매치 플레이 - 우승<br>
17년 KPGA 카이도 시리즈 2차 – 공동 3위<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KPGA 동아제약 동아 ST 챔피언십 – 2위
		</div>
	</div>
</div>
<div id="aca_popup3" class="aca_content">	
<div class="playerClose" onclick="aca_popupClose(3)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt3.jpg'/>" alt=""></p>
		<h2>박소연 프로</h2>
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 1992년 12월 16일 / 입회년도 2011년			
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
		16년 KLPGA NH투자증권 레이디스 챔피언십 – 2위<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KLPGA 교촌 허니 레이디스 오픈 – 2위<br>
17년 KLPGA MY 문영 퀸즈파크 챔피언십 – 2위<br>
18년 KLPGA 효성 챔피언십 with SBS – 5위<br>
19년 KLPGA 크리스 제41회 챔피언십 – 2위<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KLPGA 교촌 허니 레이디스 오픈 - 우승 		
		</div>
	</div>	
</div>
<div id="aca_popup4" class="aca_content">
<div class="playerClose" onclick="aca_popupClose(4)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt4.jpg'/>" alt=""></p>
		<h2>임은빈 프로</h2>
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 1997년 8월 5일 / 입회년도 2015년			
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
16년 KLPGA OK저축은행 박세리 INVITATIONAL – 2위<br>
17년 KLPGA 현대차 중국여자오픈 – 2위<br>
18년 KLPGA 효성 챔피언십(베트남) – 2위 <br>
19년 KLPGA 제 7회 E1채리티 오픈 - 1위
		</div>
	</div>	
</div>
<div id="aca_popup5" class="aca_content">	
<div class="playerClose" onclick="aca_popupClose(5)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt5.jpg'/>" alt=""></p>
		<h2>피승현 선수</h2>
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 2004년 1월 26일 / 학력 : 광탄중 3학년			
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
		17년 제30회 경기도지사배 중등부 – 우승<br>
18년 제31회 경기도지사배 중등부 – 우승<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제30회 경기도협회장배 중등부 – 우승<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제47회 소년체육대회 단체전 – 우승 / 개인전 – 2위<br>
19년도 국가대표 선발
 		
		</div>
	</div>	
</div>
<div id="aca_popup6" class="aca_content">
<div class="playerClose" onclick="aca_popupClose(6)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_info1">
		<p><img src="<c:url value='/images/hills/aca/pop/pt6.jpg'/>" alt=""></p>
		<h2>유현준 선수</h2>	
	</div>
	<div class="t_info2">
		<div class="textArea" style="height:24px; ">
			생년월일 2002년 7월 17일 / 학력 : 건대부고 2학년	
		</div>
		<h2>선수이력</h2>
		<div class="textArea">
		18년 제5회 한국 C&T배 전국 중고대회 고등부 – 우승<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제29회 스포츠조선배 전국 중고대회 고등부 – 우승<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일송배 제36회 한국 주니어 대회 고등부 – 3위<br>
19년도 국가상비군 선발		
		</div>
	</div>	
</div>

<div id="aca_overlay" class="aca_overlay" onclick="overlayPopupClose()"></div>