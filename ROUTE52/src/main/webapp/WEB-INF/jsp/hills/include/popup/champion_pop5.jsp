<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/champion_popup.css?ver=1'/>" rel='stylesheet' />
<script type="text/javascript">

	function initPopup(i) {
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
		sParams += String.format("coDiv={0}", "65");
		
		var birth = replaceAll($("#txtBirth").val(), "-", "");
		
		if(birth == "" || birth.length != 8) {
			alert("생년월일을 확인하세요.");
			return;
		}
		
		if(birth.substring(0, 4) >= 1982) {
			sParams += String.format("&ctDiv={0}", "11");
		} else {
			sParams += String.format("&ctDiv={0}", "12");
		}
		sParams += String.format("&birth={0}", birth);

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
		<h1 class="loginout" style="padding-top:60px;">이미지</h1>
		<div class="champInfo" style="padding-top:10px;">
			<h2>
			<span style="letter-spacing:-2px;">"골프장 주최 최대규모의 여성 골프대회"</span><br>
			시상규모 총 4억원 상당
			</h2>
			<h4 style="letter-spacing:-1.5px; font-size:13px;">
			제 5회 서원 · 클럽디 레이디스 골프 챔피언십 대회 참가를 원하시는 고객님께서는<br>
서원힐스 인터넷회원 로그인을 하신 이후 참가 신청해 주시기 바랍니다.<br>
회원가입이 안되신 고객님께서는 인터넷회원 가입을 하셔야만 참가신청이 가능합니다.<br>
<span class="orange" style="font-size:13px;">참가신청을 하신 후</span> 반드시 스코어등록을 하셔야만 예선전 우선시드 실시간 랭킹에 등록되니 이 점 꼭 참고 부탁 드립니다.<span class="orange" style="font-size:13px;">(참가신청 이후 스코어 등록 제출만 유효)</span>
<br><br>
‘예선전 참가 자격은 우선시드 실시간 랭킹 200명’<br>
<br>
※예선전 우선시드 실시간 랭킹은 대회요강에서 확인 바랍니다.			
</h4>
		</div>
		<div class="btnBox1">
			<a href="<c:url value='/hills/member/join02.do'/>" class="darksalmon">회원가입</a>
			<a href="<c:url value='javascript:initPopup(4)'/>" class="darksalmon">로그인</a>
			<a href="<c:url value='javascript:initPopup(4)'/>" class="darkgray"><span>아이콘</span> 참가신청</a>
		</div>
	</div>
	<div class="closeImg" onclick="javascript:popupClose(1)"></div>
</div>
<div id="championPopup2" class="champContent">
	<div class="champConBox">
		<h1 class="login">이미지</h1>
		<div class="champInfo" style="padding-top:10px;">
			<h2>
			<span style="letter-spacing:-2px;">"골프장 주최 최대규모의 여성 골프대회"</span><br>
			시상규모 총 4억원 상당
			</h2>
			<h4 style="letter-spacing:-1px; font-size:13px;">전국 최대 규모의 여성 아마추어 골프대회  제5회 서원·클럽디 레이디스 골프 챔피언십에 도전하세요.<br>
참가신청 하신 이후 반드시 스코어등록을 1회 이상 필수로 등록 하셔야만 예선전 우선시드 실시간 랭킹에 등록되오니 이 점 꼭 숙지바랍니다.<br><br>
           
     ‘예선전 참가 자격 예선전 우선시드 실시간 랭킹 200명’<br><br>

※예선전 우선시드 실시간 랭킹은 대회요강에서 확인 바랍니다

</h4>
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
			<%-- <p><img src="<c:url value='/images/hills/champion/imgBn2.jpg'/>" /></p>
			<h3>
			Seowon Hills<br>
			<span>Ladies Amateur Champion Ship</span>
			</h3> --%>
			<img src="<c:url value='/images/hills/main/champBn3.png'/>" style="width:100%;" />			
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
				<dt>생년월일 : </dt>
				<dd><input type="text" placeholder="1985-01-01" class="pop_birth" id="txtBirth"></dd>
				<dd class="small">대회 참가신청 시 반드시 신분증에 있는 생년원일을 입력 바랍니다.<br>대회 당일 신분증을 확인하며 생년월일 틀릴 시에는 실격 처리됩니다.</dd>
			</dl>
			<dl>
				<dt>대회참가신청 동의  : </dt>
				<dd class="check"><input type="checkbox" id="chkAgree"></dd>
				<dd class="small1"> 본인은 서원힐스 여성아마추어 골프대회에 참가를 신청하며, 대회와 관련하여 주최측에서 운영하는 사항을 준수하겠습니다.</dd>
			</dl>

		</div>
		<div class="btnBox2">
			<a href="javascript:doApply()" class="darkgray2 orange"><span>아이콘</span> 참가신청 완료</a>
		</div>
	<div class="closeImg" onclick="javascript:popupClose(3)"></div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$("#msId").keypress(function (event) {
		    if(event.keyCode == 13) {
		    	actionLogin();
		    }
		});

		$("#msPw").keypress(function (event) {
		    if(event.keyCode == 13) {
		    	actionLogin();
		    }
		});
	});
	
	function actionLogin() {
		var sUrl = "<c:url value='/hills/member/actionLogin.do'/>";
		var sParams = {};
		
		var msId = $("#msId").val();
		var msPw = $("#msPw").val();
		var autoLogin = $('input:checkbox[id="chkAutoLogin"]').is(":checked") ? "1" : "0";
		
		if(msId == "") {
			alert("아이디를 입력하세요.");
			return;
		} else {
			sParams["msId"] = msId;
		}
		
		if(msPw == "") {
			alert("비밀번호를 입력하세요.");
			return;
		} else {
			sParams["msPw"] = msPw;
		}

		sParams["autoLogin"] = autoLogin;
		
		progressStart();
		
        mAjax2(sUrl, sParams, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
        		location.reload();
            } else {
            	alert(data.resultMessage);
            }
        });
	}
</script>
<div id="championPopup4" class="champContent2">
		<div class="champTitle" style="margin-top:40px;">
			<img src="<c:url value='/images/hills/main/champBn3.png'/>" style="width:100%;" />			
		</div>
		<div class="loginCont">
			<span class="loginTitle">로그인 하시면 더 많은 혜택이 쏟아집니다~!</span>
			<ul class="loginInput">
				<li>
					<input type="text" value="" placeholder="아이디&amp;핸드폰번호로 로그인 가능합니다." id="msId">
				</li>
				<li>
					<input type="password" maxlength="20" placeholder="비밀번호" id="msPw">
				</li>
			</ul>
			<a href="javascript:actionLogin()" class="loginBtn">로그인</a>
				
		</div>
		
	<div class="closeImg" onclick="javascript:popupClose(4)"></div>
</div>