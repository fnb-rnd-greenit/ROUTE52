<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/champion_popup.css?ver=1'/>" rel='stylesheet' />
<script type="text/javascript">

	function initPopup(i) {
		alert('참가신청 기간이 끝났습니다.');
		return;
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
		alert('참가신청 기간이 끝났습니다.');
		return;
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
		
		sParams += String.format("ctDiv={0}", "6");
		
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
		<div class="champInfo2">
			<h2>"최초의 <span> 평화 골프대회</span>"</h2>
			<h4>서원밸리컨트리클럽이 주최하는 <br><strong>제2회 DMZ 평화골프대회</strong> 에지금 참가하세요. <br>
			신페리오 우승 시상 "상금 1,000만원"부터 <br>다양하고 푸짐한 시상품들이준비 되어있습니다. <br>
			골퍼들의 도전을 기다립니다! </h4>			
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
		<div class="champInfo2">
			<h2>"최초의 <span> 평화 골프대회</span>"</h2>
			<h4>서원밸리컨트리클럽이 주최하는 <br><strong>제2회 DMZ 평화골프대회</strong> 에지금 참가하세요. <br>
			신페리오 우승 시상 "상금 1,000만원"부터 <br>다양하고 푸짐한 시상품들이준비 되어있습니다. <br>
			골퍼들의 도전을 기다립니다! </h4>			
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
			<p><img src="<c:url value='/images/hills/champion/dmzLogo.png'/>" /></p>
			<h3>
			Seowon Hills<br>
			<span style="color:#0b3f98;">DMZ Peace Golf Championship</span>
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
				<dd class="small1"> 본인은 서원힐스 제2회 DMZ 평화 골프대회에 참가를 신청하며, 대회와 관련하여 주최측에서 운영하는 사항을 준수하겠습니다.</dd>
			</dl>
		
		</div>			
		<div class="btnBox2">
			<a href="javascript:doApply()" class="darkgray2 orange"><span>아이콘</span> 참가신청 완료</a>
		</div>
	<div class="closeImg" onclick="javascript:popupClose(3)"></div>	
	</div>
</div>