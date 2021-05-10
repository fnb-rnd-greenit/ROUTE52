<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	var duplicateId = -1;
	var pwRule = -1;
	var pwConfirm = -1;	
	var certifyKey = "";
	var certifyYn = "N";

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		}
		
		var loginCd = "${sessionScope.msMember.loginCd}";
		var imsiYn = "${sessionScope.msMember.imsiYn}";
		if(loginCd != "LOCAL") {
			$("#txtPw").prop("disabled", true);
			$("#txtPw").css("background", "#EAEAEA"); 
			$("#txtNewPw").prop("disabled", true);
			$("#txtNewPw").css("background", "#EAEAEA"); 
			$("#txtNewPwConfirm").prop("disabled", true);
			$("#txtNewPwConfirm").css("background", "#EAEAEA"); 
			$("#txtIdPhoneMessage").hide();
			$("#txtIdPhoneHeaderMessage").hide();
			$("#txtPwRuleMessage").hide();		
			$('#btnDuplicateCheck').hide();
			
			$("#txtId").val("소셜 간편 로그인");	
		}
		
		if(imsiYn != "Y") {
			$("#txtId").prop("disabled", true);
			$("#txtId").css("background", "#EAEAEA"); 
			$("#txtId").removeClass("mid");
			$("#txtId").addClass("long");
		}
		
		$("#txtChkIdMessage").hide();
		$("#txtChkPwMessage").hide();
		$("#txtChkPwConfirmMessage").hide();
		$("#txtPhone1").val("${sessionScope.msMember.phone1}");
		$("#txtPhone2").val("${sessionScope.msMember.phone2}");
		$("#txtPhone3").val("${sessionScope.msMember.phone3}");
		
		setSelectBox("${sessionScope.msMember.msBirth}");

		var smsAgree = "${sessionScope.msMember.smsAgree}";
		if(smsAgree != "") {
			$("input:radio[name=chkSmsAgree]:input[value=" + smsAgree + "]").attr("checked", true);
		}
	}
	
	function setSelectBox(birth) {
		var date = new Date();
		var yyyy = date.yyyy();

		for(i=0; i<100; i++) {
			var year = yyyy - i;
			$("#selBirth1").append("<option value='" + year + "'>" + year + "</option>");
		}
		
		for(i=1; i<=12; i++) {
			var month = i > 9 ? i : "0" + i;
			$("#selBirth2").append("<option value='" + month + "'>" + i + "</option>");
		}
		
		for(i=1; i<=31; i++) {
			var day = i > 9 ? i : "0" + i;
			$("#selBirth3").append("<option value='" + day + "'>" + i + "</option>");
		}

		if(birth != null && birth != "" && birth.length == 8) {
			$("#selBirth1").val(birth.substring(0, 4));
			$("#selBirth2").val(birth.substring(4, 6));
			$("#selBirth3").val(birth.substring(6, 8));	
		}
	}
	
	function daumPostcode(selectorZip, selectorAddr) {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				$(selectorZip).val(data.zonecode); //5자리 새우편번호 사용
                $(selectorAddr).val(fullRoadAddr);  //신주소
            }
        }).open();
    }
	
	function onCheckPw() {
        var pw = $("#txtNewPw").val(); 
        var pwChk = $("#txtNewPwConfirm").val(); 

        var pattern1 = /[0-9]/;
        var pattern2 = /[a-zA-Z]/;
        var pattern3 = /[~!@\#$%<>^&*]/;

        var chkCnt = 0;
        
        if(pattern1.test(pw)) chkCnt += 1;
        if(pattern2.test(pw)) chkCnt += 1;
        if(pattern3.test(pw)) chkCnt += 1;
        
        if(chkCnt < 2 || pw.length < 7 || pw.length > 13) {
            $("#txtChkPwMessage").show();
    		pwRule = -1;
    		return;
        }
        
        $("#txtChkPwMessage").hide();
        
        pwRule = 0;
        
        if(pw != pwChk) {
        	if(pwChk.length != "") {
	            $("#txtChkPwConfirmMessage").show();
        	}
            pwConfirm = -1;
    		return;        	
        }
        
        $("#txtChkPwConfirmMessage").hide();

        pwConfirm = 0;
    }
	
	function duplicateCheckId() {
		var sUrl = "<c:url value='/valley/member/duplicateCheckId.do'/>";
		var sParams = "";
		
		var id = $("#txtId").val();
		
		if(id == "") {
			alert("아이디를 입력하세요.");
			return;
		}
		
		if(id == "${sessionScope.msMember.msId}") {
			return;
		}
		
		sParams += String.format("&msId={0}", id);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#txtChkIdMessage").show();
				$("#txtChkIdMessage").addClass("blue");
				$("#txtChkIdMessage").removeClass("red");
				$("#txtChkIdMessage").html("사용 가능한 아이디입니다.");
				duplicateId = 0;
			} else {
				$("#txtChkIdMessage").show();
				$("#txtChkIdMessage").removeClass("blue");
				$("#txtChkIdMessage").addClass("red");
				$("#txtChkIdMessage").html("사용 불가능한 아이디입니다.");	
				duplicateId = -1;
			}
			
			progressStop();
		});
	}
	
	function doSave() {
		var sUrl = "<c:url value='/valley/member/modifyMember.do'/>;";
		var sParams = {};
		
		var loginCd = "${sessionScope.msMember.loginCd}";
		if(loginCd == "LOCAL") {
			var id = $("#txtId").val();
			if("${sessionScope.msMember.msId}" != id) {
				if(duplicateId == 0) {
					sParams["id"] = id;			
				} else {
					alert("아이디 중복체크를 하세요.")
					return;
				}
			}
			
			var pw = $("#txtPw").val(); 
			var newPw = $("#txtNewPw").val();
			if(newPw != "") {
				if(pwRule == 0 && pwConfirm == 0) {
					sParams["msPw"] = pw;
					sParams["newPw"] = newPw;
				} else {
					alert("비밀번호를 확인하세요.")
					return;
				}
			}
		}
		
		var birth = $("#selBirth1").val() + $("#selBirth2").val() + $("#selBirth3").val();
		sParams["birth"] = birth;

		var phone1 = $("#txtPhone1").val();
		if(phone1 != "") {
			sParams["phone1"] = phone1;
		}
		
		var phone2 = $("#txtPhone2").val();
		if(phone2 != "") {
			sParams["phone2"] = phone2;
		}
		
		var phone3 = $("#txtPhone3").val();
		if(phone3 != "") {
			sParams["phone3"] = phone3;
		}
		
		if("${sessionScope.msMember.phone1}" != phone1 || "${sessionScope.msMember.phone2}" != phone2 || "${sessionScope.msMember.phone3}" != phone3) {
			if(certifyYn != "Y") {
				alert("휴대폰번호 본인인증을 받으세요.")
				return;	
			}
		}
		
		var smsAgree = $(":input:radio[name=chkSmsAgree]:checked").val();
		if(smsAgree != null && smsAgree != "") {
			sParams["smsAgree"] = smsAgree;
		} else {
			alert("SMS 수신여부를 선택하세요.")
			return;
		}
		
		progressStart();
		
		mAjax2(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("회원정보가 변경되었습니다.");
				window.location.reload();
			} else {
				alert(data.resultMessage);
			}
			
			progressStop();
		});
	}
	
	function doCertification() {
		var sUrl = "<c:url value='/common/doCertification.do'/>";
		var sParams = "";
		
		var phone1 = $("#txtPhone1").val();
		var phone2 = $("#txtPhone2").val();
		var phone3 = $("#txtPhone3").val();
		
		if(phone1 == "" || phone1.length != 3) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}
		if(phone2 == "" || phone2.length != 4) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}
		if(phone3 == "" || phone3.length != 4) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}
		
		certifyKey = Math.floor(Math.random() * 1000000) + 100000;
		
		sParams += String.format("&coDiv={0}", "61");
		sParams += String.format("&certifyKey={0}", certifyKey);
		sParams += String.format("&phone={0}", phone1 + phone2 + phone3);

		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#btnConfirm").show();
				$("#btnSend").hide();
				
				alert("인증번호가 발송되었습니다.");
			} else {
				alert(data.resultMessage);				
			}
		});
	}
	
	function doConfirmCertification() {
		var code = $("#txtCerCode").val();
		
		if(certifyKey == code) {
			certifyYn = "Y";
			
			$("#txtCertifyMsg").html("인증 되었습니다.");
			$("#txtCertifyMsg").removeClass("red");
			$("#txtCertifyMsg").addClass("blue");
			$("#certifyHeader").hide();
			$("#certifyContent").hide();
			$("#txtPhone1").prop("disabled", true);
			$("#txtPhone1").css("background", "#EAEAEA"); 
			$("#txtPhone2").prop("disabled", true);
			$("#txtPhone2").css("background", "#EAEAEA"); 
			$("#txtPhone3").prop("disabled", true);
			$("#txtPhone3").css("background", "#EAEAEA"); 
		} else {
			alert("인증번호가 잘못 되었습니다.")
		}
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> 회원정보수정 <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<div class="contents">	
		<div class="midTitleBox">
			<span class="commonDot"> 회원정보 수정 </span>
			<a class="withdraw memberBtn" href="<c:url value='/m_valley/member/withdraw.do'/>">회원탈퇴</a>
			<a class="memberBtn" href="<c:url value='/m_valley/member/modify.do'/>">추가정보 확인</a>			
		</div>
		<div class="grayBg">
			<div class="memberBoxList">
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 이름</li>
						<li class="infoConent just">${sessionScope.msMember.msName}</li>
					</ul>
				</div>
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 아이디</li>
						<li class="infoConent"><input type="text" id="txtId" value="${sessionScope.msMember.msId}" class="address"><div class="overlap grayBtn" id="btnDuplicateCheck" onclick="duplicateCheckId()">중복체크</div></li>
					</ul>
				</div>
				<div class="phoneTxt" id="txtChkIdMessage"></div>				
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 현재 비밀번호</li>
						<li class="infoConent"><input type="password" id="txtPw"></li>
					</ul>
				</div>
				
				<div class="ListUnderLine passBox">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 변경할 비밀번호</li>
						<li class="infoConent"><input type="password" id="txtNewPw" onchange="onCheckPw()"></li>
					</ul>				
				</div>	
				<div class="phoneTxt" id="txtChkPwMessage">비밀번호 생성규칙을 확인해주세요.</div>
				<div class="ListUnderLine passBox2">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 비밀번호 확인</li>
						<li class="infoConent"><input type="password" id="txtNewPwConfirm" onchange="onCheckPw()"></li>
					</ul>					
				</div>
				<div class="phoneTxt" id="txtChkPwConfirmMessage">비밀번호가 일치하지 않습니다.</div>
				<div class="memPassTxt" id="txtPwRuleMessage">
					<p class="title">패스워드 생성규칙</p>
					<p class="cont">- 8 ~ 13자 입력</p>
					<p class="cont">- 영문자(대/소), 숫자, 특수문자 혼용 입력</p>
				</div>
				
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 생년월일</li>
						<li class="infoConent"><select id="selBirth1" class="select-arrow2">
						</select>
						<select id="selBirth2" class="select-arrow2">
						</select>
						<select id="selBirth3" class="select-arrow2">
						</select></li>
					</ul>
				</div>

				<div class="ListUnderLine" style="border-bottom:0;">
					<ul class="memberInfoBox">
						<li class="infoList"><span class="orangeRed"> *</span> 휴대폰번호</li>
						<li class="infoConent"><select name="" id="txtPhone1" class="select-arrow2">
						<option value="010">010</option>
						</select>
						<input type="text" class="num" id="txtPhone2"><input type="text" class="num" id="txtPhone3">
						</li>
					</ul>	
					<ul class="memberInfoBox" style="margin-top:0.3em;">
						<li class="infoList"></li>
						<li class="infoConent"><input type="text" id="txtCerCode" class="address">
						<div class="overlap grayBtn" onclick="doConfirmCertification()" id="btnConfirm" style="display:none">확인</div>
						<div class="overlap grayBtn" onclick="doCertification()" id="btnSend">인증번호발송</div></li>
					</ul>				
				</div>
				
				<div class="phoneTxt" id="txtCertifyMsg">휴대폰 번호를 변경하시려면 인증번호발송 버튼을 클릭하여 휴대폰인증을 거쳐야만 변경됩니다.</div>
				<div class="snsAgreeyBox">
					<li><span class="orangeRed">* </span>SMS수신동의 하시면 서원힐스 컨트리클럽에서 보내는 공지 및 정보를 휴대폰으로 받아 보실 수있습니다.</li>
					<li><span class="input"><input type="radio" name="chkSmsAgree" value="Y"> SMS 수신동의</span><span class="input"><input type="radio" name="chkSmsAgree" value="N"> SMS 수신거부</span></li>					
				</div>
			</div>
		</div>
		<p class="memberMent">
			추가정보를 입력하시면 각종이 벤트 내용을 받으실수 있습니다.
		</p>
		<!-- <ul class="btnBox"> 
			<li class="blueBtn"><a href="javascript:doSave()">수정완료</a></li>			
		</ul> -->
		
		<a class="blueBtn closeBtn" href="javascript:doSave()">수정완료</a>
	</div><!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>