<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<script type="text/javascript">

	$(document).ready(function() { 
		onLoadPage(); 
	});

	function onLoadPage() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId != "") {
			location.href = "<c:url value='/m_valley/index.do'/>";	
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
    			
        		var msNum = data.rows.msNum;
        		
        		if(msNum != null && msNum != "") {
            		location.href = "<c:url value='/m_valley/index.do?msNum=" + msNum + "'/>";
            		return;
        		}
        		
        		location.href = "<c:url value='/m_valley/index.do'/>";
            } else if(data.resultCode == "1000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
    			
        		var msNum = data.rows.msNum;
        		
        		if(msNum != null && msNum != "") {
            		location.href = "<c:url value='/m_valley/member/member.do?msNum=" + msNum + "'/>";
            		return;
        		}
        		
        		location.href = "<c:url value='/m_valley/member/member.do'/>";
            } else if(data.resultCode == "2000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
    			
        		var msNum = data.rows.msNum;
        		
        		if(msNum != null && msNum != "") {
            		location.href = "<c:url value='/m_valley/member/member.do?msNum=" + msNum + "'/>";
            		return;
        		}
        		
        		location.href = "<c:url value='/m_valley/member/member.do'/>";
            } else if(data.resultCode == "3000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
    			
        		var msNum = data.rows.msNum;
        		
        		if(msNum != null && msNum != "") {
            		location.href = "<c:url value='/m_valley/member/agree.do?msNum=" + msNum + "'/>";
            		return;
        		}
        		
        		location.href = "<c:url value='/m_valley/member/agree.do'/>";
            } else {
            	alert(data.resultMessage);
            }
        });
	}
	
</script>

<div id="wrap">	
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> Login <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>

	<div class="contents">
		<div class="grayBg">
			<div class="loginCont">
				 <p class="loginTitle">로그인 하시면 더 많은 혜택이 쏟아집니다~!</p>
				 <div class="logInputBox">
					<div class="loginInput">
					  <input type="text" value="" placeholder="아이디&핸드폰번호로 로그인 가능합니다." id="msId">
					  <input type="password" maxlength="20" placeholder="비밀번호" id="msPw">
					</div>
					 <div class="loginBtn"><a href="javascript:actionLogin()">로그인</a></div>
				 </div>

				 <div class="memBox">
					 <span><input type="checkbox" name="checkbox" id="chkSaveId">
					 &nbsp;아이디저장 </span>
					 <span><input type="checkbox" name="checkbox" id="chkAutoLogin">
					 &nbsp;로그인유지 </span>
				 </div>	
				 <div class="LogFindBtn">
					<a href="<c:url value='/m_valley/member/find.do'/>" class="id_Btn">아이디찾기</a>
					<a href="<c:url value='/m_valley/member/find.do'/>">비밀번호찾기</a>
				 </div>
			</div>

		</div>
	</div><!-- contents End -->
   
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>