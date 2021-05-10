<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">
	var duplicateId = "";
	var pwRule = -1;
	var pwConfirm = -1;

	$(document).ready(function() { 
		onLoadPage();
	});
	
	function onLoadPage() {
		if(document.referrer != "") {
			var bUri = document.referrer.split("/");
			var idx = bUri[bUri.length - 1].indexOf("?");
			var str = idx == -1 ? bUri[bUri.length - 1] : bUri[bUri.length - 1].substring(0, idx);
			if(str != "join03.do") {
				alert("잘못된 접근입니다.");
				location.href = "<c:url value='/hills/index.do'/>";
				return;
			}
		} else {
			alert("잘못된 접근입니다.");
			location.href = "<c:url value='/hills/index.do'/>";
			return;
		}
		
		init();
		
		var name = "${name}";
		var phone = "${phone}";
		var gender = "${gender}";
		var birth = "${birth}";
		
		$("#txtPhone").prop("readonly", true);
		$("#txtPhone").css("background", "#EAEAEA");
		$("#txtName").prop("readonly", true);
		$("#txtName").css("background", "#EAEAEA");
		
		if(name != "") {
			$("#txtName").val(name);
		} else {
			alert("잘못된 접근입니다.");
			location.href = "<c:url value='/hills/index.do'/>";
			return;
		}
		
		if(phone != "") {
			$("#txtPhone").val(phone);
		} else {
			alert("잘못된 접근입니다.");
			location.href = "<c:url value='/hills/index.do'/>";
			return;
		}

		if(gender == 1) {
			$("#divMan").addClass("on");
		} else if(gender == 0) {
			$("#divWoman").addClass("on");
		} else {
			alert("잘못된 접근입니다.");
			location.href = "<c:url value='/hills/index.do'/>";
			return;
		} 

		setSelectBox(birth);
	}
	
	function init() {
		$("#txtChkPwMessage").hide();
		$("#txtChkPwConfirmMessage").hide();
		$("#txtChkIdMessage").hide();		
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
		
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "65");
		sParams += String.format("&cdDiv={0}", "003");
		 
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#selArea").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#selArea").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function duplicateCheckId() {
		var sUrl = "<c:url value='/hills/member/duplicateCheckId.do'/>";
		var sParams = "";
		
		var id = $("#txtId").val();
		
		if(id == null || id == "") {
			alert("아이디를 입력하세요.");
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
				duplicateId = id;
			} else {
				$("#txtChkIdMessage").show();
				$("#txtChkIdMessage").removeClass("blue");
				$("#txtChkIdMessage").addClass("red");
				$("#txtChkIdMessage").html("사용 불가능한 아이디입니다.");	
				duplicateId = "";
			}
			
			progressStop();
		});
	}
	
	function onCheckPw() {
        var pw = $("#txtPw").val(); 
        var pwChk = $("#txtPwConfirm").val(); 

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
	
	function signUpForLocal() {
		var sUrl = "<c:url value='/hills/member/signUpForLocal.do'/>";
		var sParams = {};
		
		var id = $("#txtId").val();
		
		if(duplicateId == id && duplicateId != "") {
			sParams["msId"] = id;				
		} else {
			alert("아이디 중복체크를 하세요.")
			return;
		}
		
		var pw = $("#txtPw").val(); 
		
		if(pwRule == 0 && pwConfirm == 0) {
			sParams["msPw"] = pw;
		} else {
			alert("비밀번호를 확인하세요.")
			return;
		}
		var name = $("#txtName").val();
		sParams["msName"] = name;

		var phone = $("#txtPhone").val();
		sParams["msFirstPhone"] = phone.substring(0, 3);
		sParams["msMidPhone"] = phone.substring(3, 7);
		sParams["msLastPhone"] = phone.substring(7, 11);

		var birth = $("#selBirth1").val() + $("#selBirth2").val() + $("#selBirth3").val();
		sParams["msBirth"] = birth;

		var gender = $("#divMan").attr("class");
		sParams["msSex"] = gender.indexOf("on") > 0 ? "1" : "2";
		
		var area = $("#selArea").val();
		sParams["msArea"] = area;
		
		if(area == "") {
			alert("지역을 선택하세요.");
			return;
		}
		
		progressStart();
		
		mAjax2(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				alert(data.resultMessage);
				
				location.href = "<c:url value='/hills/index.do'/>";
			} else {
				alert(data.resultMessage);
			}
		});
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>Member &nbsp;&nbsp;&nbsp; ＞ <span>회원가입</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">회원가입</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>
		<div class="joinTab">
			<a href="javascript:void(0)" class="">01.회원약관동의</a>
			<a href="javascript:void(0)" class="">02.회원실명확인</a>
			<a href="javascript:void(0)" class="on">03.회원정보입력</a>
		</div>

		<div class="joinTitle titleTop">간편회원가입</div>
		<div class="joinGrayBg">
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 아이디</li>
				<li><input type="text" class="idInput" id="txtId"></li>
				<li><div class="overlap orangeBtn" onclick="duplicateCheckId()">중복확인</div></li>
			</ul>
			<div class="red passTxt" id="txtChkIdMessage"></div>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 비밀번호</li>
				<li><input type="password" id="txtPw" onchange="onCheckPw()"></li>
			</ul>		 
			<div class="red passTxt" id="txtChkPwMessage">비밀번호 생성규칙을 확인해주세요.</div>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 비밀번호확인</li>
				<li><input type="password" id="txtPwConfirm" onchange="onCheckPw()"></li>
			</ul>
			<div class="red passTxt" id="txtChkPwConfirmMessage">비밀번호가 일치하지 않습니다.</div>
			<div class="passTxt">
				<li class="blue title">패스워드 생성규칙</li>
				<li>- 8 ~ 13자 입력</li>
				<li>- 영문자(대/소), 숫자, 특수문자 혼용 입력</li>
			</div>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 이름</li>
				<li><input type="text" id="txtName"></li>
			</ul>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 핸드폰</li>
				<li><input type="text" id="txtPhone"></li>
			</ul>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 성별</li>
				<li><div class="gender" id="divWoman">여</div><div class="gender" id="divMan">남</div></li>
			</ul>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 생년월일</li>
				<li>
					<select id="selBirth1" class="select-arrow2">
					</select>
					<select id="selBirth2" class="select-arrow2">
					</select>
					<select id="selBirth3" class="select-arrow2">
					</select>
				</li>
			</ul>
			<ul class="joinInfoBox">
				<li class="infoList"><span class="orangeRed"> *</span> 지역</li>
				<li><select id="selArea" class="select-arrow2">
				</select></li>
			</ul>

		</div>

		<div class="btnBox">
			<a href="<c:url value='/hills/member/login.do'/>" class="grayBtn">취 소</a>
			<a href="javascript:signUpForLocal()" class="orangeBtn">완 료</a>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer.jsp" flush="true" />