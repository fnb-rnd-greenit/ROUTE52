<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value='/css/hills/slick.css'/>" rel="stylesheet"/>
<script type="text/javascript" src="<c:url value='/js/hills/slick.js'/>"></script>   
<script type="text/javascript">

	var isOpen = false;
	var slickPlay = false;
	var isLock = true;
	
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
		if(isLock) {
			return;;
		}
		
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
			if(slickPlay) {
				$("#sliderContainer").slick('slickPlay'); 				
			} else {
				$("#sliderContainer").slick({
					infinite: true,
					slidesToShow: 5,
					slidesToScroll: 1,
					draggable: false,
					autoplay: true,
					autoplaySpeed: 1000
				  });
				$(".slick-prev").show();
				$(".slick-next").show();
				slickPlay = true;
			}
		} else {
			quickDiv.hide();
			quickDiv2.show();
			if("${sessionScope.quick}" == "Y") {
				setSessionQuickMenu("N");
			}
			if(slickPlay) {
				$("#sliderContainer").slick('slickPause'); 
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
		var sParams = String.format("coDiv={0}", "65");

		mAjax(sUrl, sParams, function(data) {
			if (data.resultCode == "0000") {
				var rows = data.rows;

				for (i = 0; i < rows.length; i++) {
					var division = rows[i].DIVISION;
					var message = rows[i].MESSAGE;

					switch (division) {
					case "CP":
						$("#txtCoupon").html(
								String.format("쿠폰 {0}매", message));
						$("#txtCoupon2").html(
								String.format("쿠폰 {0}매", message));
						break;
					case "SC":
						$("#txtScore").html(
								String.format("최근스코어 : {0}", message));
						$("#txtScore2").html(
								String.format("최근스코어 : {0}", message));
						$("#txtScore3").html(message);
						break;
					case "BK":
						$("#txtReservation").html(message);
						$("#txtReservation2").html(message);
						break;
					case "CS":
						$("#txtVoc").html(message);
						$("#txtVoc2").html(message);
						break;
					}
				}
			}
		});
		
		sUrl = "<c:url value='/common/getFooterData2.do'/>";

		mAjax(sUrl, null, function(data) {
			if (data.resultCode == "0000") {
				var rows = data.rows;
				
				var container = $("#sliderContainer");
				container.empty();
				
				if(rows.length == 0) {
					isLock = false;
					return;
				}
				
				$("#memberInfoOpneBox").css("height", "350px");
				$("#matchHeader").show();
				$("#matchContent").show();
				$("#fbtnAdd").show();
				

				for (i = 0; i < rows.length; i++) {
					if(i == 0) {
						$("#matchHeader").empty();
						$("#matchHeader").append(rows[i].PRO_PRPS);
					}
					
					var date = getDateFormat(rows[i].BK_DAY);
					var hour = rows[i].BK_HOUR;
					var dcGu = rows[i].DC_GU;
					var dcVal = rows[i].DC_VALUE;
					var cost = rows[i].MN_COST;
					var charge = cost;
					
					if(dcGu != "X") {
				    	if(dcGu == "1") {					    	
				    		charge = Number(dcVal) / 4;
					    } else if(dcGu == "2") {	
					    	charge = Number(charge) - (Number(charge) * Number(dcVal) / 100);					    	
					    } else if(dcGu == "3") {
					    	charge = Number(charge) - Number(dcVal);
					    } 
				    }
					
					var template = "";
					template += "<ul class='slideBox slick-slide' onclick='onClickFooterMatch(\"" + rows[i].BK_DAY + "\")'>";
					template += "<span><img src='<c:url value='/images/hills/icon_mz2.png'/>'></span>";
					template += "<li class='day'>{0}월 {1}일({2})</li>";
					template += "<li class='day'>{3}시대</li>";
					template += "<li class='sum'>{4}</li>";
					template += "<li class='sum1'>최저 {5}</li> </ul>";
					
					template = String.format(template, date.mm(), date.dd(), date.week(), hour, numberWithCommas(cost), numberWithCommas(charge));
				
					container.append(template);
				}
				
				if("${sessionScope.quick}" == "Y") {
					container.slick({
						infinite: true,
						slidesToShow: 5,
						slidesToScroll: 1,
						draggable: false,
						autoplay: true,
						autoplaySpeed: 1000
					  }); 
					$(".slick-prev").show();
					$(".slick-next").show();
					slickPlay = true;
				}
				
				isLock = false;
			}
		});
	}
	
	function onClickFooterMatch(date) {
		var sUrl = "<c:url value='/hills/reservation/reservation.do'/>";
		var sParams = "?action=match&date=" + date;
		
		location.href = sUrl + sParams;
	}
</script>
<style>
*:focus {
    outline: none;
}
input[type="button"]:focus,button:focus {border:0 !important; outline: none;}
</style>
<div id="quickBox">
	<div id="memberInfoBox">
		<div class="memberInfo">
			<div class="infoBox">
				<p class="title"><img src="<c:url value='/images/hills/quickIcon01.png'/>"> 쿠폰함</p>
				<a href="<c:url value='/hills/member/coupon.do'/>" class="box2" id="txtCoupon">쿠폰 0매</a> 
			</div>
			<div class="infoBox" style="width:153px;">
				<p class="title txt6"><%-- <img src="<c:url value='/images/hills/quickIcon02.png'/>"> 나의포인트 --%></p>
				<!-- <a href="javascript:void(0)" class="box">준비중</a>-->
			</div>
			<div class="nameBoxBg2" onclick="quickBox()">MY ZONE</div>			
			<div class="infoBox">
				<p class="title txt6"><img src="<c:url value='/images/hills/quickIcon03.png'/>"> 스코어현황</p>
				<a href="<c:url value='/hills/member/stateScore.do'/>" class="box3" id="txtScore">최근스코어 : 0</a>
			</div>
			<div class="emptyBox"></div>
			<div class="infoBox">
				<p class="title txt6"><img src="<c:url value='/images/hills/quickIcon04.png'/>"> 예약현황</p>
				<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="box4" id="txtReservation">예약없음</a>
			</div>
			<div class="infoBox">
				<p class="title txt10"><img src="<c:url value='/images/hills/quickIcon05.png'/>"> VOC현황(고객문의)</p>
				<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="box3 underline" id="txtVoc">0건</a>  
			</div>
		</div>
	</div>
</div>

<div id="quickOpneBox" style="display:none;">
	<div id="memberInfoOpneBox">
		<div class="closeBox" onclick="quickBox();"></div>
		<div class="memberInfoOpne">			
			<div class="nameBoxBg" onclick="quickBox()">MY ZONE</div>
			<div class="nameIntro">
				안녕하세요 ${sessionScope.msMember.msName} 고객님!
				<div class="fbtnAdd" style="display:none" id="fbtnAdd">
					<a href="<c:url value='/hills/reservation/reservation.do?hole=11'/>"><img src="<c:url value='/images/hills/m_bt.jpg'/>"></a>
				</div>
			</div>
			
			<div class="intro" id="matchHeader" style="display:none"></div>	
			<div class="sliderBox" id="matchContent" style="display:none">
				<div class="slider slider" id="sliderContainer">
					
				</div>
			</div>
			
			<div class="myzoneBoxList">
				<ul class="myzoneBox" onclick="location.href='<c:url value='/hills/member/coupon.do'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon01.png'/>"> 쿠폰함</li>
					<li class="pink info" id="txtCoupon2">쿠폰 0매</li>
				</ul>
				<%-- <ul class="myzoneBox">
					<li><img src="<c:url value='/images/hills/quickIcon02.png'/>"> 나의포인트</li>
					<li class="pink info">준비중입니다</li>
				</ul> --%>
				
				<ul class="myzoneBox img" onclick="location.href='<c:url value='/hills/member/stateScore.do'/>';">
					<div class="FscoreBox">
						<div class="scoreTxt">
							<div><img src="<c:url value='/images/hills/quickIcon03.png'/>" style="vertical-align:middle;"> 스코어현황</div>
							<div class="pink info" id="txtScore2">최근스코어 : 0</div>
						</div>					
						<div><img src="<c:url value='/images/hills/default.jpg'/>" class="defaultImg"alt=""></div>
						<div class="scoreGrayBg"></div>
					</div>
				</ul>	
				
				<ul class="myzoneBox box" onclick="location.href='<c:url value='/hills/reservation/reservationCheck.do'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon04.png'/>"> 예약현황</li>
					<li class="pink info" id="txtReservation2">예약없음</li>					
				</ul>
				<ul class="myzoneBox box" onclick="location.href='<c:url value='/hills/board/list.do?bbsType=9'/>';">
					<li><img src="<c:url value='/images/hills/quickIcon05.png'/>"> VOC현황<br>(고객센터)</li>
					<li class="pink info" id="txtVoc2">0건</li>
				</ul>
			</div>
		</div>
	</div>
</div>