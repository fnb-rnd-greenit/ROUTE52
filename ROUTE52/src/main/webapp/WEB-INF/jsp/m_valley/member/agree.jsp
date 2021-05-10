<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_agreey.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">
<script type="text/javascript">

	$(document).ready(function(){
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
		}
	});
	
	function actionAgree() {
		var sUrl = "<c:url value='/common/actionAgree.do'/>";
		var sParams = "";
		
		var agree1 = $("input[id=chkAgree1]:checked").val();
		var agree2 = $("input[id=chkAgree2]:checked").val();
		var agree3 = $("input[id=chkAgree3]:checked").val();
		var agree4 = $("input[id=chkAgree4]:checked").val();

		if(agree1 != 'on' || agree2 != 'on' || agree3 != 'on' || agree4 != 'on') {
			alert("회원 약관을 확인해주세요.");
			
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var imsiYn = "<c:out value='${sessionScope.msMember.imsiYn}'/>";		
				if(imsiYn != "" && imsiYn == "Y") {
					alert("아이디 변경 후 이용 가능합니다.");
					location.href = "<c:url value='/m_valley/member/member.do'/>";	
					return;
				}
				
				location.href = "<c:url value='/m_valley/index.do'/>";
			} else {
				alert(data.resultCode);
			}
		});
	}
	
	function onChangeAllAgree() {
		for(i=1; i<=5; i++) {
			$("input[id='chkAgree" + i + "']").prop('checked', true);			
		}

		$("input[id='chkAgree6']").prop('checked', true);
		$("input[id='chkAgree7']").prop('checked', false);	
	}
	
	function onChangeAllDeAgree() {
		for(i=1; i<=5; i++) {
			$("input[id='chkAgree" + i + "']").prop('checked', false);			
		}
		
		$("input[id='chkAgree6']").prop('checked', false);
		$("input[id='chkAgree7']").prop('checked', true);		
	}
	
	function onChangeAgree() {
		$("input[id='chkAgree6']").prop('checked', false);
		$("input[id='chkAgree7']").prop('checked', false);
	}
</script>
<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> 회원약관 <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="grayBg">
			<div class="agreeyBgBox">
				<ul class="joinAgreeyList">
					<li class="agreeyTitle">서원 이용약관 동의 <span class="orangeRed">(필수)</span></li>
					<li class="btn"><div class="agreeyBtn" onclick="popupOpen(1)"><span class="orange">▶</span> 약관보기</div></li>
					<li class="agreeyCheck"><input type="checkbox" id="chkAgree1" onchange="onChangeAgree()"> 동의</li>				
				</ul>

				<ul class="joinAgreeyList">
					<li class="agreeyTitle">서원 인터넷서비스 이용약관 동의 <span class="orangeRed">(필수)</span></li>
					<li class="btn"><div class="agreeyBtn" onclick="popupOpen(2)"><span class="orange">▶</span> 약관보기</div></li>
					<li class="agreeyCheck"><input type="checkbox" id="chkAgree2" onchange="onChangeAgree()"> 동의</li>				
				</ul>

				<ul class="joinAgreeyList">
					<li class="agreeyTitle">개인정보 취급방침 <span class="orangeRed">(필수)</span></li>
					<li class="btn"><div class="agreeyBtn" onclick="popupOpen(3)"><span class="orange">▶</span> 약관보기</div></li>
					<li class="agreeyCheck"><input type="checkbox" id="chkAgree3" onchange="onChangeAgree()"> 동의</li>				
				</ul>

				<ul class="joinAgreeyList">
					<li class="agreeyTitle">개인정보의 수집 이용 제공 취급위탁 동의 <span class="orangeRed">(필수)</span></li>
					<li class="btn"><div class="agreeyBtn" onclick="popupOpen(4)"><span class="orange">▶</span> 약관보기</div></li>
					<li class="agreeyCheck"><input type="checkbox" id="chkAgree4" onchange="onChangeAgree()"> 동의</li>			
				</ul>

				<ul class="joinAgreeyList">
					<li class="agreeyTitle">개인정보의 수집 이용 제공(선택)</li>
					<li class="btn"><div class="agreeyBtn" onclick="popupOpen(5)"><span class="orange">▶</span> 약관보기</div></li>
					<li class="agreeyCheck"><input type="checkbox" id="chkAgree5" onchange="onChangeAgree()"> 동의</li>			
				</ul>
			</div>
		</div>
		<ul class="agreeyCheck">
			<li><input type="checkbox" id="chkAgree6" onchange="onChangeAllAgree()"> 전체 동의합니다. </li>
			<li><input type="checkbox" id="chkAgree7" onchange="onChangeAllDeAgree()"> 동의하지 않습니다.</li>
		</ul>
		<a class="blueBtn closeBtn" href="javascript:actionAgree()">동 의</a>
	</div><!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>