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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/main.css?v=3'/>">
<title>대보 관리자</title>

<script type="text/javascript">

	var currentTab = 1;
	var mCoDiv;

	$(document).ready(function() { 
		onLoadPage();
	});
	
	function onLoadPage() {
		initCompanyCombo();
		
		onChangeTabMenu(1);
	}
	
	function initCompanyCombo() {
		var grantCoDiv = "${sessionScope.adminUser.grantCoDiv}";
		var data = grantCoDiv.split(",");
		var coName = {
			"01" : "CLUBD 보은",
			"02" : "CLUBD 속리산",
			"03" : "CLUBD 금강",
			"04" : "CLUBD 금강(리버)",
			"61" : "서원밸리",
			"65" : "서원힐스"
		};
		
		for(i=0; i<data.length; i++) {
			$("#selCompany").append("<option value='" + data[i] + "'>" + coName[data[i]] + "</option>");
		}
		
		mCoDiv = data[0];
		
		$("#selCompany").on("change", function() {
			location.href = "<c:url value='/admin/main.do'/>?coDiv=" + $("#selCompany").val();
			
			/* mCoDiv = $("#selCompany").val();
			
			onChangeTabMenu(currentTab); */
		}); 
		
		if("${coDiv}" != "") { 
			mCoDiv = "${coDiv}";
			$("#selCompany").val("${coDiv}");
		}
		
		if(mCoDiv != "65") {
			$("#tab8").hide();
		}
	}

	function actionLogout() {
		var sUrl = "<c:url value='/admin/actionLogout.do'/>";
		
		mAjax(sUrl, null, function(data){
			if(data.resultCode == "0000") {
				alert("로그아웃 되었습니다.");
				location.reload();				
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function onChangeTabMenu(div) {
		currentTab = div;
		
		for(i=1; i<=10; i++) {
			if(div == i) {
				$("#tab" + i).addClass("on");
				$("#mainContainer" + i).show();
			} else {
				$("#tab" + i).removeClass("on");
				$("#mainContainer" + i).hide();
			}
		}
		
		$("#selCompanyShop").hide();
		
		if(currentTab == 1) {			
			onLoadBenner();
		} else if(currentTab == 4) {
			$("#selCompanyShop").show();
			onLoadMenu();
		} else if(currentTab == 5) {
			onLoadMessage();
		} else if(currentTab == 6) {
			onLoadQNA();
		} else if(currentTab == 7) {
			onLoadFunAndJoy();
		} else if(currentTab == 8) {
			onLoadPopup2();
		} else if(currentTab == 9) {
			onLoadPopup();
		} else if(currentTab == 10) {
			onLoadYoutube();
		}
	}
	
</script>

</head>
<body>

	<div id="header">
		<div class="logo">대보 관리자</div>
		<div><select id="selCompany"></select></div> 
		<ul class="member">
			<li><a href="https://www.seowongolf.co.kr/" target="_blank"><font color="white">서원 홈페이지</font></a></li>
			<li>|</li>
			<li><a href="https://www.clubd.co.kr" target="_blank"><font color="white">클럽디 홈페이지</font></a></li>
			<li>|</li>
			<li><a href="javascript:actionLogout()"><font color="white">로그아웃</font></a></li>
		</ul>
		
		<div>
		<select id="selCompanyShop">	
		</select>
		</div>
		
	</div>     

	<ul class="gnb">
		<li class="" id="tab1"><a href="javascript:onChangeTabMenu(1)">베너관리</a></li>
		<li class="" id="tab2" style="display:none"><a href="javascript:onChangeTabMenu(2)">게시판관리</a></li>
		<li class="" id="tab3" style="display:none"><a href="javascript:onChangeTabMenu(3)">푸쉬관리</a></li>
		<li class="" id="tab4"><a href="javascript:onChangeTabMenu(4)">메뉴관리</a></li>
		<li class="" id="tab5"><a href="javascript:onChangeTabMenu(5)">메세지관리</a></li>
		<li class="" id="tab6"><a href="javascript:onChangeTabMenu(6)">Q&amp;A관리</a></li>		
		<li class="" id="tab7"><a href="javascript:onChangeTabMenu(7)">FUN & JOY 관리</a></li>
		<li class="" id="tab8"><a href="javascript:onChangeTabMenu(8)">팝업관리(인트로)</a></li>
		<li class="" id="tab9"><a href="javascript:onChangeTabMenu(9)">팝업관리</a></li>
		<li class="" id="tab10"><a href="javascript:onChangeTabMenu(10)">유튜브관리</a></li>
	</ul>
	
	<div id="mainContainer1" style="display:none;">
		<jsp:include page="../admin/include/benner.jsp" flush="true"></jsp:include>
	</div>	
	
	<div id="mainContainer2" style="display:none">
		<jsp:include page="../admin/include/board.jsp" flush="true"></jsp:include>
	</div>	
	
	<div id="mainContainer3" style="display:none">
		
	</div>	

	<div id="mainContainer4" style="display:none">
		<jsp:include page="../admin/include/menu.jsp" flush="true"></jsp:include>
	</div>
	
	<div id="mainContainer5" style="display:none">
		<jsp:include page="../admin/include/message.jsp" flush="true"></jsp:include>		
	</div>	
	
	<div id="mainContainer6" style="display:none">
		<jsp:include page="../admin/include/qna.jsp" flush="true"></jsp:include>				
	</div>
	
	<div id="mainContainer7" style="display:none">
		<jsp:include page="../admin/include/funandjoy.jsp" flush="true"></jsp:include>				
	</div>	
	
	<div id="mainContainer8" style="display:none">
		<jsp:include page="../admin/include/popup_intro.jsp" flush="true"></jsp:include>				
	</div>	
	
	<div id="mainContainer9" style="display:none">
		<jsp:include page="../admin/include/popup.jsp" flush="true"></jsp:include>				
	</div>	
	
	<div id="mainContainer10" style="display:none">
		<jsp:include page="../admin/include/youtube.jsp" flush="true"></jsp:include>				
	</div>	
</body>
</html>