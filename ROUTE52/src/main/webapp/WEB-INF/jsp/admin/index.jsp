<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.3.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<title>대보 관리자</title>

<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td,select,option,checkbox,text,p { margin:0; padding:0;font:12px/1.2 Dotum,"돋움",sans-serif;}
table {	border-collapse:collapse; border-spacing:0;}
fieldset,img { border:0;}
address,caption,cite,code,dfn,em,strong,th,var { font-style:normal;	font-weight:normal;}
ol,ul,li {	list-style:none;}
caption {display:none;}
h1,h2,h3,h4,h5,h6 {	font-size:100%;	font-weight:normal;padding:none;margin:none;}
q:before,q:after {content:'';}
abbr,acronym { border:0;}
img, li { vertical-align: middle;}
hr,.hidden{display:none;}
.bold{font-weight:bold;}
a,img,div,ul,li,input{outline:none; selector-dummy: expression(this.hideFocus=true);vertical-align: middle;text-decoration:none; display:block;} /* 테두리점선 컨트롤(no) */
a:link {color:black;}

#wrap {width:100%;height:250px;margin:210px auto;background:url('<c:url value='/images/admin/bg.jpg'/>');}
#login {width:500px;height:180px;border:1px solid #d2d2d2;background:#fafafa;margin:0 auto;box-shadow:1px 1px 6px #222222;behavior:url('/css/pie.htc');}
.title {margin:10px 0;padding-top:20px;text-align:center;color:white;font-weight:bold;font-size:11pt;text-shadow:1px 1px 1px black;behavior:url('/css/pie.htc');} 
#login .register {padding:34px 80px 0 100px;}
#login .register li {float:left;}
#login .register .name {margin-right:15px;}
#login .register .name div {margin-top:12px;}
#login .register .box {margin-right:7px;}
#login .register .box div {margin-top:5px;}
#login .register .box input {width:165px;height:21px;line-height:21px;*height:19px;*line-height:19px;border:1px solid #c1c1c1;}
#login .register .btnlogin {margin-top:5px;padding:18px;background:#4b545e;color:white;}
#login .save {clear:both;padding:15px 90px 0 90px;*padding:3px 90px 0 90px;}
#login .save li {float:left;margin-left:4px;font-size:9pt;}
#login .save .left {margin-left:12px;}
#login .save .left2 {margin-left:12px;*padding-top:5px;}
#login .save .space2 {*padding-top:5px;}
</style>

<script type="text/javascript">

	$(document).ready(function() { 
		onLoadPage();
	});
	
	function onLoadPage() {
		$("#id").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	actionLogin();
	        }
	    });

		$("#pw").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	actionLogin();
	        }
	    });
		
		var id = getCookie("id");
		var pw = getCookie("pw");
		
		if(id != null && id != "") {
			$("#id").val(id);
			$("#chkSaveId").attr('checked', true);
		}
		
		if(pw != null && pw != "") {
			$("#pw").val(pw);
			$("#chkSavePw").attr('checked', true);
		}
	}

	function actionLogin() {
		var sUrl = "<c:url value='/admin/actionLogin.do'/>";
		var sParams = {};
		
		var id = $("#id").val();
		var pw = $("#pw").val();
		
		if(id == "") {
			alert("아이디를 입력하세요.");
			return;
		} else {
			sParams["id"] = id;
		}
		
		if(pw == "") {
			alert("비밀번호를 입력하세요.");
			return;
		} else {
			sParams["pw"] = pw;
		}

		progressStart();
		
        mAjax2(sUrl, sParams, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#id").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}
        		
        		if($('input:checkbox[id="chkSavePw"]').is(":checked")){
        			setCookie("pw", $("#pw").val(), 365);
        		} else {
        			setCookie("pw", "", 365);
        		}
        		
        		location.href = "<c:url value='/admin/main.do'/>";	
            } else {
            	alert(data.resultMessage);
            }
        });
	}

</script>

</head>
<body>
<div id="wrap">
	<p class="title">대보 관리자 로그인</p>

	<div id="login">
		<ul class="register">
			<li class="name">
				<div>아이디</div>
				<div>비밀번호</div>
			</li>
			<li class="box">
				<div><input type="text"id="id" value=""></div>
				<div><input type="password" id="pw" value=""></div>
			</li>
			<li class="btnlogin" onclick="javascript:actionLogin();" style="cursor:pointer;">><font color="white">로그인</font></li>
		</ul>
		<ul class="save">
			<li><input type="checkbox" name="checkbox" id="chkSaveId" ></li>
			<li class="space2">아이디 저장<li>
			<li class="left"><input type="checkbox" name="checkbox2" id="chkSavePw" ></li>
			<li class="space2">비밀번호 저장<li>
		</ul>
	</div>
</div>
</body>
</html>