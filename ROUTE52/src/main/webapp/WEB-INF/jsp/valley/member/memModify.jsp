<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
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
			location.href = "<c:url value='/valley/member/login.do'/>";	
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
			$("#txtPwRuleMessageHeader").hide();			
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
		$("#txtChkPwMessageHeader").hide();
		$("#txtChkPwConfirmMessage").hide();
		$("#txtChkPwConfirmMessageHeader").hide();
		
		getSelectBox();
				
		$("#txtBirth").val("${sessionScope.msMember.msBirth}");
		$("#txtZipCode").val("${sessionScope.msMember.homeZip}");
		$("#txtHomeAddress1").val("${sessionScope.msMember.homeAddr1}");
		$("#txtHomeAddress2").val("${sessionScope.msMember.homeAddr2}");
		$("#txtPhone1").val("${sessionScope.msMember.phone1}");
		$("#txtPhone2").val("${sessionScope.msMember.phone2}");
		$("#txtPhone3").val("${sessionScope.msMember.phone3}");
		$("#txtRecommender").val("${sessionScope.msMember.recommender}");
		$("#txtEmail").val("${sessionScope.msMember.email}");
		$("#txtCoName").val("${sessionScope.msMember.coName}");
		$("#txtCoZipCode").val("${sessionScope.msMember.coZip}");
		$("#txtCoAddress1").val("${sessionScope.msMember.coAddr1}");
		$("#txtCoAddress2").val("${sessionScope.msMember.coAddr2}");
		$("#txtWeddingDay").val("${sessionScope.msMember.weddingDay}");
		$("#txtHandycap").val("${sessionScope.msMember.handycap}");
		$("#txtCarNum").val("${sessionScope.msMember.carNum}");

		var birthYl = "${sessionScope.msMember.birthYl}";
		if(birthYl != "") {
			$("input:radio[name=chkBirthYl]:input[value=" + birthYl + "]").attr("checked", true);
		}
		var homePostAgree = "${sessionScope.msMember.homePostAgree}";
		if(homePostAgree != "") {
			$("input:radio[name=chkHomePostAgree]:input[value=" + homePostAgree + "]").attr("checked", true);
		}
		var smsAgree = "${sessionScope.msMember.smsAgree}";
		if(smsAgree != "") {
			$("input:radio[name=chkSmsAgree]:input[value=" + smsAgree + "]").attr("checked", true);
		}
		var emailAgree = "${sessionScope.msMember.emailAgree}";
		if(emailAgree != "") {
			$("input:radio[name=chkEmailAgree]:input[value=" + emailAgree + "]").attr("checked", true);
		}
		var coPostAgree = "${sessionScope.msMember.coPostAgree}";
		if(coPostAgree != "") {
			$("input:radio[name=chkCoPostAgree]:input[value=" + coPostAgree + "]").attr("checked", true);
		}
	}
	
	function getSelectBox() {
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "61");
		sParams += String.format("&cdDiv={0}", "002");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#selJob").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#selJob").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
				}
				
				var job = "${sessionScope.msMember.job}";
				if(job != null && job != "") {
					$("#selJob").val(job);	
				}
			} else {
				alert(data.resultMessage);
			}
		});
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
    		$("#txtChkPwMessageHeader").show();
    		pwRule = -1;
    		return;
        }
        
        $("#txtChkPwMessage").hide();
		$("#txtChkPwMessageHeader").hide();
        
        pwRule = 0;
        
        if(pw != pwChk) {
        	if(pwChk.length != "") {
	            $("#txtChkPwConfirmMessage").show();
	    		$("#txtChkPwConfirmMessageHeader").show();
        	}
            pwConfirm = -1;
    		return;        	
        }
        
        $("#txtChkPwConfirmMessage").hide();
		$("#txtChkPwConfirmMessageHeader").hide();

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
		
		var birth = $("#txtBirth").val();
		if(birth != "") {
			if(birth.length != 8) {
				alert("생년월일을 확인하세요.\r\nex)20190101");
				return;				
			}
			sParams["birth"] = birth;
		}

		var birthYl = $(":input:radio[name=chkBirthYl]:checked").val();
		if(birthYl != "") {
			sParams["birthYl"] = birthYl;
		}

		var homeZip = $("#txtZipCode").val();
		if(homeZip != "") {
			sParams["homeZip"] = homeZip;
		}
		
		var homeAddr1 = $("#txtHomeAddress1").val();
		if(homeAddr1 != "") {
			sParams["homeAddr1"] = homeAddr1;
		}
		
		var homeAddr2 = $("#txtHomeAddress2").val();
		if(homeAddr2 != "") {
			sParams["homeAddr2"] = homeAddr2;
		}
		
		var homePostAgree = $(":input:radio[name=chkHomePostAgree]:checked").val();
		if(homePostAgree != null && homePostAgree != "") {
			sParams["homePostAgree"] = homePostAgree;
		}
		
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
		
		var recommender = $("#txtRecommender").val();
		if(recommender != "") {
			sParams["recommender"] = recommender;
		}
		
		var email = $("#txtEmail").val();
		if(email != "") {
			sParams["email"] = email;
		}
		
		var emailAgree = $(":input:radio[name=chkEmailAgree]:checked").val();
		if(emailAgree != null && emailAgree != "") {
			sParams["emailAgree"] = emailAgree;
		}
		
		var coName = $("#txtCoName").val();
		if(coName != "") {
			sParams["coName"] = coName;
		}
		
		var coZip = $("#txtCoZipCode").val();
		if(coZip != "") {
			sParams["coZip"] = coZip;
		}
		
		var coAddr1 = $("#txtCoAddress1").val();
		if(coAddr1 != "") {
			sParams["coAddr1"] = coAddr1;
		}
		
		var coAddr2 = $("#txtCoAddress2").val();
		if(coAddr2 != "") {
			sParams["coAddr2"] = coAddr2;
		}
		
		var coPostAgree = $(":input:radio[name=chkCoPostAgree]:checked").val();
		if(coPostAgree != null && coPostAgree != "") {
			sParams["coPostAgree"] = coPostAgree;
		}
		
		var job = $("#selJob").val();
		if(job != null && job != "") {
			sParams["job"] = job;
		}
		
		var weddingDay = $("#txtWeddingDay").val();
		if(weddingDay != "") {
			if(weddingDay.length != 8) {
				alert("결혼기념일을 확인하세요.\r\nex)20190101");
				return;				
			}
			sParams["weddingDay"] = weddingDay;
		}
		
		var handycap = $("#txtHandycap").val();
		if(handycap != "") {
			if(handycap.length > 4) {
				alert("핸디캡은 4자리까지 입력 가능합니다.");
				return;
			}
			sParams["handycap"] = handycap;
		}
		
		var carNum = $("#txtCarNum").val();
		if(carNum != "") {
			if(carNum.length != 4) {
				alert("차량번호는 4자리로 입력하세요.");
				return;				
			}

			sParams["carNum"] = carNum;
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

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>회원 정보 수정</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">	
		<div class="myzoneTabList6">
			<a href="<c:url value='/valley/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/valley/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/valley/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/valley/member/stateScore.do'/>" class="">스코어현황</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/valley/member/memModify.do'/>" class="on">회원정보수정</a>
		</div>

		<div class="subTitle">
			<span class="title">회원 정보 수정</span>
			<span class="titleDes"></span>
			<a href="<c:url value='/valley/member/withdraw.do'/>" class="withDrawBtn">회원탈퇴</a>
		</div>
		<div class="subLine"></div>


		<div class="grayBgBox bgBottom">
			<div class="necessaTitle">
				<span class="commonDot"> 필수입력</span>
				<span class="red miniNece">* 필수 입력사항</span>
			</div>
			<div class="necessa-InputBox">
				<div class="necessa-LeftBox">
					<ul class="necessaList">
						<li class="titleBox"><span class="red">* </span>이름</li>
						<li class="cont">${sessionScope.msMember.msName}</li>

						<li class="titleBox"><span class="red">* </span>회원아이디</li>
						<li class="cont"><input type="text" class="txt mid" id="txtId" value="${sessionScope.msMember.msId}"><a href="javascript:duplicateCheckId()" class="graybtn neceBtn" id="btnDuplicateCheck">아이디 중복체크</a></li>
						<li class="titleBox" id="txtIdPhoneHeaderMessage"></li>
						<li>
							<span class="smfont blue" id="txtChkIdMessage"></span>
						</li>
						<li id="txtIdPhoneMessage">
							<span class="smfont red">* 회원아이디는 고객님의 전화번호로 기본 등록 됩니다.</span>
						</li>
					</ul>
					<ul class="necessaList">
						<li class="titleBox"><span class="red">* </span>현재 패스워드</li>
						<li class="cont">
							<input type="password" placeholder="비밀번호를 입력해주세요." class="long txt" id="txtPw">
						</li>					
					</ul>
					<ul class="necessaList">
						<li class="titleBox"><span class="red">* </span>변경할 패스워드</li>
						<li class="cont">
							<input type="password" placeholder="변경하실 비밀번호를 입력해주세요." class="long txt" id="txtNewPw" onchange="onCheckPw()">
						</li>
						<li class="titleBox" id="txtChkPwMessageHeader"></li>
						<li class="cont" id="txtChkPwMessage">
							<span class="smfont red">비밀번호 생성규칙을 확인해주세요.</span>
						</li>
						<li class="titleBox"><span class="red">* </span>패스워드 재입력</li>
						<li class="cont">
							<input type="password" placeholder="비밀번호를 한번 더 입력해주세요." class="long txt" id="txtNewPwConfirm" onchange="onCheckPw()">
						</li>
						<li class="titleBox" id="txtChkPwConfirmMessageHeader"></li>
						<li class="cont" id="txtChkPwConfirmMessage">
							<span class="smfont red">비밀번호가 일치하지 않습니다.</span>
						</li>
						<li class="titleBox" id="txtPwRuleMessageHeader"></li>
						<li style="margin-bottom:10px;" id="txtPwRuleMessage">
							<span class="blue smfont">패스워드 생성규칙</span><br>
							<span class="smfont">- 8 ~ 13자 입력<br>
							- 영문자(대/소), 숫자, 특수문자 혼용 입력</span>
						</li>	
					</ul>
				</div>

				<div class="necessa-RightBox">				
					<ul class="necessaList">
						<li class="titleBox">생년월일</li>
						<li class="cont"><input type="text" class="txt mid" id="txtBirth">
						<span class="radioBox"><input type="radio" name="chkBirthYl" value="1" checked> 양력 <input type="radio" name="chkBirthYl" value="2"> 음력</span></li>
					</ul>
					<ul class="necessaList">
						<li class="titleBox">자택 주소</li> 
						<li class="cont"><input type="text" class="txt mid" id="txtZipCode" style="vertical-align:top" readonly><input type="button" value="우편번호검색" class="blueBtn mainBtn" onclick="daumPostcode('#txtZipCode', '#txtHomeAddress1')"></li>
						<li class="titleBox"></li>
						<li class="cont"><input type="text" class="long txt" id="txtHomeAddress1" readonly></li>
						<li class="titleBox"></li>
						<li class="cont"><input type="text" class="long txt" id="txtHomeAddress2"></li>
						<li class="titleBox"></li>
						<li class="overflow">
							<span class="smfont red left">우편을 수신하시겠습니까?</span><span class="radioBox right"><input type="radio" name="chkHomePostAgree" value="Y"> 수신동의<input type="radio" name="chkHomePostAgree" value="N"> 수신하지않겠음</span>
						</li>						
					</ul>
					<ul class="necessaList">
						<li class="titleBox"><span class="red">* </span>휴대폰번호</li>
						<li class="cont">
							<input type="text" class="short txt" id="txtPhone1">
							<input type="text" class="short txt" id="txtPhone2"> 
							<input type="text" class="short txt" id="txtPhone3">
						</li>
						<li class="titleBox" id="certifyHeader"></li>
						<li class="cont" id="certifyContent"><input type="text" class="short txt" id="txtCerCode"><a href="javascript:doConfirmCertification()" class="orangeBtn cerBtn" id="btnConfirm" style="display:none">확인</a>
								<a href="javascript:doCertification()" class="graybtn cerBtn" id="btnSend">인증번호발송</a></li>
						<li class="titleBox"></li>
						<li class="cont"><span class="red phoneTxt" id="txtCertifyMsg">휴대폰 번호를 변경하실려면 인증번호발송 버튼을 클릭하여 휴대폰인증을 거쳐야만 변경됩니다.</span></li>
					</ul>
						<div class="phoneSnsBox">
							<p class="txt"><span class="red">* </span>SMS수신동의 하시면 서원밸리 컨트리클럽에서 보내는 공지 및 정보를 휴대폰으로 <br>&nbsp;&nbsp;&nbsp;받아 보실 수있습니다.</p>
							<span class="radio"><input type="radio" name="chkSmsAgree" value="Y"> SMS 수신동의<input type="radio" name="chkSmsAgree" value="N"> SMS 수신거부</span>
						</div>
				</div>
			</div><!-- grayBgBox End -->
		</div>

		<div class="grayBgBox">
			<div class="necessaTitle">
				<span class="commonDot"> 추가정보</span>
			</div>
			<div class="necessa-InputBox">
				<div class="necessa-LeftBox">
					<ul class="necessaList">
						<li class="titleBox">추천인 아이디</li>
						<li class="cont">
							<input type="text" class="long txt" id="txtRecommender">
						</li>
						<li class="titleBox">이메일주소</li>
						<li class="cont"><input type="text" class="txt mid" id="txtEmail" style="margin-right:3px;">
						</li>
						<li class="titleBox"></li>
						<li class="overflow">
							<span class="smfont red left">이메일을 수신 받으시겠습니까?</span><span class="radioBox right"><input type="radio" name="chkEmailAgree" value="Y"> 수신동의<input type="radio" name="chkEmailAgree" value="N"> 수신하지않겠음</span>
						</li>
					</ul>
					<ul class="necessaList">
						<li class="titleBox">직장명</li>
						<li class="cont">
							<input type="text" class="long txt" id="txtCoName">
						</li>
						<li class="titleBox">직장 주소</li>
						<li class="cont"><input type="text" class="txt mid" style="vertical-align:top" id="txtCoZipCode"><input type="button" value="우편번호검색" class="blueBtn mainBtn "onclick="daumPostcode('#txtCoZipCode', '#txtCoAddress1')"></li>
						<li class="titleBox"></li>
						<li class="cont"><input type="text" class="long txt" id="txtCoAddress1"></li>
						<li class="titleBox"></li>
						<li class="cont"><input type="text" class="long txt" id="txtCoAddress2"></li>
						<li class="titleBox"></li>
						<li class="overflow">
							<span class="smfont red left">우편을 수신하시겠습니까?</span><span class="radioBox right"><input type="radio" name="chkCoPostAgree" value="Y"> 수신동의<input type="radio" name="chkCoPostAgree" value="N"> 수신하지않겠음</span>
						</li>				
					</ul>
				</div>

				<div class="necessa-RightBox">				
					<ul class="necessaList">
						<li class="titleBox">직업</li>
						<li class="cont">
							<select name="" id="selJob" class="select-arrow2">
							</select>
						</li>
						<li class="titleBox">결혼기념일</li>
						<li class="cont">
							<input type="text" class="txt mid" id="txtWeddingDay">
						</li>
						<li class="titleBox">핸디캡</li>
						<li class="cont"><input type="text" class="txt mid" id="txtHandycap">
						<li class="titleBox"></li>
						<li class="overflow">
							<span class="smfont red left">핸디캡은 평균타수에서 72정도를 뺀 숫자를 의미합니다.</span>
						</li>
					</ul>
					<ul class="necessaList">
						<li class="titleBox">차량번호</li>
						<li class="cont"><input type="text" class="txt mid" id="txtCarNum">
						<li class="titleBox"></li>
						<li class="overflow">
							<span class="smfont red left">번호 4자리를 입력해 주십시오</span>
						</li>
						<li class="titleBox"></li>
						<li class="cont"></li>
					</ul>
				</div>
			</div><!-- necessaInputBox End -->
		</div>
		<div class="btnBox">
			<a href="javascript:location.href = document.referrer;" class="cancel">취 소</a>
			<a href="javascript:doSave()" class="motion">완 료</a>
		</div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />