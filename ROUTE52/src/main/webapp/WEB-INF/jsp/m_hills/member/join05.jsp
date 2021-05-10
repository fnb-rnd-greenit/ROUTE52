<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">
<script type="text/javascript">
	var certifyKey, certifyYn;
	
	$(document).ready(function() { 
		onLoadPage();
	});
	
	function onLoadPage() {
		init();
		
		initCombo();
		
		var name = "${msName}";
		
		$("#txtName").val(name);
	}
	
	function init() {
		$("#txtCertifyMsg").hide();	
		$("#btnConfirm").hide();
	}	
	
	function initCombo() {
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "65");
		sParams += String.format("&cdDiv={0}", "220");
		 
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#selArea1").append("<option value=''>선택</option>");
				for(i=0; i<data.rows.length; i++) {
					$("#selArea1").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
				}
			} else {
				alert(data.resultMessage);
			}
		});
		
		$("#selArea2").append("<option value=''>선택</option>");
		
		$("#selArea1").on("change", function() {
			$("#selArea2").empty();
			
			sUrl = "<c:url value='/common/getCommonCode.do'/>";
			sParams = "";

			sParams += String.format("&coDiv={0}", "65");
			sParams += String.format("&cdDiv={0}", "221");
			 
			mAjax(sUrl, sParams, function(data) {
				if(data.resultCode == "0000") {
					$("#selArea2").append("<option value=''>선택</option>");
					
					var s1 = $("#selArea1").val();
					
					for(i=0; i<data.rows.length; i++) {
						if(data.rows[i].CD_CODE.substring(0, 2) == s1) {
							$("#selArea2").append("<option value='" + data.rows[i].CD_CODE + "'>" + data.rows[i].CD_TITLE1 + "</option>");
						}
					}
				} else {
					alert(data.resultMessage);
				}
			});
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
		
		sParams += String.format("&coDiv={0}", "65");
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
			
			$("#certifyContainer").hide();
			$("#txtCertifyMsg").show();
			
			$("#txtPhone1").prop("disabled", true);
			$("#txtPhone1").css("background", "#EAEAEA"); 
			$("#txtPhone2").prop("disabled", true);
			$("#txtPhone2").css("background", "#EAEAEA"); 
			$("#txtPhone3").prop("disabled", true);
			$("#txtPhone3").css("background", "#EAEAEA"); 
			
			doOldKakaoCheck();
		} else {
			alert("인증번호가 잘못 되었습니다.")
		}
	}
	
	function doOldKakaoCheck() {
		var msId = "${msId}";
		var loginCd = "${msLoginCd}";
		
		if(loginCd != "KAKAO") {
			return;
		}
		
		var sUrl = "<c:url value='/hills/member/doOldKakaoCheck.do'/>";
		var sParams = "";
		
		var phone1 = $("#txtPhone1").val();
		var phone2 = $("#txtPhone2").val();
		var phone3 = $("#txtPhone3").val();
		var name = $("#txtName").val();

		sParams += String.format("&msId={0}", msId);
		sParams += String.format("&msName={0}", name);
		sParams += String.format("&phone1={0}", phone1);
		sParams += String.format("&phone2={0}", phone2);
		sParams += String.format("&phone3={0}", phone3);

		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "1000") {
				if(confirm(data.resultMessage)) {
					doMergeOldKakao(data.rows);
				}
			}
		});
	}
	
	function doMergeOldKakao(msNum) {
		var sUrl = "<c:url value='/hills/member/doMergeOldKakao.do'/>";
		var sParams = "";
		
		var msId = "${msId}";

		sParams += String.format("&msNum={0}", msNum);
		sParams += String.format("&msId={0}", msId);

		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				location.href = "<c:url value='/m_hills/index.do'/>";
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doNext() {
		if(certifyYn != "Y") {
			alert("휴대폰번호 본인인증을 받으세요.")
			return;	
		}
		
		var sUrl = "<c:url value='/hills/member/doSaveMemberInfo.do'/>";
		var sParams = "";
		
		var name = $("#txtName").val();
		var phone1 = $("#txtPhone1").val();
		var phone2 = $("#txtPhone2").val();
		var phone3 = $("#txtPhone3").val();
		
		var area1 = $("#selArea1").val();
		var area2 = $("#selArea2").val();
		
		var sex = $("#selSex").val();
		
		if(area1 == "" || area2 == "") {
			alert("지역을 선택하세요.");
			return;
		}
		
		if(name == null || name == "") {
			alert("이름을 입력하세요.");
			return;
		}
		
		if(sex == "") {
			alert("성별을 입력하세요.");
			return;
		}
		
		sParams += String.format("&msNum={0}", "${msNum}");
		sParams += String.format("&name={0}", name);
		sParams += String.format("&phone1={0}", phone1);
		sParams += String.format("&phone2={0}", phone2);
		sParams += String.format("&phone3={0}", phone3);
		sParams += String.format("&msArea1={0}", area1);
		sParams += String.format("&msArea2={0}", area2);
		sParams += String.format("&msSex={0}", sex);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				location.href = "<c:url value='/m_hills/member/agree.do'/>";
			} else if(data.resultCode == "1000") {
				alert(data.resultMessage);
				
				location.href = "<c:url value='/m_hills/index.do'/>";
			} else {
				alert(data.resultMessage);
			}
		});
	}
</script>
<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 회원가입 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="grayBg">
			<div class="joinBoxList">
				<ul class="joinInfoBox">
					<li class="infoList"><span class="orangeRed"> *</span> 이름</li>
					<li><input type="text" id="txtName"></li>
				</ul>
				<ul class="joinInfoBox">
					<li class="infoList"><span class="orangeRed"> *</span> 핸드폰</li> 
					<li>
						<input type="text" id="txtPhone1" style="width:30%;margin-right:1px">
						<input type="text" id="txtPhone2" style="width:32%;margin-right:1px"> 
						<input type="text" id="txtPhone3" style="width:32%;">
					</li>
				</ul>
				<ul class="joinInfoBox" id="certifyContainer">
					<li class="infoList"></li>
					<li><input type="text" class="idInput" id="txtCerCode" style="width:65%">
					<div class="overlap orangeBtn" id="btnSend" onclick="doCertification()" style="vertical-align: middle;cursor:pointer;">인증번호전송</div>
					<div class="overlap orangeBtn" id="btnConfirm" onclick="doConfirmCertification()" style="vertical-align: middle;cursor:pointer;">확인</div>
					</li>
				</ul>
				<ul class="joinInfoBox">
					<li class="infoList"><span class="orangeRed"> *</span> 지역</li> 
					<li>
						<select name="select" id="selArea1" class="select-arrow2">
						</select>
						<select name="select" id="selArea2" class="select-arrow2">
						</select>
					</li>
				</ul>
				<ul class="joinInfoBox">
					<li class="infoList"><span class="orangeRed"> *</span> 성별</li> 
					<li>
						<select name="select" id="selSex" class="select-arrow2">
							<option value=''>선택</option>
							<option value='1'>남자</option>
							<option value='2'>여자</option>
						</select>
					</li>
				</ul>
				<div class="blue passTxt" id="txtCertifyMsg">인증 되었습니다.</div>
			</div>  
		</div>  
		
		<a class="orangeBtn closeBtn" href="javascript:doNext()" style="margin-top:20px;">다 음</a> 
	</div><!-- contents End -->
<jsp:include page="../include/pop_agreey.jsp" flush="true" />    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>