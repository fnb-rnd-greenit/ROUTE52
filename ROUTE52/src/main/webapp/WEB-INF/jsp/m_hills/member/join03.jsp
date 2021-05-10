<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%		
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G4933";			// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "4WA4X7E22TK2";		// NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지
	
	String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자 
	
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~	
	String sServerUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	
	if(sServerUrl.indexOf("localhost") == -1 && sServerUrl.indexOf("itsone.iptime.org") == -1) {
		sServerUrl = "https://www.seowongolf.co.kr";
	}
	
    String sReturnUrl = sServerUrl + "/checkplus/checkplusSuccess.do";      // 성공시 이동될 URL
    String sErrorUrl = sServerUrl + "/checkplus/checkplusFail.do";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + 
						"6:GENDER" + sGender.getBytes().length + ":" + sGender;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {    	
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
<jsp:include page="../include/header.jsp" />
  
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">

	window.name ="Parent_window";

	function onLoadPhoneCheckPopup() {
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	
	function succPhoneCheck(name, phone, birth, gender) {
		var sUrl = "<c:url value='/m_hills/member/join04.do'/>";
		var chkUrl = "<c:url value='/common/checkPhoneNumber.do'/>";
		var sParams = "";

		sParams += String.format("?name={0}", name);
		sParams += String.format("&phone={0}", phone);
		sParams += String.format("&birth={0}", birth);
		sParams += String.format("&gender={0}", gender);
		
		mAjax(chkUrl, "phone=" + phone, function(data) {
			if(data.resultCode == "0000") {
				location.href = sUrl + encodeURI(sParams);				
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function failPhoneCheck() {
		alert("인증에 실패했습니다.\r\n다시 시도해주세요.");
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 회원가입 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="grayBg">
			<div class="hpIpBox" onclick="onLoadPhoneCheckPopup()">
				<div class="hpBox">
					<img src="<c:url value='/images/m_hills/icon_hp.png'/>" alt="">
					<span class="orange">휴대폰</span>
					<p>본인 명의의 휴대폰으로 <br>
					인증번호를 받은 후 <br>
					가입하실 수 있습니다.</p>
				</div>
								
			</div>
		</div>		
		<div class="contentBg">
			<p class="joinTextList">
				<!-- <span class="joinTxtTitle">기존에 실명인증을 받은 아이디가 있는 고객님은 추가로 아이디를 만드실 수 있습니다.</span> -->
				2012년 8월 18일부터 시행되는 정보통신망 이용 촉진 및 정보보호 등에 관한 법류(이하 정보통신망법) 제 23조의 2 ”주민등록번호의 사용제한” 에 따라 주민등록번호를 입력받지 않습니다. <br>
				이에따라 <span class="point">회원가입시 주민등록번호를 입력하는 실명인증 대신 본인명의로 가입된 휴대폰을 이용하여 본인인증</span>을 하셔야 회원가입을 하실 수 있습니다.<br><br>
				<!-- <span class="joinTxtTitle">아이핀(I-PIN)이란?</span>
				인터넷상에서 주민등록번호로 도용 범죄를 방지하기 위해 정부가 개발한 인터넷 신원확인 번호입니다.<br> -->
			</p>
			<br>
			<div class="dotLine"></div>
			<br>
			<p class="joinTextList">
			<span class="joinTxtTitle">본인인증에 실패하셨나요?</span>
			정보가 해당 인증기관에 등록되어 있지 않거나 기타 다른 사유로 실패한 경우일 수 있습니다.<br>
			인증이 안되시는 경우 나이스신용평가정보 고객센터(1600-1522)로 문의하여 주시기 바랍니다.<br>
			통화 가능시간(평일:09~18시, 토/일요일(공휴일):휴무)<br><br>
			국내거주 외국인의 회원가입은 법무부 출입국관리사무소에서 등록번호를 부여 받은 경우에만 가능합니다.<br>
		</p>
		</div>
	</div><!-- contents End -->  
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div> 

<form name="form_chk" method="post">
	<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
	<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
</form>  

</body>
</html>