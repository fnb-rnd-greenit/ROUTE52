<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header5.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		initHeaderTab(8);

		function popupOpen(i) {
			kingPopup(i);
		}
	});
	function tournament(idx) {
		for(i=0; i<3; i++) {
			if(i==idx) {
		      $("#tm" + i).addClass("on");
		      $("#tmc" + i).show();
		    } else {
		      $("#tm" + i).removeClass("on");
		      $("#tmc" + i).hide();
		    }
		}
	}
	var openIdx = -1;

	function kingPopup(i) {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number($("#layerPop" + i).css("width").replace("px", "")) / 2;
		var cH = Number($("#layerPop" + i).css("height").replace("px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;

		$("#layerPop" + i).css("left", mW);
		$("#layerPop" + i).css("top", mH);

		$("#layerPop" + i).css("display", "block");
		$("#overlay1").css("display", "block");

		openIdx = i;
	}

	function popupClose(i) {
		$("#layerPop" + i).css("display", "none");
		$("#overlay1").css("display", "none");
	}

	function popupOverlayClicked() {
		if(openIdx > 0){
			$("#layerPop" + openIdx).css("display", "none");
			$("#overlay1").css("display", "none");
		}
	}
</script>

<style>
area:focus{
  border: none;
  outline:none;
  outline-style: none;
  -moz-outline-style:none; 
}
</style>


<div id="wrap">
	<div id="championCon">
		<div class="chConBox">
			<ul>
				<li class="tm">
					<img src="<c:url value='/images/hills/champion/tournament_v2.jpg?=v2'/>" border="0" usemap="#Map" />
					<map name="Map" id="Map">
<!-- 					  <area shape="rect" coords="57,1171,347,1215" href="javascript:kingPopup(1)" />
					  <area shape="rect" coords="416,1171,704,1217" href="javascript:kingPopup(2)" />
					  <area shape="rect" coords="771,1172,1065,1215" href="javascript:alert('로컬룰은 9/28 공지 예정입니다.')" />
 -->					  
					  <area shape="rect" coords="46,1024,303,1063" href="javascript:kingPopup(1)" />
   <area shape="rect" coords="366,1022,614,1064" href="javascript:kingPopup(2)" />
   <area shape="rect" coords="680,1025,932,1062" href="<c:url value='/hills/board/view.do?bbsType=7&idx=294'/>" />
					</map>
				</li>
			</ul>
			
			<%-- <div class="tBtnBox">
				<ul>
					<li id="tm1" class="on" onclick="javascript:tournament(1)">경기방식 자세히 보기</li>
					<li id="tm2" onclick="javascript:tournament(2)">타임테이블 자세히 보기</li>
					<li id="tm3" onclick="javascript:alert('로컬룰은 9/28 공지 예정입니다.')">로컬룰 자세히 보기</li>
				</ul>
			</div>
			
			<div id="tmc1" class="tmc">
				<ul>
					<li style="text-align:center;"><img src="<c:url value='/images/hills/champion/tournament_way.jpg'/>" border="0" /></li>
				</ul>
			</div>
			<div id="tmc2" class="tmc">
				<ul>
					<li style="text-align:center;"><img src="<c:url value='/images/hills/champion/timetable.jpg'/>" border="0" /></li>
				</ul>
			</div> --%>
		</div>		
	</div>
</div>

<div id="layerPop1" class="kokLayer" style="display: none;">
	<img src="<c:url value='/images/hills/champion/tournament_way2.jpg?=v2'/>" border="0" />
	<h4><a href="javascript:popupClose(1)">닫기</a></h4>
</div>
<div id="layerPop2" class="kokLayer" style="display: none;">
	<img src="<c:url value='/images/hills/champion/timetable2.jpg?=v2'/>" border="0" />
	<h4><a href="javascript:popupClose(2)">닫기</a></h4>
</div>	
<div id="overlay1" class="overlay1" onclick="popupOverlayClicked()" style="display: none;">	
</div>


<jsp:include page="../include/footer.jsp" flush="true" />