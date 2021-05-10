<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <link href="<c:url value='/css/valley/slick.css'/>" rel="stylesheet"/> --%>
<script type="text/javascript">

	var isOpen = false;
	
	$(function($) {
		initFooter();
	});
	
	$(document).ready(function() {
		setTimeout(function() {
			if ($(window).scrollTop() + $(window).height() >= getDocHeight() - 180) {
				$("#quickBox").animate({
					bottom : 180 - (getDocHeight() - ($(window).scrollTop() + $(window).height()))
				}, 0);	
			} else {
				$("#quickBox").animate({
					bottom : 0 
				}, 0);
			}
		}, 500);
	});
	
	$(window).scroll(function() {
		if ($(window).scrollTop() + $(window).height() >= getDocHeight() - 180) {
			$("#quickBox").animate({
				bottom : 180 - (getDocHeight() - ($(window).scrollTop() + $(window).height()))
			}, 0);	
			$("#quickOpneBox").animate({
				bottom : 180 - (getDocHeight() - ($(window).scrollTop() + $(window).height()))
			}, 0);	
		} else {
			$("#quickBox").animate({
				bottom : 0
			}, 0);	
			$("#quickOpneBox").animate({
				bottom : 0
			}, 0);	
		}
	});
	
	function setSessionQuickMenu(value) {
		var sUrl = "<c:url value='/common/setSessionQuickMenu.do'/>";
		var sParams = String.format("openYn={0}", value);
		
		mAjax(sUrl, sParams, function(data) {
			
		});
	}

	function quickBox() {		
		var quickDiv = $("#quickOpneBox");
		var quickDiv2 = $("#quickBox");
		
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
    		return;
		}
		
		if (isOpen) {
			quickDiv.show();
			quickDiv2.hide();
			if("${sessionScope.quick}" == "N") {
				setSessionQuickMenu("Y");
			}
		} else {
			quickDiv.hide();
			quickDiv2.show();
			if("${sessionScope.quick}" == "Y") {
				setSessionQuickMenu("N");
			}
		}

		isOpen = !isOpen;
	}

	function getDocHeight() {
	    var D = document;
	    return Math.max(
	        D.body.scrollHeight, D.documentElement.scrollHeight,
	        D.body.offsetHeight, D.documentElement.offsetHeight,
	        D.body.clientHeight, D.documentElement.clientHeight
	    );
	}

	function initFooter() {		
		var quickDiv = $("#quickOpneBox");
		var quickDiv2 = $("#quickBox");
		
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
    		return;
		} else {
			if("${sessionScope.quick}" == "Y") {		
				quickDiv2.hide();
				quickDiv.show();	
				isOpen = false;
			} else {	
				quickDiv.hide();
				quickDiv2.show();
				isOpen = true;
			}
		}
		
		var sUrl = "<c:url value='/common/getFooterData.do'/>";
		var sParams = String.format("coDiv={0}", "61");

		mAjax(sUrl, sParams, function(data) {
			if (data.resultCode == "0000") {
				var rows = data.rows;

				for (i = 0; i < rows.length; i++) {
					var division = rows[i].DIVISION;
					var message = rows[i].MESSAGE;

					switch (division) {
					case "SC":
						$("#txtScore").html(
								String.format("최근스코어 : {0}", message));
						$("#txtScore2").html(
								String.format("최근스코어 : {0}", message));
						$("#txtScore3").html(message);
						break;
					case "WT":
						$("#txtWait").html(message == "0" ? "대기없음" : String.format("{0}건", message));
						$("#txtWait2").html(message == "0" ? "대기없음" : String.format("{0}건", message));
						break;
					case "BK":
						$("#txtReservation2").html(message);
						break;
					case "BC":	
						$("#txtReservation").html(String.format("예약 {0}건", message));
						break;
					case "CS":
						$("#txtVoc").html(message);
						$("#txtVoc2").html(message);
						break;
					}
				}
			}
		});
	}
</script>
<div id="quickBox">
	<div id="memberInfoBox">
		<div class="memberInfo">
			<!--<a href="javascript:quickBox()" class="arrow">▼</a> -->
			<div class="infoBox">
				<p class="title txt6"><img src="<c:url value='/images/hills/quickIcon04.png'/>">  MY 예약현황</p>
				<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="box4" id="txtReservation">예약없음</a>
			</div>
			
			<div class="infoBox">
				<p class="title txt6"><img src="<c:url value='/images/hills/quickIcon01.png'/>"> MY 대기현황</p>
				<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="box4" id="txtWait">대기없음</a>
			</div>

			<div class="emptyBox"></div>
			
			<div class="nameBoxBg2" onclick="quickBox()">MY ZONE</div>			
			<div class="infoBox">
				<p class="title txt6"><img src="<c:url value='/images/hills/quickIcon02.png'/>"> 스코어현황</p>
				<a href="<c:url value='/valley/member/stateScore.do'/>" class="box3" id="txtScore">최근스코어 : 0</a>
			</div>
			<div class="infoBox">
				<p class="title txt10"><img src="<c:url value='/images/hills/quickIcon05.png'/>"> VOC현황(고객문의)</p>
				<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="box5 underline" id="txtVoc">0건</a>  
			</div>
		</div>
	</div>
</div>

<div id="quickOpneBox" style="display:none;">
	<div id="memberInfoOpneBox">
		<div class="closeBox" onclick="quickBox();"></div>
		<div class="memberInfoOpne">			
			<div class="nameBoxBg2" onclick="quickBox()">MY ZONE</div>
			<div class="nameIntro">안녕하세요 ${sessionScope.msMember.msName} 고객님!</div>
			
			<!-- <div class="intro">고객님께 맞춤 그린피가 준비되어 있습니다.</div>		

			<div class="sliderBox">

				<div class="slider slider" id="sliderContainer">
					<ul class="slideBox slick-slide">
						<li class="day">2월 12일(화)</li>
						<li class="day">06시대</li>
						<li class="sum">최저 100,000</li>
					</ul>
					<ul class="slideBox slick-slide">
						<li class="day">2월 12일(화)</li>
						<li class="day">07시대</li>
						<li class="sum">최저 110,000</li>
					</ul>
					<ul class="slideBox slick-slide">
						<li class="day">2월 13일(수)</li>
						<li class="day">06시대</li>
						<li class="sum">최저 100,000</li>
					</ul>
					<ul class="slideBox slick-slide">
						<li class="day">2월 13일(수)</li>
						<li class="day">07시대</li>
						<li class="sum">최저 110,000</li>
					</ul>
					<ul class="slideBox slick-slide">
						<li class="day">2월 14일(목)</li>
						<li class="day">07시대</li>
						<li class="sum">최저 110,000</li>
					</ul>
					<ul class="slideBox slick-slide">
						<li class="day">2월 14일(목)</li>
						<li class="day">07시대</li>
						<li class="sum">최저 110,000</li>
					</ul>
				</div>

			</div> -->
			<div class="myzoneBoxList">
				
				<ul class="myzoneBox" onclick="location.href='<c:url value='/valley/reservation/reservationCheck.do'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon04.png'/>"> 예약현황</li>
					<li class="pink info" id="txtReservation2">예약없음</li>					
				</ul>
				
				<ul class="myzoneBox" onclick="location.href='<c:url value='/valley/reservation/reservationCheck.do'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon01.png'/>"> 대기현황</li>
					<li class="pink info" id="txtWait2">대기없음</li>					
				</ul>
				
				<ul class="myzoneBox img" onclick="location.href='<c:url value='/valley/member/stateScore.do'/>';">
					<div class="scoreTxt">Recently <span class="pink" id="txtScore3">0</span></div>
					<li><img src="<c:url value='/images/valley/default.jpg'/>" class="defaultImg" alt=""></li>
					<div class="scoreGrayBg"></div>
				</ul>	
			
				<ul class="myzoneBox box" onclick="location.href='<c:url value='/valley/member/stateScore.do'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon02.png'/>"> 스코어현황</li>
					<li class="pink info" id="txtScore2">최근스코어 : 0</li>
				</ul>
				
				<ul class="myzoneBox box" onclick="location.href='<c:url value='/valley/board/list.do?bbsType=9'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon05.png'/>"> VOC현황<br>(고객센터)</li>
					<li class="pink info" id="txtVoc2">0건</li>
				</ul>
			</div>
				

		</div>
	</div>
</div>