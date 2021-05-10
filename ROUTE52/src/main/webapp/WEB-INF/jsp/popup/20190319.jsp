<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
*{padding:0; margin:0;}
.popup_box{width:100%; height:100%; background-color:#e5e3d5;}
.popup_footer{position:relative; width:100%; height:28px; background:url('<c:url value='/images/popup/img02.gif'/>') -20px 0 no-repeat;}
.popup_footer .close{position:absolute; right:0;}
.popup_footer p{height:28px;}
.popup_footer .form_close input{position:absolute; left:7px; top:5px;}
</style>
<script language="JavaScript">
	
	function closeWin() {
		if ( document.forms[0].Notice.checked ){
	 		setCookie( "20190319", "Y" , 1);
		}
		
		self.close();
	}
	
	function onLoadPage() {
		if(getCookie("20190319") == "Y") {
			self.close();
		}
	}
	
	var setCookie = function(name, value, day) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + day);

		var cookie_value = escape(value) + '; expires=' + exdate.toUTCString();
		document.cookie = name + '=' + cookie_value;
	};

	var getCookie = function(name) {
		var x, y;
		var val = document.cookie.split(';');
		
		for (var i = 0; i < val.length; i++) {
			x = val[i].substr(0, val[i].indexOf('='));
			y = val[i].substr(val[i].indexOf('=') + 1);
			x = x.replace(/^\s+|\s+$/g, '');
			if (x == name) {
			  return unescape(y);
			}
		}
	};
	
</script>
</head>
<body onload="onLoadPage()">
	<form name="form1">
	<div class="popup_box">
	
		<img src="<c:url value='/images/popup/web01.jpg'/>" border="0" alt="" onclick="opener.parent.onPopupClicked(); self.close();">
	
		<div class="popup_footer" id="Table_01">
			<p>
				<span class="form_close"><input type="checkbox" name="Notice" class="input_close"></span>
				<span class="close">
					<a href="#" onclick="closeWin()"><img src="<c:url value='/images/popup/img03.gif'/>" width="67" height="28" border="0" alt="닫기"></a>
				</span>
			</p>
		</div>
	</div>
	</form>
</body>
</html>