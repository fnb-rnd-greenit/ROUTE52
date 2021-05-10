<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">
	
	$(document).ready(function() { 
		init();
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_hills/member/login.do'/>";	
		}
				
		$("#txtRecommender").val("${sessionScope.msMember.recommender}");
		$("#txtEmail").val("${sessionScope.msMember.email}");
				
		$("#txtZipCode").val("${sessionScope.msMember.homeZip}");
		$("#txtHomeAddress1").val("${sessionScope.msMember.homeAddr1}");
		$("#txtHomeAddress2").val("${sessionScope.msMember.homeAddr2}");
		
		$("#txtCoName").val("${sessionScope.msMember.coName}");
		$("#txtCoZipCode").val("${sessionScope.msMember.coZip}");
		$("#txtCoAddress1").val("${sessionScope.msMember.coAddr1}");
		$("#txtCoAddress2").val("${sessionScope.msMember.coAddr2}");
		$("#txtHandycap").val("${sessionScope.msMember.handycap}");
		$("#txtCarNum").val("${sessionScope.msMember.carNum}");

		$("#txtRecommender").prop("disabled", true);
		$("#txtRecommender").css("background", "#EAEAEA"); 
		$("#txtEmail").prop("disabled", true);
		$("#txtEmail").css("background", "#EAEAEA"); 
		$("#txtZipCode").prop("disabled", true);
		$("#txtZipCode").css("background", "#EAEAEA"); 
		$("#txtHomeAddress1").prop("disabled", true);
		$("#txtHomeAddress1").css("background", "#EAEAEA"); 
		$("#txtHomeAddress2").prop("disabled", true);
		$("#txtHomeAddress2").css("background", "#EAEAEA"); 
		$("#txtCoName").prop("disabled", true);
		$("#txtCoName").css("background", "#EAEAEA"); 
		$("#txtCoZipCode").prop("disabled", true);
		$("#txtCoZipCode").css("background", "#EAEAEA"); 
		$("#txtCoAddress1").prop("disabled", true);
		$("#txtCoAddress1").css("background", "#EAEAEA"); 
		$("#txtCoAddress2").prop("disabled", true);
		$("#txtCoAddress2").css("background", "#EAEAEA"); 
		$("#txtHandycap").prop("disabled", true);
		$("#txtHandycap").css("background", "#EAEAEA"); 
		$("#txtCarNum").prop("disabled", true);
		$("#txtCarNum").css("background", "#EAEAEA");
		$("#selJob").prop("disabled", true);
		$("#selJob").css("background", "#EAEAEA"); 
		$("#selWedding1").prop("disabled", true);
		$("#selWedding1").css("background", "#EAEAEA"); 
		$("#selWedding2").prop("disabled", true);
		$("#selWedding2").css("background", "#EAEAEA"); 
		$("#selWedding3").prop("disabled", true); 
		$("#selWedding3").css("background", "#EAEAEA"); 
		
		setSelectBox("${sessionScope.msMember.weddingDay}");

		var emailAgree = "${sessionScope.msMember.emailAgree}";
		if(emailAgree != "") {
			$("input:radio[name=chkEmailAgree]:input[value=" + emailAgree + "]").attr("checked", true);
		}
		var coPostAgree = "${sessionScope.msMember.coPostAgree}";
		if(coPostAgree != "") {
			$("input:radio[name=chkCoPostAgree]:input[value=" + coPostAgree + "]").attr("checked", true);
		}
	}
	
	function setSelectBox(wedding) {
		var date = new Date();
		var yyyy = date.yyyy();

		for(i=0; i<100; i++) {
			var year = yyyy - i;
			$("#selWedding1").append("<option value='" + year + "'>" + year + "</option>");
		}
		
		for(i=1; i<=12; i++) {
			var month = i > 9 ? i : "0" + i;
			$("#selWedding2").append("<option value='" + month + "'>" + i + "</option>");
		}

		
		for(i=1; i<=31; i++) {
			var day = i > 9 ? i : "0" + i;
			$("#selWedding3").append("<option value='" + day + "'>" + i + "</option>");
		}

		if(wedding != null && wedding != "" && wedding.length == 8) {
			$("#selWedding1").val(wedding.substring(0, 4));
			$("#selWedding2").val(wedding.substring(4, 6));
			$("#selWedding3").val(wedding.substring(6, 8));			
		}
		
		sUrl = "<c:url value='/common/getCommonCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "65");
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
	
	function doSave() {
		var sUrl = "<c:url value='/hills/member/modifyMember.do'/>;";
		var sParams = {};
		
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
		
		var job = $("#selJob").val();
		if(job != null && job != "") {
			sParams["job"] = job;
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
				
		var weddingDay = $("#selWedding1").val() + $("#selWedding2").val() + $("#selWedding3").val();
		sParams["weddingDay"] = weddingDay;
		
		var handycap = $("#txtHandycap").val();
		if(handycap != "") {
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
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 회원정보수정 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">	
		<div class="midTitleBox">
			<span class="commonDot"> 회원정보 수정</span>
			<a class="withdraw memberBtn" href="<c:url value='/m_hills/member/withdraw.do'/>">회원탈퇴</a>
			<a class="memberBtn" href="<c:url value='/m_hills/member/member.do'/>">필수정보 입력</a>			
		</div>
		<div class="grayBg">
			<div class="memberBoxList">	
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">추천인 아이디</li>
						<li class="infoConent"><input type="text" id="txtRecommender"></li>
					</ul>
				</div>	
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">이메일</li>
						<li class="infoConent"><input type="text" id="txtEmail"></li>
					</ul>
					<ul class="memberInfoBox">
						<li class="orangeRed modifyTxt">이메일을 수신 받으시겠습니까?</li>
					<li class="modifyTxt grayFont"><span class="input"><input type="radio" name="chkEmailAgree" value="Y"> 수신동의</span><span class="input"><input type="radio" name="chkEmailAgree" value="N"> 수신거부</span></li>	
					</ul>
				</div>		
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">지역</li>
						<li class="infoConent"><input type="text" class="address" id="txtZipCode"><div class="overlap grayBtn" onclick="daumPostcode('#txtZipCode', '#txtHomeAddress1')">주소검색</div></li>
					</ul>
					<ul class="memberInfoBox" style="margin-top:0.3em;">
						<li class="infoList"></li>
						<li class="infoConent"><input type="text" id="txtHomeAddress1"></li>
					</ul>
					<ul class="memberInfoBox" style="margin-top:0.3em;">
						<li class="infoList"></li>
						<li class="infoConent"><input type="text" id="txtHomeAddress2"></li>
					</ul>
				</div>
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">직업</li>
						<li class="infoConent"><select id="selJob" class="email-Select" style="width:40% !important;margin:0 0 0.3em 0;"></select></li>
					</ul>
					<ul class="memberInfoBox" style="margin-bottom:0.3em;">
						<li class="infoList">직장명</li>
						<li class="infoConent"><input type="text" id="txtCoName"></li>
					</ul>
					<ul class="memberInfoBox">
						<li class="infoList">직장주소</li>
						<li class="infoConent"><input type="text" class="address" id="txtCoZipCode"><div class="overlap grayBtn" onclick="daumPostcode('#txtCoZipCode', '#txtCoAddress1')">주소검색</div></li>
					</ul>
					<ul class="memberInfoBox" style="margin-top:0.3em;">
						<li class="infoList"></li>
						<li class="infoConent"><input type="text" id="txtCoAddress1"></li>
					</ul>
					<ul class="memberInfoBox" style="margin-top:0.3em;">
						<li class="infoList"></li>
						<li class="infoConent"><input type="text" id="txtCoAddress2"></li>
					</ul>
					<ul class="memberInfoBox">
						<li class="modifyTxt">우편물을 수신 하시겠습니까?</li>
					<li class="modifyTxt grayFont"><span class="input"><input type="radio" name="chkCoPostAgree" value="Y"> 수신동의</span><span class="input"><input type="radio" name="chkCoPostAgree" value="N"> 수신거부</span></li>	
					</ul>
				</div>	
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">결혼기념일</li>
						<li class="infoConent"><select id="selWedding1" class="select-arrow2">
						</select>
						<select id="selWedding2" class="select-arrow2">
						</select>
						<select id="selWedding3" class="select-arrow2">
						</select></li>
					</ul>
				</div>
				<div class="ListUnderLine">
					<ul class="memberInfoBox">
						<li class="infoList">핸디캡</li>
						<li class="infoConent"><input type="text" id="txtHandycap"></li>
					</ul>
					<div class="modifyTxt">핸디캡은 평균타수에서 72정도를 뺀 숫자를 의미합니다.</div>
				</div>
				
				<div class="ListUnderLine" style="border-bottom:0;">
					<ul class="memberInfoBox">
						<li class="infoList">차량번호</li>
						<li class="infoConent"><input type="text" id="txtCarNum"></li>
					</ul>
					<div class="modifyTxt">번호 4자리를 입력해 주십시오.</div>
				</div>
				
			</div>
		</div>
		
		<%-- <ul class="btnBox">
			<li class="grayBtn"><a href="<c:url value='/m_hills/member/member.do'/>">이전단계</a></li>
			<li class="orangeBtn"><a href="javascript:doSave()">수정완료</a></li>
		</ul> --%>
		<p class="memberMent">
			추가정보는 웹사이트를 통해 변경할 수 있습니다.
		</p>
		
		<a class="grayBtn closeBtn" href="<c:url value='/m_hills/member/member.do'/>">이전단계</a>
	</div><!-- contents End -->    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>