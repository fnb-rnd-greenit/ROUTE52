<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%		
	String sServerUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	
	if(sServerUrl.indexOf("localhost") == -1 && sServerUrl.indexOf("itsone.iptime.org") == -1) {
		sServerUrl = "https://www.seowongolf.co.kr";
	}
	
	String sContextPath = sServerUrl + request.getContextPath();
%>

<html>
<head>
<script type="text/javascript" src="<c:url value='/js/m_naverLogin_implicit-1.0.3.js'/>" charset="utf-8"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
</head>
<body>
<script type="text/javascript">
	var naver_key = "wSzJ1pJXrPElFz9xdZF2";
	var naver_callback = "<%= sContextPath %>/m_hills/member/succNaverLogin.do";

	var naver_id_login = new naver_id_login(naver_key, naver_callback);
		
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		actionLoginForSocial("NAVER", naver_id_login.getProfileData('id')
				, naver_id_login.getProfileData('name')
				, naver_id_login.getProfileData('gender'));
	}
	
	function actionLoginForSocial(type, id, name, gender) {
		var sUrl = "<c:url value='/hills/member/signUpForSocial.do'/>";
		var sParams = "";
		
		if (type != "") {
			sParams += String.format("msLoginCd={0}", type);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (id != "") {
			sParams += String.format("&msId={0}", id);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (name != "") {
			sParams += String.format("&msName={0}", name);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (gender != "") {
			sParams += String.format("&msSex={0}", gender);
		}
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				location.href = "<c:url value='/m_hills/index.do'/>";
			} else if(data.resultCode == "1000") {
				var msNum = data.rows.msNum;
				var msName = data.rows.msName
				
				location.href = "<c:url value='/m_hills/member/join05.do'/>?msNum=" + msNum + "&msName=" + msName;
			} else {
				alert(data.resultMessage);
			}
		});
	}	
</script>
</body>
</html>