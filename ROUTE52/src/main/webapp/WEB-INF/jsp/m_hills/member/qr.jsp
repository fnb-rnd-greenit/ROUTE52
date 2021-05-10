<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,target-densitydpi=medium-dpi" />
<meta name="apple-mobile-web-app-capable" content="no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no,email=no,address=no">
<meta name="title" content="서원힐스, 대보">
<meta name="author" content="서원힐스">
<meta name="Keywords" content="서원밸리, 서원힐스, 대보그룹">
<meta name="description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta property="og:type" content="website">
<meta property="og:title" content="서원밸리, 서원힐스, 대보그룹">
<meta property="og:description" content="대한민국 10대 명품골프장, 문화나눔 1번지 서원밸리컨트리클럽">
<meta property="og:url" content="">
<link rel="canonical" href="">  
<link rel="icon" href="<c:url value='/images/hills/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/hills/favicon.ico'/>">  
<title>서원힐스</title>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/import.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.qrcode.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/qrcode.js'/>"></script>
<script>

	var mChkinNo;
	
	$(document).ready(function() {
		init();
	});
	
	function init() {
		mChkinNo =  "<c:out value='${chkinNo}'/>";
		jQuery(".qrBox").qrcode({ 
		    render : "table",       
		    width  : 200,           
		    height : 200,          
		    text   : mChkinNo
		});
		
		doSearch();
	}
	
	function doSearch() {
		var container = $("#board-container");
		
		var sUrl = "<c:url value='/m_hills/member/getInnerInfo.do'/>";
		var sParams = "";
		
		var chkinNo = mChkinNo;
		if (chkinNo != "") {
			sParams += String.format("chkinNo={0}", chkinNo);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
			return;
		}	
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();			
			
			if(data.resultCode == "0000") {
				var row = data.rows;
				
				if(row != null){
					var d = getDateFormat(row.EN_DAY);
					var t = row.EN_TIME;
					
					if(new Date().yyyymmdd() != row.EN_DAY) {
						alert("기간이 만료된 쿠폰입니다.");
						history.back();
					}
					
					$("#txtName").html(row.EN_NAME);
					$("#txtDate").html(String.format("{0}월 {1}일", d.mm(), d.dd()));
					$("#txtCos").html(row.EN_COS_NM);
					$("#txtTime").html(t.substring(0, 2) + ":" + t.substring(2, 4));
					$("#txtLocker").html(row.EN_LOCKER);	
				}
			} else {
				alert(data.resultMessage);	
			}
		});
	}
	
</script>
<body>
<div id="wrap" class="orangeBg">
	<div class="qrWrap">
		<h1><img src="<c:url value='/images/m_hills/logo_w.png'/>"></h1>
		<div class="qrInfoBox">
			<div class="qrBox">
			</div>
			<h2 class="qrname" id="txtName"></h2>   
			<table class="qrTable">
				<colgroup>
					<col width="25%">
					<col width="25%">
					<col width="25%">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">일자</th>
						<th scope="col">코스</th>
						<th scope="col">Tee-off</th>
						<th scope="col">락카번호</th>
					</tr>					
				</thead>
				<tbody>
					<tr>
						<td id="txtDate"></td>
						<td id="txtCos"></td>
						<td id="txtTime"></td>
						<td id="txtLocker"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- footer 영역 -->
	<div id="footerWrap">
		<div class="termsBox">
			<div class="terms">
				<ul>
					<li><a href="<c:url value='/m_hills/index.do'/>">홈</a></li>
					<li><a href="javascript:void(0)" class="drawer-toggle">메뉴</a></li>
					<li><a href="<c:url value='/m_hills/board/list.do?bbsType=6'/>">이벤트</a></li>
					<li><a href="tel:031-940-9400" target="_blank">고객센터</a></li>
				</ul>
			</div>
		</div>
		<div class="footerBox">
			<div class="footer">				
				<p>경기도 파주시 광탄면 서원길 333</p>
				<p>COPYRIGHT ⓒ 서원레저(주) ALL RIGHT RESERVED.</p>
			</div>
		</div> 
	</div>
</div>
</body>
</html>