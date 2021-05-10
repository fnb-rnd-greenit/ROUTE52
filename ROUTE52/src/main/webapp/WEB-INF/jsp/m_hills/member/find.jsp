<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">

	$(document).ready(function() { 
		init();
	});
	
	function init() {
		$("#txtFindIdName").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doFindId();
	        }
	    });

		$("#txtFindIdPhone").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doFindId();
	        }
	    });

		$("#txtFindPwName").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doFindPw();
	        }
	    });

		$("#txtFindPwId").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doFindPw();
	        }
	    });
	}

	function doFindId() {
		var sUrl = "<c:url value='/common/doFindId.do'/>";
		var sParams = "";
		
		var name = $("#txtFindIdName").val();
		var phone = $("#txtFindIdPhone").val();
		
		if(name == "") {
			alert("이름을 입력하세요.");
			return;
		}
		
		if(phone == "" || phone.length < 11) {
			alert("핸드폰번호를 입력하세요.");
			return;			
		}
		
		sParams += String.format("&coDiv={0}", "65");
		sParams += String.format("&name={0}", name);
		sParams += String.format("&phone={0}", phone);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#txtFindIdName").val();
				$("#txtFindIdPhone").val();
				alert("회원님의 아이디가 등록 된 휴대폰으로 전송되었습니다.");
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doFindPw() {
		var sUrl = "<c:url value='/common/doFindPw.do'/>";
		var sParams = "";
		
		var name = $("#txtFindPwName").val();
		var id = $("#txtFindPwId").val();
		
		if(name == "") {
			alert("이름을 입력하세요.");
			return;
		}
		
		if(id == "") {
			alert("아이디를 입력하세요.");
			return;			
		}
		
		sParams += String.format("&coDiv={0}", "65");
		sParams += String.format("&name={0}", name);
		sParams += String.format("&id={0}", id);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				$("#txtFindPwName").val();
				$("#txtFindPwId").val();
				alert("회원님의 초기화 된 비밀번호가 등록 된 휴대폰으로 전송되었습니다.");
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
			<div class="loginCont bgBottom">
				<p class="loginTitle"><img src="<c:url value='/images/m_hills/login.png'/>" alt="">아이디를 잊으셨나요?</p>
				<div class="logInputBox">
					<div class="loginInput">
					  <input type="text" placeholder="이름" id="txtFindIdName">
					  <input type="text" placeholder="휴대폰번호" id="txtFindIdPhone">
					</div>
					<div class="loginBtn"><a href="javascript:doFindId()">확인</a></div>
				</div>
			</div>
			<div class="dotLine"></div>
			<div class="loginCont">
				<p class="loginTitle"><img src="<c:url value='/images/m_hills/lock.png'/>" alt="">비밀번호를 잊으셨나요?</p>
				<div class="logInputBox">
					<div class="loginInput">
							  <input type="text" value="" placeholder="이름" id="txtFindPwName">
							  <input type="text" placeholder="아이디" id="txtFindPwId">
					</div>
					<div class="loginBtn"><a href="javascript:doFindPw()">확인</a></div>
				</div>
			</div>
			<div class="loginTxt">
				<p class="q_B">회원이 아니세요?</p>
				<p>회원가입을 하시면 더 많은 혜택을 누리실 수 있습니다.</p>
				<a href="<c:url value='/m_hills/member/join02.do'/>" class="joinBtn">회원가입</a>
			</div>

		</div>
	</div><!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>