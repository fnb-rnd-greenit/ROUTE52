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
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId != "") {
			location.href = "<c:url value='/valley/index.do'/>";	
		}
		
		var id = getCookie("id");
		var pw = getCookie("pw");
		
		if(id != null && id != "") {
			$("#msId").val(id);
			$("#chkSaveId").attr('checked', true);
		}

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
	}

	function actionLogin() {
		var sUrl = "<c:url value='/valley/member/actionLogin.do'/>";
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
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}
        		
        		location.href = "<c:url value='/valley/index.do'/>";
            } else if(data.resultCode == "1000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
            	
        		location.href = "<c:url value='/valley/member/memModify.do'/>";
            } else if(data.resultCode == "2000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
            	
        		location.href = "<c:url value='/valley/member/memModify.do'/>";
            } else if(data.resultCode == "3000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
            	
        		location.href = "<c:url value='/valley/member/agree.do'/>";
            } else {
            	alert(data.resultMessage);
            }
        });
	}
	
</script>

	<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
			<p>Member &nbsp;&nbsp;&nbsp; ＞ <span>로그인</span></p>
		</div>
	</div>


<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">로그인</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>

		<div class="loginBox grayBgBox">
			<div class="loginCont">

				 <span class="loginTitle"><img src="<c:url value='/images/valley/login.png'/>" alt=""> LOGIN</span>

				 <ul class="loginInput">
					<li>
					  <input type="text" value="" id="msId" placeholder="아이디&핸드폰번호로 로그인 가능합니다.">
					</li>
					<li>
					  <input type="password" maxlength="20" id="msPw" placeholder="비밀번호">
					</li>
				 </ul>
				 <a href="javascript:actionLogin()" class="loginBtn">로그인</a>

				 <div class="memBox" style="margin-top:15px">
					  <span><input type="checkbox" name="checkbox" id="chkSaveId">
					 &nbsp;아이디 저장 </span>
					 <span><input type="checkbox" name="checkbox" id="chkAutoLogin"> 
					 &nbsp;로그인유지 </span>
					  
					<a href="<c:url value='/valley/member/find.do'/>" class="findBtn">ID/PW 찾기</a>
				 </div>
				 
				 <!-- <div class="loginTxt">
					<p class="q_B">회원이 아니세요?</p>
					<p>회원가입을 하시면 더 많은 혜택을 누리실 수 있습니다.</p> 
					<a href="" class="joinBtn">회원가입</a>
				 </div> -->
			</div>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />