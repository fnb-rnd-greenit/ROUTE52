<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
</head>
<body>
<script type="text/javascript">
	
	$(document).ready(function() { 
		actionLoginForSocial("${type}", "${id}", "${name}", "");
	});
	
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
				var msName = data.rows.msName;
				var msId = data.rows.msId
				var msLoginCd = data.rows.msLoginCd
				
				location.href = "<c:url value='/m_hills/member/join05.do'/>?msNum=" + msNum + "&msName=" + msName + "&msId=" + msId + "&msLoginCd=" + msLoginCd;
			} else {
				alert(data.resultMessage);
			}
		});
	}	
</script>
</body>
</html>