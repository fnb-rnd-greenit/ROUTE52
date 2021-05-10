<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/champion_popup.css?ver=1'/>" rel='stylesheet' />
<script type="text/javascript">

	function initPopup(i) {
		if("${sessionScope.msMember.msSex}" == "1") {
			alert("남성은 신청할 수 없습니다.")
			return;
		}
		
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number(replaceAll($("#championPopup"+i).css("width"), "px", "")) / 2;
		var cH = Number(replaceAll($("#championPopup"+i).css("height"), "px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;
		
		$("#championPopup"+i).css("left", mW);
		$("#championPopup"+i).css("top", mH);
		
		$("#championPopup"+i).css("display", "block");
		
		for(j=1; j<=3; j++) {
			if(j != i) {
				popupClose(j);
			}
		}
	}

	function popupOpen() {
		initPopup(1);
	}
	
	function popupClose(i) {
		$("#championPopup"+i).css("display", "none");
		$("#overlay").css("display", "none");
	}
	
	function doApply() {
		var sUrl = "<c:url value='/common/doCompetitionsApply.do'/>";
		var sParams = "";
		
		var agree = $("input[id=chkAgree]:checked").val();
		
		if(agree != "on") {
			alert("대회 참가신청에 동의하세요.");
			return;
		}
		
		sParams += String.format("ctDiv={0}", "5");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("참가신청 완료되었습니다.");
				popupClose(3);
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
</script>
<div id="championPopup1" class="champContent">	
	<div class="champConBox">
		<h1 class="loginout">이미지</h1>
		<div class="champInfo3">
			<h2 style="font-size:16px; line-height:30px; padding-bottom:20px; color:#ef9963;">골프장 최초 여성의, 여성에 의한, 여성을 위한 BIC 프로모션 <span><br>“서원힐스 LADY’S DAY PASSPORT ”</span></h2>
			<h4>서원밸리컨트리클럽에 주최하는<br> 최초의 여성만을 위한 <strong>BIC 프로모션!</strong><br>
			제 1회 LADY’S PASSPORT Itinerary 에 지금 참가하세요.<br>
			여성만을 위한 크루즈/골프 여행, 피부미용권 등 푸짐한 시상품과 여자여서 행복한 라운드가 기다립니다.</h4>			
		</div>
		<div class="btnBox1">
			<a href="<c:url value='/hills/member/join02.do'/>" class="darksalmon">회원가입</a>
			<a href="<c:url value='/hills/member/login.do'/>" class="darksalmon">로그인</a>
			<a href="<c:url value='/hills/member/login.do'/>" class="darkgray"><span>아이콘</span> 참가신청</a>
		</div>
	</div>	
	<div class="closeImg" onclick="javascript:popupClose(1)"></div>	
</div>
<div id="championPopup2" class="champContent">	
	<div class="champConBox">
		<h1 class="login">이미지</h1>
		<div class="champInfo3">
			<h2 style="font-size:16px; line-height:30px; padding-bottom:20px; color:#ef9963;">골프장 최초 여성의, 여성에 의한, 여성을 위한 BIC 프로모션 <span><br>“서원힐스 LADY’S DAY PASSPORT ”</span></h2>
			<h4>서원밸리컨트리클럽에 주최하는<br> 최초의 여성만을 위한 <strong>BIC 프로모션!</strong><br>
			제 1회 LADY’S PASSPORT Itinerary 에 지금 참가하세요.<br>
			여성만을 위한 크루즈/골프 여행, 피부미용권 등 푸짐한 시상품과 여자여서 행복한 라운드가 기다립니다.</h4>			
		</div>
		<div class="btnBox2">
			<a href="javascript:initPopup(3)" class="darkgray2"><span>아이콘</span> 참가신청</a>
		</div>
	</div>	
	<div class="closeImg" onclick="javascript:popupClose(2)"></div>	
</div>
<div id="championPopup3" class="champContent1">	
	<div class="champConBox1">
		<div class="champTitle">
			<p><img src="<c:url value='/images/hills/champion/imgBn3.jpg'/>" /></p>
			<h3>
			Seowon Hills<br>
			<span>서원힐스 LADY’S DAY PASSPORT</span>
			</h3>			
		</div>
		<div class="champList">
			<dl>
				<dt>신청자 성함 : </dt>
				<dd>${sessionScope.msMember.msName}</dd>
			</dl>
			<dl>
				<dt>신청자 ID : </dt>
				<dd>${sessionScope.msMember.msId}</dd>
			</dl>
			<dl>
				<dt>연락처 : </dt>
				<dd>${sessionScope.msMember.phone1}-${sessionScope.msMember.phone2}-${sessionScope.msMember.phone3}</dd>
				<dd class="small">수정이 필요한 분은 <span>개인정보수정</span>에서 정정한 뒤 다시 로그인 하여 주시기 바랍니다.</dd>
			</dl>
			<dl>
				<dt>대회참가신청 동의  : </dt>
				<dd class="check"><input type="checkbox" id="chkAgree"></dd>
				<dd class="small1"> 본인은 서원힐스 LADY’S DAY PASSPORT를 신청하며, 주최측에서 운영하는 사항을 준수하겠습니다.</dd>
			</dl>		
		</div>			
		<div class="btnBox2">
			<a href="javascript:doApply()" class="darkgray2 orange"><span>아이콘</span> 참가신청 완료</a>
		</div>
	<div class="closeImg" onclick="javascript:popupClose(3)"></div>	
	</div>
</div>