<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
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

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>Member &nbsp;&nbsp;&nbsp; ＞ <span>아이디/비밀번호 찾기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">아이디/비밀번호 찾기</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>

		<div class="grayBgBox">
			<div class="logTab">
				<a href="<c:url value='/hills/member/login.do'/>" class="loginTab">로그인</a>
				<a href="<c:url value='/hills/member/join02.do'/>" class="joinTab">회원가입</a>
			</div>
			<div class="loginBox">
				<div class="findBox">
					<div class="findId">
						<span class="findTitle"><img src="<c:url value='/images/hills/login.png'/>" alt=""> 아이디를 잊으셨나요?</span>
						<div class="findIpBox">
							<ul class="loginInput">
								<li>
								  <input type="text" placeholder="이름" id="txtFindIdName">
								</li>
								<li>
								  <input type="text" placeholder="휴대폰번호" id="txtFindIdPhone">
								</li>
							</ul>
							<a href="javascript:doFindId()" class="loginBtn">확인</a>	
						</div>
					</div>

					<div class="findId pw">
						<span class="findTitle"><img src="<c:url value='/images/hills/lock.png'/>" alt=""> 비밀번호를 잊으셨나요?</span>
						<div class="findIpBox">
							<ul class="loginInput">
								<li>
								  <input type="text" value="" placeholder="이름" id="txtFindPwName">
								</li>
								<li>
								  <input type="text" placeholder="아이디"  id="txtFindPwId">
								</li>
							</ul>
							<a href="javascript:doFindPw()" class="loginBtn">확인</a>	
						</div>
					</div>
					 <div class="loginTxt">
						<p class="q_B">회원이 아니세요?</p>
						<p>회원가입을 하시면 더 많은 혜택을 누리실 수 있습니다.</p>
						<a href="<c:url value='/hills/member/join02.do'/>" class="joinBtn">회원가입</a>
					 </div>
				</div>
			</div>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer.jsp" flush="true" />